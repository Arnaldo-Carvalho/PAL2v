% Paraconsistent Neural Network (PNN) x Artificial Neural Network (ANN) (Log-sig, Tanh, ReLU e LReLU) 
% 2 Inputs and 1 Output
% 3 Neurons in hidden layer and 1 neuron in output layer
% All neurons with the same activation function
% Referência: https://stevenmiller888.github.io/mind-how-to-build-a-neural-network/

close all; clear all; clc;
set(0,'defaultfigurecolor',[1 1 1]);

% Input a1, Input a2, Output Yd
a1=0; a2=1; Yd=1; 

% Alternative Tests 
%a1=0.92; a2=0.14; Yd=0.27 % Test 1

% Test 2
%a1=rand; % Input 1
%a2=rand; % Input 2
%Yd=rand; % Target Output

R=100; %Number of epochs
lr=1.0; % Learning Factor for all neural networks

% Starting randon weights, for all ANN and PNN in the same condiction
w1=rand;
w2=rand;
w3=rand;
w4=rand;
w5=rand;
w6=rand;
w7=rand;
w8=rand;
w9=rand;

%*************************************************************************
% ANN using Log-sigmoid activation function
w11(1)=w1;
w12(1)=w2;
w13(1)=w3;
w21(1)=w4;
w22(1)=w5;
w23(1)=w6;
w31(1)=w7;
w32(1)=w8;
w33(1)=w9;

for N=1:R;
% Combining inputs in the hidden layer
H11(N)=w11(N)*a1+w21(N)*a2;
H12(N)=w12(N)*a1+w22(N)*a2;
H13(N)=w13(N)*a1+w23(N)*a2;

% Hidden layer outputs
Hy1(N)=sigmf(H11(1),[1,0]);
Hy2(N)=sigmf(H12(1),[1,0]);
Hy3(N)=sigmf(H13(1),[1,0]);

% Output layer calculation
H21(N)=w31(N)*Hy1(N);
H22(N)=w32(N)*Hy2(N);
H23(N)=w33(N)*Hy3(N);
Y(N)=sigmf((H21(N)+H22(N)+H23(N)),[1,0]); % Output of the ANN
dY(N)=(Y(N)*(1-Y(N)));

% Error calculation
MSE(N)=0.5*(Yd-Y(N))^2;
dMSE(N)=(Y(N)-Yd);

% Adjust Weights
w31(N+1)=w31(N)-lr*dMSE(N)*dY(N)*Hy1(N);
w32(N+1)=w32(N)-lr*dMSE(N)*dY(N)*Hy2(N);
w33(N+1)=w33(N)-lr*dMSE(N)*dY(N)*Hy3(N);
w11(N+1)=w11(N)-lr*dMSE(N)*dY(N)*w31(N)*Hy1(N)*(1-Hy1(N))*a1;
w21(N+1)=w21(N)-lr*dMSE(N)*dY(N)*w31(N)*Hy1(N)*(1-Hy1(N))*a2;
w12(N+1)=w12(N)-lr*dMSE(N)*dY(N)*w32(N)*Hy2(N)*(1-Hy2(N))*a1;
w22(N+1)=w22(N)-lr*dMSE(N)*dY(N)*w32(N)*Hy2(N)*(1-Hy2(N))*a2;
w13(N+1)=w13(N)-lr*dMSE(N)*dY(N)*w33(N)*Hy3(N)*(1-Hy3(N))*a1;
w23(N+1)=w23(N)-lr*dMSE(N)*dY(N)*w33(N)*Hy3(N)*(1-Hy3(N))*a2;
end

%*************************************************************************
% ANN using Log-sigmoid activation function
w11t(1)=w1;
w12t(1)=w2;
w13t(1)=w3;
w21t(1)=w4;
w22t(1)=w5;
w23t(1)=w6;
w31t(1)=w7;
w32t(1)=w8;
w33t(1)=w9;

aa1=2*a1-1;aa2=2*a2-1; % Input normalization as tanh accept positive and negative values

