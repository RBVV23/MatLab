clc
clear all
close all

massN = [100 200 500 750 1000 2500 5000 7500 10000];
for j=1:size(massN,2)
    massPI(j)=pi;
    for n=1:massN(j)
        
    Circle=0;
    Square=0;

    for i=1:n
       x(i)=0.5-rand(1);
       y(i)=0.5-rand(1);
        if ( x(i)^2 + y(i)^2 ) <= (0.5)^2
            Circle=Circle+1;
        end
    end

    exppi(j)=4*(Circle/n);
    delta(j)=abs(exppi(j)-pi);
   

    end
end


%% PLOT

figure
plot(massN, delta, '-r', 'LineWidth', 3)
title('Line scale')
legend('\delta')
hold on
grid on

figure
plot(massN, (100*delta/pi), '-k', 'LineWidth', 3)
title('Line scale')
hold on
grid on
legend('\epsilon, %')

figure
plot(massN, exppi, '-b', 'LineWidth', 3)
title('Line scale')
hold on
grid on
plot(massN, massPI, '--g', 'LineWidth', 2)
legend('Experimental \pi', 'Real \pi')

%% SEMILOGX

figure
semilogx(massN, delta, '-r', 'LineWidth', 3)
title('SemilogX scale')
legend('\delta')
hold on
grid on

figure
semilogx(massN, (100*delta/pi), '-k', 'LineWidth', 3)
title('SemilogX scale')
hold on
grid on
legend('\epsilon, %')

figure
semilogx(massN, exppi, '-b', 'LineWidth', 3)
title('SemilogX scale')
hold on
grid on
plot(massN, massPI, '--g', 'LineWidth', 2)
legend('Experimental \pi', 'Real \pi')