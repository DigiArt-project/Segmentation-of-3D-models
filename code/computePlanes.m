% This function takes as input a Nx3 matrix containing all the XYZ coordinates of the N points that belong to a point cloud
% and the RANSAC threshold to compute a plane in the point cloud.
% It returns the computed plane as finalPlane and the remaining point cloud YY. 

function [finalPlane, YY] = computePlanes(XYZ, ransacThreshold)

[B, P, inliers, A] = ransacfitplane(XYZ', ransacThreshold);

inliersMax = 0;
indexx = 0;

for i = 1 : size(A, 1)
 
    clear F X Y Z x y s1x s1y i_barycenter j_barycenter externalBestPicture inliersNew inliersXYZ F index XBarycenter YBarycenter ZBarycenter picture1 picture11 img
 
    inliersCount = 0;
    F = [A(i, :) 0];
 
    index = min(find(~ F, 1));
    inliersNew = F(1, 1: (index - 1));
    matrix(i, 1) = i;
    matrix(i, 2) = size(inliersNew, 2);
    matrix(i, 3) = inliersMax;
 
    if size(inliersNew, 2) > inliersMax
     
        matrix(i, 4) = 1;
        indexx = indexx + 1;
     
        for j = 1 : size(inliersNew, 2)
         
            inliersXYZ(j, 1:3) = XYZ(inliersNew(1, j), 1:3);
         
        end
     
        XBarycenter = mean(inliersXYZ(:, 1));
        YBarycenter = mean(inliersXYZ(:, 2));
        ZBarycenter = mean(inliersXYZ(:, 3));
        imageFile = 'images.txt';
        exteriorFile = 'externalRansac.txt';
     
        %change the values of principal points coordinates (x0, y0) , camera constant c and image dimension (xDimention, yDimention)
        x0 = 0;
        y0 = 0;
        c = 4772.068 / 10;
        xDimention = 5184 / 10;
        yDimention = 3456 / 10;
     
        %call the function to select the most favourable view for image segmentation
        [picture1] = selectBestPicture1(XBarycenter, YBarycenter, ZBarycenter, x0, y0, c, exteriorFile, xDimention, yDimention, imageFile);
     
        %Load the image to be segmented
        picture11 = imread(picture1);
        img = picture11;
        img = img(:, :, 1);
     
        C = readtable('images.txt');
        exteriorBest = dlmread(exteriorFile);
     
        for d = 1 : size(C, 1);
            if C.Images{d} == picture1;
                deiktis = d;
            end
        end
     
        externalBestPicture = exteriorBest(deiktis, :);
        dlmwrite('bestPicture', externalBestPicture);
        bestPictureExternal = 'bestPicture';
     
        [s1x, s1y] = pointToImage(bestPictureExternal, XBarycenter, YBarycenter, ZBarycenter);
        i_barycenter = - s1y + size(img, 1) / 2;
        j_barycenter = s1x + size(img, 2) / 2;
     
        counter = 0;
        for k = 1 : size(inliersXYZ, 1)
            count = 0;
         
            labelsUsed(indexx) = i;
         
            X = inliersXYZ(k, 1);
            Y = inliersXYZ(k, 2);
            Z = inliersXYZ(k, 3);
         
            [x, y] = pointToImage(bestPictureExternal, X, Y, Z);
         
            i_new(k, indexx) = - y + size(img, 1) / 2;
            j_new(k, indexx) = x + size(img, 2) / 2;
         
            if (round(i_new(k, indexx)) > 0 && round(j_new(k, indexx)) > 0 && round(i_new(k, indexx)) < 345 && round(j_new(k, indexx)) < 518) && (round(i_barycenter) > 0 && round(j_barycenter) > 0)
                if (img(round(i_new(k, indexx)), round(j_new(k, indexx))) == img(round(i_barycenter), round(j_barycenter)));
                    counter(k, 1) = count + 1;
                    counter(k, 2) = k;
                    labelsImage(k, indexx) = img(round(i_new(k, indexx)), round(j_new(k, indexx)));
                    inliersCount = inliersCount + 1;
                    if (inliersCount > 0)
                        pointsInInliers(inliersCount, 1, indexx) = inliersNew(k);
                        finalObjObject(inliersCount, 1:3, indexx) = inliersXYZ(k, 1:3);
                    end
                 
                end
            else
                inliersCount = inliersCount + 1;
                counter = counter + 1;
                if (inliersCount > 0)
                    finalObjObject(inliersCount, 1:3, indexx) = inliersXYZ(k, 1:3);
                    pointsInInliers(inliersCount, 1, indexx) = k;
                end
            end
        end
    end
 
    inliersUsed(indexx) = inliersCount;
 
    if (inliersCount > inliersMax)
        inliersMax = inliersCount;
        finalDeiktis = i;
        pointer = indexx;
     
    end
 
end

finalPlane = finalObjObject (:, :, pointer);
finalObjLabels = labelsUsed(:, pointer);
finalInliers = pointsInInliers(:, :, pointer);

YY = XYZ;
YY([finalInliers], :) = [];

