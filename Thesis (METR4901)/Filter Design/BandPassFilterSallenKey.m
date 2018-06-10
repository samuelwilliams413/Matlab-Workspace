function [] = BandPassFilterSallenKey()
% Generate component values for bandpass filter (sallen-key) 
%   Select C1 & Ra, then determine the rest of the values. To ensure
%   stability place a small cap (10pf) across R4

%%  System Response

F0  = 70*10^3 % 70kHz
C1  = 100*10^-12 % 100pF
R4  = 68*10^3 % 68kOhm 
Q = 0.5;

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
R1  = R1/1000
R2  = R3/1000
Rf  = R2/1000
Ra  = R4/1000
Rb  = R5/1000
C1  = C1*(10^12)
C2  = C2*(10^12)
Gain = H

end

