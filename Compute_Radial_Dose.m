% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q6 Compute Radial Dose Function Table

function radial_dose_function_table = Compute_Radial_Dose(resolution)
% This function uses a given resolution to produce a table of radial beam
% leaked doses over a range of non-zero-dose radial distances 
% INPUT:
%       resolution - the step size between each radial distance in the
%       table in mm
% OUTPUT:
%       radial_dose_function_table - the completed lookup table of
%       radial distances and absorped dosages
% SIDE EFFECTS:
%       None.

% Initialize empty RDF lookup table
radial_dose_function_table = zeros(45/resolution+1,2);

% depth tracker
d = -23;
% counter
c = 1;
% fill out lookup table
while (d <= 23)
    if d <= -7.5
        radial_dose_function_table(c,:) = [d, max((d + 22.5) * 1 / 15,0)];
    elseif d <= 7.5
        radial_dose_function_table(c,:) = [d, 1];  
    else
        radial_dose_function_table(c,:) = [d, max(1 - (d - 7.5) * 1 / 15,0)];
    end
    c = c + 1;
    d = d + resolution;
end