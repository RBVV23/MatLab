clc
clear all
close all

global E f Timp
E=1;
Niter=100;


Timp=60E-6;
dt=Timp/Niter;
N=100;
Wmax=2*pi/Timp;
dw=Wmax/(Niter);
dx=dw;
Int=0;

T1=-Timp/2;
k1=-E/(Timp/6);
E1=-3*E;

T2=-Timp/3;
k2=0;
E2=-E;

T3=-Timp/6;
k3=(3/2)*E/(Timp/3);
E3=-E/4;

T4=Timp/6;
k4=0;
E4=E/2;

T5=Timp/3;
k5=-(E/2)/(Timp/6);
E5=3*E/2;



T6=Timp/2;

R=80;
C=20E-9;
T=R*C;



for i=1:2*Niter
   t(i)=-Timp + (i-1)*dt;
   for k=1:N*Wmax/dw
       W(k)=(k)*dw;
       Sjw1=Universignal(W(k), T1, T2, k1, E1);
       Sjw2=Universignal(W(k), T2, T3, k2, E2);
       Sjw3=Universignal(W(k), T3, T4, k3, E3);
       Sjw4=Universignal(W(k), T4, T5, k4, E4);
       Sjw5=Universignal(W(k), T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
       Int=Int+Sjw*exp(j*W(k)*t(i))*dw;      
   end
   S(i)=(1/(pi))*Int;
   Int=0;
end



figure
plot(t*1E6, S, '-r', 'LineWidth', 4)
grid on
hold on
title('Сигнал s(t)')
axis([-(2/3)*Timp*1000000 (2/3)*Timp*1000000 -1.5*E E])
xlabel('t, мкс')
ylabel('u, В')


N=10;

for k=1:N*Wmax/dw
       w(k)=(k)*dw;
       Sjw1=Universignal(w(k), T1, T2, k1, E1);
       Sjw2=Universignal(w(k), T2, T3, k2, E2);
       Sjw3=Universignal(w(k), T3, T4, k3, E3);
       Sjw4=Universignal(w(k), T4, T5, k4, E4);
       Sjw5=Universignal(w(k), T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
       Spectre(k)=Sjw;
       K(k)=1/(sqrt((w(k)*T)^2 + 1));
       XXX(k)=K(k)*abs(Spectre(k));
end

Fo=0;
Fmax=Wmax/(2*pi);
dF=1000;
M=(Fmax-Fo)/dF;
for m=1:M
   F(m)=Fo+dF*(m-1);
   k=(2*pi*F/dw) + 1;
   Sp(m)=K(k)*abs(Spectre(k));
end


figure
stem(w/(2*pi), abs(Spectre), '-r', 'LineWidth', 3)
grid on
hold on
title('Амплитудный спектр сигнала s(t)')
xlabel('f, Гц')
ylabel('|A|, В')

figure
plot(w/(2*pi), K, '-r', 'LineWidth', 3)
grid on
hold on
title('Амплитудный спектр сигнала s2(t)')
xlabel('f, Гц')
ylabel('|A|, В')


figure
stem(F, Sp, '-r', 'LineWidth', 3)
grid on
hold on
title('Амплитудный спектр сигнала s3(t)')
xlabel('f, Гц')
ylabel('|A|, В')


f0=0;
fmax=3e5;
df=1;
N=(fmax-f0)/df;

for i=1:N
    f(i)=(f0+df*(i-1));
    w(i)=2*pi*f(i);
    s(i)=j*w(i);
    K(i)=1/(sqrt((w(i)*T)^2 + 1));
    
end


% figure
% plot(w/(2*pi), angle(Spectre)/pi, '-r', 'LineWidth', 3)
% grid on
% hold on
% title('Фазовый спектр сигнала s(t)')
% xlabel('f, Гц')
% ylabel('\theta, \pi')


