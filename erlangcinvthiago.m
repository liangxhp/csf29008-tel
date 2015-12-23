clc;clear all;close all;

b = xlsread('ErlangCTable.xls');
delay = 0.4;
A = 2.5981;

linha = [];
coluna = [];
[l,c] = size(b);
n = 0;
aux = [];
aux2 = 1;
for i = 1:c
    if b(1,i) == delay
        for j = 2:l
            if b(j,i) == A
                n = j-1;
                break;
            else
                aux(aux2) = A - b(j,i);
                tst(j) = min(abs(aux));
                aux2 = aux2 + 1;
            end
        end
    end
end

if n == 0
    tst(~tst) = nan;
    [u,v] = min(tst);
    n = v-1;
end

display(n);