clc
clear all
close all

picture=imread('images\face1.bmp', 'bmp');
newpicture=single(rgb2gray(picture));

k=1;
h(k)=figure('name', 'Original (color)');
image(picture);


newpicture=single(rgb2gray(picture));
k=k+1;
h(k)=figure('name', 'Original (black&white)');
image(newpicture)
colormap gray(256)

A=[3 5 9]
D=[5 10 20 50 90]

for i=1:numel(D)

    picture_sp=mySPNOISE(newpicture, D(i));
        figure('name', [num2str(D(i)), '% defective pixels'] )
%     subplot(2,2,1)
    image(picture_sp)

    for j=1:numel(A)
        window=[A(j) A(j)];
        picture_filt=medfilt2(picture_sp, window);
%         subplot(2,2, j+1)
        colormap gray(256)
%         image(picture_filt)
    end

end
