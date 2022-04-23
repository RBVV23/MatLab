clc
clear all
%close all

N=[2 4 6 8 10 20 30 40 50 60 70 80 90 100 200 300]
Amax=50;

for n=1 : size(N,2)
    x=[1:N(n)];
    A=ceil( -Amax + 2*Amax*rand(N(n)) );
    f=A*x';
    xs=A\f;
    nev(n)=norm((A*xs - f))/sqrt(N(n));
    e(n)=norm((xs'-x))/sqrt(N(n));
end

figure
plot(N, e, '*r', 'LineWidth', 5)
hold on
grid on
plot(N, e, '-r', 'LineWidth', 3)
title('Зависимость ошибки решения СЛАУ от порядка')
ylabel('Ошибка')
xlabel('Порядок СЛАУ')
legend('Линейный масштаб', 2)

figure
semilogx(N, e, '*b', 'LineWidth', 5)
hold on
grid on
semilogx(N, e, '-b', 'LineWidth', 3)
title('Зависимость ошибки решения СЛАУ от порядка')
ylabel('Ошибка')
xlabel('Порядок СЛАУ')
legend('Логарифмический масштаб', 2)

n=3    
N(n)=3;
x=zeros(1, N(n));
    for i=1 : N(n)
        x(i)=i;
    end
x'
A=ceil( -Amax + 2*Amax*rand(N(n)) )
f=A*x'
xs=inv(A)*f;
sqrt(N(n))
nev(n)=norm((A*xs - f))/sqrt(N(n))
e(n)=norm((xs'-x))/sqrt(N(n))

