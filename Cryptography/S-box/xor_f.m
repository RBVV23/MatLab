function [ c ] = xor_f( a,b )

    v = [0, 0, 0;
         0, 0, 1;
         0, 1, 0;
         0, 1, 1;
         1, 0, 0;
         1, 0, 1;
         1, 1, 0;
         1, 1, 1;];
     
    vc = zeros(1,3);
    vc(1) = xor(v(a+1,1),v(b+1,1)); 
    vc(2) = xor(v(a+1,2),v(b+1,2));
    vc(3) = xor(v(a+1,3),v(b+1,3));
    
    c = 1;
    while (v(c,1)~=vc(1)) || (v(c,2)~=vc(2)) || (v(c,3)~=vc(3))
        c = c+1;
    end
    c = c - 1;
end

