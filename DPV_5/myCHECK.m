function [ Solution_matrix Target_matrix ] = myCHECK( S_noise, S_npict, S_pict, window )

H=size(S_noise,1);
W=size(S_noise,2);
Target_matrix=zeros(H,W);
Solution_matrix=zeros(H,W);
T=

for x=1:W
    for y=1:H
        
        if abs( myMED(S_npict(x,y))/S_npict(x,y) ) > T
            Solution_matrix(x,y)=1;
        end
        
    end

end

