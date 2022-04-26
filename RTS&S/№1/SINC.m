function y = SINC( x )

if (x==0)
    y=1;
end
if (x~=0)
    y=sin(x)/x;
end

end

