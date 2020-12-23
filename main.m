% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System
% 
% this is the main script, which initializes some global variables and
% calls all testing scripts to run once.

% initial point source dose
global D_0;
D_0 = 1;

% PTV dose prescribed 
global D_100;
D_100 = 20;

% OAR maximum dose limit
global D_OARMAX;
D_OARMAX = 6;

% Attributes of the helmet (beam separation angle and beam diameter in mm)
global BEAM_SEP_ANGLE;
BEAM_SEP_ANGLE = 30;
global BEAM_DIAM;
BEAM_DIAM = 30;

% Attributes of PTV (radius and centre in mm)
global PTV_RAD;
PTV_RAD = 15;
global PTV_CENTRE;
PTV_CENTRE = [30, 0, 15];

% Attributes of OAR (radius and centre in mm)
global OAR_RAD;
OAR_RAD = 15;
global OAR_CENTRE;
OAR_CENTRE = [0, 30, 45];

% Attributes of patient head (half axis lengths and centre in mm)
global HEAD_A;
HEAD_A = 80;
global HEAD_B;
HEAD_B = 100;
global HEAD_C;
HEAD_C = 80;
global HEAD_CENTRE;
HEAD_CENTRE = [0,0,0];

% choose dose cube voxel size in mm
global VOX_SIZE;
VOX_SIZE = 1;

fprintf("--------------Running Draw_3D_Scene_Testing Script--------------\n");
Draw_3D_Scene_Testing

fprintf("-----------Running Compute_Depth_Dose_Testing Script------------\n");
Compute_Depth_Dose_Testing

fprintf("-----------Running Compute_Radial_Dose_Testing Script-----------\n");
Compute_Radial_Dose_Testing

fprintf("---------Running Compute_Beam_Directions_Testing Script---------\n");
Compute_Beam_Directions_Testing

fprintf("--------Running Compute_Skin_Entry_Points_Testing Script--------\n");
Compute_Skin_Entry_Points_Testing

fprintf("--------Running Compute_Beam_Safety_Flags_Testing Script--------\n");
Compute_Beam_Safety_Flags_Testing

fprintf("---------Running Compute_Radial_Distance_Testing Script---------\n");
Compute_Radial_Distance_Testing

fprintf("--------Running Compute_Depth_from_Skin_Testing Script----------\n");
Compute_Depth_from_Skin_Testing

fprintf("------Running Compute_Point_Dose_from_Beam_Testing Script-------\n");
Compute_Point_Dose_from_Beam_Testing

fprintf("----Running Compute_Point_Dose_from_All_Beams_Testing Script----\n");
Compute_Point_Dose_from_All_Beams_Testing

%Note: takes a little while to produce 100% isocentre plot with 1 mm voxel
%size!
fprintf("---------------Running Dosimetry Analysis Script---------------\n")
Dosimetry_Analysis

fprintf("--------------Running Compute_Surface_Dose Function--------------\n")
Compute_Surface_Dose()



