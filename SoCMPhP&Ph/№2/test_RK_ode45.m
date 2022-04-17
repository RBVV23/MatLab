Nt=100;
t=linspace(0,10,Nt);
g=9.8;
y0=100;
v0=20;
[t,y]=ode45('S_ODE',t,[y0 v0]);
y_teor=zeros(1,Nt);
z_teor=zeros(1,Nt);
for i=1:Nt
    y_teor(i)=y0+v0*t(i)-g*t(i)*t(i)/2;
    z_teor(i)=v0-g*t(i);
end;
figure;
plot(t,y(:,1),t, y_teor,'.');
figure;
plot(t,y(:,2),t,z_teor,'.');