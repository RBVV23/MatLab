clear
clc
 
Im = imread('images\map1.bmp');
subplot(2,2,1)
imshow(Im)
Gr = fliplr(rgb2gray(Im)); % ����������� � ������� ������
Gr = imadjust(Gr); % ����������� �������
subplot(2,2,4)
DGr = double(Gr); % ��������� � �������� ������
DGr = DGr/max(DGr(:)); % ���������
surf(DGr)
axis([0 size(Gr,2) 0 size(Gr,1)])
shading interp
view(180,90) 
 
[m n] = size(DGr);
% ����������
S = smooth(DGr(:));
Sm = reshape(S,m,n);
figure
surf(Sm,'facealpha',0.8)
axis([0 size(Gr,2) 0 size(Gr,1)])
shading interp
view(180,80) 
%light('Position',[0,0,600])
 
% �������� �����
hmin = -800;
hmax = 2800;
% ��������� �������������� �������
k = 1;
Z = zeros(m*n,3);
for i = 1:m
    for j = 1:n
        Z(k,:) = [i, j, hmin + (hmax-hmin)*DGr(i,j)];
        k = k+1;
    end
end