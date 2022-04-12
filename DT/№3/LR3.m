% TASK
clc
clear all
close all

Fo=1990.0; % �� - �������� �������
A=0.5E-3; % �
T=0.3; % �
dt=1E-4; % �
dFo=5; % ��
Fd=1.8; % �� - ������������ ��������

f=Fo+Fd;
N=T/dt+1;
N=round(N);

t=linspace(0, T, N);
s=A*cos(2*pi*f*t);
E=sum(s.^2);

d=[10 15 20 25 30];
sigmamass=zeros(5,1);
sigmamass=sqrt( E./(10.^(d/10)) )
sigma=sigmamass(5);

f_op=zeros(N,1);
f_op(N)=1990;
df=1;
% 
% 
% 
% 
% % TEST
% Fo=2000; % �� - �������� �������
% A=1E-3; % �
% T=0.1; % �
% dt=1E-5; % �
% dFo=5; % ��
% Fd=2; % �� - ������������ ��������
% sigma=0.5;
% f=2002;
% N=T/dt+1;
% 
% 
% f_op=zeros(N,1);
% f_op(N)=2000;
% df=1;
% 
