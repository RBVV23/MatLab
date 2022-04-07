function [ vector ] = matr2vector( matrix )

Nstr=size(matrix,1);
Nstl=size(matrix,2);
vector=zeros(1,Nstr*Nstl);

for i=1:Nstr
   vector( ((i-1)*Nstl+1) : i*Nstl )=matrix(i,:);
end

end

