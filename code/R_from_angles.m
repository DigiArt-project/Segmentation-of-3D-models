function R=R_from_angles(omega,phi,kappa,units)

% Returns the rotation matrix given the three angles
% units: 0 rad (default)
%        1 grad
%        2 deg
%
%  Author: Ilias Kalisperakis 
%  2002


if nargin==3 
    units=0;
end

if units ==1
    omega=omega*pi/200;
    phi=phi*pi/200;
    kappa=kappa*pi/200;
    
elseif units == 2
    omega=omega*pi/180;
    phi=phi*pi/180;
    kappa=kappa*pi/180;
    
end

    

R=[  (cos(kappa)*cos(phi))             (cos(kappa)*sin(phi)*sin(omega)+sin(kappa)*cos(omega))            (((-cos(kappa))*sin(phi)*cos(omega))+(sin(kappa)*sin(omega)))
    (-sin(kappa)*cos(phi))      (((-sin(kappa))*sin(phi)*sin(omega))+(cos(kappa)*cos(omega)))                   (sin(kappa)*sin(phi)*cos(omega)+cos(kappa)*sin(omega))
                  sin(phi)                                             (-cos(phi))*sin(omega)                                                      cos(phi)*cos(omega)];
              

    