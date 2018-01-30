%This script computes planes in the point cloud resulting from an .obj file.
%All the extracted planes are stored in the cell named planes.

obj = readObj('example.obj'); %use appropriate file

XYZ = obj.v;
XYZ = XYZ(:, 1:3);

i = 1;

while (size(XYZ, 1) > 3)
 
    %Set RANSAC threshold for plane computation. In this case RANSAC threshold is set to 1m.
    [B, P, inliers, A] = ransacfitplane(XYZ', 1);
 
    for j = 1 : size(inliers, 1)
     
        inliersXYZ(j, 1:3) = XYZ(inliers(j), 1:3);
     
    end
 
    planes{i} = inliersXYZ;
 
    XYZ([inliers], :) = [];
 
    i = i + 1;
 
    clear B P inliers A inliersXYZ
end

