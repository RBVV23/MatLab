clc
clear all
close all

M=[1 0.5 0.25];
X=1:100;
Y1=M(1)*sqrt(X);
Y2=M(2)*sqrt(X);
Y3=M(3)*sqrt(X);

plot(X, Y1)
hold on
grid on
plot(X, Y2)
for i=1:3
legend([ 'M = ', num2str(M(i)) ])
end
%  legend([ 'Kn = ', num2str(Kn(k)) ])
