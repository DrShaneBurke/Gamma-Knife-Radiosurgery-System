% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Beam_Safety_Flags() by creating a
% plot of the flagged unsafe beams as cylinders and the OAR to visually
% verify that each plotted beam actually intersects the OAR sphere.

%run the function 
Compute_Beam_Safety_Flags()

global PTV_CENTRE;
global OAR_CENTRE;
global OAR_RAD;

% new figure
figure(4)

% start by plotting OAR sphere
[X,Y,Z] = sphere;
X = X * OAR_RAD + OAR_CENTRE(1);
Y = Y * OAR_RAD + OAR_CENTRE(2);
Z = Z * OAR_RAD + OAR_CENTRE(3);
surf(X,Y,Z, 'FaceAlpha', 0.2, 'EdgeColor', 'red');

% set some options
hold on;
axis equal;
xlabel("X Axis")
ylabel("Y Axis")
zlabel("Z Axis")
title("Plot of OAR and Unsafe Radiation Beams")
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
    'FaceColor', 'black','FaceAlpha', 0.03,'EdgeColor',lightGrey, 'EdgeAlpha', 0.5);

% now plot each unsafe beam as a cylinder 
[numBeams, ~] = size(BEAM_STRUCT_ARRAY);


for i = 1:numBeams
    % check flag to see if beam is unsafe
    if BEAM_STRUCT_ARRAY(i,10) == 0
        % create beam cylinder
        [X,Y,Z] = cylinder;
        [M, N] = size(X);
        End = zeros(1,N);
        End2= ones(1,N);
        
        % add extra row to ensure cylinder ends are coloured, stretch cylinder
        X = [End; X; End] * 15;
        Y = [End; Y; End] * 15;
        Z = [End; Z; End2] * 150;
    
        % initialize two rotation matrices to rotate beam cylinder
        [rot1, ~] = Rotation_About_Frame_Axis("y", -BEAM_STRUCT_ARRAY(i,2));
        [rot2, ~] = Rotation_About_Frame_Axis("z", BEAM_STRUCT_ARRAY(i,1));
    
        % rotate all cylinder points accordingly, centre on isocentre and reassign
        for j = 1:M+2
            for k = 1:N
                new_pt = (rot2 * rot1 * [X(j,k);Y(j,k);Z(j,k)]) + PTV_CENTRE.';
                X(j,k) = new_pt(1);
                Y(j,k) = new_pt(2);
                Z(j,k) = new_pt(3);
            end
        end
        % now we are ready to plot the beam
        surf(X,Y,Z, 'FaceColor', 'yellow', 'FaceAlpha', 0.4, 'EdgeColor', 'black','EdgeAlpha',0.05);
        
        % and plot the beam central line for more clarity
        % get dir vector
        v_beam = BEAM_STRUCT_ARRAY(i,3:5);
        % choose reasonable start and endpoints
        beam_0 = PTV_CENTRE - 150 * v_beam;
        beam_i = PTV_CENTRE;
    
        % plot the beam
        plot3([beam_0(1), beam_i(1)],[beam_0(2), beam_i(2)],[beam_0(3), beam_i(3)], 'k');
    end
end