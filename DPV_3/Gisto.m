clc
clear all
close all

DATA = [1 2 3 4 4 4 5 5 5 5 12 5 5 5 8 8 10 9];
DATA=randn(1,100);

acr=2;


sizeD=size(DATA, 2);
klv=zeros(1, sizeD);

max=max(DATA);
min=min(DATA);

unq=Unique(DATA, acr);


delta=(max-min)/(unq-1);

[X GST] = Myhist(DATA, delta);

figure
bar(X, GST)
grid on
hold on
%set('XTick', (min+delta/2) : delta : (max-delta/2))
set(gca, 'XTick', round(X,acr))



