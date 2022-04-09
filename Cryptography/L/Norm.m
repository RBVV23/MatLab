function [ y ] = Norm( x, m )
    
    n = length(x);
    d = n/m;
    y = 0;
    for i = 1:d
        if sum(x((i-1)*m+1:i*m)) ~= 0
            y = y +1;
        end
    end

end

