clc
clear all
close all

Amax=10;
%Порядок матрицы

N=3;
Ort=eye(N);
Amax=Amax-1;
for i=1:N
 W=eye(N);   
    for j=(i+1):N
        a=2*pi*rand(1);
        W(i,i)=cos(a);
        W(j,j)=cos(a);
        W(i,j)=-sin(a);
        W(j,i)=sin(a);
        Ort=Ort*W;
        W=eye(N);
    end
end

A=eye(N) + ceil(Amax - 2*Amax*rand(N));
Lvector=A(1,:)
L=diag(Lvector)
X=Ort*L*Ort'
Lvector
eig=eig(X)'