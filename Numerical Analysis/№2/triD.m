clc
clear all

Amax=10;
n=3;
alpha= [pi/6 pi/4 pi/3];

Wx = [
    1 0 0;
    0 cos(alpha(1)) -sin(alpha(1));
    0 sin(alpha(1)) cos(alpha(1))
     ];
Wy = [
    cos(alpha(2)) 0 sin(alpha(2));
    0 1 0;
    -sin(alpha(2)) 0 cos(alpha(2))
     ];
 Wz = [
    cos(alpha(3)) -sin(alpha(3)) 0;
    sin(alpha(3)) cos(alpha(3)) 0;
     0 0 1
      ];

W=Wx*Wy*Wz;
%Wobr = inv(W)
normirovka=norm(W(:,1))*norm(W(:,1));
A=ceil(Amax - 2*Amax*rand(n));
Lvector=A(1,:)
L=diag(Lvector)
X=W*L*W'
Lvector
eig(X)'


%X=X/normirovka