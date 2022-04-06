function [ X GST ] = Myhist( MASSIVE, STEP )

stb=(min(MASSIVE):STEP:max(MASSIVE));
GST=zeros(1, size(stb, 2)-1);
X=(min(MASSIVE)+STEP/2 : STEP : max(MASSIVE)-STEP/2);

for i=1:(size(stb, 2)-1)
    for j=1:size(MASSIVE, 2) 
        if ( ( stb(i) <= MASSIVE(j) ) & ( MASSIVE(j) <= stb(i+1) ) )    
            GST(i)=GST(i)+1;
        end
    end
end
end