for N=1:R;
% Combining inputs in the hidden layer
H11t(N)=w11t(N)*a1+w21t(N)*aa2;
H12t(N)=w12t(N)*a1+w22t(N)*aa2;
H13t(N)=w13t(N)*a1+w23t(N)*aa2;

% Hidden layer output
Hy1t(N)=tanh(H11t(1));dHy1t(N)=1-Hy1t(N)^2;
Hy2t(N)=tanh(H12t(1));dHy2t(N)=1-Hy2t(N)^2;
Hy3t(N)=tanh(H13t(1));dHy3t(N)=1-Hy3t(N)^2;

% Output layer calculation
H21t(N)=w31t(N)*Hy1t(N);
H22t(N)=w32t(N)*Hy2t(N);
H23t(N)=w33t(N)*Hy3t(N);
Yt(N)=(tanh(H21t(N)+H22t(N)+H23t(N))+1)/2; % Output value
dYt(N)=0.5*(1-Yt(N)^2); % derivative for ANN training

% Error calculation
MSEt(N)=0.5*(Yd-Yt(N))^2;
dMSEt(N)=(Yt(N)-Yd);

% Adjust weights
w31t(N+1)=w31t(N)-lr*dMSEt(N)*dYt(N)*Hy1t(N);
w32t(N+1)=w32t(N)-lr*dMSEt(N)*dYt(N)*Hy2t(N);
w33t(N+1)=w33t(N)-lr*dMSEt(N)*dYt(N)*Hy3t(N);
w11t(N+1)=w11t(N)-lr*dMSEt(N)*dYt(N)*w31t(N)*dHy1t(N)*aa1;
w21t(N+1)=w21t(N)-lr*dMSEt(N)*dYt(N)*w31t(N)*dHy1t(N)*aa2;
w12t(N+1)=w12t(N)-lr*dMSEt(N)*dYt(N)*w32t(N)*dHy2t(N)*aa1;
w22t(N+1)=w22t(N)-lr*dMSEt(N)*dYt(N)*w32t(N)*dHy2t(N)*aa2;
w13t(N+1)=w13t(N)-lr*dMSEt(N)*dYt(N)*w33t(N)*dHy3t(N)*aa1;
w23t(N+1)=w23t(N)-lr*dMSEt(N)*dYt(N)*w33t(N)*dHy3t(N)*aa2;
end

%*************************************************************************
% ANN using RELU
w11r(1)=w1;
w12r(1)=w2;
w13r(1)=w3;
w21r(1)=w4;
w22r(1)=w5;
w23r(1)=w6;
w31r(1)=w7;
w32r(1)=w8;
w33r(1)=w9;

for N=1:R;
% Combining inputs in the hidden layer
x11(N)=w11r(N)*a1+w21r(N)*a2;
x12(N)=w12r(N)*a1+w22r(N)*a2;
x13(N)=w13r(N)*a1+w23r(N)*a2;

% Hidden layer calculation
if x11>0;
    Hyr1(N)=x11(N);
    dHyr1(N)=1;
else
    Hyr1(N)=0;
    dHyr1(N)=0;
end

if x12>0;
    Hyr2(N)=x12(N);
    dHyr2(N)=1;
else
    Hyr2(N)=0;
    dHyr2(N)=0;
end

if x13>0;
    Hyr3(N)=x13(N);
    dHyr3(N)=1;
else
    Hyr3(N)=0;
    dHyr3(N)=0;
end

% Output layer calculation
Hr21(N)=w31r(N)*Hyr1(N);
Hr22(N)=w32r(N)*Hyr2(N);
Hr23(N)=w33r(N)*Hyr3(N);
Hr(N)=Hr21(N)+Hr22(N)+Hr23(N);
if Hr(N)>0;
    Yr(N)=Hr(N);
    dYr(N)=1;
else
    Yr(N)=0;
    dYr(N)=0;
end

