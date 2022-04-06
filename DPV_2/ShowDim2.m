function [ output_args ] = ShowDim2( Klass, Kc, Target)

K=size(Klass,3);
M=size(Klass,1);
RandA=Klass( Target(1), :, Target(2) );

cc=hsv(K);  % массив градиента цветов (от красного до голубого)
figure
plot(RandA(1), RandA(2), 'marker','o', 'color',cc(Target(2),:))
hold on
grid on
plot(Kc(:,1), Kc(:,2), '*k')
legend('Exploring point', '"Centers" of classes')
for id=1:K
    for i=1:M
       plot(Klass(i,1, id), Klass(i,2, id), 'marker','.', 'color',cc(id,:));
    end    
     plot(Kc(id,1), Kc(id,2), 'marker','*', 'color',cc(id,:))
end

end

