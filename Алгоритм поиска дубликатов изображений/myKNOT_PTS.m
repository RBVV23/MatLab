function [ knot_matr x_pts y_pts] = myKNOT_PTS( massive, param, vert_lines, horiz_lines )

if (nargin<2)
    param=20;  
end
if (nargin<3)
    vert_lines=9;  
end
if (nargin<4)
    horiz_lines=vert_lines;  
end

H=size(massive,1);
W=size(massive,2);

dx=floor( (W-vert_lines)/(vert_lines+1) );
x_beg=1+ floor( ( (W-vert_lines) - (vert_lines+1)*dx )/2 ) + dx;
x_end=x_beg+vert_lines+dx*(vert_lines-1);
dy=floor( (H-horiz_lines)/(horiz_lines+1) );
y_beg=1+ floor( ( (H-horiz_lines) - (horiz_lines+1)*dy )/2 ) + dy;
y_end=y_beg+horiz_lines+dy*(horiz_lines-1);

x_pts=[x_beg : dx+1 : x_end];
y_pts=[y_beg : dy+1 : y_end];

knot_matr=zeros(numel(y_pts),numel(x_pts));

aperture=max(2,min(size(massive,1),size(massive,2))/param);

aperture=round(aperture);
aperture=ceil((aperture-1)/2)*2 + 1;
a=(aperture-1)/2;

i=1;
for x=1:size(knot_matr,2)
   j=1;
   for y=1:size(knot_matr,1)
        massive(y_pts(y),x_pts(x))=mean(  mean( massive( y_pts(y)-a:y_pts(y)+a, x_pts(x)-a:x_pts(x)+a ) )  );
        knot_matr(j,i)=massive(y_pts(y),x_pts(x));
        j=j+1;
   end
i=i+1;   
end

end