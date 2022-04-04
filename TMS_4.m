clc
clear all
close all

Fd=2000;                            % частота дискретизации (по варианту)
Fo=40;                              % частота несущей  (по варианту)

M = 3;                              % число периодов несущей на одном радиоимпульсе (по варианту)
K = Fd/Fo;                          % число дискретных отсчетов на период несущей
U = 1;                              % амплитуда (по варианту)
% U = sqrt(2);
C = [1 1 1 -1 -1 1 -1];             % вектор бинарного кода Баркера (по варианту)
% C = [1 1 1 -1 -1 -1 1 -1 -1 1 -1];
L = size(C,2);                      % разрядность кода Баркера
N = M*L*K                           % массив отсчетов

Kn=[1 5 10];                        % массив значений диспергии гауссовского шума
% Kn=1
Iter=5;                             % количество реализаций опыта в пункте №3

sig1=FCMSIG( N, 1, K, L, U, C );    % в первом пункте M=1 для всех вариантов sig=FCMSIG( N, (M=1), K, L, U, C )


N1=[1:size(sig1,2)];    % для корректной оси X на графике
C2(1)=C(1);             % формируем крпсивую огибающую на основе кода Баркера
C2(2:L)=C(2:L);         
C2(L+1)=C(L);           

figure                  
plot(N1/K, sig1, '-r', 'LineWidth', 1)
grid on
hold on
stairs((0:L),C2, '--g', 'LineWidth', 2.5)
set(gca, 'XTick', 0:1:L)
legend('FCM signal (M=1)', 'Signal bend')
% legend('ФКМ сигнал (M=1)','Огибающая')

sig=FCMSIG( N, M, K, L, U, C );

N2=[1:size(sig,2)];    % для корректной оси X на графике

figure                  
plot(N2/(K*M), sig, '-r', 'LineWidth', 1)
grid on
hold on
stairs((0:L),C2, '--g', 'LineWidth', 2.5)
set(gca, 'XTick', 0:1:L)
legend(['FCM signal (M=',num2str(M),')'], ['Signal bend'])
% legend('ФКМ сигнал (M - по варианту)','Огибающая')


AKF=xcorr(sig);        % автокорреляционная функция сигнала построенного, на коде Баркера

Cisk=C;                 % будущий искаженный код Баркера
Cisk(2)=-C(2);          % инверсия 2-ого элемента
Cisk(3)=-C(3);          % инверсия 3-ого элемента

sigisk=FCMSIG( N, M, K, L, U, Cisk );     % ФКМ сигнал, построенный на искаженном коде Баркера
AKFisk=xcorr(sigisk);                     % автокорреляционная функция сигнала, построенного на искаженном коде Баркера

figure
plot(AKFisk/N, '-m', 'LineWidth', 3.5)
hold on
grid on
plot(AKF/N, '-g', 'LineWidth', 1)
title('Normalized autocorrelation functions of FCM signals')
%title('Нормированные автокорреляционные функции ФКМ сигналов')
legend('Distored Barker code', 'Barker code')
%legend('Искаженный кода Баркера','Код Баркера')
axis tight                     % автоподгон осей

Pin=sum(sig.^2)/N              % мощность
Es=AKF(N)                      % энергия сигнала через автокорреляционную функцию в 0
Esp=fft(AKF)/N;                % энергетический спектр
Espi=abs(fftshift(Esp));       % симметризация и взятие модуля

figure
plot((-N+1 : N-1), Espi, '-r', 'LineWidth', 0.75)
grid on
hold on
title('Energy spectrum')
% title('Энергетический спектр')
axis tight

scl=10;                        % параметр 'scl' подбирается так, чтобы был хорошо виден главный лепесток
figure
plot((-N+1 : N-1), Espi, '-r', 'LineWidth', 1.5)
grid on
hold on
title('Energy spectrum (scaled)')
% title('Энергетический спектр (масштабированный)')
axis([-N/scl N/scl 0 max(Espi)])        

NR=Kn(1)*randn(1,N);        % реализация гауссовского шума
AKFnr=xcorr(NR);            % автокорреляционная функция гауссовского шума

Enr=sum(NR.^2)              % энергия гауссовского шума

%WN=abs(fft(AKFnr)/N);      % согласно примечанию здесь возможен вариант "WN=abs(fft(AKFnr)/N)"
WN=abs(ifft(AKFnr));        % но так получается более корректные результаты


figure
plot(NR, '-r', 'LineWidth', 0.75)
grid on
hold on
title('Realization of Gaussian noize')
% title('Реализация гауссовского шума')
axis tight

figure
stem(AKFnr, '-b', 'LineWidth', 1)
grid on
hold on
title('ACF of Gaussian noize')
% title('АКФ гауссовского шума')
axis tight

figure
stem(WN, '-m', 'LineWidth', 0.75)
grid on
hold on
title('Spectral denisty (power)')
% title('Спектральная плотность мощности (СПМ)')
axis tight

ccc=hsv(size(Kn, 2));
figure
title('Mixture of signal and noise');
%title('Смесь сигнала и шума');
for k=1:size(Kn,2)
    
    
    NR(k,:)=Kn(k)*randn(1,N);
    SN(k,:)=sig+NR(k,:);
    OUT(k,:)=xcorr(SN(k,:),sig);
    str{k} = [ 'Kn = ', num2str(Kn(k)) ];   % формируем массив подписей легенды
    subplot(size(Kn,2),1,k)
    plot(OUT(k,:), 'LineWidth', 1, 'color',ccc(k,:))
    legend([ 'Kn = ', num2str(Kn(k)) ])
    hold on
    grid on
    axis tight
end

for k=1:size(Kn,2)

    for i=1:Iter
        NR(k,:)=Kn(k)*randn(1,N);
        SN(k,:)=0*sig+NR(k,:);                 % подаем на вход только шум
        OUTnr(k,:)=xcorr(SN(k,:),sig);
        NRout=sum(OUTnr(k,:).^2)/N;             % мощность на выходе коррелятора (сигнал отсутствует)

        SN(k,:)=sig+0*NR(k,:);                 % подаем на вход только сигнал
        OUTsig(k,:)=xcorr(SN(k,:),sig);
        SIGout=OUTsig(k,N)^2;                   % мощность на выходе коррелятора (шум отсутствует)

        SNRmass(i)=SIGout/NRout;                % массив из 'Iter=5' ОСШ для 'Iter=5' реализаций эксперимента
    end
    SNR(k)=mean(SNRmass);                           % усреднение ОСШ по 'Iter=5' реализациям для дисперсии шума 'Kn(k)'
    SNRtheor(k)=Es/( Kn(k)^2 );                     % теоретическое значение ОСШ (Энергия/Дисперсия)

end

Kn=Kn
SNR=SNR'
SNRtheor=SNRtheor'