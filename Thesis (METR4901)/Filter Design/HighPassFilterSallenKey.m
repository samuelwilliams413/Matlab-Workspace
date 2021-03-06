function [] = HighPassFilterSallenKey()
% Generate component values for highpass filter (sallen-key) 
%   Select C1 & Ra, then determine the rest of the values. To ensure
%   stability place a small cap (10pf) across R4

p = 10^-12
u = 10^-9
n = 10^-6
m = 10^-3
K = 10^3
M = 10^6
G = 10^9
T = 10^12

%%  System Response

F0  = 70*K % 70kHz
C1  = 100*p % 100pF
R3  = 68*K % 68kOhm 
Q = 1;

%%  Calculations

H = (1/3) * (6.5 - 1/Q);

k = 2*pi*F0*C1;
R5 = R4/(H-1);
C2 = (1/2)*C1;
R1 = 2/k;
R2 = 2/(3*k);
R3 = 4/k;



%%  Results

clc
R1  = R1/K
Rf  = R2/K
R3  = R3/K
Ra  = R4/K
Rb  = R5/K
C1  = C1/p
C2  = C2/p
Gain = H

end