clc
clear all
close all

%Порядок матрицы с заданным определителем
N=3;
%Максимальное значение случайного опрделителя
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



