% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System
% 
% Q3 Draw 3D Scene 

function Draw_3D_Scene()
% This function plots a 3D scene of the radiosurgery scenario, showing the
% head, PTV, OAR, isocenter, dose box, and coordinate axis.
% INPUT:
%       None
% OUTPUT:
%       None
% SIDE EFFECTS:
%       Plots a scene as described above

% declare some needed global variables 
global HEAD_CENTRE;
global HEAD_A;
global HEAD_B;
global HEAD_C;
global PTV_RAD;
global PTV_CENTRE;
global OAR_RAD;
global OAR_CENTRE;
global DOSE_BOX;

figure(1);

% generalize sphere points
[X, Y, Z] = sphere;

% PLOT HEAD

% get head ellipsoid points
X_H = X * HEAD_A;
Y_H = Y * HEAD_B;
Z_H = Z * HEAD_C;

% select head ellipsoid edge colour to be grey
lightGrey = [0.75 0.75 0.75];
%plot sphere (20x20 surface patches)
surf(X_H + HEAD_CENTRE(1), Y_H + HEAD_CENTRE(2), Z_H + HEAD_CENTRE(3),...
    'FaceColor', 'black','FaceAlpha', 0.03,'EdgeColor',lightGrey, 'EdgeAlpha', 0.5);
text(0.75*HEAD_A, 0.75*HEAD_B, 0, "Patient Brain");

hold on;
axis equal;
xlabel("X Axis");
ylabel("Y Axis");
zlabel("Z Axis");
title("3D Scene Visualization")

% PLOT OAR SPHERE
X_OAR = X * OAR_RAD;
Y_OAR = Y * OAR_RAD;
Z_OAR = Z * OAR_RAD;
% select tumor sphere edge colour to be red
lightRed = [1 0.75 0.75];
%plot sphere (20x20 surface patches)
surf(X_OAR + OAR_CENTRE(1), Y_OAR + OAR_CENTRE(2), Z_OAR + OAR_CENTRE(3),...
     'FaceColor', 'red', 'FaceAlpha', 0.3, 'EdgeColor',lightRed, 'EdgeAlpha', 0.3)
text(OAR_CENTRE(1) + OAR_RAD + 3, OAR_CENTRE(2), OAR_CENTRE(3), "OAR")
 
% PLOT PTV SPHERE
X_PTV = X * PTV_RAD;
Y_PTV = Y * PTV_RAD;
Z_PTV = Z * PTV_RAD;
% select tumor sphere edge colour to be red
lightYellow = [1 1 0.5];
%plot sphere (20x20 surface patches)
surf(X_PTV + PTV_CENTRE(1), Y_PTV + PTV_CENTRE(2), Z_PTV + PTV_CENTRE(3),...
     'FaceColor', 'yellow', 'FaceAlpha', 0.3, 'EdgeColor',lightYellow, 'EdgeAlpha', 0.3)
text(PTV_CENTRE(1), PTV_CENTRE(2) - PTV_RAD, PTV_CENTRE(3) - PTV_RAD, "PTV");

% PLOT DOSE BOX
% draw 12 edges between 8 point boundary
B1 = DOSE_BOX(1:3);
B2 = DOSE_BOX(4:6);
plot3([B1(1), B1(1)],[B1(2), B2(2)],[B1(3), B1(3)], 'm');
plot3([B1(1), B1(1)],[B1(2), B1(2)],[B1(3), B2(3)], 'm');
plot3([B1(1), B2(1)],[B1(2), B1(2)],[B1(3), B1(3)], 'm');
plot3([B1(1), B1(1)],[B2(2), B2(2)],[B1(3), B2(3)], 'm');
plot3([B1(1), B1(1)],[B1(2), B2(2)],[B2(3), B2(3)], 'm');
plot3([B1(1), B2(1)],[B2(2), B2(2)],[B1(3), B1(3)], 'm');
plot3([B2(1), B2(1)],[B1(2), B2(2)],[B1(3), B1(3)], 'm');
plot3([B2(1), B2(1)],[B1(2), B1(2)],[B1(3), B2(3)], 'm');
plot3([B1(1), B2(1)],[B1(2), B1(2)],[B2(3), B2(3)], 'm');
plot3([B1(1), B2(1)],[B2(2), B2(2)],[B2(3), B2(3)], 'm');
plot3([B2(1), B2(1)],[B1(2), B2(2)],[B2(3), B2(3)], 'm');
plot3([B2(1), B2(1)],[B2(2), B2(2)],[B1(3), B2(3)], 'm');
text(B2(1),B2(2),B2(3), "Dosage Box");

% PLOT ISOCENTRE
plot3(PTV_CENTRE(1), PTV_CENTRE(2), PTV_CENTRE(3), 'k.', 'MarkerSize', 20);
text(PTV_CENTRE(1)+3,PTV_CENTRE(2)+3, PTV_CENTRE(3), "Isocentre");

hold off;

end
