clc
clear all
close all

Fd=2000;                            % ������� ������������� (�� ��������)
Fo=40;                              % ������� �������  (�� ��������)

M = 3;                              % ����� �������� ������� �� ����� ������������� (�� ��������)
K = Fd/Fo;                          % ����� ���������� �������� �� ������ �������
U = 1;                              % ��������� (�� ��������)
% U = sqrt(2);
C = [1 1 1 -1 -1 1 -1];             % ������ ��������� ���� ������� (�� ��������)
% C = [1 1 1 -1 -1 -1 1 -1 -1 1 -1];
L = size(C,2);                      % ����������� ���� �������
N = M*L*K                           % ������ ��������

Kn=[1 5 10];                        % ������ �������� ��������� ������������ ����
% Kn=1
Iter=5;                             % ���������� ���������� ����� � ������ �3

sig1=FCMSIG( N, 1, K, L, U, C );    % � ������ ������ M=1 ��� ���� ��������� sig=FCMSIG( N, (M=1), K, L, U, C )


N1=[1:size(sig1,2)];    % ��� ���������� ��� X �� �������
C2(1)=C(1);             % ��������� �������� ��������� �� ������ ���� �������
C2(2:L)=C(2:L);         
C2(L+1)=C(L);           

figure                  
plot(N1/K, sig1, '-r', 'LineWidth', 1)
grid on
hold on
stairs((0:L),C2, '--g', 'LineWidth', 2.5)
set(gca, 'XTick', 0:1:L)
legend('FCM signal (M=1)', 'Signal bend')
% legend('��� ������ (M=1)','���������')

sig=FCMSIG( N, M, K, L, U, C );

N2=[1:size(sig,2)];    % ��� ���������� ��� X �� �������

figure                  
plot(N2/(K*M), sig, '-r', 'LineWidth', 1)
grid on
hold on
stairs((0:L),C2, '--g', 'LineWidth', 2.5)
set(gca, 'XTick', 0:1:L)
legend(['FCM signal (M=',num2str(M),')'], ['Signal bend'])
% legend('��� ������ (M - �� ��������)','���������')


AKF=xcorr(sig);        % ������������������ ������� ������� ������������, �� ���� �������

Cisk=C;                 % ������� ���������� ��� �������
Cisk(2)=-C(2);          % �������� 2-��� ��������
Cisk(3)=-C(3);          % �������� 3-��� ��������

sigisk=FCMSIG( N, M, K, L, U, Cisk );     % ��� ������, ����������� �� ���������� ���� �������
AKFisk=xcorr(sigisk);                     % ������������������ ������� �������, ������������ �� ���������� ���� �������

figure
plot(AKFisk/N, '-m', 'LineWidth', 3.5)
hold on
grid on
plot(AKF/N, '-g', 'LineWidth', 1)
title('Normalized autocorrelation functions of FCM signals')
%title('������������� ������������������ ������� ��� ��������')
legend('Distored Barker code', 'Barker code')
%legend('���������� ���� �������','��� �������')
axis tight                     % ���������� ����

Pin=sum(sig.^2)/N              % ��������
Es=AKF(N)                      % ������� ������� ����� ������������������ ������� � 0
Esp=fft(AKF)/N;                % �������������� ������
Espi=abs(fftshift(Esp));       % ������������� � ������ ������

figure
plot((-N+1 : N-1), Espi, '-r', 'LineWidth', 0.75)
grid on
hold on
title('Energy spectrum')
% title('�������������� ������')
axis tight

scl=10;                        % �������� 'scl' ����������� ���, ����� ��� ������ ����� ������� ��������
figure
plot((-N+1 : N-1), Espi, '-r', 'LineWidth', 1.5)
grid on
hold on
title('Energy spectrum (scaled)')
% title('�������������� ������ (����������������)')
axis([-N/scl N/scl 0 max(Espi)])        

NR=Kn(1)*randn(1,N);        % ���������� ������������ ����
AKFnr=xcorr(NR);            % ������������������ ������� ������������ ����

Enr=sum(NR.^2)              % ������� ������������ ����

%WN=abs(fft(AKFnr)/N);      % �������� ���������� ����� �������� ������� "WN=abs(fft(AKFnr)/N)"
WN=abs(ifft(AKFnr));        % �� ��� ���������� ����� ���������� ����������


figure
plot(NR, '-r', 'LineWidth', 0.75)
grid on
hold on
title('Realization of Gaussian noize')
% title('���������� ������������ ����')
axis tight

figure
stem(AKFnr, '-b', 'LineWidth', 1)
grid on
hold on
title('ACF of Gaussian noize')
% title('��� ������������ ����')
axis tight

figure
stem(WN, '-m', 'LineWidth', 0.75)
grid on
hold on
title('Spectral denisty (power)')
% title('������������ ��������� �������� (���)')
axis tight

ccc=hsv(size(Kn, 2));
figure
title('Mixture of signal and noise');
%title('����� ������� � ����');
for k=1:size(Kn,2)
    
    
    NR(k,:)=Kn(k)*randn(1,N);
    SN(k,:)=sig+NR(k,:);
    OUT(k,:)=xcorr(SN(k,:),sig);
    str{k} = [ 'Kn = ', num2str(Kn(k)) ];   % ��������� ������ �������� �������
    subplot(size(Kn,2),1,k)
    plot(OUT(k,:), 'LineWidth', 1, 'color',ccc(k,:))
    legend([ 'Kn = ', num2str(Kn(k)) ])
    hold on
    grid on
    axis tight
end

for k=1:size(Kn,2)

    for i=1:Iter
        NR(k,:)=Kn(k)*randn(1,N);
        SN(k,:)=0*sig+NR(k,:);                 % ������ �� ���� ������ ���
        OUTnr(k,:)=xcorr(SN(k,:),sig);
        NRout=sum(OUTnr(k,:).^2)/N;             % �������� �� ������ ����������� (������ �����������)

        SN(k,:)=sig+0*NR(k,:);                 % ������ �� ���� ������ ������
        OUTsig(k,:)=xcorr(SN(k,:),sig);
        SIGout=OUTsig(k,N)^2;                   % �������� �� ������ ����������� (��� �����������)

        SNRmass(i)=SIGout/NRout;                % ������ �� 'Iter=5' ��� ��� 'Iter=5' ���������� ������������
    end
    SNR(k)=mean(SNRmass);                           % ���������� ��� �� 'Iter=5' ����������� ��� ��������� ���� 'Kn(k)'
    SNRtheor(k)=Es/( Kn(k)^2 );                     % ������������� �������� ��� (�������/���������)

end

Kn=Kn
SNR=SNR'
SNRtheor=SNRtheor'