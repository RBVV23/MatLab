clc
clear all
close all

N=1000;
T=5;
dt=T/N;
Time=linspace(0,T,N);
boost=10;

x0=0;
v0x=0.75;
y0=50;
Hmax=150;
v0y=10;
g=10;

for i=1:N
    t(i)=dt*(i-1);
    x(i)=x0 + v0x*t(i);
    y(i)=y0 + v0y*t(i) - 0.5*g*t(i)*t(i);
    plot(x, y, '--r', 'LineWidth', 1)
    hold on
    plot(x(i), y(i), '*r', 'LineWidth', 3)
    hold off
    axis([0 v0x*T -50 Hmax])
    pause(dt/boost)
end