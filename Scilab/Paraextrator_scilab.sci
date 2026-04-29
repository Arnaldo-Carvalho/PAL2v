// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// % Algoritmo de Lógica Paraconsistente %
// % Extrator de Contradições %
// % Autor: Arnaldo de Carvalho Junior %
// % 2026 %
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Limpa memória e tela do Scilab
clc
clear

// Vetor de Referência
vetor1=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];

// Vetor de Valores Aleatórios
for x=1:10;
vetor2(1,x)=rand();
end

// Selecione vetor1 para teste ou vetor2 para valores aleatórios
A=vetor2;

// Calcula o tamanho do vetor
s=size(A,2);

// Algoritmo Paraextrator
C=s; // Faz C igual ao tamanho do vetor de entrada (s)
n=1;
Ampal2v=A;

// Loop do ParaExtrator
while C>=2;
Mi(n,1)=max(Ampal2v(n,:)); // seleciona Mi como máximo do vetor atual
Lb(n,1)=1-min(Ampal2v(n,:)); // seleciona Lambda como 1 - minimo do vetor atual
GC(n,1)=Mi(n,1)-Lb(n,1); // Calcula GC
GCT(n,1)=Mi(n,1)+Lb(n,1)-1; // Calcula GCT
D(n,1)=((1-abs(GC(n,1)))^2+GCT(n,1)^2)^0.5; // Calcula D
if D(n,1)>1; // Verifica se D é maior que 1
D(n,1)=1;
else
end

// Calcula GCR
if GC(n,1)>0;
GCR(n,1)=1-D(n,1);
elseif GC(n,1)<0;
GCR(n,1)=D(n,1)-1;
else
GCR(n,1)=0;
end
MIER(n,1)=(GCR(n,1)+1)/2; // Calcula MIER
Ampal2v(:,C)=[];
Ampal2v(:,1)=MIER(:,1); // Coloca o resultado do MIER na primeira posição do vetor
Ampal2v=gsort(Ampal2v,2); // reorganiza o restante do vetor
C=C-1; // subtrai um valor de C
end // Retorna o loop para o início (while)

// *** Comparação com Outros Cálculos de Média ***
// calcula a Média Aritmética Simples
Amedia=mean(A);

// calcula a Média Geométrica
Amgeo=geomean(A)

// Calcula a Média Harmônica
Amh = harmean(A)

// Calcula a Raiz Média Quadrática (RMS)
Q=A.^2;
S=sum(Q);
Arms=sqrt(S/s);

// Apresentação dos Resultados
mprintf("Valores de Entrada")
mprintf(" \n");mprintf(" \n");
disp(A)
mprintf(" \n");mprintf(" \n");
mprintf("Média Aritmética = %7.2f \n",Amedia)
mprintf("Média Geométrica = %7.2f \n",Amgeo)
mprintf("Média Harmônica = %7.2f \n",Amh)
mprintf("Raiz Média Quadrática = %7.2f \n",Arms)
mprintf("ParaExtrator = %7.2f \n",Ampal2v)
