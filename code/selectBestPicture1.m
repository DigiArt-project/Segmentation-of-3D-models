%This function returns the most appropriate image for image segmentation according to predefined criteria (selects the most fronto-parallel view where the object is 
% depicted in the center of the image). The inputs of the function are the 3D XYZ coordinates of the barycenter of the 3D object that is going to be segmented in the 
% 2D space, the principal point coordinates of the images x0, y0, the camera constant c, tha dimention of the images imageDimention X, imageDimentrion Y and two files.
% The file named fileNameExterior records the exterior orientation of all the available images and the file fileNameImages records the names of all the available images.
% Sample files are available at the repository. 

function [picture1] = selectBestPicture1(X, Y, Z, x0, y0, c, fileNameExterior, imageDimentionX, imageDimentionY, fileNameImages)

clear F R distanceFromCenter finalSelection sorted angles x y

F = dlmread(fileNameExterior);
R = zeros(3, 3);

for i = 1 : size(F, 1);
 
    X0 = F(i, 1);
    Y0 = F(i, 2);
    Z0 = F(i, 3);
    omega = F(i, 4) * pi / 180;
    phi = F(i, 5) * pi / 180;
    kappa = F(i, 6) * pi / 180;
 
    [x, y] = colinearity(c, x0, y0, X0, Y0, Z0, omega, phi, kappa, X, Y, Z);
 
    i_new(i, 1) = - y + imageDimentionY / 2;
    j_new(i, 1) = x + imageDimentionX / 2;
 
    clear x y
    angles(i, 1) = omega ^ 2 + phi ^ 2 + kappa ^ 2;
    angles(i, 2) = i;
 
end

distanceFromCenter = zeros(size(i_new, 1), 2);

for i = 1 : size(i_new, 1);
 
    distanceFromCenter(i, 1) = sqrt(i_new(i, 1) ^ 2 + j_new(i, 1) ^ 2);
    distanceFromCenter(i, 2) = i;
 
end

l = 1;

for j = 1 : size(i_new, 1);
 
    if (0 <= i_new(j, 1) && i_new(j, 1) <= imageDimentionY) && (0 <= j_new(j, 1) && j_new(j, 1) <= imageDimentionX)
     
        finalSelection(l, 1) = distanceFromCenter(l, 1);
        finalSelection(l, 2) = distanceFromCenter(l, 2);
        l = l + 1;
     
    end
end

sortedAngles = sortrows(angles, 1);
sortedDistances = sortrows(finalSelection, 1);
sorted = sortrows(angles, 1);

index1 = isempty(find(sortedDistances == sorted(1, 2)));
index2 = isempty(find(sortedDistances == sorted(2, 2)));
index3 = isempty(find(sortedDistances == sorted(3, 2)));

C = readtable(fileNameImages);
deiktis = sorted(1, 2);

if (index1 == 0)
    picture1 = C.Images{sorted(1, 2), 1};
 
elseif (index2 == 0)
    picture1 = C.Images{sorted(2, 2), 1};
elseif (index3 == 0)
    picture1 = C.Images{sorted(3, 2), 1};
else picture1 = C.Images{1};
end

end


