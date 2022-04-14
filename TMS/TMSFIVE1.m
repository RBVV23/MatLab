function [ s_FM S_FM Fox Wb] = TMSFIVE1( m, w, T, Fo, Fs )

global Type

Tc=max(T);
Ts=1/Fs;

switch Type
    case 1
Sm=sin(w*T);
    case 2
Sm=cos(w*T);
end

Ao=1;
s_FM=Ao*cos(2*pi*Fo*T + m*Sm);      % сигнал с угловой модул€цией по формуле их лекций
S_FM=fft(s_FM);                     % находим спектр через Ѕѕ‘
S_FM=fftshift(S_FM);                % симметризаци€ спектра относительно 0
Fox=[-Fs/2 : 1/Tc : Fs/2];          % формируем массив частот симметричный относительно 0
Wb=2*pi*Fox*Ts;                     % формируем массив безразмерных частот симметричный относительно 0


end

