function [X,Y,Z] = getCube(o, x, y, z)

xc=o(1); 
yc=o(2); 
zc=o(3);

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];

X = x*(X) + xc;
Y = y*(Y) + yc;
Z = z*(Z) + zc; 
end
