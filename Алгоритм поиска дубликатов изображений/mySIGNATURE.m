function [ out_vect out_matr ] = mySIGNATURE( massive )

H=size(massive,1);
W=size(massive,2);
mass_bright=zeros(3*H,3*W);
concat=zeros(8,H*W);

j=1;
for y=2:3:3*H
        i=1;
    for x=2:3:3*W
        mass_bright(y,x)=massive(j,i);
        i=i+1;
    end
    j=j+1;
end

j=1; k=1;
for y=2:3:3*H
    for x=2:3:3*W
        if (y<3*H-3)
        mass_bright(y+1,x)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y+3,x));
        end
        if (y<3*H-3)&(x<3*W-3)
        mass_bright(y+1,x+1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y+3,x+3));
        end
        if (x<3*W-3)
        mass_bright(y,x+1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y,x+3));
        end
        if (y>3)&(x<3*W-3)
        mass_bright(y-1,x+1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y-3,x+3));
        end
        if (y>3)
        mass_bright(y-1,x)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y-3,x));
        end
        if (y>3)&(x>3)
        mass_bright(y-1,x-1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y-3,x-3));
        end
        if (x>3)
        mass_bright(y,x-1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y,x-3));
        end
        if (y<3*H-3)&(x>3)
        mass_bright(y+1,x-1)=myDIFFERENCE_GRAD(mass_bright(y,x)-mass_bright(y+3,x-3));
        end
    end
end

out_matr=mass_bright;

k=1;
for y=2:3:3*H
    for x=2:3:3*W
        concat(1,k)=mass_bright(y-1,x-1);
        concat(2,k)=mass_bright(y-1,x);
        concat(3,k)=mass_bright(y-1,x+1);
        concat(4,k)=mass_bright(y,x-1);
        concat(5,k)=mass_bright(y,x+1);
        concat(6,k)=mass_bright(y+1,x-1);
        concat(7,k)=mass_bright(y+1,x);
        concat(8,k)=mass_bright(y+1,x+1);
        k=k+1;
    end
end

out_vect = [];
for n=1:k-1
    out_vect=[out_vect concat(:,n)'];
end

end