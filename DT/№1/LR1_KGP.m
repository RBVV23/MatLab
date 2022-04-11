clc
clear all
close all

f0=1200 % Гц
T=12E-3 % с
A=0.001 % В


N=1000;
K=1000;

realQd=zeros(1,N/50);

t=linspace(0,T,N);
u=A*cos(2*pi*f0*t);

E=sum(u.^2);


alpha1=0.2 
alpha2=0.01

d=linspace(0, 7, N/50);

alpha=alpha2;
for i=1:N/50
    sigma(i)=sqrt(E/(d(i)^2));
    Disp(i)=sigma(i)^2;
    Variance=Disp(i);
    gamma(i)=sqrt(E*sigma(i)^2)*ERFCINV(alpha);
    Qd(i)=ERFC(ERFCINV(alpha) - d(i));
    
    for j=1:K
       noise=sigma(i)*randn(1,N);
       noise=noise-mean(noise);
       T=sum( (noise+u).*u );
           if ( T>gamma(i) )
               realQd(i)=realQd(i)+1/K;
           end
    end
 
    
end

plot(d, Qd, '-r', 'LineWidth', 3)
grid on
hold on

legend('\alpha = 0.2')
xlabel('d')
ylabel('Qd')



%% alpha=alpha2
% DESCRIPTIVE TEXT

alpha=alpha1;
for i=1:N/50

sigma(i)=sqrt(E/(d(i)^2));

Disp(i)=sigma(i)^2;
Variance=Disp(i);
    
gamma(i)=sqrt(sigma(i)^2*E)*ERFCINV(alpha);
Qd(i)=ERFC(ERFCINV(alpha)-d(i));
end

plot(d,Qd, '-b', 'LineWidth', 3)
plot(d, realQd, 'xg', 'LineWidth', 3)
legend('\alpha = 0.01','\alpha = 0.2', '\alpha = 0.01 - experiment','Location','southeast')
axis([0 max(d) 0 1.05])


%% Отстойничек
% DESCRIPTIVE TEXT

% a=zeros(1,N);
% a=rand(1,N);
% 
% asr=mean(a);
% -sqrt(u)*((norminv(a,0,1))')
% alpha=exp(-[gamma1*gamma1]/[N*sigma*sigma*asr*asr]);
% arg=sqrt(-2*log(alpha));
% b=sqrt( [N*asr*asr]/[2*sigma*sigma] )
% 
% Qd=marcumq(b,arg);


% 
% Qd(i)=erfc(erfcinv(alpha)-d(i));