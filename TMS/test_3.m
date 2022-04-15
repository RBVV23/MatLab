clc
clear all
close all

% ПАРАМЕТРЫ ПО ВАРИАНТУ
% 1 вариант (по умолчанию)

U=1;
Fd=2000;        % частота дискретизации
T=5;            % длительность сигнала
tau=0.05;       % постоянная времени
N=1024;         % количество рассматриваемых отсчетов сигнала
Nfft=T*Fd;
Nfft=8096;

Ts=T/N;         % минимальный шаг по оси времени

L=tau/Ts;       % количество отсчетов tau (постоянной времени)
K=[1:N];        % массив отсчетов времени


s1=U*exp(-tau*K*Ts);

dcr=U/s1(N)                         % уровень спада сигнала
W=linspace(-Fd/2,Fd/2,Nfft);
W=W*pi/Fd;                          % массив безразмерной частоты

Wh=linspace(-Fd/2,Fd/2,N);
Wh=Wh*pi/Fd;             

S1=fft(s1,Nfft)/N;
S1=fftshift(S1);

Lfft=tau*Fd; 
H=zeros(1,Nfft);                                 % массив отсчетов передаточной функции
for ind=1:Nfft/2+1                               % для положительных частот
    H(ind)=1/( 1+j*[(2*pi)*(ind-1)*L/Nfft] );
end

H(Nfft : -1 : Nfft/2+2)=conj( H(2:Nfft/2) );     % заменяем значения на отрицательных частотах комплексно-сопряженными
H=fftshift(H);                          % симметризация передаточной функции


S2=(H.*S1);                             % получаем спектр выходного сигнала
s2=abs(ifft(S2,Nfft))*Nfft;                     % восстанавливаем выходной сигнал из спектра

K1=[1:Nfft];
a=U/(1-log(dcr)*L/N);
sa2=a*[ exp(-log(dcr)*K1/Nfft) - exp(-K1/Lfft) ];    % аналитическое выражение для выходного сигнала


V(1:Nfft)=[s2 - sa2].^2;         % массив квадратов отклонений s2 и sa2
SKO=sqrt(sum(V)/Nfft)            % СКО - "показатель качества"

figure
plot(s1, '-b', 'LineWidth', 1.5)
hold on
grid on
legend('s1 - in-signal')
%legend('s1 - входной сигнал')
title('Time domain')
%title('Сигнал во временной области')

figure
stem(W, S1, '-b', 'LineWidth', 1.5)
hold on
grid on
plot(W, abs(H), '--g', 'LineWidth', 1.5)
legend('Spectrum S1 (in-signal)', 'Haper')
%legend('s1 - входной сигнал')
title('Frequency domain')
%title('Сигналы во временной области')

figure
plot(W, abs(H), '-g', 'LineWidth', 1.5)
hold on
grid on
title('Frequency domain')
legend('Haper, |H|')
%title('Передаточная характеристика, |H|')

figure
plot(W, abs(H), '--g', 'LineWidth', 0.75)
hold on
grid on
stem(W, S2, '-r', 'LineWidth', 1.5)
legend('Haper', 'Spectrum S2 (out-signal)')
%legend('s1 - входной сигнал')
title('Frequency domain')
%title('Сигналы во временной области')


figure
plot(s2, '-r', 'LineWidth', 1.5)
hold on
grid on
plot(sa2, '--g', 'LineWidth', 1.5)
legend('s2 - reconstructed', 'sa2 - analitical')
title('Time domain')

