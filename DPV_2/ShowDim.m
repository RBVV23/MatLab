function [ output_args ] = ShowDim( Klass, Kc, Target )

% Klass - пространство классов для отображения
% Kc - вектор "центров" классов
% Target - исследуемый элемент

K=size(Klass,2);
M=size(Klass,1);

cc=hsv(K);  % массив градиента цветов (от красного до голубого)
figure
plot(Target(1), Klass(Target(1), Target(2)), 'marker','o', 'color',cc(Target(2),:))
hold on
grid on
plot(1, Kc, '*k')
legend('Exploring point', '"Centers" of classes')

for id=1:K
    for i=1:M
       plot(i, Klass(i,id), 'marker','.', 'color',cc(id,:));
    end    
    plot([1:M], Kc(id)*ones(M), 'color',cc(id,:));
    plot(1, Kc(id), 'marker','*', 'color',cc(id,:))
end
plot(Target(1), Klass(Target(1), Target(2)), 'marker','o', 'color',cc(Target(2),:))

end

