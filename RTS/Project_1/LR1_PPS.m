clc
clear all
close all


f1=[455	465	476];
f2=[452	461	471];
f3=[454	461	470];
A=[0.7 1 0.7];

plot(f1, A, '-r', 'LineWidth', 2)
hold on
grid on
plot(f2, A, ':b', 'LineWidth', 2)
plot(f3, A, '--g', 'LineWidth', 2)
legend('Detector off', 'Rn = 6,8 kÎm','Rn = 22 kOm')
