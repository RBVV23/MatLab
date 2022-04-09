clc
clear all
close all

p=179
a=2
b=81

m=9
k=20

for i=1:k
    LEFT(i)=mod( (a^(i*m) ),p);
end

for j=1:m-1
    RIGHT(j)=mod(( b*a^j ),p);
end

for i=1:k
    for j=1:m-1
        if LEFT(i)==RIGHT(j)
            myI=i
            myJ=j
        end
    end
end