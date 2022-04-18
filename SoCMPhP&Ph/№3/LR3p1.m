clc;
clear all;
close all;

%Начальные условия
Vo=0;
Vn=9.5e3;
Mp=3e3;
Mpmin=5e2;
LMBD=0.1;
U=3e3;
Umax=4e3;
dU=10;
dMp=50;
Ho=0;
Tmin=0;
% Tmax=
n=3;
BETTA=100;

M=(Umax-U)/dU;
K=(Mp-Mpmin)/dMp;

%Точность
dt=1;
% N=(Tmax-Tmin)/dt;


for n= 2:4
    P(n)=exp(-Vn/(n*U));
    mo(n)=Mp*(( (1-LMBD)/(P(n)-LMBD) )^n )
end

%Двухступенчатая
fprintf('Двухступенчатая')
i=2;
alpha=(mo(i) /Mp)^(1/i);
m2=(alpha-1)*Mp;
m1=(alpha-1)*(Mp+m2);
Mo=Mp+m1+m2;


m2=roundn(m2,3)
m1=roundn(m1,3)
Mo=roundn(Mo,3)
Mo2st=Mo;

%Аналитическая формула
N1=( Mo - (Mp+m1+LMBD*m2) )/(BETTA);
N2 =( (Mp+m1) - (Mp+LMBD*m1) )/(BETTA); 

H2st(1)=Ho;
for i= 1:N1
    t2(i)= Tmin + dt*(i-1);
    m2st(i)= Mo - BETTA*t2(i);
    V2st(i) = Vo + U*log(Mo/m2st(i));
    H2st(i+1) = H2st(i) + V2st(i)*dt;
end

    
for i= N1+1 : N1+N2
    t2(i)= Tmin + dt*(i-1);
    m2st(i)= (Mo-(LMBD)*m2) - BETTA*t2(i);
    V2st(i) = V2st(N1) + U*log((Mo-m2)/m2st(i));
    H2st(i+1) = H2st(i) + V2st(i)*dt;
end

Vo=V2st(i);
t2(N1+N2+1) = t2(i) + dt;
m2st(N1+N2+1)= Mo - m2 - m1;
V2st(N1+N2+1)=V2st(N1+N2) + U*log((Mo-m1-m2)/m2st(N1+N2+1));
%H2st(N1+N2+1)=H2st(N1+N2) + V2st(N1+N2+1)*dt;
T2=t2(N1+N2+1);
%ode45

T=linspace(0,t2(N1),N1);
[T1 Fode1]=ode45('Sys_ODE', T, [Mo V2st(1)]);
T=linspace(t2(N1+1),t2(N1+N2),N2);
[T2 Fode2]=ode45('Sys_ODE', T, [(Mo-m2) V2st(N1)]);

n=2;
for j= 1:M
    Ut(j)=U + dU*(j-1);
    P=exp(-Vn/(n*Ut(j)));
    mass2st(j)=(( (1-LMBD)/(P-LMBD) )^n)*Mp;
end

for k= 1:K+1
    Mpt(k)= Mpmin + dMp*(k-1);
    P=exp(-Vn/(n*U));
    mass2st2(k)=(( (1-LMBD)/(P-LMBD) )^n)*Mpt(k);
end

