clc
clear all
close all

DATA = [1 2 3 4 4 4 5 5 5 5 12 5 5 5 8 8 10 9];

%DATA=randn(1,100);

DATA=sort(DATA);

acr=2;


sizeD=size(DATA, 2);
klv=zeros(1, sizeD);

max=max(DATA);
min=min(DATA);

delta=Width(DATA, acr);


X=linspace(min-delta,max+delta,sizeD*10^acr);
dX=X(2)-X(1);
Nx=round(delta/dX);
Parzen=zeros(sizeD*10^acr);

k=1;
for i=1:size(X,2)
    if round(X(i), 3)==round(DATA(k), 3)
        Parzen(i)=1;
        k=k+1
    end
end


% for i=1:size(X,2)
%     if round(X(i), acr)==DATA(k)
%         for j=(1+i-Nx):(i+Nx-1)
%             Parzen(j)=(2*pi)^(-0.5)/delta * exp( -0.5*(X(j)-X(i)/delta)^2 );
%         end
%         k=k+1
%     end
% end

plot(X, Parzen, '-r', 'LineWidth', 3)
grid on
hold on
plot(DATA*0, '*g', 'LineWidth', 3)

