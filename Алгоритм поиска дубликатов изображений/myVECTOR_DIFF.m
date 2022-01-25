function [ result ] = myVECTOR_DIFF( vector )

L=numel(vector);
for i=1:(L-1)
    diff_vect(i)=abs( vector(i+1) - vector(i) );
end
result=sum(diff_vect);
end

