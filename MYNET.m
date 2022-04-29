function [ O1output ] = MYNET( I1, I2, W )

w1=W(1);
w2=W(2);
w3=W(3);
w4=W(4);
w5=W(5);
w6=W(6);

H1input=I1*w1 + I2*w3;
H2input=I1*w2 + I2*w4;

H1output=logsig(H1input);
H2output=logsig(H2input);

O1input=H1output*w5 + H2output*w6;
O1output=(logsig(O1input));

end

