clc
clear all
close all


T=10E-3 % ñ
A=0.5E-3 % Â


N=1000;
K=1000;


t=linspace(0,T,N);
realP1=zeros(1,20);
realP2=zeros(1,20);
w=zeros(1,N);

M8=hadamard(8);
Wal1=M8(5,:);
Wal7=M8(2,:);

i=1;
for k=1 : 8
    for j=1:N/8
        s0(i+j-1)=A*Wal1(k);
        s1(i+j-1)=A*Wal7(k);
        s2(i+j-1)=-A*Wal1(k);
    end
    i=i+N/8;
end

krf1=0;
krf2=-1;
E0=sum(s0.^2);
E1=sum(s1.^2);
E2=sum(s2.^2);
Esr1=(E0+E1)/2;
Esr2=(E0+E2)/2;
%Esr=Esr1=Esr2
Esr=(Esr1+Esr2)/2


d=linspace(1E-6, 7, N/50);


for i=1:N/50
    sigma(i)=sqrt(Esr/(d(i)^2));
    P1(i)=ERFC( sqrt( [Esr*(1-krf1)] / [2*sigma(i)^2] ) );
    P2(i)=ERFC( sqrt( [Esr*(1-krf2)] / [2*sigma(i)^2] ) );
    for j=1:K
       w=sigma(i)*randn(1,N);
       w=w-mean(w);
       x=s0+w;
       T1=sum(x.*(s1-s0)) - (E1-E0)/2;
       T2=sum(x.*(s2-s0)) - (E1-E0)/2;
           if ( T1>0 )
               realP1(i)=realP1(i)+1/K;
           end
          
           if ( T2>0 )
               realP2(i)=realP2(i)+1/K;
           end
           
    end
    
end

figure
plot(s0, '-r', 'LineWidth', 3)
grid on
legend('Signal s0 - Wal(1)')

figure
plot(s1, '-b', 'LineWidth', 3)
grid on
legend('Signal s1 - Wal(7)')

figure
plot(s2, '-m', 'LineWidth', 3)
grid on
legend('Signal s2 - -Wal(1)')


figure
plot(d, P1, '-g', 'LineWidth', 1.5)
grid on
hold on
plot(d, realP1, '*g', 'LineWidth', 1)
xlabel('d')
ylabel('Po')
legend('Theoretical', 'Experimental')
title('Orthogonal signals - s0; s1')


figure
plot(d, P2, '-g', 'LineWidth', 1.5)
grid on
hold on
plot(d, realP2, '*g', 'LineWidth', 1)
xlabel('d')
ylabel('Po')
legend('Theoretical', 'Experimental')
title('Opposite signals - s0; s2')

figure
plot(d, P1, '-r', 'LineWidth', 3)
grid on
hold on
plot(d, P2, '--b', 'LineWidth', 3)
xlabel('d')
ylabel('Po')
legend('Orthogonal', 'Opposite')
title('Comparison')

