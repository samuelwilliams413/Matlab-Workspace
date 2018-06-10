function [] = BandPassFilterSallenKey()
% Generate component values for bandpass filter (sallen-key) 
%   Select C1 & Ra, then determine the rest of the values. To ensure
%   stability place a small cap (10pf) across R4

p = 10^-12
u = 10^-9
n = 10^-6
m = 10^-3
k = 10^3
Meg = 10^6
G = 10^9

%%  System Response

F0  = 70 % 70kHz
C1  = 100*p % 100pF
R4  = 68*k % 68kOhm 
Q = 0.5;

%%  Calculations

H = (1/3) * (6.5 - 1/Q);

j = 2*pi*F0*C1;
R5 = R4/(H-1);
C2 = (1/2)*C1;
R1 = 2/j;
R2 = 2/(3*j);
R3 = 4/j;



%%  Results

clc
R1  = R1/Meg
R2  = R3/Meg
Rf  = R2/k
Ra  = R4/k
Rb  = R5/k
C1  = C1/p
C2  = C2/p
Gain = H

end

