clc
clear all
close all


%% ПАРАМЕТРЫ ПО ВАРИАНТУ
% 1 вариант (по умолчанию)

Type=1      % Тип импульса
tau=10E-3   % Продолжительность импульса
Q=4;        % Скважность импульса
U=1E-3      % Максимальное значение напряжения в импульсе
N=256;      % Количество точек для расчета
Tcm=0;      % Задержка сигнала

L=10;       % Число точек разбиения для восстановления сигнала

Time=linspace(0, tau, N);
TimeL=linspace(0, tau, N*L);


dt=tau/N;
df=1/tau;
dw=2*pi/N;
Ncm=Tcm/dt;


M=N/Q;

X=zeros(1,N);               % Массив под спектр сигнала
s=zeros(1, L*N);            % Массив под восстанавливаемый сигнал

%% ФОРМИРОВАНИЕ ИМПУЛЬСА
% 0 - Прямоугольный
% 1 - Пилообразный
% 2 - Треугольный
% 3 - Гауссовский

switch Type
   case 0
    for i=(Ncm+1):(M+Ncm-1)
       X(i)=U; 
    end
   case 1
    for i=(Ncm+1):(M+Ncm-1)
       X(i)=U*(i-Ncm)/(M-1); 
    end
   case 2
    for i=(Ncm+1):(M/2+Ncm-1)
       X(i)=U*(i-Ncm)/(M/2); 
    end
    for i=(M/2+Ncm):(M+Ncm-1)
       X(i)=U-U*(i-M/2-Ncm)/(M/2); 
    end
   case 3
    disp=(3*M/2)/log(10);
    Ug=U/(2*pi)^(-0.5); 
    for i=(Ncm+1):(M+Ncm-1)
       X(i)=Ug*(2*pi)^(-0.5)*exp( -( i-(Ncm+M/2) )^2/(2*disp) ); 
    end
   otherwise
    for i=(Ncm+1):(M+Ncm-1)
       X(i)=0;
       printf('Некорректно задан тип сигнала')
    end
end

%% ТЕЛО ПРОГРАММЫ

Y=fft(X)/N;
Ymod=abs(Y);
Fr=linspace(0,df*(N-1),N);  % Реальная частота
Wb=linspace(0,dw*(N-1),N);  % Безразмерная частота
Wbi=pi*[-1:2/N:(1-2/N)];    % Безразмерная частота (симметричная относительно 0)
Fri=0.5*[-1:2/N:(1-2/N)];   % Реальная частота (симметричная относительно 0)
Yi=fftshift(Y);             % Спектр сигнала (симметричнаый относительно 0)
Yimod=abs(Yi);
Yarg=angle(Y);
Yiarg=angle(Yi);

%%%%%%


Yrazv=fliplr(Y);
Ymodr=abs(Yrazv);
Yargr=angle(Yrazv);

V=2*pi/L/N;
for m=1:L*N
    sig=0;
    for ind=2:N/2
    sig=sig+2*Ymodr(ind)*cos((ind-1)*m*V +Yargr(ind-1) );
    end
Sm(m)=Y(1)+sig;
end

Sm=fliplr(Sm);

S=N*ifft(Y);


%% ПОСТРОЕНИЕ ГРАФИКОВ

figure
subplot(4,1,1)
stem(X, '-r', '.')
axis([0 N 0 U])
grid on
title('Source signal')
ylabel('U, В')
xlabel('N - readouts')

subplot(4,1,2)
stem(Ymod, '-r', '.')
axis([0 N 0 max(Ymod)])
grid on
title('Amplitude spectrum')
ylabel('Re(X)')
xlabel('N - readouts')


subplot(4,1,3)
stem(Yimod, '-r', '.')
axis([0 N 0 max(Yimod)])
grid on
title('Amplitude spectrum (symmetrically relative 0)')
ylabel('Re(X)')
xlabel('N - readouts')

subplot(4,1,4)
plot(S, '-r', 'LineWidth', 2.5)
axis([0 N 0 max(S)])
grid on
title('Reconstructed signal')
ylabel('U, V')
xlabel('N - readouts')

%%%%%%

figure
subplot(4,1,1)
stem(Fr, Ymod, '-r', '.')
axis([min(Fr) max(Fr) 0 max(Ymod)])
grid on
title('Amplitude spectrum (symmetrically relative 0)')
ylabel('Re(X)')
xlabel('F - real frequency')

subplot(4,1,2)
stem(Wbi, Yimod, '-r', '.')
axis([min(Wbi) max(Wbi) 0 max(Yimod)])
grid on
title('Amplitude spectrum (symmetrically relative 0)')
ylabel('Re(X)')
xlabel('Wb - dimensionless frequency')

subplot(4,1,3)
stem(Fr, Yarg, '-r', '.')
axis([min(Fr) max(Fr) min(Yarg) max(Yarg)])
grid on
title('Phase spectrum')
ylabel('Im(X)')
xlabel('F - real frequency')

subplot(4,1,4)
stem(Wbi, Yiarg, '-r', '.')
axis([min(Wbi) max(Wbi) min(Yiarg) max(Yiarg)])
grid on
title('Phase spectrum')
ylabel('Im(X)')
xlabel('Wb - dimensionless frequency')

%%%%%%

figure
subplot(3,1,1)
plot(Time, X, '-r', 'LineWidth', 2.5)
title('Signals in time domain')
grid on
legend('Source signal')
axis([min(Time) max(Time) min(X) max(X)])

subplot(3,1,2)
plot(TimeL, Sm, '-r', 'LineWidth', 2.5)
grid on
legend('Reconstructed (analytical)')
axis([min(Time) max(Time) min(X) max(X)])

subplot(3,1,3)
plot(Time, S, '-r', 'LineWidth', 2.5)
grid on
legend('Reconstructed (ifft)')
axis([min(Time) max(Time) min(X) max(X)])
ylabel('U, В')
xlabel('t, s')