% _chassis = _c
% _bonnet = _b

%%  Bonnet
o = [3720-1115,0,0];
x = 1115;
y = 900;
z = 1610;

[X_b, Y_b, Z_b] = getCube(o, x, y, z);

%% Chassis
o = [0,0,0];
x = 3720-1115;
y = 1625;
z = 1610;

[X_c, Y_c, Z_c] = getCube(o, x, y, z);


%% Plot
C_car='blue';                  % unicolor
alpha = 1

close all
hold on

fill3(X_b,Y_b,Z_b,C_car,'FaceAlpha',alpha);    % draw cube
axis equal
hold on
fill3(X_c,Y_c,Z_c,C_car,'FaceAlpha',alpha);    % draw cube
axis equal
hold on