function [car_coordinates] = getTestParameters();
distances_forward = [0,1,5,10,25,50];
distances_sideway = [0,2,6,10];

car_length = 3720/1000;
car_width = 1610/1000;
PLOTTING = true;
if(PLOTTING)
    close all
    figure
    hold on
end

count = 1;
for f = 1:length(distances_forward)
    for s = 1:length(distances_sideway)
        
        if (distances_forward(f) == 0)
            x_off = 0;
            y_off = (car_width/2) + distances_sideway(s);
            z_offset = 0;
        else
            x_off = (car_length) + distances_forward(f);
            y_off = (car_width/2) + distances_sideway(s);
            z_offset = 0;
        end
        
        if (distances_sideway(s) == 0)
            y_off = 0;
        end
        
        off = [x_off, y_off,z_offset]
        if ((x_off ~= 0) || (y_off ~= 0))
            C = getCarAt(x_off, y_off, z_offset);
            if(PLOTTING)
                for i = 1:16
                    plot3(C(i,1),C(i,2),C(i,3),'*')
                end
            end
            count = count + 1;
        end
        
    end
end
if(PLOTTING)
    xlabel('X: length') % x-axis label
    zlabel('Z: Height') % y-axis label
    ylabel('Y: Width') % z-axis labelel('Y: Width') % z-axis label
end
end