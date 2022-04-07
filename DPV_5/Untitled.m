clc
clear all
close all

A=ones(5,5);
A(2,2)=A(2,2)*5;
B=ones(5,5)*i;
B(4,4)=B(4,4)*5;

A=medfilt2(A,[3 3])

B=medfilt2(imag(B),[3 3])*i

