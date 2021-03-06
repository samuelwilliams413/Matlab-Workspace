
function [CC] = getCarLine(x,y,z)
x= 0,y = 0,z = 0
[car_coord] = getCarAt(x,y,z)

veticies = [1, 2, 4, 3, 1, 5, 6, 8, 7, 5, 1, 2, 6, 2, 1, 3, 7, 3, 4, 8, 4,12, 11, 9, 10, 12, 11, 15, 13, 9, 10, 2, 1];
veticies = [1, 2, 4, 3, 1]

x_values = [];
y_values = [];
z_values = [];

for vv = 1:length(veticies)
    v = veticies(vv);
    x_values = [x_values, car_coord(v,1)];
    y_values = [y_values, car_coord(v,2)];
    z_values = [z_values, car_coord(v,3)];
end

x_values = transpose(x_values);
y_values = transpose(y_values);
z_values = transpose(z_values);

x_values_i = [];
y_values_i = [];
z_values_i = [];
num = 10;

for v = 2:(length(veticies))
    pl = veticies(v-1);
    p = veticies(v);
    
    coord_index = 1;
    idle_x = ones(1,num+1);
    idle_x = idle_x*car_coord(p, coord_index);
    if ((car_coord(p, coord_index) - car_coord(pl, coord_index) ~= 0))
        inc = (car_coord(p, coord_index) - car_coord(pl, coord_index))/num;
        idle_x = car_coord(pl, coord_index) : inc : car_coord(p, coord_index);
    end
    coord_index = 2;
    idle_y = ones(1,num+1);
    idle_y = idle_y*car_coord(p, coord_index);
    if ((car_coord(p, coord_index) - car_coord(pl, coord_index) ~= 0))
        inc = (car_coord(p, coord_index) - car_coord(pl, coord_index))/num;
        idle_y = car_coord(pl, coord_index) : inc : car_coord(p, coord_index);
    end
    coord_index = 3;
    idle_z = ones(1,num+1);
    idle_z = idle_z*car_coord(p, coord_index);
    if ((car_coord(p, coord_index) - car_coord(pl, coord_index) ~= 0))
        inc = (car_coord(p, coord_index) - car_coord(pl, coord_index))/num;
        idle_z = car_coord(pl, coord_index) : inc : car_coord(p, coord_index);
    end
    
    idle_x = idle_x;
    idle_y = idle_y;
    idle_z = idle_z;
    x_values_i = [x_values_i, idle_x];
    y_values_i = [y_values_i, idle_y];
    z_values_i = [z_values_i, idle_z];
end
x_values_i = transpose(x_values_i);
y_values_i = transpose(y_values_i);
z_values_i = transpose(z_values_i);


close all
figure
hold on
for p = 1:length(x_values_i)
    plot3(x_values_i(p), y_values_i(p), z_values_i(p),'.')
end
plot3(x_values , y_values , z_values)
CC(:,1) = x_values_i;
CC(:,2) = y_values_i;
CC(:,3) = z_values_i;
end