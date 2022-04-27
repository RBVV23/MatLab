clc
clear all
close all


E=1;
tmin=0;
dt=0.1

for i=1:25
t(i)=tmin+dt*(i-1);
s(i)=0;
end

for i=26:75
t(i)=tmin+dt*(i-1);
s(i)=E;
end

for i=76:100
t(i)=tmin+dt*(i-1);
s(i)=0;
end

figure
plot(t, s, '-r', 'LineWidth', 3)
grid on
hold on
axis([0 10 -0.2 1.2])

Sw=fft(s);

figure
plot(abs(Sw), '-r', 'LineWidth', 3)
grid on
hold on