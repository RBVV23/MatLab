clc
clear all
close all


In=[2.8215 1.9992 1.6852 1.5595 1.4513 1.2014 1.0085];
Un=[56.430 58.277 58.980 59.262 59.503 60.068 60.511];
Rn=[20 29.15 35 38 41 50 60];
InRn=In.*Rn

%In=sort(In);
%Un=sort(Un);

% InRn(4)-In(4)*Rn(4)

figure
plot(In, Un, '-r', 'LineWidth', 1)
hold on
grid on
plot(In, InRn, '--b', 'LineWidth', 1)
title('Нагрузочная характеристика')
ylabel('В')
xlabel('мА')
legend('Внешняя характеристика', 'In*Rn', 2)