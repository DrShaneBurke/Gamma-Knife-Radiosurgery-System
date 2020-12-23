% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q15 Dosimetry Analysis

% This script plots the tumor vs the surface of 100% isodose coverage, and
% then plots dosage volume histograms for the tumor and organ to be saved.

% run Compute_Dose() to set dose cubes 
Compute_Dose()

global D_100;
global PTV_CENTRE;
global PTV_RAD;
global OAR_CENTRE;
global OAR_RAD;
global PTV_DOSE_CUBE;
global OAR_DOSE_CUBE;

[M1,M2,M3] = size(PTV_DOSE_CUBE);
[N1,N2,N3] = size(PTV_DOSE_CUBE);

figure(5)
%decimal +/- range for 100% isodose margin
margin = 0.075;
X = [];
Y = [];
Z = [];
%find voxels with dosages within this range and plot as an alpha surface
for i = 1:N1
    for j = 1:4:N2
        for k = 1:N3
            % check if voxel's radiation in specified range
             if D_100*(1-margin) < round(PTV_DOSE_CUBE(i,j+3,k)) && round(PTV_DOSE_CUBE(i,j+3,k))< D_100*(1+margin)
                centre = PTV_DOSE_CUBE(i,j:j+2,k);
                % if so, record voxel coordinates
                X = [X; centre(1)];
                Y = [Y; centre(2)];
                Z = [Z; centre(3)];
             end
        end
    end
end

% plot an alpha shape using 100% isodose voxel coordinates
shp = alphaShape(X, Y, Z, PTV_RAD);
plot(shp, 'FaceColor', 'blue','EdgeAlpha', 0.2)
axis equal;
xlabel("X Axis")
ylabel("Y Axis")
zlabel("Z Axis")
title("PTV vs 100% Isodose Surface")
hold on;


% PLOT PTV SPHERE
[X,Y,Z] = sphere;
X_PTV = X * PTV_RAD;
Y_PTV = Y * PTV_RAD;
Z_PTV = Z * PTV_RAD;
% select tumor sphere edge colour to be red
lightYellow = [1 1 0.5];
%plot sphere (20x20 surface patches)
surf(X_PTV + PTV_CENTRE(1), Y_PTV + PTV_CENTRE(2), Z_PTV + PTV_CENTRE(3),...
     'FaceColor', 'yellow', 'FaceAlpha', 0.3, 'EdgeColor',lightYellow, 'EdgeAlpha', 0.3)
legend("100% Isodose Surface", "PTV");


% next, plot the DVH for the OAR and PTV

max_X = 140;

range_PTV = zeros(max_X,1);
range_OAR = range_PTV;
y_PTV = range_PTV;
y_OAR = range_PTV;
% run through dose boxes for PTV and OAR, place voxels into bins for the
% histogram

for i = 1:N1
     for j = 1:4:N2
         for k = 1:N3
             % check if point is inside PTV sphere
             centre = PTV_DOSE_CUBE(i,j:j+2,k);
             if (centre(1) - PTV_CENTRE(1))^2 + (centre(2) - PTV_CENTRE(2))^2 + (centre(3) - PTV_CENTRE(3))^2 <= PTV_RAD^2
                % if so, use dosage value to increment corrosponding
                % element of range_PTV vector
                ndx = round(PTV_DOSE_CUBE(i,j+3,k)/D_100*100);
                range_PTV(ndx+1) = range_PTV(ndx+1) + 1;
             end
         end
     end
end

for i = 1:M1
     for j = 1:4:M2
         for k = 1:M3
             % check if point is inside PTV sphere
             centre = OAR_DOSE_CUBE(i,j:j+2,k);
             if (centre(1) - OAR_CENTRE(1))^2 + (centre(2) - OAR_CENTRE(2))^2 + (centre(3) - OAR_CENTRE(3))^2 <= OAR_RAD^2
                % if so, use dosage value to increment corrosponding
                % element of range_PTV vector
                ndx = round(OAR_DOSE_CUBE(i,j+3,k)/D_100*100);
                range_OAR(ndx+1) = range_OAR(ndx+1) + 1;
             end
         end
     end
end

% now compute relevent y value vectors for the histogram
total_PTV = sum(range_PTV);
total_OAR = sum(range_OAR);
for i = 1:max_X
    % add ratio of total structure volume to sets of y-values for histogram
    less_PTV = sum(range_PTV(1:i-1));
    less_OAR = sum(range_OAR(1:i-1));
    
    %calculate net total structure volume ratio at a given dosage
    y_PTV(i) = (total_PTV - less_PTV) / total_PTV * 100;
    y_OAR(i) = (total_OAR - less_OAR) / total_OAR * 100;
end

% and finally plot the results, along with an x axis incrementing by 1 from
% 0 to 150
figure(6)
plot((1:max_X).', [y_PTV, y_OAR], '.-');
grid on;
xlabel("relative dose [%]")
ylabel("ratio of total structure volume [%]")
title("OAR and PTV Dose Volume Histograms")
legend('PTV','OAR')
