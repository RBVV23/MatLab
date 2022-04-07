function [ out ] = myMED( matrix, window, Type )

height=size(matrix,1);
width=size(matrix,2);

if (nargin==0)
    error('Not enough input arguments') 
end
if (nargin<3)
    window=3;  
end
if (nargin<2)
    Type='cycle';  
end

newmatrix=matrix;
switch Type
    case 'cycle'
        Type
        matrix=[matrix matrix matrix; matrix matrix matrix; matrix matrix matrix;];
    case 'zeros'
        Type
        matr_board=zeros(height, width);
        matrix=[matr_board matr_board matr_board; matr_board matrix matr_board; matr_board matr_board matr_board;];
    case 'ones'
        Type
        matr_board=ones(height, width);
        matrix=[matr_board matr_board matr_board; matr_board matrix matr_board; matr_board matr_board matr_board;];
    case 'mirrow'
        Type
end

window=ceil((window-1)/2)*2 + 1;
a=(window-1)/2;
j=1;
for y=(height+1):(2*height)
    i=1;
    for x=(width+1):(2*width)
        newmatrix(j,i)=median( matrix2vector(matrix(y-a:y+a,x-a:x+a)) );
        i=i+1;
    end
    j=j+1;
end
out=newmatrix;
end

