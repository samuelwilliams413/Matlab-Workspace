function [] = getCar()

%l_cab() = [0, (3720-1115)];
%h_cab() = [0, 1625];
%w_cab() = [0, 1610];

l_cab_1 = [0, (3720-1115)];
h_cab_1 = [1625, 1625];
w_cab_1 = [1610, 1610];
l_cab_2 = [0, (3720-1115)];
h_cab_2 = [0, 0];
w_cab_2 = [0, 0];
l_cab_3 = [0, (3720-1115)];
h_cab_3 = [1625, 1625];
w_cab_3 = [0, 0];
l_cab_4 = [0, (3720-1115)];
h_cab_4 = [0, 0];
w_cab_4 = [1610, 1610];


l_cab = (3720-1115);
h_cab = 1625;
w_cab = 

close all
figure
hold on
plot3(l_cab_1,w_cab_1,h_cab_1)
plot3(l_cab_2,w_cab_2,h_cab_2)
plot3(l_cab_3,w_cab_3,h_cab_3)
plot3(l_cab_4,w_cab_4,h_cab_4)
xlabel('X: length') % x-axis label
zlabel('Z: Height') % y-axis label
ylabel('Y: Width') % z-axis label
end