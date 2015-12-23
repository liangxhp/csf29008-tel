clc;clear all;close all;

b = xlsread('ErlangCTable.xls');
delay = 0.4;
A = 7.9590;

linha = [];
coluna = [];
[l,c] = size(b);
n = [];
for i = 1:c
    if b(1,i) == delay
        for j = 2:l
            if(b(j,i) == A)
                n = j-1;
                break;
            end
        end
    end
end

display(n);