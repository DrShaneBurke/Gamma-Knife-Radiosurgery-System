% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System
% 
% Q3 Draw 3D Scene Testing: This scripts tests the function Draw_3D_Scene
% by calling it to visualize the important bodies of the gamma knife scene


% initialize a global variable for the dose box using other precomputed
% variables

global DOSE_BOX;
DOSE_BOX = Compute_Dose_Box(PTV_RAD, PTV_CENTRE, OAR_RAD, OAR_CENTRE);

% Call Draw_3D_Scene()
Draw_3D_Scene()


