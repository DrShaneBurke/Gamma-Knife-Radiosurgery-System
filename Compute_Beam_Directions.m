% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q7 Compute Beam Directions

function beam_info_array = Compute_Beam_Directions()
% This function creates a beam structure array for the radiation point
% sources with the following row structure: 
% [longitude, latitude, vx, vy, vz] where v is the beam source direction
% vector. It uses a globally set beam separation angle.
% INPUT:
%       None.
% OUTPUT:
%       beam_info_array - the initialized beam structure array
% SIDE EFFECTS:
%       None.


% declare some global variables needed
global PTV_CENTRE;
global BEAM_SEP_ANGLE;

% get number of beams
N = 360/BEAM_SEP_ANGLE*90/BEAM_SEP_ANGLE + 1;

% preallocate array
beam_info_array = zeros(N,5);

% counter
count = 1;

for latitude = 0:BEAM_SEP_ANGLE:90-BEAM_SEP_ANGLE
    % in outer loop rotate unit point [1 0 0] around the y axis
    [roty, ~] = Rotation_About_Frame_Axis("y", latitude);
    pt0 = roty * [1; 0; 0];
    for longitude = 0:BEAM_SEP_ANGLE:360-BEAM_SEP_ANGLE
        % in inner loop rotate the unit point around z axis
        [rotz, ~] = Rotation_About_Frame_Axis("z", longitude);
        pt = rotz * pt0;
        
        % get beam coordinates 
        pt = pt.' + PTV_CENTRE;
        
        % find beam direction vector
        dirVec = PTV_CENTRE - pt;
        
        % add to array
        beam_info_array(count,:) = [longitude, latitude, dirVec];
        count = count + 1;
    end
end
% add final point. This point will be pointing down in the z axis towards
% the isocentre
beam_info_array(count,:) = [0, 90, [0,0,-1]];
end