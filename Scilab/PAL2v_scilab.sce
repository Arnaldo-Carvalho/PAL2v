// Algorítmo de Lógica Paraconsistente
// Estado Lógico Paraconsistente
// Diagrama de Lattice LPA2v
// Dr. Arnaldo de Carvalho Junior
// Versão 2026

resp='s'
while resp=='s'||resp=='S'
clear
clc
// Exibe mensagens e aguarda entrada de dados na janela de console
mprintf("*** LÓGICA PARACONSISTENTE ANOTADA COM ANOTAÇÃO DE 2 VALORES ***")
mprintf(" \n");mprintf(" \n"); // exibe linha em branco no console
mprintf(" LPA2v")
mprintf(" \n");mprintf(" \n");
Mi = input("Informe o Grau de Evidência Favorável (entre 0.00 e 1.00): ")
mprintf(" \n");mprintf(" \n");
Lbda=input("Informe o Grau de Evidência Desfavorável (entre 0.00 e 1.00): ")
mprintf(" \n");mprintf(" \n");
Lc=input("Informe o Controle (ente {0,1} Valor default = 0.5}")
mprintf(" \n");mprintf(" \n");
Lcc = Lc
Lcct = 1 - Lcc

clc
mprintf("*** LÓGICA PARACONSISTENTE ANOTADA COM ANOTAÇÃO DE 2 VALORES ***")
mprintf(" \n");mprintf(" \n");
mprintf(" LPA2v")
mprintf(" \n");mprintf(" \n");
mprintf("Grau de Evidência Favorável (Mi) = %7.2f \n",Mi)
mprintf("Grau de Evidência Desfavorável (Lambda) %7.2f \n",Lbda)
mprintf(" \n");mprintf(" \n");
GC=Mi-Lbda; // Cálculo GC
mprintf("Grau de Certeza (GC) = %7.2f \n",GC);
GCT=Mi+Lbda-1; // Cálculo GCT
mprintf("Grau de Contradição (GCT) = %7.2f \n",GCT);
disp ""
D=((1-abs(GC))^2+GCT^2)^0.5; // Cálculo Distância
if GC>0 then GCR=1-D;
else if GC<0 then GCR=D-1;
 else GCR=0.5;   
end
end
MIE=(GC+1)/2; // Cálçulo MIE
MIER=(GCR+1)/2; // Cálculo MIER
mprintf("Grau de Evidência Resultante (MIE) = %7.2f \n",MIE);
mprintf("Grau de Evidência Resultante Real (MIER) = %7.2f \n",MIER);
MIEct=(GCT+1)/2; // Cálculo MIEct
mprintf("Grau de Contradição Resultante (MIEct) = %7.2f \n",MIEct);
mprintf(" \n");mprintf(" \n");
if GC>=Lcc then S1="Verdadeiro (V)"
else if GC<=-Lcc then S1="Falso (F)"
else if GCT>=Lcct then S1="Inconsistente (T)"
else if GCT<=-Lcct then S1="Indeterminado (I)" 
else if GC>=0 && GC<Lcc && GCT>=0 && GCT<Lcct && GC>=GCT then S1="Quase Verdadeiro tendendo a Inconsistente (Qv=>T)"
else if GC>=0 && GC<Lcc && GCT>=0 && GCT<Lcct && GC<GCT then S1="Inconsistente tendendo a Verdadeiro (T=>V)"
else if GC>=0 && GC<Lcc && GCT>-Lcct && GCT<=0 && GC>=abs(GCT) then S1="Quase Verdadeiro tendendo a Indeterminado (Qv=>I)"        
else if GC>=0 && GC<Lcc && GCT>-Lcct && GCT<=0 && GC<abs(GCT) then S1="Indeterminado tendendo a Verdadeiro (I=>V)"
else if GC>-Lcc && GC<=0 && GCT>-Lcct && GCT<=0 && abs(GC)>=abs(GCT) then S1="Quase Falso tendendo a Indeterminado (Qf=>I)" 
else if GC>-Lcc && GC<=0 && GCT>-Lcct && GCT<=0 && abs(GC)<abs(GCT) then S1="Indeterminado tendendo a Falso (I=>F)"
else if GC>-Lcc && GC<=0 && GCT>=0 && GCT<Lcct && abs(GC)>=GCT then S1="Quase Falso tendendo a Inconsistente (Qf=>T)" 
        else S1="T=>F"                       
