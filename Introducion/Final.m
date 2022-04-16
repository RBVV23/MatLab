clc
clear all
tetta0=0;
tettaN=180;
h=0.5;
N=(tettaN-tetta0)/h;
for j=1 : N+1
    tetta(j)=tetta0 + (j-1)*h;
    t(j)=tetta(j)*pi/180
    gamma0(j)=(sin(t(j))-t(j)*cos(t(j)))/pi;
    gamma1(j)=(2*t(j)-sin(2*t(j)))/(2*pi);
    gamma2(j)=(2*(sin(t(j)))^3)/(3*pi);
    alpha0(j)=gamma0(j)/(1-cos(t(j)));
    alpha1(j)=gamma1(j)/(1-cos(t(j)));
    alpha2(j)=gamma2(j)/(1-cos(t(j)));
end
figure
plot(tetta, gamma0, '-r', 'LineWidth', 3)
xlabel('Угол отсечки, град.')
ylabel('Коэффиценты разложения в ряд Фурье')
hold on
grid on
set(gca, 'XTick',0:45:180)
set(gca, 'YTick',0:0.1:5)
plot(tetta, gamma1, '-b', 'LineWidth', 3)
plot(tetta, gamma2, '-g', 'LineWidth', 3)

figure
plot(tetta, alpha0, '-r', 'LineWidth', 3)
xlabel('Угол отсечки, град.')
ylabel('Коэффиценты Берга')
hold on
grid on
set(gca, 'XTick',0:45:180)
set(gca, 'YTick',0:0.1:5)
plot(tetta, alpha1, '-b', 'LineWidth', 3)
plot(tetta, alpha2, '-g', 'LineWidth', 3)