clc
clear all
close all

% ��������� �� ��������
% 1 ������� (�� ���������)

U=1;
Fd=2000;        % ������� �������������
T=5;            % ������������ �������
tau=0.05;       % ���������� �������
N=1024;         % ���������� ��������������� �������� �������
Nfft=T*Fd;
Nfft=8096;

Ts=T/N;         % ����������� ��� �� ��� �������

L=tau/Ts;       % ���������� �������� tau (���������� �������)
K=[1:N];        % ������ �������� �������


s1=U*exp(-tau*K*Ts);

dcr=U/s1(N)                         % ������� ����� �������
W=linspace(-Fd/2,Fd/2,Nfft);
W=W*pi/Fd;                          % ������ ������������ �������

Wh=linspace(-Fd/2,Fd/2,N);
Wh=Wh*pi/Fd;             

S1=fft(s1,Nfft)/N;
S1=fftshift(S1);

Lfft=tau*Fd; 
H=zeros(1,Nfft);                                 % ������ �������� ������������ �������
for ind=1:Nfft/2+1                               % ��� ������������� ������
    H(ind)=1/( 1+j*[(2*pi)*(ind-1)*L/Nfft] );
end

H(Nfft : -1 : Nfft/2+2)=conj( H(2:Nfft/2) );     % �������� �������� �� ������������� �������� ����������-������������
H=fftshift(H);                          % ������������� ������������ �������


S2=(H.*S1);                             % �������� ������ ��������� �������
s2=abs(ifft(S2,Nfft))*Nfft;                     % ��������������� �������� ������ �� �������

K1=[1:Nfft];
a=U/(1-log(dcr)*L/N);
sa2=a*[ exp(-log(dcr)*K1/Nfft) - exp(-K1/Lfft) ];    % ������������� ��������� ��� ��������� �������


V(1:Nfft)=[s2 - sa2].^2;         % ������ ��������� ���������� s2 � sa2
SKO=sqrt(sum(V)/Nfft)            % ��� - "���������� ��������"

figure
plot(s1, '-b', 'LineWidth', 1.5)
hold on
grid on
legend('s1 - in-signal')
%legend('s1 - ������� ������')
title('Time domain')
%title('������ �� ��������� �������')

figure
stem(W, S1, '-b', 'LineWidth', 1.5)
hold on
grid on
plot(W, abs(H), '--g', 'LineWidth', 1.5)
legend('Spectrum S1 (in-signal)', 'Haper')
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
stem(W, S2, '-r', 'LineWidth', 1.5)
legend('Haper', 'Spectrum S2 (out-signal)')
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

