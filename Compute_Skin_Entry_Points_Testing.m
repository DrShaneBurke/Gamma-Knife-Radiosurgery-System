% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Skin_Entry_Points() by taking the
% computed skin entry point for each beam and creating a plot showing the
% skin surface(head), plotted entry points, and beams.

Compute_Skin_Entry_Points()

[N, ~] = size(BEAM_STRUCT_ARRAY);

figure(3)

% PLOT HEAD

% generalize sphere points
[X, Y, Z] = sphere;
% get head ellipsoid points
X_H = X * HEAD_A;
Y_H = Y * HEAD_B;
Z_H = Z * HEAD_C;
% select head ellipsoid edge colour to be grey
lightGrey = [0.75 0.75 0.75];
%plot sphere (20x20 surface patches)
surf(X_H + HEAD_CENTRE(1), Y_H + HEAD_CENTRE(2), Z_H + HEAD_CENTRE(3),...
    'FaceColor', 'black','FaceAlpha', 0.08,'EdgeColor',lightGrey, 'EdgeAlpha', 0.5);
% text(0.75*HEAD_A, 0.75*HEAD_B, 0, "Patient Brain");

hold on;
axis equal;
xlabel("X Axis");
ylabel("Y Axis");
zlabel("Z Axis");
title("Beam Skin Entry Points")

% plot isocenter
plot3(PTV_CENTRE(1),PTV_CENTRE(2),PTV_CENTRE(3),'.k','MarkerSize',15);

% plot all beams
for i = 1:N
    % get dir vector
    v_beam = BEAM_STRUCT_ARRAY(i,3:5);
    % choose reasonable start and endpoints
    beam_0 = PTV_CENTRE - 150 * v_beam;
    beam_i = PTV_CENTRE + 0 * v_beam;
    
    % plot the beam
    plot3([beam_0(1), beam_i(1)],[beam_0(2), beam_i(2)],[beam_0(3), beam_i(3)]);
    
    % finally, plot the skin entry point for each beam
    int = BEAM_STRUCT_ARRAY(i, 6:8);
    plot3(int(1),int(2),int(3),'r.','MarkerSize',10);
end

