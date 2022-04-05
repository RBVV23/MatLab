clc
clear all
close all


Fd = 10000            % ������� ������������� (�� ��������), ��
f0 = 40               % ��������� ������� (�� ��������), ��
f1 = 90              % �������� ������� (�� ��������), ��
Fc = 1400            % ������� ������� (�� ��������), ��

Tmax = 2;            % ������������ ������������� �������, �
M = [0.25 0.5 1];    % ������ ��������� ������� ���������


Am=1
Ts=1/Fd;
Fmod=(f0+f1)/2;
T=[0:Ts:Tmax];
F=[-Fd/2 : 1/Tmax : Fd/2];
N=size(T,2)
ini_phase=0

%%

s_MOD=chirp(T,f0,Tmax,f1);
s_AM = ammod(s_MOD, Fc, Fd, ini_phase, Am);
s_AM_SC = ammod(s_MOD, Fc, Fd);
s_LOW = ssbmod(s_MOD, Fc, Fd, ini_phase);
s_HI = ssbmod(s_MOD, Fc, Fd, ini_phase, 'upper');

%% ���������� �������� �������� �� ��������� �������
j=1;
h(j)=figure('name', 'Signals in time domain');
subplot(5,1,1)
plot(T, s_MOD, '-y', 'LineWidth', 1.5)
grid on
hold on
legend('Modulating signal')

subplot(5,1,2)
plot(T, s_AM, '-r', 'LineWidth', 1.5)
grid on
hold on
legend('Amplitude modulation')

subplot(5,1,3)
plot(T, s_AM_SC, '-g', 'LineWidth', 1.5)
grid on
hold on
legend('AM with supressed carrier')

subplot(5,1,4)
plot(T, s_LOW, '-b', 'LineWidth', 1.5)
grid on
hold on
legend('SSB modulation (upper side)')


subplot(5,1,5)
plot(T, s_HI, '-k', 'LineWidth', 1.5)
grid on
hold on
legend('SSB modulation (lower side)')


%%
S_MOD=abs( fftshift( fft(s_MOD) ) );
S_AM=abs( fftshift( fft(s_AM) ) );
S_AM_SC=abs( fftshift( fft(s_AM_SC) ) );
S_LOW=abs( fftshift( fft(s_LOW) ) );
S_HI=abs( fftshift( fft(s_HI) ) );

%% ���������� �������� ��������
j=j+1;
h(j)=figure('name', 'Signals in frequency domain');
subplot(5,1,1)
stem(F, S_MOD, '-y', 'LineWidth', 1.5)
grid on
hold on
legend('Modulating signal')

subplot(5,1,2)
stem(F, S_AM, '-r', 'LineWidth', 1.5)
grid on
hold on
legend('Amplitude modulation')

subplot(5,1,3)
stem(F, S_AM_SC, '-g', 'LineWidth', 1.5)
grid on
hold on
legend('AM with supressed carrier')

subplot(5,1,4)
stem(F, S_LOW, '-b', 'LineWidth', 1.5)
grid on
hold on
legend('SSB modulation (upper side)')

subplot(5,1,5)
stem(F, S_HI, '-k', 'LineWidth', 1.5)
grid on
hold on
legend('SSB modulation (lower side)')

%% ���������� ������������
j=j+1;
h(j)=figure('name', 'Modulating signal');
spectrogram(s_MOD, 256, 250, 256, Fd);
j=j+1;
h(j)=figure('name', 'Amplitude modulation');
spectrogram(s_AM, 256, 250, 256, Fd);
j=j+1;
h(j)=figure('name','AM with supressed carrier');
spectrogram(s_AM_SC, 256, 250, 256, Fd);
j=j+1;
h(j)=figure('name', 'SSB modulation (upper side)');
spectrogram(s_LOW, 256, 250, 256, Fd);
j=j+1;
h(j)=figure('name', 'SSB modulation (lower side)');
spectrogram(s_HI, 256, 250, 256, Fd);

%% ������������ ������� ������� ���������

j=j+1;
h(j)=figure('name','Time domain');
for i=1:size(M,2)
   s_AMm=myAMMOD( T, s_MOD, Fc, M(i), ini_phase );
   S_AMm=fftshift( fft( s_AMm ) );
   
   subplot(size(M,2), 1, i)
   plot(T, s_AMm, '-r', 'LineWidth', 1.5)
   grid on
   hold on
   legend(['AM, m = ',num2str(M(i))])
end

j=j+1;
h(j)=figure('name','Frequency domain');
for i=1:size(M,2)
   s_AMm=myAMMOD( T, s_MOD, Fc, M(i), ini_phase );
   S_AMm=fftshift( fft( s_AMm ) );
  
   subplot(size(M,2), 1, i)
   stem(F, S_AMm, '-g', 'LineWidth', 1.5)
   grid on
   hold on
   legend(['AM, m = ',num2str(M(i))])
end


j=j+1;
h(j)=figure('name','Spectrogram');
for i=1:size(M,2)
   s_AMm=myAMMOD( T, s_MOD, Fc, M(i), ini_phase );
   S_AMm=fftshift( fft( s_AMm ) );
   subplot(size(M,2), 1, i)
   spectrogram(s_AMm, 256, 250, 256, Fd);
   legend(['AM, m = ',num2str(M(i))])
end

for i=1:j
    file_name = strcat('fig_', num2str(i));  
    saveas(h(i), file_name, 'png'); 
end
