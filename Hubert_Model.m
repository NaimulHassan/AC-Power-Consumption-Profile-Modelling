clc
close all
clear all

%% Input


disp('Give Input Tout: ');
Tout= input (' ');
disp('Give Input Tset: ');
Tset= input (' ');
disp('Give Input delT(delT): ');
delT= input (' ');
disp('Give Input Area: ');
A= input(' ');
A= A.*0.092903;
disp('Give Input Capacity: ');
C= input(' ');
disp('Give Input COP: ');
COP= input(' ');


%% Constant values

    
Cp=1.005*10^3;
Density_Air= 1.225;
h= 3.2;
v= A*h;
Mair= Density_Air*v;

Req= 0.35;
Ph_on= -3517*C;
Ph_off= 373*COP;
Pon= -Ph_on/COP
% [r,c]= size(C)
% Poff= ones(1, c)
Poff= Ph_off/COP

upper= Tset+delT/2;
lower= Tset-delT/2;

%%
Tcycle=20
TON= (Cp.*Mair.*Req.*log((Ph_on.*Req+Tout-upper)./(Ph_on.*Req+Tout-lower)))./60
TOFF= abs((Cp.*Mair.*Req.*log((Ph_off.*Req+Tout-lower)./(Ph_off.*Req+Tout-upper)))./60)
TON1= (-Cp.*Mair.*Req.*delT./(Ph_on.*Req+Tout-Tset))./60 % Approximation
% TOFF= ones(1,c)
TOFF1= abs(Cp.*Mair.*Req.*delT./(Ph_off.*Req+Tout-Tset))./60 % Approximation
T=TON+TOFF
T1=TON1+TOFF1
dc= TON./T.*100

changeon= ((TON-TON1)./TON).*100
changeoff= ((TOFF-TOFF1)./TOFF).*100
change= ((T-T1)./T).*100