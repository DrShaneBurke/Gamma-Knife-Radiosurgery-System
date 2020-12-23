% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q11 Compute Depth from Skin

function depth_from_skin = Compute_Depth_from_Skin(point_of_interest, beam_index)
% This function computes the skin depth of a point of interest with respect
% to the centre of a specified beam
% INPUT:
%       point_of_interest - the point to have it's relative skin depth
%       computed 
%       beam_index - the index of the beam central to be used from
%       the beam structure array
% OUTPUT:
%       depth_from_skin - the computed relative skin depth in mm.
% SIDE EFFECTS:
%       None.

%PTV_CENTRE will act as a point on the beam of interest
global PTV_CENTRE;
global BEAM_STRUCT_ARRAY;

%next, get beam direction vector using input beam index
v = BEAM_STRUCT_ARRAY(beam_index,3:5);

%use assignment 1 function to find point on line nearest point of interest
%(construct plane containing this point, with a normal equal to the beam's
%direction vector)
int = Intersect_Line_and_Plane(point_of_interest, v, PTV_CENTRE, v);

%get norm of difference between nearest point on line and beam skin entry
%point as relative depth from skin
skin_entry = BEAM_STRUCT_ARRAY(beam_index,6:8);
depth_from_skin = norm(int - skin_entry);

end