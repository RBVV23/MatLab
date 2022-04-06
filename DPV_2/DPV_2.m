%% СЛУЧАЙ ОДНОМЕРНОГО ПРОСТРАНСТВА
% Одна частная реализация
clc
clear all
close all

K=5;         % число классов
Nr=1000;     % размер пространства
M=10;        % число элемнтов класса 
Kr=5;        % характеристический "размер" класса (вероятность >0.99)

N=5;         % количество соседей

[Klass Kc]=DimGen(K, Nr, M, Kr)                         % создание пространства классов с вектором "цетров" Kc


Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ] % выбор элемента для исследования в пространстве
RandA=Klass( Target(1), Target(2) )                     % значение исследуемого элемента класса
ShowDim(Klass, Kc, Target)                              % графическое отображение пространства классов
Answer=KNN( Klass, Target, N, Nr)                       % определение класса элемента методом "k-NN"


if ( Answer==Target(2) )
    fprintf('Correct')
else
    fprintf('Error')
end

%% СЛУЧАЙ ДВУМЕРНОГО ПРОСТРАНСТВА
% Исследование зависимости от количества соседей и компактности классов
clc
clear all
close all


K=5;                                                             % число классов
Nr=1000;                                                          % размер пространства
M=100;                                                            % число элемнтов класса 
Krmass=[Nr/M/100 Nr/M/50 Nr/M/20 Nr/M Nr/M*20 Nr/M*30 Nr/M*50];        % "радиус" класса с вероятность >0.99 


Nmax=50;                                                          % максимальное количество соседей
Result=zeros(size(Krmass,2),Nmax);

Itr=100;                        % количество итераций
ccc=hsv(size(Krmass, 2));       % массив градиента цветов (от красного до голубого)
for k=1:size(Krmass, 2)         % зависимость от характеристического размера класса в пространстве
    Kr=Krmass(k);
    [Klass Kc]=DimGen2(K, Nr, M, Krmass(k));     % создание пространства классов с вектором "цетров" Kc
    
    for N=1:Nmax                                 % зависимость от количества соседей 'k'
        for j=1:Itr                              % цикл для усреднения случайных выборок при прочих равных
            Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ]; % выбор элемента в пространстве для исследования 
            RandA=Klass( Target(1), :, Target(2) );                  % координаты исследуемого элемента 
            Answer=KNN2( Klass, Target, N, Nr);                      % определение класса элемента методом "k-NN"

                if ( Answer==Target(2) )
                    Result(k,N)=Result(k,N)+1;
                end
        end                           
    end
    ShowDim2(Klass, Kc, Target)                  % графическое отображение пространства классов (одна реализация)
end

figure
for k=1:size(Krmass, 2) 
    plot(Result(k,:)/Itr,  'LineWidth', 1.5, 'color',ccc(k,:))
    hold on
    grid on 
    str{k} = [ 'Kr = ', num2str(Krmass(k)) ]; % сохраняем подпись
end
legend(str)