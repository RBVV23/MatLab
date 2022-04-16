clc
clear all

betta0=0.01;
T0=300;
Ep0=3;
Est=4.7;
k=0.02;
m=2.5;
n=1.4;
p=2.3;
ezimax=6;
ezimin=2;



h=0.01;
N=(ezimax-ezimin)/h

esi=5
T=200;
betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
 
figure   
plot(ezi, ic, '-r', 'LineWidth', 1.5)
ylabel('���� ���� �����, �')
xlabel('���������� ������-�����, �')
hold on
grid on

T=300;
betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
 
   
plot(ezi, ic, '-g', 'LineWidth', 1.5)
ylabel('���� ���� �����, �')
xlabel('���������� ������-�����, �')
hold on
grid on

T=400;
betta=betta0*((T0/T)^n);
Ep=Est-((T/T0)^(n/p))*(Est-Ep0)
for j=1 : N
        ezi(j)=ezimin+j*h
        if ((ezi(j)>=Ep) & (esi>=0))
            ic(j)=betta*((ezi(j)-Ep)^p)*( 1+k*esi-exp(-m*esi/ezi(j)) )*1000
        else
            ic(j)=0;
        end
end
 
plot(ezi, ic, '-b', 'LineWidth', 1.5)
ylabel('���� ���� �����, ��')
xlabel('���������� ������-�����, �')
hold on
grid on

legend('200�', '300�', '400�', 2)



set(gca, 'XTick', 2:1:6)
set(gca, 'YTick', 0:10:70)
