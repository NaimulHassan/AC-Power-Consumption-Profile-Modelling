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

shape=[{'-o'} {'-x'} {'-s'} {'->'} {'-*'} {'-<'}]
%% Constant values
for(i=1:length(delT))

Cp=1.005*10^3;
Density_Air= 1.225;
h= 3.2;
v= A*h;
Mair= Density_Air*v;

Req= 0.35;
Ph_on= -3517*C;
Ph_off= 373*COP;
Pon= -Ph_on/COP
Poff= Ph_off/COP

Tcycle= 20
upper= Tset+delT(i)/2;
lower= Tset-delT(i)/2;

%%

%TON= (Cp.*Mair.*Req.*log((Ph_on.*Req+Tout-upper)./(Ph_on.*Req+Tout-lower)))./60
%TOFF= abs((Cp.*Mair.*Req.*log((Ph_off.*Req+Tout-lower)./(Ph_off.*Req+Tout-upper)))./60)

TON= (-Cp.*Mair.*Req.*delT(i)./(Ph_on.*Req+Tout-Tset))./60
TOFF= abs(Cp.*Mair.*Req.*delT(i)./(Ph_off.*Req+Tout-Tset))./60

T=TON+TOFF
dc= TON./T.*100
E=  (abs(Pon.*TON+Poff.*TOFF)./(T) +(0.3.*3517.*C./COP).*(Tcycle./(T)))./1000

%% Energy consumption plot

[r c]= size(Tset);
if c>1
    plot(Tset, E, char(shape(i)),'linewidth',2)
    hold on
end
end
grid on
xlabel('Set Point, T_{set} (^{\circ} C)')
ylabel('Energy Consumption, E_h (kWh)')
hleg= legend('2', '4', '6', '8', '10', '12')
htitle = get(hleg,'Title');
set(htitle,'String','Dead-band, \Delta T (K)')

