clc
clear variabes
close all
N = 3;
g = [ 0,1,2,7,5,4,6,3];

M = zeros(2^N,2^N);

for alpha = 0:7
    for x = 0:7
        betta = xor_f(g(xor_f(x,alpha)+1),g(x+1));
        M(alpha+1,betta+1) = M(alpha+1,betta+1) + 1;
    end
end
 M1 = M(2:8,2:8);
 Pd = max(max(M1))/2^N;
 fprintf('1.Разностная характеристика - %i\n',Pd);

vx = [0, 0, 0;
    0, 0, 1;
    0, 1, 0;
    0, 1, 1;
    1, 0, 0;
    1, 0, 1;
    1, 1, 0;
    1, 1, 1;];

vf = zeros(2^N,7);

vf(:,1:3) = [0, 0, 0;
            0, 0, 1;
            0, 1, 0;
            1, 1, 1;
            1, 0, 1;
            1, 0, 0;
            1, 1, 0;
            0, 1, 1;];
ind = 0;
for i = 1:8
    ind = 0;
%     Попарные
    for i_m = 1:3    
       for j_m = i_m+1:3
           vf(i,4+ind) = xor(vf(i,i_m),vf(i,j_m));
           ind = ind + 1;
       end 
    end
%     Тройка
    vf(i,7) = xor(xor(vf(i,1),vf(i,2)),vf(i,3));
end
vf

wf = zeros(2^N,7);
nl = zeros(1,7);
bpf = zeros(2^N,7);
for i = 1:7
    wf(:,i) = YA(vf(:,i));
    nl(i) = 2^(3-1)-max(abs(wf(2:2^N,i)));
    bpf(:,i) = BPF(vf(:,i));
end
wf
nl
bpf
