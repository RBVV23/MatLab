function [ Answer ] = KNN2( Klass, Target, N, Nr)

% Klass - пространство классов для отображения
% Target - исследуемый элемент
% N - количество соседей "k"
% Nr - размер пространства

K=size(Klass,3);
M=size(Klass,1);
RandA=Klass( Target(1), :, Target(2) );

d=zeros(1,M*K);
solution=zeros(1, K);

sosedmass=zeros(1, 2, N);
markdist=0;
for n=1:N
mindist=Nr;
i=1;
for id=1:K
    for m=1:M
        d(i)=sqrt( ( Klass(m,1,id)- RandA(1) )^2 + ( Klass(m,2,id)- RandA(2) )^2  );
        if (d(i)<mindist) & (d(i) > markdist)
            sosed=[m id];
            mindist=d(i);
        end
        i=i+1;
    end
end
markdist=mindist;
sosedmass(1,:,n)=sosed;
solution(sosed(2))=solution(sosed(2))+1;
end

[ans Answer]=max(solution);

end

