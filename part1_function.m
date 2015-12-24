function [ SIR ] = part1_ex( Area_cidade,Rc,n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ntable = [1 3 7 13 21 4 12 19 9 16];
ntable = sort(ntable);
SIR_lim = 13; %dB
i0 = 2;
Bw_down = 60e6;
Bw_up = 60e6;
Bw_multimidia = 10e6;
setor = 3;
Pr_delay = 0.4;
lambda = 0.15;
H = 3000;
F = 0.05;
%% Fator de reuso
N = ((((10^(SIR_lim/10))*i0)^(1/n))^2)/3;
aux = 1;
aux2 = [];
for i = 1:length(ntable)
    if(ceil(N) == ntable(i))
        aux = i;
        N = ntable(i);
        break;
    else
        aux2(i) = ntable(i)-ceil(N);
    end
end
if(ceil(N) ~= ntable(aux))
    for i = 1:length(aux2)
        if(aux2(i) > 0)
            N = ntable(i);
            break;
        end
    end
end

%% Quantidade de canal por cluster
S = (Bw_down + Bw_up)/Bw_multimidia;
%% �rea da c�lula
Area_celula = ((3*sqrt(3))/2)*Rc^2;
%% N�mero de clusters
N_cluster = Area_cidade/(N*Area_celula);
%% Capacidade de canal por c�lula
k = S/N;
%% Capacidade de canal por setor
k_set = ceil(k/setor);
%% Tr�fego por setor
A_setor = erlangc(k_set,Pr_delay);
%% Tr�fego por celula
A_celula = A_setor*setor;
%% N�mero total de c�lulas
Total_celula = N_cluster*N;
%% Tr�fego de usu�rios
A_usuario = (lambda/3600)*H*F;
%% Usu�rios por celula
U_celula = A_celula/A_usuario;
%% Usu�rios do sistema
U_sistema = Total_celula*U_celula;
%% Usu�rios simult�neos
U_simultaneo = S*N_cluster;
%% Raz�o de reuso
q = sqrt(3*N);
%% Raz�o Sinal-Interfer�ncia
SIR = 10*log10((q^n)/i0);
%% Resultado
sprintf('Resultado da SIR: %d',SIR)
if(SIR >= SIR_lim)
    sprintf('Resultado OK!')
else
    sprintf('Resultado NOK!')
end

end

