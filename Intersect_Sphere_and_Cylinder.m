% Nick Cheney
% SN 20063624 
% 2020/10/10 
% CISC 330 
% Computational Geometry Assignment 
% 
% Q4 Intersect-Sphere-and-Cylinder: This script contains the function
% Intersect_Sphere-and_Cylinder() that computes the number of intersection
% points between a sphere and an infinite cylinder. 

function ints = Intersect_Sphere_and_Cylinder(C, R, r, P, v)
% Intersect_Sphere_and_Cylinder(C, R, r, P, v) finds the number of
% intersections between a Sphere, denoted by a centre point C and radius R,
% and an infinite cylinder denoted by its radius r, a fixed point on its
% axis, P, and direction vector v. The number of intersections is returned
% as a single value. The function will validate that all input is
% numerical, R and r are single values, and C, P and v are 1x3 matrices,
% and any invalid input will result in an error message being thrown.
% INPUTS:
%       C - the centre point of the sphere
%       R - the radius of the sphere
%       r - the radius of the cylinder
%       P - a point on the cylinder's central axis
%       v - a direction vector for the cylinder's central axis
% OUTPUTS:
%       ints - the number of intersections between the sphere and cylinder
%       (0, 1 or Inf)
% SIDE EFFECTS:
%       Input is validated to ensure all arguments are numeric, C, P and v
%       have 1x3 dimensionality, and R and r have 1x1 dimensionality and
%       are postive. An error is thrown if any values are invalid. Also, an
%       error is thrown if the direction vector v has magnitude 0.

% first, we need to validate the input. all values must be numeric, vectors
% must have 1x3 dimensionality and radii must have 1x1 dimensionality and
% be positive.

type = {'numeric'};
vec_size = {'size',[1, 3]};
rad_size = {'size',[1, 1]};
% First validate point coordinates and vector
validateattributes(C, type, vec_size)
validateattributes(P, type, vec_size)
validateattributes(v, type, vec_size)
% Then validate radii
validateattributes(R, type, rad_size)
validateattributes(r, type, rad_size)

% And check if radii are equal to 0
if (R == 0 || r == 0)
    error("Radius must be a positive number ")
end
% Then, we'll check to see if the cylinders's direction vector has
% magnitude 0, which isn't allowed for this computation.
if (norm(v) == 0)
    error("Direction vector v cannot have magnitude 0 ")
end

% Now that all input is validated, we can begin the computation. First, we
% need to find the closest point on the central axis of the cylinder to the
% centre of the sphere. We can write an equation for the line of the
% cylinder's central axis as L = P + tv, where t is a scalar parameter.
% When L is the closest to the sphere's centre C, the cylinder's direction
% vector v and the line between L and C (C - L) are orthogonal. Thus, the
% dot product of the two is zero: 
% v(C - L) = 0
% Subbing in the definition of L we get:
% v(C - P - tv) = 0
% After distributing the tv term:
% v(C - P) - vvt = 0
% and then rearranging for t:
% t = (vv)^-1(v(C - P))
% The equivalent in matlab:
t = (v*v.')\(v*((C - P).'));

% Now we can compute L = P = tv
L = P + t*v;

% And find the distance from L to C:
dist = norm(C - L);

% At this point, we have the distance from sphere centre C to the nearest
% point on the central axis of the cylinder. We can now use a set of
% conditionals to determine the number of intersection points. 

% If dist = 0, then the cylinder and sphere share the same centre. In this
% case, if the sphere radius R is less than the cylinder radius r, then the
% sphere is completely interior to the cylinder and there are 0
% intersections. If the radii are equal or the sphere's radius is greater,
% there is an implicit surface intersection and thus infinite
% intersections.

% If dist < r, there are three possibilities to consider. If R + dist < r,
% than the sphere is still entirely enveloped in the cylinder and there are
% zero intersections. If R + dist = r, then the sphere just barely touches
% the inside of the cylinder and there is 1 intersection. If R + dist > r,
% than there is overlap between the sphere and cylinder and thus infinite
% intersections.

% If dist == r, a sphere of any radius will result in overlap and thus
% there will be infinite intersections.

% If dist > r, there are again 3 cases to consider. If dist > R + r, the
% sphere is too far to intersect, thus 0 points of intersection. If
% dist=R+r, then the sphere just barely touches the cylinder externally and
% there is 1 intersection. If dist < R + r, there is again overlap, and
% therefore infinite intersections.

%These conditions are layed out below, and ints is assigned appropriately.

if (dist == 0)
    % sphere centre on cylinder central axis
    if (R < r)
        ints = 0;
    else 
        ints = Inf;
    end
elseif (dist < r)
    % sphere centre within cylinder
    if (R + dist < r)
        ints = 0;
    elseif (R + dist == r)
        ints = 1;
    else 
        ints = Inf;
    end
elseif (dist == r)
    % sphere centre on cylinder
    ints = Inf;
else
    % sphere centre exterior to cylinder
    if (dist > R + r)
        ints = 0;
    elseif (dist == R + r)
        ints = 1;
    else
        ints = Inf;
    end
end

end