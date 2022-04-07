clc
clear all
close all


picture=imread('images\map2.bmp', 'bmp');
picture=rgb2gray(picture);
newpicture=picture;
vector=zeros(1,size(newpicture,2)*size(newpicture,1));
Nstr=size(newpicture,1);
Nstl=size(newpicture,2)
for i=1:Nstr
   vector( ((i-1)*Nstl+1) : i*Nstl )=newpicture(i,:);
end
% vector=vector/max(vector);
D=max(vector);
rng(0);
K=5;
for j=1:K
    
    A=rand*20;
    phi=rand*2*pi;
    w=rand*D*2*pi;

    for i=1:size(vector,2)
       vector(1,i)=vector(1,i)+A*sin(w*i+phi);
    end
end

for i=1:Nstr
   newpicture(i,:)=vector( ((i-1)*Nstl+1) : i*Nstl );
end

S=abs(fftshift(fft2(picture)));
newS=abs(fftshift(fft2(newpicture)));

figure
imshow(picture)
figure
imshow(newpicture)
newpicture=single(newpicture);
% figure
% imshow(newpicture)

figure
imshow(log(S), [])

figure
imshow(log(newS), [])

figure
surf(log(S))

figure
surf(log(newS))
% legend('Without noise','With noise')

% Face=myIPF('images\face1.bmp', 'bmp', '"Face"');
% Painting=myIPF('images\painting2.bmp', 'bmp', '"Painting"');









%% old
% NOISElvl=linspace(5,75,3);
% 
% figure
% for i=1:size(NOISElvl,2)
%     lvl=NOISElvl(i);
%     MapSP=mySPNOISE( Map, lvl, '"Map"' );
%     Spectre=fft(MapSP);
%     subplot(size(NOISElvl,2),1,i) 
%     semilogy(abs(Spectre), '-r')
%     grid on
%     hold on
% %     title(['Type of image: ', imagetype, ' (with noise)'])
%     legend(['Noise = ', num2str(lvl) ,'%'],3)
% end
% title(['Type of image: ', 'Map', ' (with noise)'])
% 
% hold on