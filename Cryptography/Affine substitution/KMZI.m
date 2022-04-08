clc
clear all
close all

Variant=1;
TypeA=[1,2,4,5,8,13,20,22,23];
alphabet=['А','Б','В','Г','Д','Е','Ж','З','И','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ь','Ы','Э','Ю','Я'];

for Variant=1:30

%Введите шифрграмму (с включенным CapsLock)
% ST='ЗШРУКМГЩ';
address=['E',num2str(Variant*2)];
[empty ST]=xlsread('KMZI_1','main',address)
ST=char(ST);

%Введите известные пары символов в одну строчку (с включенным CapsLock)
% key='ГУХЯ'
address=['H',num2str(Variant*2)];
[empty key]=xlsread('KMZI_1','main',address)
key=char(key);

if find(TypeA==Variant)
X1=find(key(1)==alphabet)-1;
Y1=find(key(2)==alphabet)-1;
X2=find(key(3)==alphabet)-1;
Y2=find(key(4)==alphabet)-1;
else
Y1=find(key(1)==alphabet)-1;
X1=find(key(2)==alphabet)-1;
Y2=find(key(3)==alphabet)-1;
X2=find(key(4)==alphabet)-1;
end
    
R=30;
a=0;

if X2>X1
   Y2=Y2+30;
   Y3=rem(Y2-Y1,30);
   X3=X2-X1;
else
   Y1=Y1+30;
   Y3=rem(Y1-Y2,30);
   X3=X1-X2;
end
   while (R~=Y3)
       R=rem(X3*a,30);
       a=a+1;
end
a=a-1;
a=rem((a+30),30)
b=Y1-rem(X1*a,30);
b=rem((b+30),30)




OT='x';
for i=1:numel(ST)
   STnum(i)=find(alphabet==ST(i))-1;
   OTnum(i)=rem( (a*STnum(i)+b),30 );
   OT(i)=alphabet(OTnum(i)+1);
end
OT=OT
address=['L',num2str(Variant*2)];
xlswrite('KMZI_1',OT, 'main',address)
address=['I',num2str(Variant*2)];
xlswrite('KMZI_1',a, 'main',address)
address=['J',num2str(Variant*2)];
xlswrite('KMZI_1',b, 'main',address)
end
