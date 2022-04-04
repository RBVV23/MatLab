clc
clear all
close all

% ��������� �� ��������
% 1 ������� (�� ���������)

U=1;
Fd=2000;        % ������� �������������
%Fd=Fd*2 - ��� ������ � ��������� ������� �������������
tau=5;          % ���������� ������� (��������� �������)
tauRC=0.05;     % ���������� ������� (��������� �������)
N=1024;       % ���������� ��������������� �������� �������
%N=2*N - ��� ������ � ��������� ������� �������������

Ts=1/Fd;        % ����������� ��� �� ��� �������
%Ts=2*Ts - ��� ������ � ��������� ������� �������������

T=Ts*N           % ������������ �������


L=tauRC/Ts;     % ���������� �������� tau (���������� �������)
K=[1:N];        % ������ �������� �������


s1=U*exp(-tau*K*Ts);

dcr=U/s1(N)                         % ������� ����� �������

W=linspace(-Fd/2,Fd/2,N);
W=W*pi/Fd;                          % ������ ������������ �������


S1=fft(s1)/N;
S1=fftshift(S1);

H=zeros(1,N);                                 % ������ �������� ������������ �������
for ind=1:N/2+1                               % ��� ������������� ������
    H(ind)=1/( 1+j*[(2*pi)*(ind-1)/T*tauRC] );
end

H(N : -1 : N/2+2)=conj( H(2:N/2) );     % �������� �������� �� ������������� �������� ����������-������������
H=fftshift(H);                          % ������������� ������������ �������


S2=(H.*S1);                             % �������� ������ ��������� �������
s2=abs(ifft(S2,N)*N);                   % ��������������� �������� ������ �� �������


a=U/(1-tau*tauRC);
sa2=a*[ exp(-tau*K*Ts) - exp(-K*Ts/tauRC) ];    % ������������� ��������� ��� ��������� �������


V(1:N)=[s2 - sa2].^2;         % ������ ��������� ���������� s2 � sa2
SKO=sqrt(sum(V)/N)            % ��� - "���������� ��������"

figure
plot(s1, '-b', 'LineWidth', 1.5)
hold on
grid on
legend('s1 - in-signal')
%legend('s1 - ������� ������')
title('Time domain')
%title('������ �� ��������� �������')

figure
stem(W, abs(S1)/max(S1), '-b', 'LineWidth', 1.5)
hold on
grid on
plot(W, abs(H), '--g', 'LineWidth', 1.5)
legend('Normalized spectrum S1 (in-signal)', 'Haper')
%legend('s1 - ������� ������')
title('Frequency domain')
%title('������� �� ��������� �������')

figure
plot(W, abs(H), '-g', 'LineWidth', 1.5)
hold on
grid on
title('Frequency domain')
legend('Haper, |H|')
%title('������������ ��������������, |H|')

figure
plot(W, abs(H), '--g', 'LineWidth', 0.75)
hold on
grid on
stem(W, abs(S2)/max(S2), '-r', 'LineWidth', 1.5)
legend('Haper', 'Normalized spectrum S2 (out-signal)')
%legend('s1 - ������� ������')
title('Frequency domain')
%title('������� �� ��������� �������')


figure
plot(s2, '-r', 'LineWidth', 1.5)
hold on
grid on
plot(sa2, '--g', 'LineWidth', 1.5)
legend('s2 - reconstructed', 'sa2 - analitical')
title('Time domain')

