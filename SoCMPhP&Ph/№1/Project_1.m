close all;
clc;
clear all;

xmin=0.2;
xmax=1.2;
y(1)=0.25;
x(1)=xmin;



h=0.1;
N=(xmax-xmin)/h;
ye1(1)=y(1);
x1(1)=x(1);
for i= 1: N+1
   x1(i+1)=xmin + i*h;
   ye1(i+1)=ye1(i) + h*func( x1(i),ye1(i) );
  
end 

ye1k=ye1(i+1);


figure('Name','2.2')
plot(x1, ye1, '-r', 'LineWidth', 1)
hold on
grid on

h=0.05;
N=(xmax-xmin)/h;
ye2(1)=y(1);
x2(1)=x(1);
for i= 1: N+1
   x2(i+1)=xmin + i*h;
   ye2(i+1)=ye2(i) + h*func( x2(i),ye2(i) );
end 

ye2k=ye2(i+1);


plot(x2, ye2, '-b', 'LineWidth', 1)
title('Метод Эйлера')
legend('h=0.1', 'h=0.05')

ce=1;
edelta=ce*abs(ye2k-ye1k);

%%%%%%%%%%%%%%%



a1=0;
a2=0.5;
a3=0.5;
a4=1;



h=0.1;
N=(xmax-xmin)/h;
yrk1(1)=y(1);
x3(1)=x(1);
for i= 1: N+1
   x3(i+1)=xmin + i*h;
 
   k1(i)=h*func(x3(i),yrk1(i));
   k2(i)=h*func(x3(i)+ h/2, yrk1(i) + k1(i)/2);
   k3(i)=h*func(x3(i) + h/2, yrk1(i) + k2(i)/2);
   k4(i)=h*func(x3(i) + h, yrk1(i) + k3(i));
   dy(i)=(k1(i) + 2*k2(i) + 2*k3(i) + k4(i))/6;
   yrk1(i+1)= yrk1(i) + dy(i);
end
yrk1k=yrk1(i+1);

figure('Name','2.3')
plot(x3, yrk1, '-r', 'LineWidth', 2)
hold on
grid on


h=0.05;
N=(xmax-xmin)/h;
yrk2(1)=y(1);
x4(1)=x(1);
for i= 1: N+1
   x4(i+1)=xmin + i*h;
 
   k1(i)=h*func(x4(i),yrk2(i));
   k2(i)=h*func(x4(i)+ h/2, yrk2(i) + k1(i)/2);
   k3(i)=h*func(x4(i) + h/2, yrk2(i) + k2(i)/2);
   k4(i)=h*func(x4(i) + h, yrk2(i) + k3(i));
   dy(i)=(k1(i) + 2*k2(i) + 2*k3(i) + k4(i))/6;
   yrk2(i+1)= yrk2(i) + dy(i);
end
yrk2k=yrk2(i+1);

crk=1/15;
rkdelta=crk*abs(yrk1k-yrk2k);

plot(x4, yrk2, '-b', 'LineWidth', 2)
title('Метод Рунге-Кутты')
legend('h=0.1', 'h=0.05')
%legend('Метод Эйлера', 'Точное решение', 'Метод Рунге-Кутты')




figure('Name','2.4')
plot(x2, ye2, '-r', 'LineWidth', 1)
hold on
grid on
plot(x4, yrk2, '-b', 'LineWidth', 2)
title('Сравнение методов (при h=0.05)')
legend('Метод Эйлера', 'Метод Рунге-Кутты')


fprintf('2.5')
edelta=edelta
rkdelta=rkdelta



