clear;clc
sim('PID_PAL');
% Gera Figuras de Saida
figure(1)
t=length(Y);
for n=1:t
    T(n,1)=n/10;
end
plot(T,Y(1:t,1),'k','LineWidth',1);
hold on;
plot(T,Y(1:t,2),'b','LineWidth',2);
hold on;
plot(T,Y(1:t,3),'r','LineWidth',2);
hold on;
plot(T,Y(1:t,4),'m','LineWidth',2);
grid on;
xlabel('t(seg)','FontSize',10);
ylabel('Amplitude','FontSize',10);
leg = legend({'u(t) Degrau','y(t) malha aberta', 'y(t) com Controle PID','y(t) com Controle PID_P_A_L_2_v'},'Location','southeast','FontSize',10);
title('Saída y(t)','FontSize',10);
figure(2)
plot(T,LPA(1:t,1),'g','LineWidth',2);
hold on;
plot(T,LPA(1:t,2),'b','LineWidth',2);
hold on;
plot(T,LPA(1:t,3),'r','LineWidth',2);
hold on;
plot(T,LPA(1:t,4),'m','LineWidth',2);
grid on;
xlabel('t(seg)','FontSize',10);
ylabel('Amplitude','FontSize',10);
leg = legend({'P_P_A_L K_P*(G_C CNAP1)','I_P_A_L K_I*(Mie cNAPxct1)', 'D_P_A_L K_D*(Miect cNAPxct2)','y(t) com Controle PID_P_A_L_2_v'},'Location','southeast','FontSize',10);
title('Saída y(t)','FontSize',10);