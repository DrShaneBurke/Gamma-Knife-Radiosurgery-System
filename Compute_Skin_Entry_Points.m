% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q8 Compute Skin Entry Points

function Compute_Skin_Entry_Points()
% This function takes the global array of the gamma knife beam structure,
% and using the globalized half-axis values and centre of the patient head,
% adds the skin entry point and depth of isocenter from this point to each
% row/beam.
% INPUT:
%       None.
% OUTPUT:
%       None.
% SIDE EFFECTS:
%       Adds skin entry point and isocenter depth from skin entry point to
%       each beam in array

global PTV_CENTRE
global HEAD_A
global HEAD_B
global HEAD_C
% call array to be used
global BEAM_STRUCT_ARRAY;

[N,~] = size(BEAM_STRUCT_ARRAY);
for i = 1:N
    % get beam direction vector
    v = BEAM_STRUCT_ARRAY(i,3:5);
    % used assn1 function to compute skin entry point of head ellipse and
    % beam line
    
    [~, skin_entry] = Intersect_Line_and_Ellipsoid(PTV_CENTRE, v, HEAD_A, HEAD_B, HEAD_C);
    
    %from skin entry point compute depth to isocentre
    d2c = norm(PTV_CENTRE - skin_entry(1,:));
    
    %write skin entry point and depth to isocentre to beam data
    BEAM_STRUCT_ARRAY(i,6:9) = [skin_entry(1,:), d2c];
end
end