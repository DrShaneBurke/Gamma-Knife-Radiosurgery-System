% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests Compute_Beam_Directions() by calling the
% function and storing the computed beam structure array as a global
% variable, then plotting the beam central lines for visual inspection

global BEAM_STRUCT_ARRAY
BEAM_STRUCT_ARRAY = Compute_Beam_Directions();

[N, ~] = size(BEAM_STRUCT_ARRAY);

figure(2)

% plot isocenter
plot3(PTV_CENTRE(1),PTV_CENTRE(2),PTV_CENTRE(3),'.k','MarkerSize',15);
hold on;
grid on;
axis equal;
xlabel("X Axis");
ylabel("Y Axis");
zlabel("Z Axis");
title("Beam trajectories")

% plot all beams
for i = 1:N
    % get dir vector
    v_beam = BEAM_STRUCT_ARRAY(i,3:5);
    % choose reasonable start and endpoints
    beam_0 = PTV_CENTRE - 150 * v_beam;
    beam_i = PTV_CENTRE + 20 * v_beam;
    
    % plot the beam
    plot3([beam_0(1), beam_i(1)],[beam_0(2), beam_i(2)],[beam_0(3), beam_i(3)]);
end