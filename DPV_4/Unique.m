function [ SUM ] = Unique( MASSIVE, ACCURATE )

SUM=1;
for i=1:(size(MASSIVE,2)-1)
   if round( MASSIVE(i), ACCURATE ) == round( MASSIVE(i+1), ACCURATE )
       i=i+1;
   else
       SUM=SUM+1;
   end
end
end

