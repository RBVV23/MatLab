clc
clear all
close all

Fo = 1000        
m = 0.1          

w = 80;          
w = 2*pi*w;
Tc = 2*pi/w     

N10 = 10;        

Fs=N10*Fo       
Ts=1/Fs         
T=[0:Ts:Tc];     

    
[s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs );


plot(T, s_FM,  '-b', 'LineWidth', 1.5)
hold on
grid on
title('FM-signal')
xlabel('Time, s')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Frequency, Hz')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 

stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Dimensionless frequency')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])


N=size(T,2)
newP=round(log2(N))                
newTs=Tc/(2^newP - 1)              
newT=[ 0 : newTs : Tc ]            
newFs=1/newTs                      
newFo=(w/2/pi)*round(Fo/(w/2/pi))  
integer=newFo/(w/2/pi)              
if (newFo>0.5*Fo) & (newFo<1.5*Fo)  
    OK=1                            
else
    OK=0                            
end

Fo=newFo;
Fs=newFs;
    
[s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs );

plot(T, s_FM,  '-b', 'LineWidth', 1.5)
hold on
grid on
title('FM-signal')
xlabel('Time, s')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Frequency, Hz')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Dimensionless frequency')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

 M=[0.1 1 2];     

    for i=1:size(M,2)
    m=M(i)                                                  
    [s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs ); 
    
    [Nline Pow PowTheor] = TMSFIVE2( s_FM, S_FM );
    
    NlineTeor=Tc/Ts                 
    Nline=Nline                      
    PowTheor=PowTheor               
    Pow=Pow                          
    
    figure(100)
    subplot(size(M,2),1,i)
    plot(newT, s_FM,  '-b', 'LineWidth', 1.5)
    hold on
    grid on
    title('FM-signal')
    xlabel('Time, s')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

    subplot(size(M,2),1,i)
    stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
    hold on
    grid on
    title('Amplitude spectre of FM-signal')
    xlabel('Frequency, Hz')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])

    subplot(size(M,2),1,i)
    stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
    hold on
    grid on
    title('Amplitude spectre of FM-signal')
    xlabel('Dimensionless frequency')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
    
    end