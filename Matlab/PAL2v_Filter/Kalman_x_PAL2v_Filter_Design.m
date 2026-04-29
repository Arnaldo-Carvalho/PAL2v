% Matlab Kalman Filtering Design
% https://www.mathworks.com/help/control/examples/kalman-filter-design.html
% Time-Varying Kalman Filter Design
% MATLAB 2015
clear;clc;
A = [1.1269   -0.4940    0.1129,
     1.0000         0         0,
          0    1.0000         0];

B = [-0.3832
      0.5919
      0.5191];

C = [1 0 0];

D = 0;
Plant = ss(A,[B B],C,0,-1,'inputname',{'u' 'w'},'outputname','y');
Q = 3; % A number greater than zero
R = 1.5; % A number greater than zero
[kalmf,L,~,M,Z] = kalman(Plant,Q,R);
% First, build a complete plant model with u,w,v as inputs and
% y and yv as outputs:
a = A;
b = [B B 0*B];
c = [C;C];
d = [0 0 0;0 0 1];
P = ss(a,b,c,d,-1,'inputname',{'u' 'w' 'v'},'outputname',{'y' 'yv'});
sys = parallel(P,kalmf,1,1,[],[]);
SimModel = feedback(sys,1,4,2,1);
SimModel = SimModel([1 3],[1 2 3]);     % Delete yv form I/O
t = (0:100)';
u = sin(t/6);
rng(10,'twister');
w = sqrt(Q)*randn(length(t),1);
v = sqrt(R)*randn(length(t),1);
sys = ss(A,B,C,D,-1);
y = lsim(sys,u+w);   % w = process noise
yv = y + v;          % v = meas. noise
P=B*Q*B';         % Initial error covariance
x=zeros(3,1);     % Initial condition on the state
ye = zeros(length(t),1);
ycov = zeros(length(t),1);
errcov = zeros(length(t),1);
% Kalman Filter
for i=1:length(t)
  % Measurement update
  Mn = P*C'/(C*P*C'+R);
  x = x + Mn*(yv(i)-C*x);  % x[n|n]
  P = (eye(3)-Mn*C)*P;     % P[n|n]

  ye(i) = C*x;
  errcov(i) = C*P*C';

  % Time update
  x = A*x + B*u(i);        % x[n+1|n]
  P = A*P*A' + B*Q*B';     % P[n+1|n]
end

% CNAPapxct
LBDA(1,1)=0.5;
MI(1,1)=0.5;
GC(1,1)=0;
GCT(1,1)=0;
MIE(1,1)=0.5;
LBDA(1,1)=0.5;
MI2(1,1)=MIE(1,1);
GC2(1,1)=0;
GCT2(1,1)=0;
MIE2(1,1)=0.5;
LBDA2(1,1)=0.5;
MI3(1,1)=MIE2(1,1);
GC3(1,1)=0;
GCT3(1,1)=0;
MIE3(1,1)=0.5;
LBDA3(1,1)=0.5;
FA=0.6;
yvn=(yv-(-5))/10; % yv normalizado
for n=2:length(t);
MI(n,1)=yvn(n);
LBDA(n,1)=1-MIE(n-1,1);
GC(n,1)=MI(n,1)-LBDA(n,1);
GCT(n,1)=MI(n,1)+LBDA(n,1)-1;
MIE(n,1)=MIE(n-1,1)+GCT(n,1)*FA;
MI2(n,1)=MIE(n,1);
LBDA2(n,1)=1-MIE2(n-1,1);
GC2(n,1)=MI2(n,1)-LBDA2(n,1);
GCT2(n,1)=MI2(n,1)+LBDA2(n,1)-1;
MIE2(n,1)=MIE2(n-1,1)+GCT2(n,1)*FA;
MI3(n,1)=MIE2(n,1);
LBDA3(n,1)=1-MIE3(n-1,1);
GC3(n,1)=MI3(n,1)-LBDA3(n,1);
GCT3(n,1)=MI3(n,1)+LBDA3(n,1)-1;
MIE3(n,1)=MIE3(n-1,1)+GCT3(n,1)*FA;
end
MIEd=MIE*10+(-5);
MIE3d=MIE3*10+(-5);

figure(1)
g1=plot(t(1:80),y(1:80),'k:',t(1:80),ye(1:80),'r-',t(1:80),MIEd(1:80),'b-'); %Plot Filtro Kalman & LPA2v
g1(1).LineWidth = 2;g1(2).LineWidth = 2;g1(3).LineWidth = 2;
grid on;
xlabel ('$Time$','Interpreter','latex','FontSize',24,'FontWeight','bold','Color','k');
ylabel ('$Amplitude$','Interpreter','latex','FontSize',24,'FontWeight','bold','Color','k');
%title ('Resposta do Filtro com Variação de Tempo','FontSize',14,'FontWeight','bold','Color','k');
leg = legend('$y(t)$','$ye(t)$','$\mu_E$','Location','best','FontSize',12);
set(leg,'Interpreter','Latex');
