clc
clear all
close all
rng(0);


prefix='images\';
class='face';
number=1;
filename=strcat(prefix,class,num2str(number),'.bmp');


picture=imread(filename, 'bmp');

k=1;
h(k)=figure('name', 'Original (color)');
image(picture);


newpicture=single(rgb2gray(picture));
k=k+1;
h(k)=figure('name', 'Original (black&white)');
image(newpicture)
colormap gray(256)

pict_vect=matrix2vector(newpicture);
K=8;
[pict_vect noise_vect]=myGARM_NOISE(pict_vect,K);
noisepicture=vector2matrix(pict_vect, picture);
noise_matr=vector2matrix(noise_vect, picture);


k=k+1;
h(k)=figure('name', 'Picture with noise');
image(noisepicture)
colormap gray(256)

k=k+1;
h(k)=figure('name', 'Only noise (image))');
image(noise_matr)
colormap gray(256)

S_pict=fft2(newpicture);
S_noise=fft2(noise_matr);
S_npict=fft2(noisepicture);

window=10;
S_npict_mod=abs(S_npict);
S_noise_mod=abs(S_noise);
S_filt=medfilt2(S_npict_mod,[window window]);
S_filt_noise=medfilt2(S_noise_mod,[window window]);
S_filt=(S_npict./S_npict_mod).*S_filt;
S_filt_noise=(S_noise./S_noise_mod).*S_filt_noise;

H=size(S_filt,1);
W=size(S_filt,2);
counter=0;

% for y=1:H
%    for x=1:W
%       if (S_filt(y,x)<3*S_npict(y,x))
%          S_filt(y,x)=0;
%          counter=counter+1;
%       end
%       if (S_filt_noise(y,x)<3*S_noise(y,x))
%          S_filt_noise(y,x)=0;
%       end
%    end
% end



Re_pict=ifft2(S_pict);
Re_npict=(ifft2((S_filt)));
Re_noise=(ifft2((S_filt_noise)));

k=k+1;
h(k)=figure('name', 'Without noise');
surf((abs((S_pict))))

k=k+1;
h(k)=figure('name', 'Only noise (spectrum)');
surf((abs((S_noise))))

k=k+1;
h(k)=figure('name', 'With noise');
surf((abs((S_npict))))

k=k+1;
h(k)=figure('name', 'Filtered picture with noise');
surf((abs(S_filt)))

k=k+1;
h(k)=figure('name', 'Filtered noise');
surf((abs(S_filt_noise)))


k=k+1;
h(k)=figure('name', 'Recovered original picture');
image(Re_pict)
colormap gray(256)

k=k+1;
h(k)=figure('name', 'Recovered noised picture');
image(real(Re_npict))
colormap gray(256)

k=k+1;
h(k)=figure('name', 'Recovered noise');
image(real(Re_noise))
colormap gray(256)