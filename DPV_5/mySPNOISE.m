function [ outarray ] = mySPNOISE( inarray, lvl)

N=lvl/100*numel(inarray);
H=size(inarray,1);
W=size(inarray,2);
outarray=inarray;

for i=1:round(N/2)
   x=ceil(W*rand(1,2));
   y=ceil(H*rand(1,2));
   outarray(y(1), x(1))=255;
   outarray(y(2), x(2))=0;
end

end





