function [ strings columns ] = myMATR_TRACKER( massive )
 


H=size(massive,1);
W=size(massive,2);


for y=1:H
    strings(y)=myVECTOR_DIFF(massive(y,:));
end
for x=1:W
    columns(x)=myVECTOR_DIFF(massive(:,x));
end

strings=strings';

end

