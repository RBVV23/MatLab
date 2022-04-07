function [ out noise ] = myGARM_NOISE( vector,K )
rng(0)
noise=zeros(1,size(vector,2));
for j=1:K
    D=max(vector);
    A=rand*(D^(2/3));
    phi=rand*2*pi;
    w=rand*2*pi*D;

        for i=1:size(vector,2)
            noise_K(1,i)=A*sin(w*i+phi);
            noise(1,i)=noise(1,i)+noise_K(1,i);
            vector(1,i)=vector(1,i)+noise_K(1,i);
        end
end

out=vector;
end

