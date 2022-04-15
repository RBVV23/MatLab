function [ sig ] = FCMSIG( N, M, K, L, U, C )

%% �������
% N - ����� ����� ��������
% M - ����� �������� ������� �� ����� �������������
% K - ����� ���������� �������� �� ������ �������
% L - ����������� ���� �������
% U - ���������
% C - ������ ��������� ���� �������

%% ��� �������
% M = 1;
% K = 512;
% U = sqrt(2); 
% C = [1 1 1 -1 -1 -1 1 -1 -1 1 -1]
% L = size(C,2);
% N = M*L*K;

%%

n=[0:(M*K-1)];          % � ������������ �������� ������-�� "n=[0:(M*K+1)]" � �� ��������
FSIN=sin(2*pi*n/K);

for ind=1:L
    FKM( ((ind-1)*K*M+1) : (ind*K*M) ) = C(ind)*FSIN;
    sig=U.*FKM;
end


end
