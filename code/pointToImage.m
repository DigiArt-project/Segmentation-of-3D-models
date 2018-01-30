%The function pointToImage returns the x,y image coordinates 
%of a X,Y,Z 3D point

function[x, y] = pointToImage(exteriorFile, X, Y, Z)

external = dlmread(exteriorFile);

X0 = external(1);
Y0 = external(2);
Z0 = external(3);
omega = (external(4) * pi / 180);
phi = (external(5) * pi / 180);
kappa = (external(6) * pi / 180);

%change the variable for the camera constant and the principal point coordinates
c = 4772.068 / 10;
x0 = 0;
y0 = 0;

[x, y] = colinearity(c, x0, y0, X0, Y0, Z0, omega, phi, kappa, X, Y, Z);

end