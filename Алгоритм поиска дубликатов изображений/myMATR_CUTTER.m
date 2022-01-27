function [ begin finish ] = myMATR_CUTTER( vector, param )

if (nargin<2)
    param=0.05;  
end

L=numel(vector);
treshold=sum(vector)*param;

begin=0;
subtotal=vector(1);

while (subtotal<=treshold)
    begin=begin+1;
    subtotal=subtotal+vector(1+begin);
end
begin=1+begin;

finish=0;
subtotal=vector(L);

while (subtotal<=treshold)
    finish=finish+1;
    subtotal=subtotal+vector(L-finish);
end
finish=L-finish;
end