% Error calculation
MSEr(N)=0.5*(Yd-Yr(N))^2;
dMSEr(N)=(Yr(N)-Yd);

% Adjusting weights
w31r(N+1)=w31r(N)-lr*dMSEr(N)*dYr(N)*Hyr1(N);
w32r(N+1)=w32r(N)-lr*dMSEr(N)*dYr(N)*Hyr2(N);
w33r(N+1)=w33r(N)-lr*dMSEr(N)*dYr(N)*Hyr3(N);
w11r(N+1)=w11r(N)-lr*dMSEr(N)*dYr(N)*w31r(N)*dHyr1(N)*a1;
w21r(N+1)=w21r(N)-lr*dMSEr(N)*dYr(N)*w31r(N)*dHyr1(N)*a2;
w12r(N+1)=w12r(N)-lr*dMSEr(N)*dYr(N)*w32r(N)*dHyr2(N)*a1;
w22r(N+1)=w22r(N)-lr*dMSEr(N)*dYr(N)*w32r(N)*dHyr2(N)*a2;
w13r(N+1)=w13r(N)-lr*dMSEr(N)*dYr(N)*w33r(N)*dHyr3(N)*a1;
w23r(N+1)=w23r(N)-lr*dMSEr(N)*dYr(N)*w33r(N)*dHyr3(N)*a2;
end

%*************************************************************************
% ANN LRELU
w11l(1)=w1;
w12l(1)=w2;
w13l(1)=w3;
w21l(1)=w4;
w22l(1)=w5;
w23l(1)=w6;
w31l(1)=w7;
w32l(1)=w8;
w33l(1)=w9;

alfa=0.05;

for N=1:R;
% % Combining inputs in the hidden layer
x11l(N)=w11l(N)*a1+w21l(N)*a2;
x12l(N)=w12l(N)*a1+w22l(N)*a2;
x13l(N)=w13l(N)*a1+w23l(N)*a2;

% Hidder layer output
if x11l>=0;
    Hyl1(N)=x11l(N);
    dHyl1(N)=1;
else
    Hyl1(N)=alfa*x11l(N);
    dHyl1(N)=alfa;
end

if x12l>=0;
    Hyl2(N)=x12l(N);
    dHyl2(N)=1;
else
    Hyl2(N)=alfa*x12l(N);
    dHyl2(N)=alfa;
end

if x13l>=0;
    Hyl3(N)=x13l(N);
    dHyl3(N)=1;
else
    Hyl3(N)=alfa*x13l(N);
    dHyl3(N)=alfa;
end

% Output layer calculation
Hl21(N)=w31l(N)*Hyl1(N);
Hl22(N)=w32l(N)*Hyl2(N);
Hl23(N)=w33l(N)*Hyl3(N);
Hl(N)=Hl21(N)+Hl22(N)+Hl23(N);
if Hl(N)>=0;
    Yl(N)=Hl(N);
    dYl(N)=1;
else
    Yl(N)=alfa*Hl(N);
    dYl(N)=alfa;
end

% Error calculation
MSEl(N)=0.5*(Yd-Yl(N))^2;
dMSEl(N)=(Yl(N)-Yd);

% Adjust weights
w31l(N+1)=w31l(N)-lr*dMSEl(N)*dYl(N)*Hyl1(N);
w32l(N+1)=w32l(N)-lr*dMSEl(N)*dYl(N)*Hyl2(N);
w33l(N+1)=w33l(N)-lr*dMSEl(N)*dYl(N)*Hyl3(N);
w11l(N+1)=w11l(N)-lr*dMSEl(N)*dYl(N)*w31l(N)*dHyl1(N)*a1;
w21l(N+1)=w21l(N)-lr*dMSEl(N)*dYl(N)*w31l(N)*dHyl1(N)*a2;
w12l(N+1)=w12l(N)-lr*dMSEl(N)*dYl(N)*w32l(N)*dHyl2(N)*a1;
w22l(N+1)=w22l(N)-lr*dMSEl(N)*dYl(N)*w32l(N)*dHyl2(N)*a2;
w13l(N+1)=w13l(N)-lr*dMSEl(N)*dYl(N)*w33l(N)*dHyl3(N)*a1;
w23l(N+1)=w23l(N)-lr*dMSEl(N)*dYl(N)*w33l(N)*dHyl3(N)*a2;
end

