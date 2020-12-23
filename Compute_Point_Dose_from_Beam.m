% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q12 Compute Point Dose from Beam

function point_dose_value = Compute_Point_Dose_from_Beam(point_of_interest, beam_index)
% This function computes the the dose to a point of interest with respect
% to a beam
% INPUT:
%       point_of_interest - the point to have it's point dose value
%       computed 
%       beam_index - the index of the beam central to be used from
%       the beam structure array
% OUTPUT:
%       point_dose_value - the resulting dose at the point of interest from
%       the beam
% SIDE EFFECTS:
%       None.

% declare needed global variables
global DAF_TABLE;
global RDF_TABLE;
global D_0;


% first we need to get the relative depth from skin of the point with
% respect to the chosen beam
d = round(Compute_Depth_from_Skin(point_of_interest, beam_index));
% then use the global DAF table to get the relevant value
DAF = DAF_TABLE(d+1,2);

%then get the radial distance of the point from the beam
r = round(Compute_Radial_Distance(point_of_interest, beam_index));
% and use global RDF table to get relevant value
if r > 23
    % too far for any radial dose
    RDF = 0;
else
    %use lookup table for non-zero value
    RDF = RDF_TABLE(r+24,2);
end

% now we can compute overall point dose
point_dose_value = D_0 * DAF * RDF;

end