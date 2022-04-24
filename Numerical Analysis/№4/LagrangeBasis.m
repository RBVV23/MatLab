function [ y ] = LagrangeBasis( x,n )

global X N
proizved=1;

for k=1:N
    if (k ~= n)
proizved=proizved*[( x-X(k) )/( X(n) - X(k) )];
    else
proizved=proizved;
% fprintf('k=')
% fprintf('%d',k)
% fprintf(' n=')
% fprintf('%d',n)
% fprintf('\n')
    end
end



y=proizved;
end

