clc
clear all
close all

f0=1200 % Ãö
T=12E-3 % ñ
A=0.001 % Â
Wc=2*pi*f0;

N=1000;
K=1000;

a=zeros(1,N);
w=zeros(1,N);
realQd=zeros(1,20);
gamma1kvadr=zeros(1,20);
gamma1kvadr2=zeros(1,20);


t=0:T:(N*T);

alpha=0.01;
alpha2=0.2;
d=linspace(0, 7, 20);
phi=rand*2*pi;

for n=1:N
    a(n)=A;
    s(n)=a(n)*sin( [n-1]*Wc*T + phi );
end

E=sum(s.^2);


for i=1:20
sigma(i)=sqrt(E/(d(i)^2));

b=sqrt( [N*mean(a)^2]/ [2*sigma(i)^2] );
Qd(i)=marcumq(b,sqrt(-2*log(alpha)));
Qd2(i)=marcumq(b,sqrt(-2*log(alpha2)));

gamma1kvadr(i)=-log(alpha)*N*sigma(i)^2*mean(a)^2;
gamma1kvadr2(i)=-log(alpha2)*N*sigma(i)^2*mean(a)^2;

    for k=1:K
        w=sigma(i)*randn(1,N);

    for n=1:N
        x(n)=s(n)+w(n);
        Xci(n)=a(n)*x(n)*cos( Wc*T*[n-1] );
        Xsi(n)=a(n)*x(n)*sin( Wc*T*[n-1] );
    end

    Xc=sum(Xci);
    Xs=sum(Xsi);
    G=Xc*sin(phi) + Xs*cos(phi);
    R=sqrt(Xc^2 + Xs^2);


    if ( R^2 > gamma1kvadr(i) )
        realQd(i)=realQd(i)+1/K;
    end


    end

end

plot(d,Qd, '-r', 'LineWidth', 3)
grid on
hold on
plot(d,Qd2, '-b', 'LineWidth', 3)
plot(d, realQd, 'xg', 'LineWidth', 3)
legend('\alpha = 0.01','\alpha = 0.2', '\alpha = 0.01 - experiment','Location','southeast')
axis([0 max(d) 0 1.05])