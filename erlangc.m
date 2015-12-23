function [ B ] = erlangc( n,delay )
%erlangc Summary of this function goes here
%   Detailed explanation goes here
b = xlsread('ErlangCTable.xls');

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

end

