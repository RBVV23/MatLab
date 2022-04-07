clc
clear all
close all
rng(0)
picture=imread('images\nature1.bmp', 'bmp');
% picture=imread('images\face1.bmp', 'bmp');
% picture=imread('images\fortest.bmp', 'bmp');
newpicture=single(rgb2gray(picture));

H=size(newpicture,1);
W=size(newpicture,2);

K=8;
pict_vect=matrix2vector(newpicture);
[pict_vect noise_vect]=myGARM_NOISE(pict_vect,K);
noisepicture=vector2matrix(pict_vect, picture);
noise_matr=vector2matrix(noise_vect, picture);


A=[5 10 15 25 45];
A=45;
K=[0.05 0.1 0.15 0.25 0.4];
K=0.15;
for i=1:max(numel(A),numel(K))
    k=K
    a=A
S_pict=fft2(newpicture);
S_noise=fft2(noise_matr);
S_npict=fft2(noisepicture);
% Re=ifft2(S_npict);

S_npict=fftshift(S_npict);

S_filt=medfilt2(abs(S_npict), [a a]);
% S_filt=myMED(abs(S_npict), a, 'cycle');

% S_npict_filt=S_filt.*[ S_npict./abs(S_npict)];
S_npict_filt=[S_filt./abs(S_npict)].*S_npict;
% S_npict_filt=fftshift(S_npict_filt);
% S_npict=fftshift(S_npict);


S_npict_filt=myRE_CENTER(S_npict_filt, S_npict, k);


figure('name', ['window=' num2str(a) ' zone=' num2str(k)])
subplot(2, 2, 1)
imshow(log(abs(S_npict)), []);
colormap gray(256)
subplot(2, 2, 2)
imshow(log(abs(S_npict_filt)), []);
colormap gray(256)


S_npict_filt=fftshift(S_npict_filt);
S_npict=fftshift(S_npict);

% Re_noise=real(ifft2(S_noise_filt));
% Re_noise=Re_noise + abs(min(min(Re_noise)));
% partition=linspace(min(min(Re_noise)), max(max(Re_noise)), 255);
% index=quantiz(matrix2vector(Re_noise),partition);
% Re_noise=vector2matrix(index,Re_noise);
Re_npict=real(ifft2(S_npict_filt));

Re_npict=Re_npict + abs(min(min(Re_npict)));
partition=linspace(min(min(Re_npict)), max(max(Re_npict)), 255);
index=quantiz(matrix2vector(Re_npict),partition);
Re_npict=vector2matrix(index,Re_npict);
Re_pict=(ifft2(S_pict));





% figure('name', 'Pre-processing')
% subplot(2, 2, 1)
% image(picture)
% colormap gray(256)
% subplot(2, 2, 2)
% image(newpicture)
% colormap gray(256)
% subplot(2, 2, 3)
% image(noisepicture)
% colormap gray(256)
% subplot(2, 2, 4)
% image(noise_matr)
% colormap gray(256)


% figure('name', 'Post-processing')
% subplot(2, 2, 1)
% image(picture)
% colormap gray(256)
% subplot(2, 2, 2)
% image(Re_pict)
% colormap gray(256)
% subplot(2, 2, 3)
% image(Re_npict)
% colormap gray(256)
% subplot(2, 2, 4)
% image(Re_noise)
% colormap gray(256)


subplot(2, 2, 3)
image(noisepicture)
colormap gray(256)
subplot(2, 2, 4)
image(Re_npict)
colormap gray(256)




end