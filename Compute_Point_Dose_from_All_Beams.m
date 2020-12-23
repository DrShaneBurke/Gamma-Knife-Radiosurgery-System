% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q13 Compute Point Dose from All Beams

function point_dose_value = Compute_Point_Dose_from_All_Beams(point_of_interest)
% This function computes the overall sum of all bem dosages to a point of
% interest
% INPUT:
%       point_of_interest - the point to have net dosage computed
% OUTPUT:
%       point_dose_value - computed net dosage
% SIDE EFFECTS:
%       None.

global BEAM_STRUCT_ARRAY;
[N,~] = size(BEAM_STRUCT_ARRAY);

% sum up point dosages from each beam to point, excluding those with beam
% safety flag of zero (unsafe)
point_dose_value = 0;
for i = 1:N
    if BEAM_STRUCT_ARRAY(10) ~= 0
        point_dose_value = point_dose_value + Compute_Point_Dose_from_Beam(point_of_interest, i);
    end
end
end