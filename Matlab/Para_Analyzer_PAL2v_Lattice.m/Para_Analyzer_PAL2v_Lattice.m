% Para-Analyzer
% Author: Arnaldo de Carvalho Junior  Nov/2023
% This script cover the rules and equations of PAL2v
% Results are presented in PAL2v Lattice
% The The Lattice is splited in 12 logical states that can be used by
% Para-Analyzer in expert systems
% https://doi.org/10.1016/j.engappai.2023.107342

clc; clear all; close all;
disp('   ');
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
disp('+                                                    +');
disp('+                     PARA-ANALYZER                  +');
disp('+                                                    +');
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
disp('   ');

Mu = input('Enter the value of favorable evidence degree (0 <= Mu <=1): '); % Grau de Evidência Favorável
Lambda = input('Enter the value of unfavorable evidence degree  (0 <= Lambda <= 1): '); % Grau de Evidência Desfavorável
disp('   ');
CCL = input('Enter the certainty control limit (0 <= CCL <= 1): '); % CCL

Vscc=CCL; Vicc=-CCL; % Upper and Lower certainty control limts
CCTL = 1- CCL;
Vscct=1-Vscc; Vicct=-Vscct; % Upper and Lower Contradiction control limts

DCT=(Mu+Lambda)-1; % Contradiction Degree (DCT)
S2a=DCT; % Paraconsistent Analysis Node (PAN) S2a output

Phi = 1-abs(DCT); % Certainty Interval

DC=Mu-Lambda;   % Certainty Degree (DC)
S2b=DC; % Paraconsistent Analysis Node (PAN) S2b output


% Contradiction Extration for Unique PAL2v output
D=((1-abs(DC))^2+DCT^2)^0.5; % Distance
if D>=1
    D=1;
end
if DC>0
    DCR=1-D;
elseif DC<0
    DCR=D-1;
else
    DCR=0;
end
% PAL2v PAN normalized outputs
MIE=(DC+1)/2;
MIER=(DCR+1)/2;
MIEct=(DCT+1)/2;

% Para-Analyzer
if DC>=Vscc
    S1='True (T)';
elseif DC<=Vicc
    S1='False (F)';
elseif DCT>=Vscct
    S1='Inconsistent (I)';
elseif DCT<=Vicct
    S1='Indeterminate or Paracomplete (P)';
elseif DC>0 && DC<Vscc && DCT>0 && DCT<Vscct && DC>DCT
    S1='Quasi-True, tending to Inconsistent (QT=>I)';
elseif DC>0 && DC<Vscc && DCT>0 && DCT<Vscct && DC<DCT
    S1='Quasi-Indeterminate, tending to True (QI=>T)';
elseif DC>0 && DC<Vscc && DCT>Vicct && DCT<0 && DC>abs(DCT)
    S1='Quasi-True, tending to Paracomplete (QT=>P)';
elseif DC>0 && DC<Vscc && DCT>Vicct && DCT<0 && DC<abs(DCT)
    S1='Quasi-Paracomplete, tending to True (QP=>T)';
elseif DC>Vicc && DC<0 && DCT>Vicct && DCT<0 && abs(DC)>abs(DCT)
    S1='Quasi-False, tending to Paracomplete (QF=>P)';
elseif DC>Vicc && DC<0 && DCT>Vicct && DCT<0 && abs(DC)<abs(DCT)
    S1='Quasi-Paracomplete, tending to False (QP=>F)';
elseif DC>Vicc && DC<0 && DCT>0 && DCT<Vscct && abs(DC)>abs(DCT)
    S1='Quasi-False, tending to Inconsistent (QF=>I)';
elseif DC>Vicc && DC<0 && DCT>0 && DCT<Vscct && abs(DC)<abs(DCT)
    S1='Quasi-Inconsistent, tending to False (QI=>F)';
else
    S1='Undefined';
