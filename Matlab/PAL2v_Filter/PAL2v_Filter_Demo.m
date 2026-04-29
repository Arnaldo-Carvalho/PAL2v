% PAL2v Filter
% Prof. Dr. Arnaldo de Carvalho Junior
% https://sites.google.com/view/prof-arnaldo/pal2v-key-points
% eailab.labmax.org
% Apr 2024

clc;clear all; close all;

% Create input signal
F = 0.5; % create frequency
t = linspace(0, 6*pi*F); % create time
A = 0.25; % amplitude of Input signal
R = 0.025; % noise amplitude
n = R*randn(size(t)); % generate noise
DC = 0.5; % Add DC level

% Input Signal
% Select between square, sinusoidal or triangle waves
%I = A*square(t) + DC; % pure square signal without noise
%I = A*sin(t)+DC; % pure sin signal without noise
I = A*sawtooth(t,1/2)+DC; % triangle signal without noise
In = I+n; % input signal with noise

% *** PAL2v Filter ***
N = 2; % number of PANCLctx cells (1 to 6!!!)
FLref = 0.25; % Filter adjust reference

% Filter Order Selection (max 6)
for i = 1:6
    if i <= N;
        FL(i) = FLref;
    else
        FL(i) = 1;
    end
end

% Setup initial values

MI1=In;
MIE1=zeros(size(t))+0.5; MIE2=MIE1; MIE3=MIE2; MIE4=MIE3;MIE5=MIE4;
MI2=MIE1;MI3=MIE2;MI4=MIE3;MI5=MIE4;

% start filtering
for x = 2:max(size(t));
    MI1(x)=In(x); % Input of the 1st Filter
    MIE1(x)=FL(1)*MI1(x)+(1-FL(1))*MIE1(x-1); % 1st Order Output
    
    MI2(x)=MIE1(x); % Input of the 2nd Filter
    MIE2(x)=FL(2)*MI2(x)+(1-FL(2))*MIE2(x-1); % 2nd Order Output
    
    MI3(x)=MIE2(x); % Input of the 3rd Filter
    MIE3(x)=FL(3)*MI3(x)+(1-FL(3))*MIE3(x-1); % 3rd Order Output
    
    MI4(x)=MIE3(x); % Input of the 4th Filter
    MIE4(x)=FL(4)*MI4(x)+(1-FL(4))*MIE4(x-1); % 4th Order Output
    
    MI5(x)=MIE4(x); % Input of the 5th Filter
    MIE5(x)=FL(5)*MI5(x)+(1-FL(5))*MIE5(x-1); % 5th Order Output
end
    
O=MIE5; % Filter output

% Generate Figures
plot(t/pi,I,'k',t/pi,In,'b',t/pi,O,'r');
legend('Clean Input','Noisy Input','Output Filtered','Location','best','FontSize',12);
grid on;

% Generate Transfer Function
z=sym('z');
FT1=FL(1)/(1-(1-FL(1))*z^-1);
FT2=FL(2)/(1-(1-FL(2))*z^-1);
FT3=FL(3)/(1-(1-FL(3))*z^-1);
FT4=FL(4)/(1-(1-FL(4))*z^-1);
FT5=FL(5)/(1-(1-FL(5))*z^-1);
FT=FT1*FT2*FT3*FT4*FT5;
disp('PAL2v Filter Transfer Function :')
pretty(FT)

