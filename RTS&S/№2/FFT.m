clc
clear all
close all

f1=50;
f2=150;


N=1000;
Tmin=0;
Tmax=0.1
dt=(Tmax-Tmin)/N;

t=Tmin:dt:Tmax;

E=1;
A1=1.0;
A2=0.7;
A3=0.5;

s=t;
for i=1 : (500)
    s(i)=0;
end

for i=500 : 550
    s(i)=1;
end

for i=550 : 1000
    s(i)=0;
end

% figure
% plot(t, s1, '-r', 'LineWidth', 3)
% hold on
% grid on
% 
% figure
% plot(t, s2, '-b', 'LineWidth', 3)
% hold on
% grid on

figure
plot(t, s, '-g', 'LineWidth', 3)
hold on
grid on


fd=1/dt;
Sw=fft(s);
Sw=fftshift(Sw)
Fw=linspace(-fd/2, fd/2, N+1)
Sw=2*Sw;
Sw(N/2+1)=Sw(N/2+1)/2;

for i=1:N/2
    Sw(i)=0;
end



figure
plot( Fw, abs(Sw)/N, '-k', 'LineWidth', 5)
hold on
grid on
axis([-30 250 -0.1 1.5])

