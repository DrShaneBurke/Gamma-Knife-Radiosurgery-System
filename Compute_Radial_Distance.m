% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q10 Compute Radial Distance

function radial_distance = Compute_Radial_Distance(point_of_interest, beam_index)
% This function computes the radial distance between a beam central and a
% point of interest in mm.
% INPUT:
%       point_of_interest - the point to have it's radial distance computed
%       beam_index - the index of the beam central to be used from the beam
%       structure array
% OUTPUT:
%       radial_distance - the computed radial distance in mm.
% SIDE EFFECTS:
%       None.

%PTV_CENTRE will act as a point on the beam of interest
global PTV_CENTRE
global BEAM_STRUCT_ARRAY

%next, get beam direction vector using input beam index
v = BEAM_STRUCT_ARRAY(beam_index,3:5);

%use assignment 1 function to find point on line nearest point of interest
%(construct plane containing this point, with a normal equal to the beam's
%direction vector)
int = Intersect_Line_and_Plane(point_of_interest, v, PTV_CENTRE, v);

%get norm of difference between nearest point on line and point of interest
%as radial distance
radial_distance = norm(int - point_of_interest);

end