% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System
% 
% Q5 Compute Dose Absorption Function Table

function dose_absorption_function_table = Compute_Depth_Dose(resolution, maxDepth)
% This function uses a given resolution and maximum depth and produces a
% table of beam depth and dose provided at depth based on the dose
% absorption function given in the assignment.
% INPUT:
%       resolution - the step size between each depth in the table in mm
%       maxDepth - the maximum depth to compute the table to, in mm
% OUTPUT:
%       dose_absorption_function_table - the completed lookup table of
%       depths and absorbed dosages
% SIDE EFFECTS:
%       None.

% initialize empth DAF lookup table
dose_absorption_function_table = zeros(maxDepth / resolution + 1, 2);

% depth tracker/counter
d = 0;
% fill out lookup table
while (d <= maxDepth)
%     find place in list
    pos = round(d / resolution) + 1;
    if (d <= 20) % function increases to this point
        dose_absorption_function_table(pos,:) = [d, 0.5 + 0.025 * d];
    else
        dose_absorption_function_table(pos,:) = [d, 1 - 0.005 * (d - 20)];
    end
    d = d + resolution;
end
end