clc;clear all;close all;

b = xlsread('ErlangCTable.xls');
delay = 0.4;
n = 1;

linha = [];
coluna = [];
[l,c] = size(b);

for i = 1:c
   if b(1,i) == delay
       coluna = i;
      for j = 1:l
         if b(j,1) == n
             linha = j;
            break; 
         end
      end
   end
end

B = b(linha,coluna);
display(B);