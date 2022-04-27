function [ y ] = Universignal(w, T1, T2, k, E)

x=T2;
y2=(1/w) * exp(-j*w*x) * [E*j + (k/w)*(j*w*x + 1)];
x=T1;
y1=(1/w) * exp(-j*w*x) * [E*j + (k/w)*(j*w*x + 1)];
y=y2-y1;


end

