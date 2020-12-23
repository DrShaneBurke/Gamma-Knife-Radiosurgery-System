% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Point_Dose_from_Beam() by running
% it on all beams using a ground truth point (the isocentre), and ensuring
% that the DAF and computed point dose match for each beam (the RDF should
% be 1 for each since r = 0).


global BEAM_STRUCT_ARRAY;
global PTV_CENTRE;
[N,~] = size(BEAM_STRUCT_ARRAY);

% run through each beam and compare point dose vs DAF dose
allEqual = true;
for i = 1:N
    % compute DAF for isocentre
    d = round(Compute_Depth_from_Skin(PTV_CENTRE, i));
    DAF = DAF_TABLE(d+1,2);
    
    % compute point dose
    PD = Compute_Point_Dose_from_Beam(PTV_CENTRE, i);
    
    % and compare, flag if unequal
    if PD ~= DAF
        allEqual = false;
    end
end

if allEqual
    fprintf("Point dose value is the same as DAF at isocentre for all beams\n\n");
else
    fprintf("Error in Compute_Point_Dose_from_Beam()\n\n");
end
