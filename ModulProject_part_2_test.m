clc
clear all
close all


%% Демонстрационная итерация

I1=1; I2=0;
w1=0.45; w2=0.78; w3=-0.12; w4=0.13; w5=1.5; w6=-2.3;




H1input=I1*w1 + I2*w3;
H2input=I1*w2 + I2*w4;

H1output=logsig(H1input);
H2output=logsig(H2input);

O1input=H1output*w5 + H2output*w6;
O1output=logsig(O1input)

O1target=xor(I1, I2)
Error=mse(O1target, O1output)


%% Один цикл обучения
EPSILON=0.7; %скорость обучения
ALPHA=0.3; %реактивный ранец

deltaO1=(O1target - O1output)*dlogsig(O1input, O1output)

deltaH1=(w5*deltaO1 )*dlogsig(H1input, H1output)
deltaH2=(w6*deltaO1 )*dlogsig(H2input, H2output)


GRADw5=deltaO1*H1output
GRADw6=deltaO1*H2output

GRADw1=deltaH1*I1;
GRADw2=deltaH2*I1;
GRADw3=deltaH1*I2;
GRADw4=deltaH2*I2;


DELTAw5=EPSILON*GRADw5 + ALPHA*0
DELTAw6=EPSILON*GRADw6 + ALPHA*0

DELTAw1=EPSILON*GRADw1 + ALPHA*0;
DELTAw2=EPSILON*GRADw2 + ALPHA*0;
DELTAw3=EPSILON*GRADw3 + ALPHA*0;
DELTAw4=EPSILON*GRADw4 + ALPHA*0;


NEWw5=w5 + DELTAw5
NEWw6=w6 + DELTAw6

NEWw1=w1 + DELTAw1
NEWw2=w2 + DELTAw2
NEWw3=w3 + DELTAw3
NEWw4=w4 + DELTAw4

%% Округленные пошаговые отсчеты
H1input=round(H1input, 2)
H2input=round(H2input, 2)
H1output=round(H1output, 2)
H2output=round(H2output, 2)
O1input=round(O1input, 3)
O1output=round(O1output, 2)
Error=round(Error, 2)

%% Функции активации

X=-10:0.01:10;
Y1=logsig(X); 
dY1=dlogsig(X, Y1);
Y2=purelin(X);
dY2=dpurelin(X, Y2);
Y3=tansig(X);
%dY3=dtansig(X);
Y4=hardlim(X);
%dY4=dhardlim;