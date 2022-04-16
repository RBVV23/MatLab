clc
clear all

betta0=0.01;
T0=300;
T=T0;
Ep0=3;
Est=4.7;
k=0.02;
m=2.5;
n=1.4;
p=2.3;
esimax=16;
esimin=0;

betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)

h=0.1;
N=(esimax-esimin)/h
ezi=4
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end

figure
plot(esi, ic, '-y', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
hold on
grid on

ezi=4.5
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end

plot(esi, ic, '-b', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
hold on
grid on

ezi=4.8
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end

plot(esi, ic, '-r', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
hold on
grid on

ezi=5
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end


plot(esi, ic, '-g', 'LineWidth', 1.5)
ylabel('Сила тока стока, мА')
xlabel('Напряжение сток-исток, В')
hold on
grid on
title('Выходные характеристики транзистора при различных напряжениях затвор-исток')
legend('4,0 В', '4,5 В', '4,8 В', '5,0 В', 2)




set(gca, 'XTick', 0:2:16)
set(gca, 'YTick', 0:10:70)