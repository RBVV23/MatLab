clc
clear all
close all


I1=[0; 0; 1; 1;]; 
I2=[0; 1; 0; 1;];

TARGET=xor(I1, I2);

EPSILON=0.7;
ALPHA=0.3;
ERROR=0.05;
NMAX=100000;

DELTAw1(1)=0;
DELTAw2(1)=0;
DELTAw3(1)=0;
DELTAw4(1)=0;
DELTAw5(1)=0;
DELTAw6(1)=0;

error(1)=1;

w1(1)=0.45;
w2(1)=0.78;
w3(1)=0.12;
w4(1)=0.13;
w5(1)=1.5;
w6(1)=-2.3;



i=1;
while ( (error(i) > ERROR) & (i<NMAX) )

H1in=I1*w1(i) + I2*w3(i);
H2in=I1*w2(i) + I2*w4(i);

H1out=logsig( H1in );
H2out=logsig( H2in );

O1in=H1out*w5(i) + H2out*w6(i);
O1out=logsig( O1in );


error(i+1)=mse(TARGET, O1out );

deltaO1=(TARGET - O1out).*dlogsig(O1in, O1out);

deltaH1=(w5(i)*deltaO1 ).*dlogsig(H1in, H1out);
deltaH2=(w6(i)*deltaO1 ).*dlogsig(H2in, H2out);


GRADw1(i+1)=mean( deltaH1.*I1 );
GRADw2(i+1)=mean( deltaH2.*I1 );
GRADw3(i+1)=mean( deltaH1.*I2 );
GRADw4(i+1)=mean( deltaH2.*I2 );

GRADw5(i+1)=mean( deltaO1.*H1out );
GRADw6(i+1)=mean( deltaO1.*H2out );


DELTAw1(i+1)=EPSILON*GRADw1(i+1) + ALPHA*DELTAw1(i);
DELTAw2(i+1)=EPSILON*GRADw2(i+1) + ALPHA*DELTAw1(i);
DELTAw3(i+1)=EPSILON*GRADw3(i+1) + ALPHA*DELTAw1(i);
DELTAw4(i+1)=EPSILON*GRADw4(i+1) + ALPHA*DELTAw1(i);
DELTAw5(i+1)=EPSILON*GRADw5(i+1) + ALPHA*DELTAw1(i);
DELTAw6(i+1)=EPSILON*GRADw6(i+1) + ALPHA*DELTAw1(i);

w1(i+1)=w1(i) + DELTAw1(i+1);
w2(i+1)=w2(i) + DELTAw2(i+1);
w3(i+1)=w3(i) + DELTAw3(i+1);
w4(i+1)=w4(i) + DELTAw4(i+1);
w5(i+1)=w5(i) + DELTAw5(i+1);
w6(i+1)=w6(i) + DELTAw6(i+1);

i=i+1;

if (mod(i,100)==0)
    i=i
end

end

i=i-1;
fprintf('TRAINING SUCCESSFULLY COMPLETED  \n')




Wvector(1)=w1(i);
Wvector(2)=w2(i);
Wvector(3)=w3(i);
Wvector(4)=w4(i);
Wvector(5)=w5(i);
Wvector(6)=w6(i);
Wvector=Wvector;

RESULT= MYNET(I1, I2, Wvector)';
RESULT=round(MYNET(I1, I2, Wvector),0)'



fprintf('Number of epochs: ')
disp(i)
fprintf('Result error (MSE): ')
disp(error(i))
fprintf('Weights: \n      w1         w2        w3       w4        w5        w6 \n')
disp(Wvector)


