function [wc_1, u_1, v_1, wc_2, u_2, v_2] = getCameraCoordinates(focal_length, world_coordinates)
focal_length = focal_length;
world_coordinates = world_coordinates;
f = focal_length;
x = world_coordinates;
%% K: Intrinsic Camera Parameters
% No offset, no skew
pixel_size = 1;
a = pixel_size;
skew = 0;
y = skew;
sensor_offset = 0;
u_0 = sensor_offset;
v_0 = sensor_offset;


K = [f/a, y, u_0, 0; 0, f/a, v_0, 0; 0, 0, 1, 0];

%% R: 3D Rotational Matirx
% No rotation
theta = 100/1000;
R_1 = [1,0,theta;0,1,0;-theta,0,1;0,0,0];
R_2 = [1,0,-theta;0,1,0;theta,0,1;0,0,0];

%% T: 3D Rotational Matirx
baseline_offset = 2/2; % 1 meter between two cameras
T_1 = transpose([baseline_offset, 0, 0, 1]);
T_2 = -T_1;


%% p_: Camera Coordinate
RT_1 = [R_1,T_1];
RT_2 = [R_2,T_2];
RT_2(4,4) = 1;

wc_p_1 = K*RT_1*x;
wc_p_2 = K*RT_2*x;

wc_1 = wc_p_1(3);
wc_2 = wc_p_2(3);

p_1 = wc_p_1/wc_1;
p_2 = wc_p_2/wc_2;

u_1 = p_1(1);
v_1 = p_1(2);
u_2 = p_2(1);
v_2 = p_2(2);


end