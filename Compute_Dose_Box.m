% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System
% 
% Q2 Compute Dose Box 

function dose_box = Compute_Dose_Box(ptv_rad, ptv_ctr, oar_rad, oar_ctr)
% This function takes the centre and radius of two spheres representing the
% PTV and OAR, and returns the minimum dose box containing the two
% INPUT:
%       ptv_rad - radius of the PTV
%       ptv_ctr - centre of the PTV
%       oar_rad - radius of the OAR
%       oar_ctr - centre of the OAR
% OUTPUT:
%       dose_box - the computed dose box defined by two opposite corner
%       points
% SIDE EFFECTS:
%       None.

% list all possible min and max x,y,z values for PTV and OAR

Xs = [ptv_ctr(1) - ptv_rad; ptv_ctr(1) + ptv_rad; oar_ctr(1) - oar_rad; oar_ctr(1) + oar_rad];
Ys = [ptv_ctr(2) - ptv_rad; ptv_ctr(2) + ptv_rad; oar_ctr(2) - oar_rad; oar_ctr(2) + oar_rad];
Zs = [ptv_ctr(3) - ptv_rad; ptv_ctr(3) + ptv_rad; oar_ctr(3) - oar_rad; oar_ctr(3) + oar_rad];

% take min and max of each to define box
dose_box = [min(Xs), min(Ys), min(Zs), max(Xs), max(Ys), max(Zs)];

end
