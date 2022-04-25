clc
clear all
close all

eps=1E-6

xmin=-10*pi;
xmax=10*pi;

dx=0.01;
N=(xmax-xmin)/dx

for i=1:N
   x(i)=xmin + dx*(i-1);
   y(i)=FUNC(x(i));
   y2(i)=2/(1+x(i)*x(i));
end

figure
plot(x, y, '-r', 'LineWidth', 3)
hold on
grid on
plot(x, y2, '-b', 'LineWidth', 3)
title('sin(x)/x')






