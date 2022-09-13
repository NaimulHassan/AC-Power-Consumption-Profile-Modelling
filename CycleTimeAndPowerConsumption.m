clc
close all
clear all

%% Input


disp('Give Input Tout: ');
Tout= input (' ');
disp('Give Input Tset: ');
Tset= input (' ');
disp('Give Input delT: ');
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

matrix_one= ones(1,length(C));
Req= 0.35;
Ph_on= -3517*C;
Ph_off= 373*COP;
Pon= -Ph_on/COP
Poff= matrix_one.*Ph_off/COP
Tcycle =20;
upper= Tset+delT/2;
lower= Tset-delT/2;

%%


TON= (Cp.*Mair.*Req.*log((Ph_on.*Req+Tout-upper)./(Ph_on.*Req+Tout-lower)))./60

TOFF= matrix_one.*abs((Cp.*Mair.*Req.*log((Ph_off.*Req+Tout-lower)./(Ph_off.*Req+Tout-upper)))./60)
T=TON+TOFF
dc= TON./T.*100
E=  (abs(Pon.*TON+Poff.*TOFF)./T+ (0.3.*3517.*C./COP).*(Tcycle./T))./1000
%% Graph

% delT vs T

[r c]= size(delT);
if(c>1)
    figure
    plot(delT, TON, '-o','linewidth', 2)
    hold on
    plot(delT, TOFF, '-x','linewidth', 2)
    hold on
    plot (delT, T, '-s', 'linewidth', 2, 'Color', 'm')
    xlabel('Dead-band, \DeltaT (K)')
    ylabel('Duration (min)')
    legend ('T_{ON}', 'T_{OFF}', 'Cycle time')
    grid on
end

% A vs T

[r, c]= size(A);
if(c>1)
    figure
    plot(A, TON, '-o', 'linewidth', 2)
    hold on
    plot(A, TOFF, '-x', 'linewidth', 2)
    hold on
    plot (A, T, '-s', 'linewidth', 2, 'Color', 'm')
    xlabel('Area, A (m^{2})')
    ylabel('Duration (min)')
    legend ('T_{ON}', 'T_{OFF}', 'Cycle time')
    grid on
end

% Capacity vs TON/TOFF and Pon/Poff
[r, c]= size(C);
if(c>1)
    figure
    plot(C, TON, '-o', 'linewidth', 2)
    hold on
    plot(C, TOFF, '-x', 'linewidth', 2)
    hold on
    plot (C, T, '-s', 'linewidth', 2, 'Color', 'm')
    xlabel('Capacity, C (ton)')
    ylabel('Duration (min)')
    legend ('T_{ON}', 'T_{OFF}', 'Cycle time')
    grid on
    
    figure
    plot(C, abs(Pon./1000), '--', 'linewidth', 2)
    hold on
    plot(C, abs(Poff./1000), '-*', 'linewidth', 2)
    xlabel('Capacity, C (ton)')
    ylabel ('Power Consumption (kW)')
    legend('P_{ON} (kW)', 'P_{OFF} (kW)')
    grid on
end
