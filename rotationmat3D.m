function [R] = rotationmat3D(theta0,u)
ux = u(1);
uy = u(2);
uz = u(3);
c = cos(theta0);
s = sin(theta0);

R = zeros(3,3);
R(1,1) = ux^2 + (uy^2 + uz^2)*c;
R(2,2) = uy^2 + (ux^2 + uz^2)*c;
R(3,3) = uz^2 + (ux^2 + uy^2)*c;

R(1,2) = ux*uy*(1-c) - uz*s;
R(1,3) = ux*uz*(1-c) + uy*s;
R(2,1) = ux*uy*(1-c) + uz*s;
R(3,1) = ux*uz*(1-c) - uy*s;

R(2,3) = uy*uz*(1-c) - ux*s;
R(3,2) = uy*uz*(1-c) + ux*s;