end
end
end
end
end
end
end
end
end
end
end
mprintf("Estado lógico Paraconsistente é:");
disp(S1)
//getf(LPA2v_Lattice_scilab.sce)
//---------------------------------------------------------------------------------------
// MONTA GRÁFICO
// ---------------------------------------------------------------------------------------
// desenha o reticulado
clf
gce().font_size = 2;
plot([-1 0],[0 1], 'Color','k','LineWidth',2)
plot([0 1], [1 0], 'Color','k','LineWidth',2)
plot([1 0], [0 -1],'Color','k','LineWidth',2)
plot([0 -1],[-1 0],'Color','k','LineWidth',2)
plot([-1 1],[0 0], 'Color','k','LineWidth',2)
plot([0 0], [-1 1],'Color','k','LineWidth',2)
// Desenha Controles de Certeza e de Contradição
plot([Lcc,Lcc],[(1-Lcc),(-1+Lcc)], 'Color','g','LineWidth',2)
plot([-Lcc,-Lcc],[(1-Lcc),(-1+Lcc)], 'Color','g','LineWidth',2)
plot([-Lcc,Lcc], [(1-Lcc),(1-Lcc)],'Color','g','LineWidth',2)
plot([-Lcc,Lcc],[(-1+Lcc),(-1+Lcc)],'Color','g','LineWidth',2)
plot([-Lcc,Lcc],[(-1+Lcc),(1-Lcc)],'Color','g','LineWidth',2)
plot([-Lcc,Lcc],[(1-Lcc),(-1+Lcc)],'Color','g','LineWidth',2)
//%%%%%%%%%%%%%%% inserindo valores no reticulado%%%%%%%%%%%%%%
//---------------------------------------------------------------------------------------
// Valores relacionados a Lambda
// Monta a reta vertical para o valor de Lambda até encostar no reticulado//% line([Lambda Lambda],[-1.1 (-1-Lambda)],'Color','r','LineWidth',1,'LineStyle',':');
plot([-Lbda -Lbda],[-1 (-1+Lbda)],'Color','r','LineWidth',1,'LineStyle',':')
// monta a reta diagonal dentro do reticulado
plot([-Lbda (1-Lbda)],[(-1+Lbda) Lbda],'Color','r','LineWidth',1,'LineStyle',':')
// Valores relacionados a Mi
// monta a reta vertical para o valor de Mi até encostar no reticulado
plot([Mi Mi],[-1 (-1+Mi)],'Color','r','LineWidth',1,'LineStyle',':')
// monta a reta diagonal dentro do reticulado
plot([Mi (-1+Mi)],[(-1+Mi) Mi],'Color','r','LineWidth',1,'LineStyle',':')
// monta a reta diagonal dentro do reticulado
plot([Mi (-1+Mi)],[(-1+Mi) Mi],'Color','r','LineWidth',1,'LineStyle',':')
//---------------------------------------------------------------------------------------
// exibe valores
xstring(Mi,-0.95,['<=','$\mu$'])
xstring(-Lbda,-0.95,["<=",'$\lambda$'])
xstring(GC, (GCT-0.06),["<=",'$\epsilon$','(',string(GC),',',string(GCT),")"])
xstring(0.3,0.9,"GRAU DE EVIDENCIA ")
xstring(0.3,0.8,["RES. REAL = ",string(MIER)])
xtitle( 'Diagrama Lattice LPA2v', boxed = %t)
mprintf(" \n");mprintf(" \n");   
resp=input('Deseja realizar novo estudo (S/N) ?',"s")
R=isempty(resp)
if R==1 || resp<>"s" then resp = 'N'
    else resp='S'
    end
mprintf(" \n");mprintf(" \n");   
disp('ATÉ BREVE!');
end;


