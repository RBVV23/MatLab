%Вторая производная sinc(x)
function y = VTPR( x )
if (x == 0)
    y=0;
else 
    y1=-(1/x)*sin(x);
    y2=-(2/(x*x))*cos(x);
    y3=(2/(x*x*x))*sin(x);
    y=y1+y2+y3;
end

