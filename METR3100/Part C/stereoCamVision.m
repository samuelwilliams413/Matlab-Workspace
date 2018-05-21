function [] = stereoCamVision()

focal_lengths = [10,50,100];


%% For all points
xw = 0.5;
yx = -0.1;
zw = 3;

%points = getCarLine(50,(1610/1000)/2,(1625/1000)/2);
points = getCarLine(0,0,0);
pl = size(points);
pl = pl(1);
for p = 1:pl
    x = transpose([points(p,:), 1]);
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
        width = 35.8; %mm
        height = 23.9; %mm
        
        w_dev = (width/1000)/2;
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
PLOTTING = false
if(PLOTTING)
    close all
    figure
    count = 1;
    for fl = 1:length(focal_lengths)
        
        
        for camera = 1:2
            
            sbpt(count) = subplot(length(focal_lengths),2,count);
            count = count + 1;
            
            frame_x = [-w_dev w_dev w_dev -w_dev -w_dev];
            frame_y = [-h_dev -h_dev h_dev h_dev -h_dev];
            
            %u = -u; % invert due to lense
            %v = v; % invert due to lense
            
            plot(frame_x, frame_y)
            hold on
            
            for p = 1:pl
                plot((u(p,fl, camera)), v(p,fl, camera), '.')
            end
            
            xlabel('u') % x-axis label
            zlabel('v') % y-axis label
            
            titleString = strcat('F: ',int2str(focal_lengths(fl)),'mm - Camera', int2str(camera));
            title(titleString)
        end
        
    end
    % linkaxes([sbpt(1), sbpt(2), sbpt(3), sbpt(4), sbpt(5), sbpt(6)],'xy')
else
    fl = 1
    camera = 1
    close all
    figure
    hold on
    xw = 0.5;
    yw = -0.1;
    zw = 3;
    plot3(0, 1, 0, '*')
    hold on
    plot3(0, -1, 0, '*')
    hold on
    plot3(xw, yw, zw, 'o')
    
    x = getCarLine(10,0,0);
    pl = size(x);
    pl = pl(1);
    for p = 1:pl
    hold on
        plot(x(p,:), '.')
    end
    
end
end
