% Nick Cheney
% SN 20063624 
% 2020/10/10 
% CISC 330 
% Computational Geometry Assignment 
% 
% Q4. Intersect-Sphere-and-Clyinder Testing: This script tests the function
% Intersect_Sphere_and_Cylinder() that computes the number of intersections
% of a sphere and a cylinder. To do so, it calls its function case_test(),
% which tries calling Intersect_Sphere_and_Cylinder() with various values
% for C, R, r, P, v.

%The script starts by calling Intersect_Sphere_and_Cylinder() with invalid
%input(s) via case_test()

% string value provided as argument
case_test([0 0 0], 1, 1, [0 0 0], "dir vector");
% radius value has wrong dimensionality
case_test([0 0 0], [1 0], 1, [0 0 0], [0 0 1])
% cylinder axis dir. vector has wrong dimensionality
case_test([0 0 0], 1, 1, [0 0 0], [0; 0; 1])
% direction vector has zero magnitude
case_test([0 0 0], 1, 1, [0 0 0], [0 0 0])
% Sphere radius is zero
case_test([0 0 0], 0, 1, [0 0 0], [0 0 1])

% Then with valid inputs
% External sphere, no intersections
case_test([0 3 0], 1, 1, [0 0 0], [0 0 1])
% External sphere, one intersection
case_test([0 2 0], 1, 1, [0 0 0], [0 0 1])
% External sphere, infinite intersections
case_test([0 2 0], 2, 1, [0 0 0], [0 0 1])

% Internal sphere, no intersections
case_test([0 0 1], 1, 2, [0 0 0], [0 0 1])
% Internal sphere, one intersection
case_test([0 1 1], 1, 2, [0 0 0], [0 0 1])
% Internal sphere, infinite intersections
case_test([0 0 0], 2, 1, [0 0 0], [0 0 1])

function case_test(C, R, r, P, v)
% case_test(C, R, r, P, v) attempts to call the function
% Intersect_Sphere_and_Cylinder to find the number of intersections of a
% sphere, defined by centre C and radius R, and an infinite cylinder,
% defined by radius r, central axis point P and central axis dir. vector v.
% It will then either print the number of intersections, or catch an error
% thrown by the function, display the error message to stderr and then
% terminate. 
% INPUTS:
%       C - the centre point of the sphere
%       R - the radius of the sphere
%       r - the radius of the cylinder
%       P - a point on the cylinder's central axis
%       v - a direction vector for the cylinder's central axis
% OUTPUTS:
%       None
% SIDE EFFECTS:
%       On valid input prints the number of intersections of sphere and
%       cylinder.
% 
%       Otherwise, catches and prints any error message thrown by
%       Intersect_Line_and_Ellipsoid() to stderr, then terminates.

fprintf("Finding number of intersections of a sphere and cylinder:\n");
try
    % Attempt to assign variables to the output of Intersect_Line_and_Ellipsoid()
    num_int = Intersect_Sphere_and_Cylinder(C, R, r, P, v);
catch e 
    %error is thrown because input wasn't valid or incorrect
    fprintf(2, e.message); % print error's message to stderr
    fprintf("\n\n");
    return; % terminate
end

% Variable successfully assigned, proceed to outputting number of
% intersections
fprintf("Sphere defined by centre (%g, %g, %g) and radius %g\n", C(1),C(2),C(3),R);
fprintf("Cylinder defined by central axis point (%g, %g, %g), direction"...
        +" vector (%g, %g, %g) and radius %g\n", P(1),P(2),P(3), v(1),v(2),...
        v(3), r);
fprintf("Number of intersections: %g\n\n",num_int);

end