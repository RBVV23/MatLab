clc
clear variables
close all

L = [0,1,1,0,1,0;
     0,1,1,1,0,0;
     1,0,0,1,1,0;
     0,0,0,1,1,1;
     1,1,0,0,0,1;
     1,0,1,0,0,1];
 m = 2;
 n = size(L,1);
 v = [0,0,0,0,0,1];
 r2 = 2*n+1;
 r = 0;
 L = L';
 q = 0;
 for i = 1:2^n-1
     vL = zeros(1,n);
     for i_m = 1:n
         for j_m = 1:n
            vL(i_m) = vL(i_m) + v(j_m)*L(j_m,i_m);
         end
     end
     vL = mod(vL,2);
     r = Norm(v,m) + Norm(vL,m);
     if r2 > r
         r2 = r;
         vmin = v;
         q = 0;
     end
     if r2 == r
         v
         q = q + 1;
     end
     v = Inc(v);
 end
 r2
 q