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
ezimax=6;
ezimin=2;

betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)

h=0.01;
N=(ezimax-ezimin)/h
esi=1
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
 
figure   
plot(ezi, ic, '-y', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение затвор-исток, В')
hold on
grid on

esi=2
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
    
plot(ezi, ic, '-b', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение затвор-исток, В')
hold on
grid on
    
esi=4
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
    
plot(ezi, ic, '-g', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение затвор-исток, В')
hold on
grid on    

esi=15
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
    
plot(ezi, ic, '-r', 'LineWidth', 1.5)
ylabel('Сила тока стока, мА')
xlabel('Напряжение затвор-исток, В')
hold on
grid on
set(gca, 'XTick', 2:1:6)
set(gca, 'YTick', 0:10:70)
title('Проходные характеристики транзистора при различных напряжениях сток-исток')
legend('1,0 В', '2,0 В', '4,0 В', '16,0 В', 2)
