function [] = stereoCamVision()
xw = 0.5;
yx = -0.1;
zw = 3;
points = [[xw, yx, zw]];
p = size(points);
focal_lengths = [10,50,100];

%for pts = 1:p(1)
    for fl = 1:length(focal_lengths)
        f = focal_lengths(fl); % mm
        f = f/1000; % m
        
        %% x: World Coordinates
        
        x = transpose([points(1,:), [1]])
        
        [wc_1, u_1, v_1, wc_2, u_2, v_2] = getCameraCoordinates(f, x(1));
        wc(1) = wc_1;
        wc(2) = wc_2;
        u(fl,1) = u_1;
        u(fl,2) = u_2;
        v(fl,1) = v_1;
        v(fl,2) = v_2;
        
        [wcuv] = [wc_1, u_1, v_1]
        [wcuv] = [wc_2, u_2, v_2]
        
        %% Sensor Bounds
        width = 35.8; %mm
        height = 23.9; %mm
        
        w_dev = (width/1000)/2;
        h_dev = (height/1000)/2;
        
        VERBOSE = true
        if (VERBOSE)
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
    end
%end
%% Plotting
PLOTTING = true
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
            plot((-u(fl, camera)), v(fl, camera), '*')
            
            xlabel('u') % x-axis label
            zlabel('v') % y-axis label
            
            titleString = strcat('F:',int2str(focal_lengths(fl)),'mm - Camera:', int2str(camera));
            title(titleString)
        end
        
    end
    linkaxes([sbpt(1), sbpt(2), sbpt(3), sbpt(4), sbpt(5), sbpt(6)],'xy')
end
end
