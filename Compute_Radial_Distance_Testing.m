% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script test the function Compute_Radial_Distance() by testing it on
% a ground truth beam central line and point of interest

% choose point of interest on the edge of the PTV:
global PTV_CENTRE;
global PTV_RAD;
pt = PTV_CENTRE - [PTV_RAD,0,0];

% choose beam index of the last beam in the beam structure array, which
% will be the beam through the top of the helmet, parallel to the z axis:
global BEAM_STRUCT_ARRAY;
[N, ~] = size(BEAM_STRUCT_ARRAY);
index = N;

%compute ground truth radial distance:
r = Compute_Radial_Distance(pt, index);

% ascertain correct value:
fprintf("Radial distance (should be %g): %g\n\n", PTV_RAD, r);