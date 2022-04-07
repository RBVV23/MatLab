function [ matrix ] = vector2matrix( vector, matr_example )

Nstr=size(matr_example,1);
Nstl=size(matr_example,2);

for i=1:Nstr
   matrix(i,:)=vector( ((i-1)*Nstl+1) : i*Nstl );
end

end

