clc
clear all
close all


% % ПАРАМЕТРЫ ПО ВАРИАНТУ
% 1 вариант (по умолчанию)

N = 1024;
Fd = 5500;  W=2*pi*Fd;   Ts=1/Fd;
Fo = 1000;  To=1/Fo; Wo=2*pi*Fo;    % несущая частота
VRT = 1;                            % коэффициент перед 't' по варианту
Am = 1;                             % коэффициент перед 'sin' или 'cos' по варианту

Tc=N*Ts*5;
L=(To/Ts);

L=64;
% Wo=2*pi/(Ts*L)

Uo=1;
M=0.5;

K=[0:N-1];  % массив отчетов времени

Psi=0;
X=2*pi*VRT*(K/N) + Psi;
Type=1;

switch Type
    case 1
s=Am*sin(X);
s_ort=Am*cos(X);
    case 2
s=Am*cos(X);
s_ort=Am*sin(X);
end

Ussb=Uo*sqrt(1+M*s+(M/2)^2);    % Огибающая (амплитуда) ОПМ-сигнала
Uam=Uo*(1 + M*s);               % Огибающая (амплитуда) АМ-сигнала

a=Uo*(1+(M/2)*s);
b=(M*Uo/2)*s_ort;
TETA=atan(b./a);

OMbf=zeros(1,N);
K1=[2:N];
OMbf(2:N)=TETA(K1)-TETA(K1-1);      % Безоамзмерная мгновенная частота с вычтенной несущей
OMbf(1)=OMbf(2);

Y=2*pi*K/L;

u2=Uam(K+1).*cos(Y);                % ВЧ-наполнение АМ-сигнала
u=Ussb(K+1).*cos(Y + TETA(K+1));    % ВЧ-наполнение ОПМ-сигнала
Su=fft(u)/N;                        % Спектр ВЧ-наполнения ОПМ-сигнала
Sh=fftshift(Su);                    % Симмеризация спектра относительно 0
Su2=fft(u2)/N;                      % Спектр ВЧ-наполнения АМ-сигнала
Sh2=fftshift(Su2);                  % Симмеризация спектра относительно 0

Uamv=(Uam-Uo)/M;

%R=abs(Sh);

Sz=2*Sh;                % удваиваем спектр для получения спектра аналитического сигнала
%Sz(1:N/2 + 1)=0;        % обнуляем часть спектра с отрицательной частотой
Sz(N/2 + 1 :N)=0;
%Sz(N/2 +1)=Sh(N/2 +1);  % уравниваем спектры на нулевой частоте
Za=ifft(Sz)*N;          % восстановление аналитического сигнала из его спектра при помощи ОБПФ
Zu2=ifft(Sh2)*N;        % восстановление ВЧ-наполнения АМ-сигнала из его спектра при помощи ОБПФ

Zamod=abs(Za);

Zssbv=[(abs(Za)/Uo).^2-(M/2)^2-1]/M;  %восстановление исходного сигнала из ОПМ

Ur=real(Za);        % Сигнал s(t)
Ui=imag(Za);        % Сигнал s_ort(t)
TET=zeros(1, N);
OMb=zeros(1, N);


figure
plot(u, '-k', 'LineWidth', 1)
hold on
grid on
plot(s, '-g', 'LineWidth', 3)
plot(Zssbv, '--r', 'LineWidth', 3)
plot(Ussb, '-b', 'LineWidth', 2)
plot(-Ussb, '-b', 'LineWidth', 2)
legend('HF-carrier wave','s(t) - signal','Zssb(t) - reconstructed signal','Ussb(t) - amplitude')
title('SSB-modulation')

% figure
% plot(s, '-g', 'LineWidth', 3)
% hold on
% grid on
% plot(u2, '-k', 'LineWidth', 1)
% plot(Uamv, '--r', 'LineWidth', 3)
% plot(Uam, '-b', 'LineWidth', 2)
% plot(-Uam, '-b', 'LineWidth', 2)
% legend('s(t) - signal','HF-carrier wave','Uamv(t) - reconstructed* signal','Uam(t) - amplitude')
% title('Amplitude modulation')


figure
stem(Sh, '-m', 'LineWidth', 2)
hold on
grid on
stem(Sz, '--k', 'LineWidth', 2)
legend('Sh - spectrum', 'Sz - anal spectrum')


TET(1)=-angle(Za(1)) + Y(1); % иначе фаза будет смещена относительно истинного значения
for ind=2:N
    OMb(ind)=[ Ur(ind-1)*Ui(ind) - Ur(ind)*Ui(ind-1) ] /( Ur(ind)^2 + Ui(ind)^2 ) -2*pi/L ;
    TET(ind)=TET(ind-1) + OMb(ind);
end   
OMb(1)=OMb(2);  % иначе после первого отсчета происходит скачок частоты


V(1:N)=(OMb(1:N) - OMbf(1:N)).^2;
SKO=sqrt(sum(V)/N)
    
figure
plot(K, TET, '-r', 'LineWidth', 2)
hold on
grid on
plot(K, TETA, '--g', 'LineWidth', 2)
legend('TET', 'TETA')

figure
plot( OMb, '-r', 'LineWidth', 2)
hold on
grid on
plot(OMbf, '--g', 'LineWidth', 2)
legend('OMb', 'OMbf')

