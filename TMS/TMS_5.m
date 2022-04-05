clc
clear all
close all


%% ��������� �� ��������
% 1 ������� (�� ���������)

global Type

Fo = 1000        % ������� ������� (��)
m = 0.1          % ������ ������� ���������

Type=1;          % ��� ������������������ �������, 1 - sin, 2 - cos
w = 80;          % ����� ����� '2��' � 't' �� ��������
w = 2*pi*w;
Tc = 2*pi/w      % ������ ������������� ���������

N10 = 10;        % ���������� �������� �� ���� ������ ������� (� ���� �� ������� �� ����� 10)

Fs=N10*Fo        % �� ����� ������� ������� �� ����� 10 ��������
Ts=1/Fs          % �������� �������������
T=[0:Ts:Tc];     % ������ ������� (������������� ���� ������ ������������� ���������)


    % ������������ ��-������� ��� ������ �������� ������������ �������
    % s_FM - ��-������; S_FM - ��� ������; Fox - ��� �������� �������; Wb - ��� ������������ �������
    
[s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs );

j=1;

h(j)=figure
plot(T, s_FM,  '-b', 'LineWidth', 1.5)
hold on
grid on
title('FM-signal')
xlabel('Time, s')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;

h(j)=figure
stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Frequency, Hz')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;

h(j)=figure
stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Dimensionless frequency')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;


%% �������� ����������
    % ���������! �� ���� ������� �������� �������� �������� 
N=size(T,2);
newP=round(log2(N))                % ��������� ������� ������ ��� ���������� �������� �������
newTs=Tc/(2^newP - 1)              % ���������� �������� - ������� ������, � ����� �� ������� �������������� ��������
newT=[ 0 : newTs : Tc ]            % ������ ������ ������� - �� �������������� ������� �� <������� ������> �����
newFs=1/newTs                      % �������������� ������� �������������
newFo=(w/2/pi)*round(Fo/(w/2/pi))  % ��������� ��������� � �������� �������, �� ������� ������������ ������� (������� �� 2pi �������� ����������� ������� � ��������, � ��� � ���� ����� �� �������� - ��� �������� ����)

integer=newFo/(w/2/pi)              % �������� ��������� �������� (������) ������������� � �������� ���������
if (newFo>0.5*Fo) & (newFo<1.5*Fo)  % �������� ����� ������� ������� �� �������������� �������������� ���������
    OK=1                            % ������, ������������, ��� ������� ���������
else
    OK=0                            % ������, ������������, ��� � ���� �������� (���������� � �����������)
end
    
%% ���������� ������ ��� ����������� ����������
    % ������������ �����, ��� �������

    % ��������� �������� ����������
T=newT;
Fo=newFo;
Fs=newFs;
    
[s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs );

h(j)=figure
plot(T, s_FM,  '-b', 'LineWidth', 1.5)
hold on
grid on
title('FM-signal')
xlabel('Time, s')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;

h(j)=figure
stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Frequency, Hz')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;

h(j)=figure
stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
hold on
grid on
title('Amplitude spectre of FM-signal')
xlabel('Dimensionless frequency')
legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
file_name = strcat('fig_', num2str(j));  
saveas(h(j), file_name, 'png'); 
j=j+1;

 %% ������ ����������� ������������� � ������������ ������� ������� ���������

 M=[0.1 1 2];     % ������ �������� ��������� ( �� ����� �� ����� m=0.1 )

    for i=1:size(M,2)
    m=M(i)                                                   % ������ ������ ���������
    [s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs ); % ��������� ��-������ � ����� �������� ���������
    
    % ������������ ���������� ������������� ��� ������ �������� ������������ �������
    % Nline - ���������� ������� ����� ������� >1 ���; Pow - �������� ������� ("������������"); PowTheor - �������� ������� (�������������) 
    [Nline Pow PowTheor] = TMSFIVE2( s_FM, S_FM );
    
    NlineTeor=Tc/Ts                  % ������������� �������� ��� ���������� ����� �������
    Nline=Nline                      % ������������� ������ ����� ������� (������ �������� � ���������� ��������)
    PowTheor=PowTheor                % ������������� �������� ��� �������� �������
    Pow=Pow                          % ������������� ������ �������� ������� (������ �������� � ���������� ��������)
                            
    figure(100)
    subplot(size(M,2),1,i)
    plot(newT, s_FM,  '-b', 'LineWidth', 1.5)
    hold on
    grid on
    title('FM-signal')
    xlabel('Time, s')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
    if (i==3)
        h(j)=figure(100)
        file_name = strcat('fig_', num2str(j));  
        saveas(h(j), file_name, 'png');
        j=j+1;
    end

    figure(101)
    subplot(size(M,2),1,i)
    stem(Fox, abs(S_FM), '-r', 'LineWidth', 1.5)
    hold on
    grid on
    title('Amplitude spectre of FM-signal')
    xlabel('Frequency, Hz')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
    if (i==3)
        h(j)=figure(101)
        file_name = strcat('fig_', num2str(j));  
        saveas(h(j), file_name, 'png');
        j=j+1;
    end
    
    figure(102)
    subplot(size(M,2),1,i)
    stem(Wb, abs(S_FM), '-r', 'LineWidth', 1.5)
    hold on
    grid on
    title('Amplitude spectre of FM-signal')
    xlabel('Dimensionless frequency')
    legend(['Fo = ', num2str(Fo), ' Hz (m = ', num2str(m), ')'])
     if (i==3)
        h(j)=figure(102)
        file_name = strcat('fig_', num2str(j));  
        saveas(h(j), file_name, 'png');
        j=j+1;
    end
    
    end
    
   