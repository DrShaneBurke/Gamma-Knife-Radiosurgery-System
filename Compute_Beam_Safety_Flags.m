% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q9 Compute Beam Safety Flags

function Compute_Beam_Safety_Flags()
% This function adds a beam safety flag to each beam in the beam structure
% array to indicate whether the beam is safe (doesn't intersect OAR) or
% unsafe (intersects/overlaps the OAR).
% INPUT:
%       None.
% OUTPUT: 
%       None.
% SIDE EFFECTS:
%       An extra column is added to each row of BEAM_STRUCT_ARRAY, a safety
%       flag which is set to 1 for a safe beam or 0 for an unsafe beam

global OAR_RAD;
global OAR_CENTRE;
global BEAM_DIAM;
global PTV_CENTRE;
global BEAM_STRUCT_ARRAY;

[N,~] = size(BEAM_STRUCT_ARRAY);

for i = 1:N
    % determine if beam intersects with OAR via assignment 1 function
    numInt = Intersect_Sphere_and_Cylinder(OAR_CENTRE, OAR_RAD, BEAM_DIAM/2, PTV_CENTRE, BEAM_STRUCT_ARRAY(i,3:5));
    
    if numInt == 0
        BEAM_STRUCT_ARRAY(i,10) = 1;
    else
        BEAM_STRUCT_ARRAY(i,10) = 0;
    end
end
end