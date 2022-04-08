function [ w ] = YA( f )
    N = length(f);
    if N == 1
        w = f;
    else
        A = f(1:N/2);
        B = f(N/2+1:N);
        w = [YA(A+B);YA(A-B)];
    end
    
end

