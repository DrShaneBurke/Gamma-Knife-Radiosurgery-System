% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% Q16 Compute Surface Dose

function Compute_Surface_Dose()
% This function computes the doses on the surfaces of the PTV and OAR, and
% plots the results along with the coldest and hottest locations on each
% surface
% INPUT:
%       None.
% OUPUT:
%       None.
% SIDE EFFECTS:
%       PTV and OAR surface doses are plotted, color coded based on dosage

% initialize sphere of PTV points
global PTV_CENTRE;
global PTV_RAD;
global OAR_RAD;
global OAR_CENTRE;
global BEAM_STRUCT_ARRAY;
global D_0;
[N,~] = size(BEAM_STRUCT_ARRAY);

dim = 41; %adjust to get better resolution
[X,Y,Z]=sphere(dim-1);
X = X * PTV_RAD + PTV_CENTRE(1); 
Y = Y * PTV_RAD + PTV_CENTRE(2); 
Z = Z * PTV_RAD + PTV_CENTRE(3); 

%set colour map to point dose values, record hottest and coldest dose and
%location

hottest = [0,0,0,0];
coldest = [0,0,0,N*D_0]; % uses maximum possible dosage
C=zeros(dim,dim);
for i = 1:dim
    for j = 1:dim
        C(i,j) = Compute_Point_Dose_from_All_Beams([X(i,j), Y(i,j), Z(i,j)]);
        if C(i,j) > hottest(4)
            hottest = [X(i,j), Y(i,j), Z(i,j),C(i,j)];
        end
        
        if C(i,j) < coldest(4)
            coldest = [X(i,j), Y(i,j), Z(i,j),C(i,j)];
        end
    end
end

figure(7)
surf(X,Y,Z,C,'EdgeAlpha',0.05)
axis equal
% select color map
colormap turbo; %comment this out if using an older version of MATLAB
shading interp
xlabel("X Axis")
ylabel("Y Axis")
zlabel("Z Axis")
title("PTV Surface Dosage Plot")
colorbar
hold on
% plot hottest and coldest points
plot3(hottest(1),hottest(2),hottest(3),'w.','MarkerSize',20);
txt_h = sprintf("Hottest Point: %g",hottest(4));
text(hottest(1),hottest(2),hottest(3)+3, txt_h)
plot3(coldest(1),coldest(2),coldest(3),'w.','MarkerSize',20);
txt_c = sprintf("Coldest Point: %g",coldest(4));
text(coldest(1)+5,coldest(2)+5,coldest(3)+3, txt_c)
% and print these values 
fprintf("Hottest point on PTV: (%.2f, %.2f, %.2f)\t Dosage: %.2f\n",...
    hottest(1),hottest(2),hottest(3),hottest(4));
fprintf("Coldest point on PTV: (%.2f, %.2f, %.2f)\t Dosage: %.2f\n\n",...
    coldest(1),coldest(2),coldest(3),coldest(4));

% and now plot the same for the OAR
[X,Y,Z]=sphere(dim-1);
X = X * OAR_RAD + OAR_CENTRE(1); 
Y = Y * OAR_RAD + OAR_CENTRE(2); 
Z = Z * OAR_RAD + OAR_CENTRE(3); 

%set colour map to point dose values, record hottest and coldest dose and
%location
hottest = [0,0,0,0];
coldest = [0,0,0,N*D_0]; % uses maximum possible dosage
C=zeros(dim,dim);
for i = 1:dim
    for j = 1:dim
        C(i,j) = Compute_Point_Dose_from_All_Beams([X(i,j), Y(i,j), Z(i,j)]);
        if C(i,j) > hottest(4)
            hottest = [X(i,j), Y(i,j), Z(i,j),C(i,j)];
        end
        
        if C(i,j) < coldest(4)
            coldest = [X(i,j), Y(i,j), Z(i,j),C(i,j)];
        end
    end
end
figure(8)
surf(X,Y,Z,C,'EdgeAlpha',0.05)
axis equal
% select color map
colormap turbo; %comment this out if using an older version of MATLAB
shading interp
xlabel("X Axis")
ylabel("Y Axis")
zlabel("Z Axis")
title("OAR Surface Dosage Plot")
colorbar
hold on
% plot hottest and coldest points
plot3(hottest(1),hottest(2),hottest(3),'w.','MarkerSize',20);
txt_h = sprintf("Hottest Point: %g",hottest(4));
text(hottest(1),hottest(2),hottest(3)+3, txt_h)
plot3(coldest(1),coldest(2),coldest(3),'w.','MarkerSize',20);
txt_c = sprintf("Coldest Point: %g",coldest(4));
text(coldest(1)+5,coldest(2)+5,coldest(3)+3, txt_c)
fprintf("Hottest point on OAR: (%.2f, %.2f, %.2f)\t Dosage: %.2f\n",...
    hottest(1),hottest(2),hottest(3),hottest(4));
fprintf("Coldest point on OAR: (%.2f, %.2f, %.2f)\t Dosage: %.2f\n\n",...
    coldest(1),coldest(2),coldest(3),coldest(4));
end