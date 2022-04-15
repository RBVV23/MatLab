clc
clear all
close all

r=zeros(3,15);
u=zeros(3,15);

r(1,:)=[1 0 0 0 1 1 0 0 1 0 0 1 0 1 0];
r(2,:)=[1 0 0 1 1 0 0 1 1 0 0 1 1 0 0];
r(3,:)=[0 0 1 0 1 1 0 0 0 0 0 0 1 0 0];

L=size(r,2);

H=[0 0 0 0 0 0 0 1 1 1 1 1 1 1 1,
   0 0 0 1 1 1 1 0 0 0 0 1 1 1 1,
   0 1 1 0 0 1 1 0 0 1 1 0 0 1 1,
   1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];

for i=1:3
    
    
e=zeros(1,L);   
    S=r(i,:)*H';
    for j=1:numel(S)
        S(j)=mod(S(j),2);
    end
S
    for j=1:size(H,2)
        if ( H(:,j)' == S )
           e(j)=1; 
        end
    end
 e   
    u(i,:)=r(i,:)+e;
    for j=1:numel(u)
        u(j)=mod(u(j),2);
    end
    k=1;
    for n=1:L
        if (n~=1) && (n~=2) && (n~=4) && (n~=8)
        m(i,k)=u(i,n);
        k=k+1;
        end
    end
    
end

m_vector=matrix2vector(m);

letter=zeros(6,5);
for k=1:6
   letter(k,:)=m_vector((k-1)*5+1 : (k-1)*5+5);
end