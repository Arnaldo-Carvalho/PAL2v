% Paraconsistent Extractor of Contradiction Effects Algorithm (ParaExtrctr)
% Dr. Arnaldo de Carvalho Junior
% Version 1 - 05/15/2023

clc;clear all;close all;


% create a vector of 11 randon values
for x=1:5;
     A(1,x)=rand();
end

A = [0.0, 0.015152, 0.040404, 0.242424, 1.0, 0.116162]

% Note:
% Update the vector A with the values of interest if necessary

s=size(A,2); % size of vector A
C=s;
n=1;
Apal2v=A;

% ParaExtractor Algorithm
while C>=2;
    Mi(n,1)=max(Apal2v(n,:))
    Lb(n,1)=1-min(Apal2v(n,:))
    GC(n,1)=Mi(n,1)-Lb(n,1);
    GCT(n,1)=Mi(n,1)+Lb(n,1)-1;
    D(n,1)=((1-abs(GC(n,1)))^2+GCT(n,1)^2)^0.5;
    if D(n,1)>1;
        D(n,1)=1;
    else
    end
    if GC(n,1)>0;
        GCR(n,1)=1-D(n,1);
    elseif GC(n,1)<0;
        GCR(n,1)=D(n,1)-1;
    else
        GCR(n,1)=0;
    end
    MER(n,1)=(GCR(n,1)+1)/2;
    Apal2v=sort(Apal2v,2); % order from Apal2v min to max
    Apal2v=Apal2v(1:C-1); % remove max value from Apal2v
    Apal2v(:,1)=MER(:,1); % remove min value and add Mer in Apal2v
C=C-1; 
end

Am=mean(A); % return the simple mean value (average) for the A vector 
Amedian= median(A); % return the median value for the A vector 
Amgeo=geomean(A);% return the geometric mean for the A vector
Arms = rms(A); % return the root-mean-square (RMS) for the A vector
Ahmean = harmmean(A); % return the harmonic mean for the A vector

% Print the Results
disp('Paraconsistent Extractor of Contradiction Effects Algorithm (ParaExtrctr)');
disp('  ');            %jump one line 
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('+ *** CAUTION *** Program uses randon values between [0,1] for the input vector !!! +')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');            
disp('   ') %pula uma linha
fprintf('Input Values:');
disp('  ');            %jump one line 
fprintf('%8.2f\r\n',A);
plot(sort(A));
fprintf('Mean (average): %6.4f',Am);
disp('  ');            %jump one line 
fprintf('Median: %6.2f',Amedian);
disp('  ');            %jump one line 
fprintf('Geometric Mean: %6.4f',Amgeo);
disp('  ');            %jump one line 
fprintf('Root mean square (RMS): %6.4f',Arms);
disp('  ');            %jump one line 
fprintf('Harmonic Mean: %6.4f',Ahmean);
disp('  ');            %jump one line 
fprintf('ParaExtractor (ParaExtrctr): %6.4f',Apal2v);
disp('  ');            %jump one line 

