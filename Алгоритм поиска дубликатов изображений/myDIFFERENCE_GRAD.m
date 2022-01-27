function [ result ] = myDIFFERENCE_GRAD( difference )

if difference<=-50
        result=-2;
end
if (difference>-50) & (difference<=-3)
        result=-1;
end
if(difference>=-2) & (difference<=2)
        result=0;
end
if (difference>=3) & (difference<50)
        result=1;
end
if difference>=50
        result=2;
end


end

