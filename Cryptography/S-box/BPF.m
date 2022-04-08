function [ w ] = BPF( f )
    N = length(f);
    if N == 1
        w = f;
    else
        A = f(1:N/2);
        B = f(N/2+1:N);
        C = zeros(N/2,1);
        for i = 1:N/2
           C(i) = xor(A(i),B(i)); 
        end
        w = [BPF(A);BPF(C)];
    end
    
end
