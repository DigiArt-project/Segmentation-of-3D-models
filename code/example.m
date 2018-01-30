%The example.m is called to run the whole experiment. 
%In this script you have to load the appropriate .obj file
% you need to segment and set the RANSAC threshold to an
%appropriate value for you data. The script computes a cell
%containing all the segmented planes from the .obj file
%based on 2D and 3D features.

%obj = readObj('example.obj'); %use appropriate file

XYZ = obj.v;
XYZ = XYZ(:, 1:3);

i = 1;

while (size(XYZ, 1) > 3)
     
    % set the ransac thershold you choose. In this example, RANSAC threshold is set to 1m.
    [finalPlane, YY] = computePlanes(XYZ, 1);
 
    planes{i} = finalPlane;
    clear finalPlane XYZ
    XYZ = YY;
    i = i + 1;
 
end



