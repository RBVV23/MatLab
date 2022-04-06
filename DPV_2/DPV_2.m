%% ������ ����������� ������������
% ���� ������� ����������
clc
clear all
close all

K=5;         % ����� �������
Nr=1000;     % ������ ������������
M=10;        % ����� �������� ������ 
Kr=5;        % ������������������ "������" ������ (����������� >0.99)

N=5;         % ���������� �������

[Klass Kc]=DimGen(K, Nr, M, Kr)                         % �������� ������������ ������� � �������� "������" Kc


Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ] % ����� �������� ��� ������������ � ������������
RandA=Klass( Target(1), Target(2) )                     % �������� ������������ �������� ������
ShowDim(Klass, Kc, Target)                              % ����������� ����������� ������������ �������
Answer=KNN( Klass, Target, N, Nr)                       % ����������� ������ �������� ������� "k-NN"


if ( Answer==Target(2) )
    fprintf('Correct')
else
    fprintf('Error')
end

%% ������ ���������� ������������
% ������������ ����������� �� ���������� ������� � ������������ �������
clc
clear all
close all


K=5;                                                             % ����� �������
Nr=1000;                                                          % ������ ������������
M=100;                                                            % ����� �������� ������ 
Krmass=[Nr/M/100 Nr/M/50 Nr/M/20 Nr/M Nr/M*20 Nr/M*30 Nr/M*50];        % "������" ������ � ����������� >0.99 


Nmax=50;                                                          % ������������ ���������� �������
Result=zeros(size(Krmass,2),Nmax);

Itr=100;                        % ���������� ��������
ccc=hsv(size(Krmass, 2));       % ������ ��������� ������ (�� �������� �� ��������)
for k=1:size(Krmass, 2)         % ����������� �� ������������������� ������� ������ � ������������
    Kr=Krmass(k);
    [Klass Kc]=DimGen2(K, Nr, M, Krmass(k));     % �������� ������������ ������� � �������� "������" Kc
    
    for N=1:Nmax                                 % ����������� �� ���������� ������� 'k'
        for j=1:Itr                              % ���� ��� ���������� ��������� ������� ��� ������ ������
            Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ]; % ����� �������� � ������������ ��� ������������ 
            RandA=Klass( Target(1), :, Target(2) );                  % ���������� ������������ �������� 
            Answer=KNN2( Klass, Target, N, Nr);                      % ����������� ������ �������� ������� "k-NN"

                if ( Answer==Target(2) )
                    Result(k,N)=Result(k,N)+1;
                end
        end                           
    end
    ShowDim2(Klass, Kc, Target)                  % ����������� ����������� ������������ ������� (���� ����������)
end

figure
for k=1:size(Krmass, 2) 
    plot(Result(k,:)/Itr,  'LineWidth', 1.5, 'color',ccc(k,:))
    hold on
    grid on 
    str{k} = [ 'Kr = ', num2str(Krmass(k)) ]; % ��������� �������
end
legend(str)