function [ n ] = erlangcinv( A,delay )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
b = xlsread('ErlangCTable.xls');

linha = [];
coluna = [];
[l,c] = size(b);
n = [];
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
                if(abs(aux(aux2)) < 0.5)
                    n = j-1;
                    break;
                end
                aux2 = aux2 + 1;
            end
        end
    end
end

end

