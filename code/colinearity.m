function  [x,y]=colinearity(c,xo,yo,Xo,Yo,Zo,omega,phi,kappa,X,Y,Z)

%  Author: PCVG
%  2002
%  angles in rad

R=R_from_angles(omega,phi,kappa,0);

x= xo-(c*((R(1,1)*(X-Xo)+R(1,2)*(Y-Yo)+R(1,3)*(Z-Zo))/...
        (R(3,1)*(X-Xo)+R(3,2)*(Y-Yo)+R(3,3)*(Z-Zo))));

y= yo-(c*((R(2,1)*(X-Xo)+R(2,2)*(Y-Yo)+R(2,3)*(Z-Zo))/...
        (R(3,1)*(X-Xo)+R(3,2)*(Y-Yo)+R(3,3)*(Z-Zo))));
                           
                           
                         
