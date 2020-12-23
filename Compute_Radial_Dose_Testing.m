% Nick Cheney
% SN 20063624
% 2020/12/09
% CISC 330 
% Gamma Knife System

% This script tests the function Compute_Radial_Dose() by calling it with a
% given resolution then printing the resulting table to console and
% capturing it as a global variable

% set resolution to 1 mm
res = 1;

global RDF_TABLE;
RDF_TABLE = Compute_Radial_Dose(res)