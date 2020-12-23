% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Depth_from_Skin() by testing it on
% a ground truth central beam line and a point of interest

% choose point of interest on the lateral edge of the PTV:
global PTV_CENTRE;
global PTV_RAD;
pt = PTV_CENTRE - [PTV_RAD,0,0];

% choose beam index of the last beam in the beam structure array, which
% will be the beam through the top of the helmet, parallel to the z axis:
global BEAM_STRUCT_ARRAY;
[N, ~] = size(BEAM_STRUCT_ARRAY);
index = N;

% compute ground truth depth from skin:
d = Compute_Depth_from_Skin(pt, index);

% ascertain correct value, should be the same as the depth of the isocentre
% from the skin using the 90 degree lateral beam:
d_iso = norm(PTV_CENTRE - BEAM_STRUCT_ARRAY(N,6:8));
fprintf("Point depth from skin (should be %g): %g\n\n", d_iso, d);
