function [ y ] = Inc( x )

    n = length(x);
    p = 1;
    y = zeros(1,n);
    for i = 1:n
        y(n-i+1) = x(n-i+1) + p;
        p = 0;
        if y(n-i+1) == 2
            p = 1;
            y(n-i+1) = 0;
        end
    end

end