%*************************************************************************
%Paraconsistent Neural Network
w11p(1)=w1;
w12p(1)=w2;
w13p(1)=w3;
w21p(1)=w4;
w22p(1)=w5;
w23p(1)=w6;
w31p(1)=w7;
w32p(1)=w8;
w33p(1)=w9;
for N=1:R;
    if w11p(N)*a1<0;
        Mi11=0;
    elseif w11p(N)*a1>1;
        Mi11=1;
    else
        Mi11=w11p(N)*a1;
    end
    
    if w12p(N)*a1<0;
        Mi12=0;
    elseif w12p(N)*a1>1;
        Mi12=1;
    else
        Mi12=w12p(N)*a1;
    end
    
    if w13p(N)*a1<0;
        Mi13=0;
    elseif w13p(N)*a1>1;
        Mi13=1;
    else
        Mi13=w13p(N)*a1;
    end
    
    if w21p(N)*a2<0;
        Lbda11=0;
    elseif w21p(N)*a2>1;
        Lbda11=1;
    else
        Lbda11=w21p(N)*a2;
    end
    
    if w22p(N)*a2<0;
        Lbda12=0;
    elseif w22(N)*a2>1;
        Lbda12=1;
    else
        Lbda12=w22p(N)*a2;
    end 
    
   if w23p(N)*a2<0;
        Lbda13=0;
    elseif w23p(N)*a2>1;
        Lbda13=1;
    else
        Lbda13=w23p(N)*a2;
   end
    
   % Hidden Pal2v neuron 11
    Gc11=Mi11-Lbda11;
    Gct11=Mi11+Lbda11-1;
    D11=((1-abs(Gc11))^2+Gct11^2)^0.5;
    if Gc11>0.00001;
        Gcr11=1-D11;
        Mier11=(Gcr11+1)/2;
        dMi11=(1-Mi11)/((2*Mi11^2+2*Lbda11^2-4*Mi11+2)^0.5);
        dLbda11=-Lbda11/((2*Mi11^2+2*Lbda11^2-4*Mi11+2)^0.5);
    elseif Gc11<-0.00001;
        Gcr11=D11-1;
        Mier11=(Gcr11+1)/2;
        dMi11=Mi11/((2*Mi11^2+2*Lbda11^2-4*Lbda11+2)^0.5);
        dLbda11=(Lbda11-1)/((2*Mi11^2+2*Lbda11^2-4*Lbda11+2)^0.5);   
    else
        Gcr11=0;
        Mier11=0.5;
        dMi11=1/(2*(2*Mi11^2+2*Lbda11^2-4*Mi11+2)^0.5);
        dLbda11=-1/(2*(2*Mi11^2+2*Lbda11^2-4*Lbda11+2)^0.5);      
    end
    if D11>=1;
        D11=1;
        Gcr11=0;
        Mier11=0.5;
        dMi11=1/(2*(2*Mi11^2+2*Lbda11^2-4*Mi11+2)^0.5);
        dLbda11=-1/(2*(2*Mi11^2+2*Lbda11^2-4*Lbda11+2)^0.5); 
    else
    end
       % Hidden Pal2v neuron 12
    Gc12=Mi12-Lbda12;
    Gct12=Mi12+Lbda12-1;
    D12=((1-abs(Gc12))^2+Gct12^2)^0.5;
    if Gc12>0.00001;
        Gcr12=1-D12;
        Mier12=(Gcr12+1)/2;
        dMi12=(1-Mi12)/((2*Mi12^2+2*Lbda12^2-4*Mi12+2)^0.5);
        dLbda12=-Lbda12/((2*Mi12^2+2*Lbda12^2-4*Mi12+2)^0.5);
    elseif Gc12<-0.00001;
        Gcr12=D12-1;
        Mier12=(Gcr12+1)/2;
        dMi12=Mi12/((2*Mi12^2+2*Lbda12^2-4*Lbda12+2)^0.5);
        dLbda12=(Lbda12-1)/((2*Mi12^2+2*Lbda12^2-4*Lbda12+2)^0.5);
    else  
        Gcr12=0;
        Mier12=0.5;
        dMi12=1/(2*(2*Mi12^2+2*Lbda12^2-4*Mi12+2)^0.5);
        dLbda12=-1/(2*(2*Mi12^2+2*Lbda12^2-4*Lbda12+2)^0.5);      
    end
    if D12>=1;
        D12=1;
        Gcr12=0;
        Mier12=0.5;
        dMi12=1/(2*(2*Mi12^2+2*Lbda12^2-4*Mi12+2)^0.5);
        dLbda12=-1/(2*(2*Mi12^2+2*Lbda12^2-4*Lbda12+2)^0.5);
    else
    end
          % Hidden Pal2v neuron 13
    Gc13=Mi13-Lbda13;
    Gct13=Mi13+Lbda13-1;
    D13=((1-abs(Gc13))^2+Gct13^2)^0.5;
    if Gc13>0.00001;
        Gcr13=1-D13;
        Mier13=(Gcr13+1)/2;
        dMi13=(1-Mi13)/((2*Mi13^2+2*Lbda13^2-4*Mi13+2)^0.5);
        dLbda13=-Lbda13/((2*Mi13^2+2*Lbda13^2-4*Mi13+2)^0.5);
    elseif Gc13<-0.00001;
        Gcr13=D13-1;
        Mier13=(Gcr13+1)/2;
        dMi13=Mi13/((2*Mi13^2+2*Lbda13^2-4*Lbda13+2)^0.5);
        dLbda13=(Lbda13-1)/((2*Mi13^2+2*Lbda13^2-4*Lbda13+2)^0.5);
    else
        Gcr13=0;
        Mier13=0.5;
        dMi13=1/(2*(2*Mi13^2+2*Lbda13^2-4*Mi13+2)^0.5);
        dLbda13=-1/(2*(2*Mi13^2+2*Lbda13^2-4*Lbda13+2)^0.5);      
    end
    if D13>=1;
        D13=1;
        Gcr13=0;
        Mier13=0.5;
        dMi13=1/(2*(2*Mi13^2+2*Lbda13^2-4*Mi13+2)^0.5);
        dLbda13=-1/(2*(2*Mi13^2+2*Lbda13^2-4*Lbda13+2)^0.5);    
    else
    end    
    % PAN linear 21
    if w31p(N)*Mier11<0;
        Mi21=0;
    elseif w31p(N)*Mier11>1;
        Mi21=1;
    else
        Mi21=w31p(N)*Mier11;
    end
    
    if w32p(N)*Mier12<0;
        Lbda21=0;
    elseif w32p(N)*Mier12>1;
        Lbda21=1;
    else
        Lbda21=w32p(N)*Mier12;
    end
    
    Mie21=(Mi21-Lbda21+1)/2;
    dMi21=0.5;
    dLbda21=-0.5;
    
    % PAL2v neuron at output layer
    Mi31=Mie21;
    
   if w33p(N)*Mier13<0;
        Lbda31=0;
    elseif w33p(N)*Mier13>1;
        Lbda31=1;
    else
        Lbda31=w33p(N)*Mier13;
   end
   
    Gc31=Mi31-Lbda31;
    Gct31=Mi31+Lbda31-1;
    D31=((1-abs(Gc31))^2+Gct31^2)^0.5;
    if Gc31>0.00001;
        Gcr31=1-D31;
        Mier31=(Gcr31+1)/2;
        dMi31=(1-Mi31)/((2*Mi31^2+2*Lbda31^2-4*Mi31+2)^0.5);
        dLbda31=-Lbda31/((2*Mi31^2+2*Lbda31^2-4*Mi31+2)^0.5);
    elseif Gc31<-0.00001;
        Gcr31=D31-1;
        Mier31=(Gcr31+1)/2;
        dMi31=Mi31/((2*Mi31^2+2*Lbda31^2-4*Lbda31+2)^0.5);
        dLbda31=(Lbda31-1)/((2*Mi31^2+2*Lbda31^2-4*Lbda31+2)^0.5);
    else
        Gcr31=0;
        Mier31=0.5;
        dMi31=1/(2*(2*Mi31^2+2*Lbda31^2-4*Mi31+2)^0.5);
        dLbda31=-1/(2*(2*Mi31^2+2*Lbda31^2-4*Lbda31+2)^0.5);      
    end
    if D31>=1;
        D31=1;
        Gcr31=0;
        Mier31=0.5;
        dMi31=1/(2*(2*Mi31^2+2*Lbda31^2-4*Mi31+2)^0.5);
        dLbda31=-1/(2*(2*Mi31^2+2*Lbda31^2-4*Lbda31+2)^0.5);   
    else
    end    
    Ypal(N)=Mier31;
    MSEpal(N)=0.5*(Yd-Ypal(N))^2;
    dMSEpal(N)=(Ypal(N)-Yd);
    
    % Atualização Pesos
    w31p(N+1)=w31p(N)-lr*dMSEpal(N)*dMi31*dMi21*Mier11;
    w32p(N+1)=w32p(N)-lr*dMSEpal(N)*dMi31*dLbda21*Mier12;
    w33p(N+1)=w33p(N)-lr*dMSEpal(N)*dLbda31*Mier13;
    w11p(N+1)=w11p(N)-lr*dMSEpal(N)*dMi31*dMi21*w31p(N)*dMi11*a1; 
    w12p(N+1)=w12p(N)-lr*dMSEpal(N)*dMi31*dLbda21*w32p(N)*dMi12*a1;
    w13p(N+1)=w13p(N)-lr*dMSEpal(N)*dLbda31*w33p(N)*dMi13*a1;
    w21p(N+1)=w21p(N)-lr*dMSEpal(N)*dMi31*dMi21*w31p(N)*dLbda11*a2;
    w22p(N+1)=w22p(N)-lr*dMSEpal(N)*dMi31*dLbda21*w32p(N)*dLbda12*a2;
    w23p(N+1)=w23p(N)-lr*dMSEpal(N)*dLbda31*w33p(N)*dLbda13*a2;
