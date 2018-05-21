
function [car_coord] = getCarAt(x,y,z)
[car_coord] = getCar();

car_coord(:,1) = x + car_coord(:,1);
car_coord(:,2) = y + car_coord(:,2);
car_coord(:,3) = z + car_coord(:,3);

end