function [ array1Dnorm ] = myIPF( filename, filetype, imagetype )

[array3D_unit8, palette]=imread(filename, filetype);
array3D=double(array3D_unit8);

figure
subplot(2,2,1)
image(array3D_unit8)
legend('unit8')
subplot(2,2,2)
image(array3D)

W=size(array3D,2);
H=size(array3D,1);


array2D=zeros(H,W);

for x=1:W
   for y=1:H
       array2D(y,x)=[ array3D(y,x,1) + array3D(y,x,2) + array3D(y,x,3) ]/3;
   end
end

bim=uint8(array2D);
array2Dnorm=array2D/255;




subplot(2,2,3)
image(array2D)
colormap(gray(256))

array2Dsp=imnoise(array2D,'salt & pepper',0.05);

subplot(2,2,4)
image( array2Dsp );
colormap(gray(256));

L=H*W;
array1D=zeros(1, L);
   for y=1:H
       array1D( (1+W*(y-1)) : (W*y) )=array2D(y,:);
       array1Dnorm( (1+W*(y-1)) : (W*y) )=array2Dnorm(y,:);
   end

Spectre=fft(array1D);
Spectre_norm=fft(array1Dnorm);

figure
subplot(2,1,1)
semilogy(abs(Spectre), '-r')
grid on
hold on
title(['Type of image: ', imagetype])
subplot(2,1,2)
semilogy(abs(Spectre_norm), '-b')
grid on
hold on
title(['Type of image: ', imagetype])

end

