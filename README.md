# Segmentation-of-3D-models
Segment a 3D model into semantically meaningful partial models
This repository contains code for 3D segmentation of .obj files, based on 3D and 2D characteristics, as explained in the methodology .pdf.

Point clouds sourcing from .obj files are first segmented using a RANSAC based approach and planes are computed. You may run onlyRANSAC.m to 
extract planes based only on geometric features. 

For the combined 2D/3D segmentation you need:
1) A point cloud sourcing from multiple overlapping images in .obj format.
2) The images, segmented using an image segmentation approach. In our case k-means image segmentation has been performed
using spatial and colour features as presented by Mohammad Al Nagdawi (in https://www.mathworks.com/matlabcentral/answers/324455-k-means-image-segmentation-based-on-intensity-and-spatial?requestedDomain=true) . 
A sample segmented image is available in the sample files folder under the name 'sampleImage.tif'. 
3) A .txt file recording the names of all the available images as in the sample file 'images.txt', stored in sample files folder.
4) A .txt file recording the exterior orientation for each image with format Xo(m) Yo(m) Zo(m) omega(degrees) phi(degrees) kappa(degrees).
A sample file with name 'exteriorRansac.txt' is available in the sample files folder. 
!! The sequence of images files in 'images.txt' and of exterior orientation in 'exterioRansac.txt' has to be same. 
5) The interior orientation of the images (c camera constant measured in pixels), principal point coordinates (x0,y0 measured in pixels) and the image dimensions (measured in pixels). The values for
these variables have to be set in computePlanes.m and in pointToImage.m files (where comments indicate).

In order to run the whole script for combined (2D/3D) segmentation, you run the example.m, where you have to load your .obj file and set the value for the RANSAC threshold. 


Copyrights:
-fitplane.m
-iscolinear.m
-isdegegenerate.m
-ransac.m
-ransacfitplane.m
-dbscan.m
have been written by Peter Kovesi and downloaded from http://www.peterkovesi.com/matlabfns/

-Rfromangles.m
-colinearity.m
have been written by I. Kalisperakis et al and downloaded from http://photogram.tg.teiath.gr/?page_id=122

-readObj.m
has been written by Bernard Abayowa and downloaded from https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/65052/versions/1/previews/PN_triangle/readObj.m/index.html?access_key=





