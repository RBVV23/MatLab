function [ Nline Pow PowTheor] = TMSFIVE2( s_FM, S_FM )

Nline=0;
Pow=0;
PowTheor=0;

for i=1:size(S_FM, 2)               % size(S_FM, 2) - количество отсчетов в спектре
    if abs( S_FM(i) ) > 1E-3
        Nline=Nline+1;              % считаем количество линий спектра с мощностью >1 мВт
    end
    Pow=Pow+(s_FM(i))^2;            % считаем энергию по определению
end

for i=1:ceil(size(S_FM, 2)/2)
    PowTheor=PowTheor+0.5*( 2*abs(S_FM(i)) )^2;        % ебаная формула из ебаных лекций
end

PowTheor=PowTheor/size(S_FM,2);                        % фирменное магическое деление на число отсчетов N от Хвостатого (с этого Никита Олегович очень горит)

end

