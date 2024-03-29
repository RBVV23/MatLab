clc

clear all
close all



%���������� ��������
fprintf('���������� ��������: ')
N=20

%���������� ��������� �� ���� ������
fprintf('���������� ��������� �� ���� ������: ')
Niter=100

%���������� �������������� ��������
fprintf('���������� �������������� ��������: ')
Nperiod=3

%���������� �������
fprintf('���������� �������: ')
tau=4/3

%������� �������
fprintf('������� ������� (��): ')
f=3E3


E=1;
w=2*pi*f;
T=1/f;
dt=T/Niter;

s(1)=0;



for i=1:(Niter*Nperiod)
t(i)=(i-1)*dt;     

   for n=1:N
      A(n)=E*SINC(n*pi/tau);%*exp(-j*w*T/2);
      a(n)=abs(A(n));
      O(n)=angle(A(n));
      s(n+1)=s(n)+a(n)*cos( n*w*t(i) + O(n) );
      ans=s(n+1);
   end
   Ao=SINC((0)*pi/tau);
   s0=abs(Ao)*cos(0*w*t(i) + angle(Ao));
   S(i)=ans+s0/2;
   s(1)=0;
end

%Emax=E*SINC(1*pi/4);

figure
plot(t/T, S/E, '-r', 'LineWidth', 2)
grid on
hold on
title('������ s(t)')
xlabel('����� � ��������, T')
ylabel('������������� ����� s(t)/E')
%axis([0 Nperiod*T -0.125*Emax 1.125*Emax])
legend(['���������� ���������� (%) - ' num2str(100/tau)])



figure
plot(a, '*r', 'LineWidth', 2)
grid on
hold on
title('����������� ������')
xlabel('����� ���������, n')
ylabel('���������, ')
%axis([0 N -0.125 2])


figure
plot(O/pi, '*r', 'LineWidth', 2)
grid on
hold on
title('������� ������')
xlabel('����� ���������, n')
ylabel('��������� ����, \pi')
%axis([0 N -0.125 2])

