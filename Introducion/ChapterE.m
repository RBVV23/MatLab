clc
clear all

figure
betta0=0.01;
Ep0=3;
T0=300;
Est=4.7;
k=0.02;
m=2.5;
n=1.4;
p=2.3;
esimax=16;
esimin=0;

T=300
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


plot(esi, ic, '-r', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
set(gca,'XTick', 0:2:16)
set(gca,'YTick', 0:10:70)
hold on
grid on
legend('300 К; 4,0 В', 2) 

T=400
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

plot(esi, ic, '--r', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
hold on
grid on

T=300
betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)
ezi=4.5
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end


plot(esi, ic, '-g', 'LineWidth', 1.5)
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


plot(esi, ic, '-b', 'LineWidth', 1.5)
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


plot(esi, ic, '-m', 'LineWidth', 1.5)
ylabel('Сила тока стока, А')
xlabel('Напряжение сток-исток, В')
hold on
grid on












T=400
betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)
ezi=4.5
for j=1 : N
        esi(j)=esimin+j*h
        if ((ezi>=Ep) & (esi(j)>=0))
            ic(j)=betta*((ezi-Ep)^p)*( 1+k*esi(j)-exp(-m*esi(j)/ezi) )*1000
        else
            ic(j)=0;
        end
end

plot(esi, ic, '--g', 'LineWidth', 1.5)
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

plot(esi, ic, '--b', 'LineWidth', 1.5)
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

plot(esi, ic, '--m', 'LineWidth', 1.5)
ylabel('Сила тока стока, мА')
xlabel('Напряжение сток-исток, В')
hold on
grid on
legend('300 К; 4,0 В', '400 К; 4,0 В', '300 К; 4,5 В', '300 К; 4,8 В', '300 К; 5,0 В', '400 К; 4,5 В', '400 К; 4,8 В', '400 К; 4,8 В', '400 К; 5,0 В', 2) 








set(gca, 'XTick', 0:2:16)
set(gca, 'YTick', 0:10:70)
