function [] = stereoVision()
%STEREOVISION
focal_lengths = [10,50,100];
xw = 0.5;
yw = -0.1;
zw = 3;
real_space = false;
if (real_space)
    close all
    figure
    hold on
    plot3(0, 1, 0, '*')
    hold on
    plot3(0, -1, 0, '*')
    hold on
    
    
    plot3(xw, yw, zw, 'o')
else
    p = 1
    x = transpose([xw, yw, zw, 1]);
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
    
    %% Plotting
    
    close all
    figure
    count = 1;
    
    for fl = 1:length(focal_lengths)
        for camera = 1:2
            
            sbpt(count) = subplot(length(focal_lengths),2,count);
            count = count + 1;
            
            frame_x = [-w_dev w_dev w_dev -w_dev -w_dev];
            frame_y = [-h_dev -h_dev h_dev h_dev -h_dev];

            plot(frame_x, frame_y)
            hold on
            plot((-u(p,fl, camera)), v(p,fl, camera), '.')
            
            xlabel('u') % x-axis label
            zlabel('v') % y-axis label
            titleString = strcat('F: ',int2str(focal_lengths(fl)),'mm - Camera', int2str(camera));
            title(titleString)
        end
        
    end
     linkaxes([sbpt(1), sbpt(2), sbpt(3), sbpt(4), sbpt(5), sbpt(6)],'xy')
    
end
end


