clc
clear all
close all

% ПАРАМЕТРЫ ПО ВАРИАНТУ
% 1 вариант (по умолчанию)

U=1;
Fd=2000;        % частота дискретизации
%Fd=Fd*2 - для пункта с удвоением частоты дискретизации
tau=5;          % постоянная времени (временная область)
tauRC=0.05;     % постоянная времени (частотная область)
N=1024;       % количество рассматриваемых отсчетов сигнала
%N=2*N - для пункта с удвоением частоты дискретизации

Ts=1/Fd;        % минимальный шаг по оси времени
%Ts=2*Ts - для пункта с удвоением частоты дискретизации

T=Ts*N           % длительность сигнала


L=tauRC/Ts;     % количество отсчетов tau (постоянной времени)
K=[1:N];        % массив отсчетов времени


s1=U*exp(-tau*K*Ts);

dcr=U/s1(N)                         % уровень спада сигнала

W=linspace(-Fd/2,Fd/2,N);
W=W*pi/Fd;                          % массив безразмерной частоты


S1=fft(s1)/N;
S1=fftshift(S1);

H=zeros(1,N);                                 % массив отсчетов передаточной функции
for ind=1:N/2+1                               % для положительных частот
    H(ind)=1/( 1+j*[(2*pi)*(ind-1)/T*tauRC] );
end

H(N : -1 : N/2+2)=conj( H(2:N/2) );     % заменяем значения на отрицательных частотах комплексно-сопряженными
H=fftshift(H);                          % симметризация передаточной функции


S2=(H.*S1);                             % получаем спектр выходного сигнала
s2=abs(ifft(S2,N)*N);                   % восстанавливаем выходной сигнал из спектра


a=U/(1-tau*tauRC);
sa2=a*[ exp(-tau*K*Ts) - exp(-K*Ts/tauRC) ];    % аналитическое выражение для выходного сигнала


V(1:N)=[s2 - sa2].^2;         % массив квадратов отклонений s2 и sa2
SKO=sqrt(sum(V)/N)            % СКО - "показатель качества"

figure
plot(s1, '-b', 'LineWidth', 1.5)
hold on
grid on
legend('s1 - in-signal')
%legend('s1 - входной сигнал')
title('Time domain')
%title('Сигнал во временной области')

figure
stem(W, abs(S1)/max(S1), '-b', 'LineWidth', 1.5)
hold on
grid on
plot(W, abs(H), '--g', 'LineWidth', 1.5)
legend('Normalized spectrum S1 (in-signal)', 'Haper')
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
stem(W, abs(S2)/max(S2), '-r', 'LineWidth', 1.5)
legend('Haper', 'Normalized spectrum S2 (out-signal)')
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

