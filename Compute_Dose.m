% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q14 Compute Dose

function Compute_Dose()
% 
% 
% 
% 
% 
% 
% 
global OAR_CENTRE;
global OAR_RAD;
global PTV_CENTRE;
global PTV_RAD;
global VOX_SIZE;

% find the upper and lower bounds of the minimum sphere surrounding the OAR
% sphere
OAR_Low = OAR_CENTRE - [OAR_RAD,OAR_RAD,OAR_RAD];
OAR_Up = OAR_CENTRE + [OAR_RAD,OAR_RAD,OAR_RAD];

% use these to find the minimum dose cube covering the OAR, store in global
% variable
global OAR_DOSE_CUBE;
OAR_DOSE_CUBE = Create_Dose_Cube(OAR_Low, OAR_Up, VOX_SIZE);

% repeat the same process for the PTV/Isocentre
PTV_Low = PTV_CENTRE - [PTV_RAD,PTV_RAD,PTV_RAD];
PTV_Up = PTV_CENTRE + [PTV_RAD,PTV_RAD,PTV_RAD];

global PTV_DOSE_CUBE;
PTV_DOSE_CUBE = Create_Dose_Cube(PTV_Low, PTV_Up, VOX_SIZE);
end

function dose_cube = Create_Dose_Cube(pt1, pt2, vox_size)
% Creates a dose cube or 3-D matrix of voxel centre points and net point
% dosage values using two anchor points and a provided voxel size 
% INPUT:
%       pt1 - lower bound of cube (lowest x,y,z)
%       pt2 - upper bound of cube (highest x,y,z)
%       vox_size - voxel length/width/height
% OUTPUT:
%       dose_cube - the initialized 3-D matrix of voxels, with each voxel
%       in the form [x,y,z,dosage]. size: N x 4N x N 

N = abs((pt2(1) - pt1(1))/vox_size) + 1;

% nested loop to fill in row, column and page of dose cube. 
dose_cube = zeros(N,N*4,N);
for i = 0:N-1
    % pages move from highest to lowest z values
    z = pt2(3) - i * vox_size; 
    for j = 0:N-1
        % rows move from lowest to highest x values
        x = pt1(1) + j * vox_size;
        for k = 0:N-1
            % columns move from lowest to highest y values
            y = pt1(2) + k * vox_size;
            dose = Compute_Point_Dose_from_All_Beams([x,y,z]);
            % 4 columns for voxel, 3 for P = [x,y,z], 4th for dosage
            dose_cube(j+1,4*k+1:4*k+4,i+1) = [x, y, z, dose];
        end
    end
end
end