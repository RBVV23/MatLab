function [ Klass, Kc ] = DimGen2( K, Nr, M, Kr )

% K - число классов
% Nr - размер пространства
% M - число элемнтов класса 
% Kr - "разброс" класса

for id=1:K
    Kc(id,1)=round(Nr*rand(1));
    Kc(id,2)=round(Nr*rand(1));
    
    
    for m=1:M
        for cor=1:2
        Klass(m,cor,id)=round(Kc(id,cor)+(Kr/3)*(0.5-randn(1)),10);
        end
    end
end

end

