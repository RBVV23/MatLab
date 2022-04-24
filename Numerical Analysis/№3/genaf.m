function [A,f]=genaf2(x)
N=max(size(x));
Amax=100;
 A=ceil(Amax/2-Amax*rand(N,N));
  f=A*x';
end