figure('Name', '2 ступени')
plot(Ut, mass2st, '-r', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от скорости истечения газов U');
%legend('');
xlabel('U, м/с')
ylabel('Mo, кг')

figure('Name', '2 ступени')
plot(Mpt, mass2st2, '-r', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от полезной нагрузки Mp');
%legend('');
xlabel('Mp, кг')
ylabel('Mo, кг')


figure('Name', '2 ступени')
plot(t2, m2st, '-r', 'LineWidth', 3);
grid on
hold on
title('Зависимость массы ракеты m от времени t');
%legend('');
xlabel('t, с')
ylabel('m, кг')

figure('Name', '2 ступени')
plot(t2, H2st, '-r', 'LineWidth', 3);
grid on
hold on
title('Зависимость высоты подъема ракеты H от времени t');
xlabel('t, с')
ylabel('H, м')


figure('Name', '2 ступени')
plot(t2, V2st, '-r', 'LineWidth', 3);
grid on
hold on
plot(T1, Fode1(:, 2), ':y', 'LineWidth', 3);
plot(T2, Fode2(:, 2), ':y', 'LineWidth', 3);
title('Зависимость скорости ракеты V от времени t');
xlabel('t, с')
ylabel('V, м/с')
legend('Аналитическая формула','Численное решение');




%Трехступенчатая
fprintf('Трехступенчатая')
i=3;
Vo=0;
alpha=(mo(i) /Mp)^(1/i);
m3=(alpha-1)*Mp
m2=(alpha-1)*(Mp+m3)
m1=(alpha-1)*(Mp+m2+m3)
Mo=Mp+m1+m2+m3

m3=roundn(m3,3)
m2=roundn(m2,3)
m1=roundn(m1,3)
Mo=roundn(Mo,3)
Mo3st=Mo;


N1=( Mo - (Mp+m1+m2+LMBD*m3) )/(BETTA);
N2 =( (Mp+m1+m2) - (Mp+m1+LMBD*m2) )/(BETTA); 
N3 =( (Mp+m1) - (Mp+LMBD*m1) )/(BETTA);

H3st(1)=Ho;
for i= 1:N1
    t3(i)= Tmin + dt*(i-1);
    m3st(i)= Mo - BETTA*t3(i);
    V3st(i) = Vo + U*log(Mo/m3st(i));
    H3st(i+1) = H3st(i) + V3st(i)*dt;
end

for i= N1+1 : N1+N2
    t3(i)= Tmin + dt*(i-1);
    m3st(i)= (Mo-(LMBD)*m3) - BETTA*t3(i);
    V3st(i) = V3st(N1) + U*log((Mo-m3)/m3st(i));
    H3st(i+1) = H3st(i) + V3st(i)*dt;
end

for i= N1+N2+1 : N1+N2+N3
    t3(i)= Tmin + dt*(i-1);
    m3st(i)= (Mo-(LMBD)*m3-(LMBD)*m2) - BETTA*t3(i-1);
    V3st(i) = V3st(N1+N2) + U*log((Mo-m3-m2)/m3st(i));
    H3st(i+1) = H3st(i) + V3st(i)*dt;
end

t3(N1+N2+N3+1) = t3(i);
m3st(N1+N2+N3+1)= Mo - m3 - m2 - m1;
V3st(N1+N2+N3+1) = V3st(N1+N2+N3) + U*log((Mo-m1-m2-m3)/m3st(N1+N2+N3+1));
%H3st(N1+N2+N3+1) = H3st(N1+N2+N3) + V3st(N1+N2+N3+1)*dt;

%ode45


T=linspace(0,t3(N1),N1);
[T1 Fode1]=ode45('Sys_ODE', T, [Mo V3st(1)]);
T=linspace(t3(N1+1),t3(N1+N2),N2);
[T2 Fode2]=ode45('Sys_ODE', T, [(Mo-m3) V3st(N1)]);
T=linspace(t3(N1+N2+1),t3(N1+N2+N3),N3);
[T3 Fode3]=ode45('Sys_ODE', T, [(Mo-m3-m2) V3st(N1+N2)]);


n=3;
for j= 1:M
    P=exp(-Vn/(n*Ut(j)));
    mass3st(j)=(( (1-LMBD)/(P-LMBD) )^n)*Mp;
end

for k= 1:K+1
    Mpt(k)= Mpmin + dMp*(k-1);
    P=exp(-Vn/(n*U));
    mass3st2(k)=(( (1-LMBD)/(P-LMBD) )^n)*Mpt(k);
end

figure('Name', '3 ступени')
plot(Mpt, mass3st2, '-g', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от полезной нагрузки Mp');
%legend('');
xlabel('Mp, кг')
ylabel('Mo, кг')


figure('Name', '3 ступени')
plot(Ut, mass3st, '-g', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от скорости истечения газов U');
%legend('');
xlabel('U, м/с')
ylabel('Mo, кг')


figure('Name', '3 ступени')
plot(t3, m3st, '-g', 'LineWidth', 3);
grid on
hold on
title('Зависимость массы ракеты m от времени t');
legend('3 ступени')
xlabel('t, с')
ylabel('m, кг')


figure('Name', '3 ступени')
plot(t3, V3st, '-g', 'LineWidth', 3);
grid on
hold on
plot(T1, Fode1(:, 2), ':y', 'LineWidth', 3);
plot(T2, Fode2(:, 2), ':y', 'LineWidth', 3);
plot(T3, Fode3(:, 2), ':y', 'LineWidth', 3);
title('Зависимость скорости ракеты V от времени t');
xlabel('t, с')
ylabel('V, м/с')
legend('Аналитическая формула','Численное решение');

figure('Name', '3 ступени')
plot(t3, H3st, '-g', 'LineWidth', 3);
grid on
hold on
%plot(T, Yode(:, 2), '-g', 'LineWidth', 1);
title('Зависимость высоты подъема ракеты H от времени t');
xlabel('t, с')
ylabel('H, м')




%Четырехступенчатая
fprintf('Четырехступенчатая')
i=4;
Vo=0;
alpha=((mo(i))/Mp)^(1/i);
m4=(alpha-1)*Mp
m3=(alpha-1)*(Mp+m4)
m2=(alpha-1)*(Mp+m3+m4)
m1=(alpha-1)*(Mp+m2+m3+m4)
Mo=Mp+m1+m2+m3+m4


m4=roundn(m4,3)
m3=roundn(m3,3)
m2=roundn(m2,3)
m1=roundn(m1,3)
Mo=roundn(Mo,3)
Mo4st=Mo;


N1=( Mo - (Mp+m1+m2+m3+LMBD*m4) )/(BETTA);
N2 =( (Mp+m1+m2+m3) - (Mp+m1+m2+LMBD*m3) )/(BETTA); 
N3 =( (Mp+m1+m2) - (Mp+m1+LMBD*m2) )/(BETTA);
N4 =( (Mp+m1) - (Mp+LMBD*m1) )/(BETTA);



H4st(1)=Ho;
for i= 1:N1
    t4(i)= Tmin + dt*(i-1);
    m4st(i)= Mo - BETTA*t4(i);
    V4st(i) = Vo + U*log(Mo/m4st(i));
    H4st(i+1)= H4st(i) + V4st(i)*dt;
    end

for i= N1+1 : N1+N2
    t4(i)= Tmin + dt*(i-1);
    m4st(i)= (Mo-(LMBD)*m4) - BETTA*t4(i);
    V4st(i) = V4st(N1) + U*log((Mo-m4)/m4st(i));
    H4st(i+1)= H4st(i) + V4st(i)*dt;
end

for i= N1+N2+1 : N1+N2+N3
    t4(i)= Tmin + dt*(i-1);
    m4st(i)= (Mo-(LMBD)*m4-(LMBD)*m3) - BETTA*t4(i);
    V4st(i) = V4st(N1+N2) + U*log((Mo-m3-m4)/m4st(i));
    H4st(i+1)= H4st(i) + V4st(i)*dt;
end

for i= N1+N2+N3+1 : N1+N2+N3+N4
    t4(i)= Tmin + dt*(i-1);
    m4st(i)= (Mo-(LMBD)*m4-(LMBD)*m3-(LMBD)*m2) - BETTA*t4(i);
    V4st(i) = V4st(N1+N2+N3) + U*log((Mo-m4-m3-m2)/m4st(i));
    H4st(i+1)= H4st(i) + V4st(i)*dt;
end

t4(N1+N2+N3+N4+1) = t4(i);
m4st(N1+N2+N3+N4+1)= Mo - m4 - m3 - m2 - m1;
V4st(N1+N2+N3+N4+1) = V4st(N1+N2+N3+N4) + U*log((Mo-m1-m2-m3-m4)/m4st(N1+N2+N3+N4+1));
%H4st(N1+N2+N3+N4+1) = H4st(N1+N2+N3+N4) + V4st(N1+N2+N3+N4+1)*dt;

%ode45

T=linspace(0,t4(N1),N1);
[T1 Fode1]=ode45('Sys_ODE', T, [Mo V4st(1)]);
T=linspace(t4(N1+1),t4(N1+N2),N2);
[T2 Fode2]=ode45('Sys_ODE', T, [(Mo-m4) V4st(N1)]);
T=linspace(t4(N1+N2+1),t4(N1+N2+N3),N3);
[T3 Fode3]=ode45('Sys_ODE', T, [(Mo-m4-m3) V4st(N1+N2)]);
T=linspace(t4(N1+N2+N3+1),t4(N1+N2+N3+N4),N4);
[T4 Fode4]=ode45('Sys_ODE', T, [(Mo-m4-m3-m2) V4st(N1+N2+N3)]);


n=4;
for j= 1:M
    P=exp(-Vn/(n*Ut(j)));
    mass4st(j)=(( (1-LMBD)/(P-LMBD) )^n)*Mp;
end

for k= 1:K+1
    Mpt(k)= Mpmin + dMp*(k-1);
    P=exp(-Vn/(n*U));
    mass4st2(k)=(( (1-LMBD)/(P-LMBD) )^n)*Mpt(k);
end


figure('Name', '4 ступени')
plot(Mpt, mass4st2, '-b', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от полезной нагрузки Mp');
%legend('');
xlabel('Mp, кг')
ylabel('Mo, кг')


figure('Name', '4 ступени')
plot(Ut, mass4st, '-b', 'LineWidth', 3);
grid on
hold on
title('Зависимость начальной массы ракеты Mo от скорости истечения газов U');
%legend('');
xlabel('U, м/с')
ylabel('Mo, кг')


figure('Name', '4 ступени')
plot(t4, m4st, '-b', 'LineWidth', 3);
grid on
hold on
title('Зависимость массы ракеты m от времени t');
legend('4 ступени')
xlabel('t, с')
ylabel('m, кг')

figure('Name', '4 ступени')
plot(t4, V4st, '-b', 'LineWidth', 3);
grid on
hold on
plot(T1, Fode1(:, 2), ':y', 'LineWidth', 3);
plot(T2, Fode2(:, 2), ':y', 'LineWidth', 3);
plot(T3, Fode3(:, 2), ':y', 'LineWidth', 3);
plot(T4, Fode4(:, 2), ':y', 'LineWidth', 3);
title('Зависимость скорости ракеты V от времени t');
xlabel('t, с')
ylabel('V, м/с')
legend('Аналитическая формула','Численное решение');

figure('Name', '4 ступени')
plot(t4, H4st, '-b', 'LineWidth', 3);
grid on
hold on
%plot(T, Yode(:, 2), '-g', 'LineWidth', 1);
title('Зависимость высоты подъема ракеты H от времени t');
xlabel('t, с')
ylabel('H, м')
