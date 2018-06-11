%% Band Pass Filter (SallenKey)
%
function [] = BandPassFilterSallenKey()
% Generate component values for bandpass filter (sallen-key) 
%   Select C1 & Ra, then determine the rest of the values. To ensure
%   stability place a small cap (10pf) across R4

p = 10^-12
u = 10^-9
n = 10^-6
m = 10^-3
K = 10^3
M = 10^6
G = 10^9

%%  System Response

F0  = 70*K % 70kHz
C1  = 100*p % 100pF
R4  = 68*K % 68kOhm 
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

R1  = R1
Rf  = R2
R3  = R3
Ra  = R4
Rb  = R5
C1  = C1
C2  = C2
Gain = H

end

