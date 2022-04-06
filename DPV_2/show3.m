function [ output_args ] = show2( Klass, Kc )

K=size(Klass,3);
M=size(Klass,1);

cc=hsv(K);  % массив градиента цветов (от красного до голубого)
figure
plot(Kc, Kc, '*k')
legend('"Centers" of classes')
hold on
grid on
for id=1:K
    for i=1:M
       plot(Klass(i,1, id), Klass(i,2, id), 'marker','o', 'color',cc(id,:));
    end

    for i=1:M
       plot(Klass(i,1, id), Klass(i,2, id), 'marker','o', 'color',cc(id,:));
    end
    
end
plot(Kc, Kc, '*k')
end

