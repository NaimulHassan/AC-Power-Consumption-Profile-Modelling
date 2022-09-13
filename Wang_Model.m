clc
close all
clear all

%%

disp('Give Input Tamb (Tout): ');
Tamb= input(' ');
disp('Give Input Tw (wall temparature, slight less than Tamb): ');
Tw= input (' ');
disp('Give Input Tset: ');
Tset= input (' ');
disp('Give Input range(delT/2): ');
range= input (' ');

%% Set values
for(C=1:0.5:4)
Cp=1*10^3;
Density_Air= 1.225;
A= 10:500;
h= 3.2;
v= A.*h;
Mair= Density_Air.*v;
l= 0.24;
num_of_walls= 4;
K= 0.721;
Rwr= 1./(0.25.*A);
Req=0.35;
%C= 1;
EER=2.9;
Pon= 3517*C;
Poff= 2.9*375;

up= Tset+range;
down= Tset-range;


%%
TON= ((Mair.*Cp.*Req.*Rwr./(Req-Rwr)).*log((Tamb.*Rwr-Tw.*Req+(Req-Rwr).*down-Pon.*Req.*Rwr)./(Tamb.*Rwr-Tw.*Req+(Req-Rwr).*up-Pon.*Req.*Rwr)))./60
TOFF= abs(((Mair.*Cp.*Req.*Rwr./(Req-Rwr)).*log((Tamb.*Rwr-Tw.*Req+(Req-Rwr).*up-Poff.*Req.*Rwr)./(Tamb.*Rwr-Tw.*Req+(Req-Rwr).*down-Poff.*Req.*Rwr)))./60)


T=TON+TOFF
dc= TON./T.*100

E= ((Pon.*TON+Poff.*TOFF)./T)./1000
plot(A,E)
hold on
end
legend('1','1.5','2','2.5','3','3.5','4');
