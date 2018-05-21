function [] = stereoVision()
f_values = [0,1,5,10,25,50,100,150]
s_values = [0,2,6]

% %% Values to be tested
% [0, 2]
% [0, 6]
% [0, 10]
% [1, 2]
% [1, 6]
% [5, 2]
% [5, 6]
% [10, 2]
% [10, 6]
% [25, 2]
% [25, 6]
% [50, 0]
% [50, 2]
% [50, 6]
% [100, 0]
% [150, 0]

MOUNTING_X = (3720-1115)/1000;
forward_distance = 0;

car_width = 1610/1000;
side_distance = car_width + 10;
plot_method = '-*';

real_space = false;

%STEREOVISION
focal_lengths = [10,50,100]; % this is divided by 1000 later
ground_height = 150/1000;

car_width = 1610/1000;

cab_length = (3720-1115)/1000;
cab_height = 1625/1000;

bon_length = 1115/1000;
bon_height = 900/1000;

%% Cam Height
camera_height = bon_height;
%%
x1 = forward_distance + MOUNTING_X;
x2 = x1 + cab_length;
x3 = x2 + bon_length;

y1 = side_distance + car_width/2;
y2 = side_distance + -car_width/2;

z0 = camera_height;
z1 = cab_height - z0;
z2 = ground_height - z0;
z3 = bon_height - z0;

% Back pane of cabin
x_A = [x1, x1, x1, x1, x1];
y_A = [y2, y1, y1, y2, y2];
z_A = [z1 z1 z2 z2 z1];

% Front pane of cabin
x_B = [x2, x2, x2, x2, x2];
y_B = [y2, y1, y1, y2, y2];
y_C = [z1 z1 z2 z2 z1];

x_B = [x2, x2, x2];
y_B = [y2, y1, y2];
y_C = [z1, z1, z1];

% Back pane of bonnet
x_D = [x2, x2, x2, x2, x2];
y_D = [y2, y1, y1, y2, y2];
z_D = [z3 z3 z2 z2 z3];

x_D = [x2, x2, x2];
y_D = [y2, y1, y2];
z_D = [z3, z3, z3];

% Front pane of bonnet
x_E = [x3, x3, x3, x3, x3];
y_E = [y2, y1, y1, y2, y2];
z_E = [z3 z3 z2 z2 z3];

% Interconnet
x_F = [x3, x1, x1, x3, x3, x2, x2, x1];
y_F = [y2, y2, y1, y1, y1, y1, y1, y1];
z_F = [z2, z2, z2, z2, z3, z3, z1, z1];

xw = [x_A, x_B, x_D, x_E, x_F];
yw = [y_A, y_B, y_D, y_E, y_F];
zw = [z_A, y_C, z_D, z_E, z_F];

XXX = xw;
YYY = yw;
ZZZ = zw;

xw = YYY;
yw = ZZZ;
zw = XXX;


if (real_space)
    %xw = 0.5;
    %yw = -0.1;
    %zw = 3;
    close all
    figure
    hold on
    plot3(0, 1, 0, '*')
    hold on
    plot3(0, -1, 0, '*')
    hold on
    plot3(xw, yw, zw, '-o')
    axis equal
    
else
    for p = 1:length(xw)
        x = transpose([xw(p), yw(p), zw(p), 1]);
        %% For all focal lengths
        for fl = 1:length(focal_lengths)
            f = focal_lengths(fl); % mm
            f = f/1000; % m
            
            %% x: World Coordinates
            [wc_1, u_1, v_1, wc_2, u_2, v_2] = getCameraCoordinates(f, x);
            wc(1) = wc_1;
            wc(2) = wc_2;
            u(p,fl,1) = u_1;
            u(p,fl,2) = u_2;
            v(p,fl,1) = v_1;
            v(p,fl,2) = v_2;
            
            [wcuv] = [wc_1, u_1, v_1];
            [wcuv] = [wc_2, u_2, v_2];
            
            %% Sensor Bounds
            car_width = 35.8; %mm
            height = 23.9; %mm
            
            w_dev = (car_width/1000)/2;
            h_dev = (height/1000)/2;
            
            VERBOSE = true;
            if (VERBOSE)
                
                if ((abs(u_1) > w_dev) || (abs(v_1) > h_dev))
                    stateCamera(1) = "Out of camera 1 bounds";
                else
                    stateCamera(1) = "Within camera 1 bounds";
                end
                
                if ((abs(u_2) > w_dev) || (abs(v_2) > h_dev))
                    stateCamera(2) = "Out of camera 2 bounds";
                else
                    stateCamera(2) = "Within camera 2 bounds";
                end
                stateCamera = stateCamera;
                
            end
        end
    end
    %% Plotting
    
    close all
    figure
    count = 1;
    
    p = 2
    
    for fl = 1:length(focal_lengths)
        for camera = 1:2
            
            sbpt(count) = subplot(length(focal_lengths),2,count);
            count = count + 1;
            
            frame_x = [-w_dev w_dev w_dev -w_dev -w_dev];
            frame_y = [-h_dev -h_dev h_dev h_dev -h_dev];
            
            plot(frame_x, frame_y)
            hold on
            
            if(camera == 1)
                c = 1;
                plot((-u(:,fl, c)), v(:,fl, c), plot_method)
            else
                c = 2;
                plot((-u(:,fl, c)), v(:,fl, c), plot_method)
            end
            
            
            xlabel('u') % x-axis label
            zlabel('v') % y-axis label
            titleString = strcat('F: ',int2str(focal_lengths(fl)),'mm - Camera', int2str(camera));
            title(titleString)
        end
        linkaxes([sbpt(count-1), sbpt(count-2)],'xy')
    end
    
    
end
end


