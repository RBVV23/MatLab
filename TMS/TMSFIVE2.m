function [ Nline Pow PowTheor] = TMSFIVE2( s_FM, S_FM )

Nline=0;
Pow=0;
PowTheor=0;

for i=1:size(S_FM, 2)               % size(S_FM, 2) - ���������� �������� � �������
    if abs( S_FM(i) ) > 1E-3
        Nline=Nline+1;              % ������� ���������� ����� ������� � ��������� >1 ���
    end
    Pow=Pow+(s_FM(i))^2;            % ������� ������� �� �����������
end

for i=1:ceil(size(S_FM, 2)/2)
    PowTheor=PowTheor+0.5*( 2*abs(S_FM(i)) )^2;        % ������ ������� �� ������ ������
end

PowTheor=PowTheor/size(S_FM,2);                        % ��������� ���������� ������� �� ����� �������� N �� ���������� (� ����� ������ �������� ����� �����)

end

