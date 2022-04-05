clc
clear all
close all


%% ПАРАМЕТРЫ ПО ВАРИАНТУ
% 1 вариант (по умолчанию)

global Type

Fo = 1000        % несущая частота (Гц)
m = 0.1          % индекс фазовой модуляции

Type=1;          % тип тригонометрической функции, 1 - sin, 2 - cos
w = 80;          % число между '2пи' и 't' по варианту
w = 2*pi*w;
Tc = 2*pi/w      % период модулирующего колебания

N10 = 10;        % количество отсчетов на один период несущей (у всех по условию не менее 10)

Fs=N10*Fo        % на одном периоде несущей не менее 10 отсчетов
Ts=1/Fs          % интервал дискретизации
T=[0:Ts:Tc];     % массив времени (рассматриваем один период модулирующего колебания)


    % формирование ФМ-сигнала при помощи отдельно прописанноый функции
    % s_FM - ФМ-сигнал; S_FM - его спектр; Fox - ось линейной частоты; Wb - ось безразмерной частоты
    
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


%% ПЕРЕСЧЕТ ПАРАМЕТРОВ
    % ОСТОРОЖНО! За этот кусочек придется серьезно пояснять 
N=size(T,2);
newP=round(log2(N))                % подбираем степень двойки для количества отсчетов времени
newTs=Tc/(2^newP - 1)              % количество отсчетов - степень двойки, а здесь мы считаем соотвествующий интервал
newT=[ 0 : newTs : Tc ]            % задаем массмв времени - он гаранитировано состоит из <степень двойки> точек
newFs=1/newTs                      % соответсвующая частота дискретизации
newFo=(w/2/pi)*round(Fo/(w/2/pi))  % подбираем ближайшую к исходной несущую, но кратную модулирующей частоте (деление на 2pi приводит циклические частоты к линейным, а они у всех целые по варианту - это упрощает счет)

integer=newFo/(w/2/pi)              % проверка кратности периодов (частот) модулирующего и несущего колебаний
if (newFo>0.5*Fo) & (newFo<1.5*Fo)  % проверка новой несущей частоты на принадлежность установленному интервалу
    OK=1                            % маркер, показывающий, что условие выполнено
else
    OK=0                            % маркер, показывающий, что у тебя проблемы (обратитесь к специалисту)
end
    
%% ПОВТОРЕНИЕ РАБОТЫ ДЛЯ ОБНОВЛЕННЫХ ПАРАМЕТРОВ
    % Расслабляйте булки, тут попроще

    % обновляем значения переменных
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

 %% ОЦЕНКА МОЩНОСТНЫХХ ХАРАКТЕРИСТИК И ИССЛЕДОВАНИЕ ВЛИЯНИЯ ИНДЕКСА МОДУЛЯЦИИ

 M=[0.1 1 2];     % массив индексов модуляции ( до этого мы брали m=0.1 )

    for i=1:size(M,2)
    m=M(i)                                                   % меняем индекс модуляции
    [s_FM S_FM Fox Wb]=TMSFIVE1( m, w, T, Fo, Fs ); % формируем ФМ-сигнал с новым индексом модуляции
    
    % исследование мощностных характеристик при помощи отдельно прописанноый функции
    % Nline - количество боковых линий спектра >1 мВт; Pow - мощность сигнала ("практическая"); PowTheor - мощность сигнала (теоретическая) 
    [Nline Pow PowTheor] = TMSFIVE2( s_FM, S_FM );
    
    NlineTeor=Tc/Ts                  % теоретическое значение для количества линий спектра
    Nline=Nline                      % практическтий расчет линий спектра (должен совпасть с предыдущей строчкой)
    PowTheor=PowTheor                % теоретическое значение для мощности сигнала
    Pow=Pow                          % практическтий расчет мощности сигнала (должен совпасть с предыдущей строчкой)
                            
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
    
   