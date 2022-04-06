clc
clear all
close all


K=5;          % число классов
Nr=100;      % размер пространства
M=5;         % число элемнтов класса 
Kr=30;        % "радиус" класса с вероятность >0.99 

N=5;         % количество соседей

[Klass Kc]=DimGen2(K, Nr, M, Kr);                       % создание пространства классов с вектором "цетров" Kc

Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ] % выбор элемента в пространстве для исследования 
RandA=Klass( Target(1), :, Target(2) )                  % координаты исследуемого элемента 
ShowDim2(Klass, Kc, Target)                             % графическое отображение пространства классов
Answer=KNN2( Klass, Target, N, Nr)                      % определение класса элемента методом "k-NN"

if ( Answer==Target(2) )
    fprintf('Correct')
else
    fprintf('Error')
end

