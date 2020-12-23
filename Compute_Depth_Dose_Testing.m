% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This module tests the function Compute_Depth_Dose by calling it with a
% given resolution and max depth then printing the table to the console.

% set resolution to 1 mm
res = 1;

% set max depth to 200 cm, this is twice the longest half axis length (y =
% 100 mm)
max_dep = 200;

% Need to capture the table as a global variable for later usage
global DAF_TABLE;
DAF_TABLE = Compute_Depth_Dose(res, max_dep)