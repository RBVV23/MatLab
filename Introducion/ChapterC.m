clc
clear all

betta0=0.01;
T0=300;
Ep0=3;
Est=4.7;
k=0.02;
m=2.5;
n=1.4;
p=2.3;
Tmax=400;
Tmin=200;


h=10;
N=(Tmax-Tmin)/h

for j=1 : N
        T(j)=Tmin+j*h
        betta(j)=betta0*((T0/T(j))^n)*1000
        Ep(j)=Est-((T(j)/T0)^(n/p))*(Est-Ep0)
end

figure
plot(T, betta, '-r', 'LineWidth', 1.5)
ylabel('Удельная кривизна, мА/В^p')
xlabel('Температура, К')
hold on
grid on
legend('To = 300K', 2)


set(gca, 'XTick', 200:25:400)
set(gca, 'YTick', 5:5:20)



figure
plot(T, Ep, '-b', 'LineWidth', 1.5)
ylabel('Пороговое напряжение, В/м')
xlabel('Температура, К')
hold on
grid on
legend('To = 300K', 2)
set(gca, 'XTick', 200:25:400)
set(gca, 'YTick', 2:0.5:4)




