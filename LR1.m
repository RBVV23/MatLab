clc
clear all
close all

In = [3.679848481058293 2.5375559983982314 1.936723538578653 1.5660339278467468 1.3144813802121298 1.1325823177788688 0.9949183859894466 0.8871065969788755 0.8003746374682735];
Uo = [73.59696962116585 76.12667995194704 77.46894154314616 78.30169639233729 78.86888281272772 79.28076224452074 79.59347087915576 79.8395937280988 80.03746374682733];

figure
plot(In, Uo, '-r', 'LineWidth', 3) %������� ��������������
hold on
grid on
xlabel('In, mA')
ylabel('Uo, B')


for i=1:(size(Uo,2)-1)
   dU(i)=Uo(i+1)-Uo(i); 
   dI(i)=In(i+1)-In(i);
   dr(i)=-dU/dI;
   In2(i)=0.5*[ In(i+1)+In(i) ];
end

figure
plot(In2, dr, '-b', 'LineWidth', 3) %�������� �������������
hold on
grid on
xlabel('In, mA')
ylabel('dr, kOm')


maxU = [74.43368927207317 76.97781398081149 78.32539602190977 79.16124941702311 79.7308176149119 80.1427991949968 80.45791528024331 80.70262406852332 80.90162009459215];
minU = [72.84659350980193, 75.36693481135495, 76.70572409410958, 77.53641569736735, 78.10212379586308, 78.5136772670646, 78.82496114373085, 79.07220660850571, 79.26908298729309];

Kp=(maxU-minU)./(2*Uo);

figure
plot(In, Kp*100, '-g', 'LineWidth', 3) %����������� ���������
hold on
grid on
xlabel('In, mA')
ylabel('Kp, %')


P1 = [298.5739 206.57562 158.16293 128.13782 107.87919 93.21065 82.14757 73.48361 66.58753];
Po = [270.84115707422626, 193.1863233150033, 150.0439563388146, 122.62957387032105, 103.6770766292303, 89.79662414167532, 79.19306866834685, 70.82983997981582, 64.06320733017775];
ALPHA = Po./P1;

figure
plot(In, ALPHA, '-m', 'LineWidth', 3) %����������� ������������� ��������������
hold on
grid on
xlabel('In, mA')
ylabel('\alpha')