end

%*************************************************************************
% Figure
figure(1);
plot(Ypal,'b','LineWidth',2);
hold on;
plot(Y,'m','LineWidth',2);
hold on;
plot(Yt,'g','LineWidth',2);
hold on;
plot(Yr,'r','LineWidth',2);
hold on;
plot(Yl,'k:','LineWidth',2);
grid on;
xlabel('epoch','FontSize', 20);
ylabel('output','FontSize', 20);
set(gca,'FontSize',20);
leg = legend('RNP','RNA $\sigma$','RNA tanh','RNA ReLU','RNA LReLU');
set(leg,'Interpreter','Latex');
set(leg,'Location','best','Fontsize',20);

figure(2);
plot(MSEpal,'b','LineWidth',2);
hold on;
plot(MSE,'m','LineWidth',2);
hold on;
plot(MSEt,'g','LineWidth',2);
hold on;
plot(MSEr,'r','LineWidth',2);
hold on;
plot(MSEl,'k:','LineWidth',2);
grid on;
xlabel('epoch','FontSize', 20);
ylabel('MSE','FontSize', 20);
set(gca,'FontSize',20);
leg = legend('RNP','RNA $\sigma$','RNA tanh','RNA ReLU','RNA LReLU');
set(leg,'Interpreter','Latex');
set(leg,'Location','best','Fontsize',20);