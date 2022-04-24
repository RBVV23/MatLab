clc
clear all
close all

%ѕор€док матрицы с заданным определителем
N=3;
%ћаксимальное значение случайного опрделител€
Dmax=100;
Amax=50;

Det=ceil(Dmax*rand(1))
A=ceil(Amax-2*Amax*rand(N));
k=det(A);
k=(k)^(1/N);
A=A/k;
A=A*((Det)^(1/N));

A
det(A)