end
disp('   '); % Display PAL2v Results in Command Window
disp('*** Para-Analyzer Result ***');
fprintf('Logical Output : %s',S1);
disp('      ');
disp('      ');
disp('*** PAL2v Output ***');
fprintf('Certainty Degree (DC) : %5.2f\n',DC);
fprintf('Contradiction Degree (DCT) : %5.2f\n',DCT);
fprintf('Real Certainty Degree (DCR) : %5.2f\n',DCR);
disp('      ');
disp('*** Normalized PAL2v Output ***');
fprintf('Resulting Evidence Degree (MIE) : %5.2f\n',MIE);
fprintf('Resulting Real Evidence Degree (MIER) : %5.2f\n',MIER);
fprintf('Resulting Contradiction Degree (MIEct) : %5.2f\n',MIEct);
fprintf('Certainty Interval (Phi) : %5.2f\n',Phi);
disp('      ');
disp('      ');

%---------------------------------------------------------------------------------------
% Generate PAL2v Lattice
%---------------------------------------------------------------------------------------

	%Draw Lattice
	line([-1 0],[0 1], 'Color','k','LineWidth',2);
	line([0 1], [1 0], 'Color','k','LineWidth',2);
	line([1 0], [0 -1],'Color','k','LineWidth',2);
	line([0 -1],[-1 0],'Color','k','LineWidth',2);
	line([-1 1],[0 0], 'Color','k','LineWidth',1);
	line([0 0], [-1 1],'Color','k','LineWidth',1);
    
    %Split Lattice in 12 Logical States
    line([CCL,CCL],[CCTL,-CCTL],'Color','g','LineWidth',1)
    line([-CCL,-CCL],[CCTL,-CCTL],'Color','g','LineWidth',1)
    line([-CCL,CCL], [CCTL,CCTL],'Color','g','LineWidth',1)
    line([-CCL,CCL],[-CCTL,-CCTL],'Color','g','LineWidth',1)
    line([-CCL,CCL],[-CCTL,CCTL],'Color','g','LineWidth',1)
    line([-CCL,CCL],[CCTL,-CCTL],'Color','g','LineWidth',1)
    
    
	%%%%%%%%%%%%%%%%%%% Adding Values to the Lattice %%%%%%%%%%%%%%%%%%%%%%%%
    Lambda=-Lambda;
	%---------------------------------------------------------------------------------------
	% Marks related to Lambda
	% Draw vertical line related to Lambda until Lattice
	%   line([Lambda Lambda],[-1.1 (-1-Lambda)],'Color','r','LineWidth',1,'LineStyle',':');
	line([Lambda Lambda],[-1 (-1-Lambda)],'Color','r','LineWidth',2,'LineStyle',':');
    
	% Draw diagnoal line related to Lambda inside Lattice 
	line([Lambda (1+Lambda)],[(-1-Lambda) -Lambda],'Color','r','LineWidth',2,'LineStyle',':');

	%---------------------------------------------------------------------------------------
	% Marks related to Mu
	% Draw vertical line related to Mu until Lattice
	line([Mu Mu],[-1 (-1+Mu)],'Color','b','LineWidth',2,'LineStyle',':');

	% Draw diagnoal line related to Mu inside Lattice  
	line([Mu (-1+Mu)],[(-1+Mu) Mu],'Color','b','LineWidth',2,'LineStyle',':');

% Display values
if Mu<=0.5
text(Mu,-0.9,['\leftarrow \mu'],'FontSize',12);
else
text(Mu-0.15,-0.9,['\mu \rightarrow'],'fontweight','bold','FontSize',12);    
end
if Lambda>=-0.5
text(Lambda-0.15,-0.9,['\lambda \rightarrow'],'fontweight','bold','FontSize',12);
else
text(Lambda,-0.9,['\leftarrow \lambda'],'fontweight','bold','FontSize',12);
end
text(DC+0.01,DCT+0.01,['\leftarrow \epsilon\tau'],'fontweight','bold','FontSize',12);
txt = '\bullet DCR';
text(0.8,0.8,txt,'Color','r','fontweight','bold','FontSize',12)
hold on
plot(DC,DCT,'.','MarkerSize',12,'Color','k');
hold on
plot(DCR,0,'.','MarkerSize',12,'Color','r');

Quest = input('New Calculation (y/n) ?','s'); % Ask if run again
if Quest =='y'
Para_Analyzer_PAL2v_Lattice
else
end
disp('   ');
disp('See you soon !!!!');
