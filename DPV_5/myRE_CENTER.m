function [ out_matr ] = myRE_CENTER( massive, original, param )


out_matr=massive;
% massive=zeros(20);
% original=ones(20);
% param=0.1;

[H W]=size(massive);


for x=floor(W/2-param*W):ceil(W/2+param*W)
    for y=floor(H/2-param*H):ceil(H/2+param*H)
       out_matr(y,x)=original(y,x);
    end
end


end

