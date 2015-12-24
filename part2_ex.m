function [ pop ] = part2_ex( Area_cidade,Densidade,Rc,n )
%part2_ex Summary of this function goes here
%   Detailed explanation goes here
ntable = [1 3 7 13 21 4 12 19 9 16];
ntable = sort(ntable);
%% Dados iniciais
Habitantes = Area_cidade*Densidade;
i0 = 2;
Bw_full = 0.2e6;
Bw_voz = 25e6;
Pr_delay = 0.4;
lambda = 3;
H = 120;
F = 0.5;
%% Usuarios do sistema
U_sistema = 0.75*Habitantes;
%% Área da cï¿½lula
Area_celula = ((3*sqrt(3))/2)*Rc^2;
%% Número total de cï¿½lulas
Total_celula = Area_cidade/Area_celula;
%% Quantidade de canal por cluster
S = Bw_voz/Bw_full;
%% Usuários por celula
U_celula = U_sistema/Total_celula;
%% Tráfego de usuï¿½rios
A_usuario = (lambda/3600)*H*F;
%% Tráfego por celula
A_celula = A_usuario*U_celula;
%% Capacidade de canal por célula
k = erlangcinv(A_celula,Pr_delay);
%% Fator de reuso
N = S/k;
aux = 1;
aux2 = [];
for i = 1:length(ntable)
    if(floor(N) == ntable(i))
        aux = i;
        N = ntable(i);
        break;
    else
        aux2(i) = ntable(i)-floor(N);
    end
end
if(floor(N) ~= ntable(aux))
    for i = 1:length(aux2)
        tst = min(abs(aux2));
        for m = 1:length(aux2)
            if abs(aux2(m)) == tst
                N = ntable(m);
                break;
            end
        end
    end
end
    %% Número de clusters
    N_cluster = Area_cidade/(N*Area_celula);
    %% Razão de reuso
    q = sqrt(3*N);
    %% Razão Sinal-Interferência
    SIR = 10*log10((q^n)/i0);
    %% Calculo do numero de canais por celula
    if((k - ceil(k)) ~= 0)
        cel1 = (k - ceil(k))*N;
        cel2 = cel1 - N;
        A_cel1 = erlangc(floor(k),Pr_delay);
        A_cel2 = erlangc(ceil(k),Pr_delay);
        A_cluster = cel1*A_cel1 + cel2*A_cel2;
    else
        A_cel = erlangc(k,Pr_delay);
        A_cluster = A_cel*A_cel;
    end
    %% TrÃ¡fego do sistema
    A_sistema = A_usuario*U_sistema;
    %% Porcentagem da populaÃ§Ã£o atendida
    pop = 100*U_sistema/Habitantes
    %% Resultado PopulaÃ§Ã£o
    sprintf('Resultado da população atendida: %d',pop)
    if(pop >= 75)
        sprintf('Resultado OK!')
    else
        sprintf('Resultado NOK!')
    end

end

