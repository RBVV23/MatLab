clc
clear all
close all

Ndiscr=500;

%Снято в лаборатории
f=2000;
T=500E-6;
Um=228E-3;


W=2*pi*f;
Tmin=0;
Tmax=4*T;
dt=T/Ndiscr;
Ntime=(Tmax-Tmin)/dt;

for i=1:Ntime
    t(i)=Tmin+dt*(i-1);
    original(i)=Um*sin(2*pi*t(i)/T);
end

plot(t*1E6, Um*1E3, '--r', 'LineWidth', 1)
grid on
hold on
plot(t*1E6, -Um*1E3, '--r', 'LineWidth', 1)
plot(t*1E6, original*1E3, '-r', 'LineWidth', 3)
title('Синусоидальный сигнал')
xlabel('t, мкс')
ylabel('U, мВ')
set(gca, 'XTick', 0:250:2000)
axis([0 2000 -300 300])
legend('Амплитуда - 228 мВ')