function [] = stereoCamVision()
f = 50; % mm
f = f/1000; % m

%% x: World Coordinates
xw = 0.5;
yx = -0.1;
zw = 3;
x = transpose([xw, yx, zw, 1]);

[wc_1, u_1, v_1, wc_2, u_2, v_2] = getCameraCoordinates(f, x);
[wcuv] = [wc_1, u_1, v_1]
[wcuv] = [wc_2, u_2, v_2]

%% Sensor Bounds
width = 35.8; %mm
height = 23.9; %mm

w_dev = (width/1000)/2;
h_dev = (height/1000)/2;

if ((abs(u_1) > w_dev) || (abs(v_1) > h_dev))
    FAILED = "Out of camera 1 bounds"
else
    PASSED = "Within camera 1 bounds"
end

if ((abs(u_2) > w_dev) || (abs(v_2) > h_dev))
    FAILED = "Out of camera 2 bounds"
else
    PASSED = "Within camera 2 bounds"
end

end

