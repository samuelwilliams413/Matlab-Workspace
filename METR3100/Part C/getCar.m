function [car_coord] = getCar()

l_cab = (3720-1115);
h_cab = 1625;
w_cab = 1610;
l_bon = 1115;
h_bon = 900;
w_bon = 1610;


cab_coord = zeros(8,3);

i = 1;
for x = 1:2
    for y = 1:2
        for z = 1:2
            if(x == 1)
                xx = l_cab;
            else
                xx = 0;
            end
            
            if(y == 1)
                yy = w_cab;
            else
                yy = 0;
            end
            
            if(z == 1)
                zz = h_cab;
            else
                zz = 0;
            end
            
            cab_coord(i, 1) = xx;
            cab_coord(i, 2) = yy;
            cab_coord(i, 3) = zz;
            i = i + 1;
        end
    end
end

bon_coord = zeros(8,3);

i = 1;
for x = 1:2
    for y = 1:2
        for z = 1:2
            if(x == 1)
                xx = l_bon;
            else
                xx = 0;
            end
            
            xx = xx + (3720-1115);
            
            if(y == 1)
                yy = w_bon;
            else
                yy = 0;
            end
            
            if(z == 1)
                zz = h_bon;
            else
                zz = 0;
            end
            
            bon_coord(i, 1) = xx;
            bon_coord(i, 2) = yy;
            bon_coord(i, 3) = zz;
            i = i + 1;
        end
    end
end



PLOTTING = false;
if(PLOTTING)
    close all
    figure
    hold on
    for i = 1:8
        plot3(cab_coord(i,1),cab_coord(i,2),cab_coord(i,3),'*')
    end
    for i = 1:8
        plot3(bon_coord(i,1),bon_coord(i,2),bon_coord(i,3),'*')
    end
    xlabel('X: length') % x-axis label
    zlabel('Z: Height') % y-axis label
    ylabel('Y: Width') % z-axis label
end


car_coord = transpose([transpose(cab_coord), transpose(bon_coord)])/1000;

end