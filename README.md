# Gamma Knife Radiosurgery System
This program implements a simple Gamma Knife radiosurgery treatment plan for the lethal irradiation of a small metastatic brain tumor. Point sources of Cobalt-60 provide cylindrical (pencil) beams of radiation in a hemispheric (helment) arrangement, separated by uniform polar angles, and the centre lines of each beam intersect at a common point, the isocentre. The area to be strongly irradiated (prescribed target volume, PTV) and an area to be minimally irradiated (organ at risk, OAR) are represented as spheres with a given centre and radius. 

To focus the radiation on the PTV, a head frame is screwed into the patients head and positioned within the Gamma Knife "helmet" such that the aforementioned isocentre coincides with the centre of the PTV. From here, any beams directly passing through the OAR are plugged to minimize the radiation passing through it. Then, dose boxes eclosing the PTV and OAR are created, and point radiations throughout these cubes are computed to verify that none of the OAR receives more than a set maximum dose and all of the PTV receives the minimum prescribed dose. The dose at a given point is the result of the summation of the dosage received at that point from each beam, which is in turn a function of the beam's initial intensity, depth travelled into the tissue when nearest the point (dose absorption function, DAF), and minimal radial distance from the point (Radial Dose Function, RDF). This is described in greater detail in code comments. 

## Compute_Dose_Box
Computes the uppper and lower bounds of a dose box containing the OAR and PTV. Later changed to split these up.

## Draw_3D_Scene
Visualizes the positions of the OAR, PTV and head in 3D

## Compute_Dose_Absorption_Function_Table
Precomputes the DAF at depths of 1 mm increments

## Compute_Radial_Dose_Function_Table
Precomputes the RDF at radial distances in 1 mm increments

## Compute_Beam_Directions
Computes each beam's direction vector (pointing from location on hemisphere to isocentre)

## Compute_Skin_Entry_Points
Computes the intersection of each beam with the head surface (approximated as an ellipsoid) 

## Compute_Beam_Safety_Flags
Computes a flag for each beam indicating whether it intersects the OAR (unsafe) or not (safe)

## Compute_Radial_Distance
Computes the radial distance between a single point and a beam

## Compute_Depth_from_Skin
Computes a single point's depth into the skin with respect to a given beam

## Compute_Point_Dose_from_Beam
Computes the point dose at a point from a single beam

## Compute_Point_Dose_from_All_Beams
Computes the net point dose from all beams at a given point

## Compute_Dose
Creates 3-D arrays of voxel points with a given resolution (e.g. l = w = h = 1 mm) encompassing the OAR and PTV, and computes the net dose at each voxel point.

## Dosimetry Analysis
Creates a plot comparing the PTV surface to the surface of 100% isodose (surface along which the prescribed dosage is provided). Also plots a Dose Volume Histogram from the PTV and OAR 

## Compute_Surface_Dose
Plots the surfaces of the PTV and OAR, colour coded by the levels of radiation received at each point on each sphere. Also computes the lowest (coldest) and highest (hottest) dosages on each surface as well as their locations. 
