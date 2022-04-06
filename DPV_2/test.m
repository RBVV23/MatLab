clc
clear all
close all


K=5;          % ����� �������
Nr=100;      % ������ ������������
M=5;         % ����� �������� ������ 
Kr=30;        % "������" ������ � ����������� >0.99 

N=5;         % ���������� �������

[Klass Kc]=DimGen2(K, Nr, M, Kr);                       % �������� ������������ ������� � �������� "������" Kc

Target=[round(1+(M-1)*rand(1)) round(1+(K-1)*rand(1)) ] % ����� �������� � ������������ ��� ������������ 
RandA=Klass( Target(1), :, Target(2) )                  % ���������� ������������ �������� 
ShowDim2(Klass, Kc, Target)                             % ����������� ����������� ������������ �������
Answer=KNN2( Klass, Target, N, Nr)                      % ����������� ������ �������� ������� "k-NN"

if ( Answer==Target(2) )
    fprintf('Correct')
else
    fprintf('Error')
end

