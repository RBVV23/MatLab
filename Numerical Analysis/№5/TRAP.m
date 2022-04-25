%Метод трапеций
function  y  = TRAP(a, b, h)

Int=0;

for i=1 : (b-a)/h
    ksi=a + (i-1)*h;
    Int=Int+(h/2)*[FUNC(ksi+h) + FUNC(ksi)];
end

y=Int;


end

