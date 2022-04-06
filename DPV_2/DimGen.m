function [ Klass, Kc ] = DimGen( K, Nr, M, Kr )

% K - ����� �������
% Nr - ������ ������������
% M - ����� �������� ������ 
% Kr - ������������������ "������" ������ (����������� >0.99)

Klass=zeros(M,K);
for i=1:K
    Kc(i)=round(Nr*rand(1));
    for j=1:M
        Klass(j,i)=round(Kc(i)+(Kr/3)*(0.5-randn(1)),1);
    end
end
end

