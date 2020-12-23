% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Point_Dose_from_All_Beams() by
% running it on a ground truth point (the isocentre), the sum of all DAF
% dosages to this point matches the computed net point dose. 

% NOTE: There was no function "Compute Isocentre Dose" for comparison as
% instructed in the assignment...

global BEAM_STRUCT_ARRAY;
global PTV_CENTRE;
[N,~] = size(BEAM_STRUCT_ARRAY);

% run through each beam and compute sum of all DAF values
sum_DAF = 0;
for i = 1:N
    % compute DAF for isocentre
    d = round(Compute_Depth_from_Skin(PTV_CENTRE, i));
    DAF = DAF_TABLE(d+1,2);
    
    % add to sum
    sum_DAF = sum_DAF + DAF;
end

% compute net point dose
NetPD = Compute_Point_Dose_from_All_Beams(PTV_CENTRE);

% and compare
if NetPD == sum_DAF
    fprintf("Computed Net Point Dose equals sum of beam-point DAFs at isocentre\n\n")
else
    fprintf("Compute_Point_Dose_from_All_Beams() is not working correctly.\n\n")
end

