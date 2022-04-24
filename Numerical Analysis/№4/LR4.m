clc
clear all
close all



Sum=0;
xmax=10;
xmin=-10;
dx=0.01;
Nmax=(xmax-xmin)/dx + 1;

global X N


%������ � ���������� ������� �������
for i= 1: Nmax
   x(i)= xmin + dx*(i-1);
   Ftz(i)=Fx(x(i));
end

figure
title('������ ������')
plot(x, Ftz, '-r', 'LineWidth', 3)
hold on
grid on



N=10;
dX=(xmax-xmin)/(N-1);

%������ ���������� �����
for i= 1: N
   X(i)= xmin + dX*(i-1);
   Y(i)=Fx(X(i));
end

plot(X, Y, '*r', 'LineWidth', 3)
hold on
grid on

figure
title('������� �����')
plot(X, Y, '*r', 'LineWidth', 3)
hold on
grid on


for i= 1: Nmax
    for n=1:N
        l=LagrangeBasis(x(i),n);
        Sum=Sum + Y(n)*l;
    end
L(i)=Sum;
Sum=0;  
end


title('���������������� ���������')
plot(x, L, '-b', 'LineWidth', 3)



