fs = 100000;
t = 0:1/fs:0.01-1/fs;
x = 10*sawtooth(2*pi*500*t,1/2);

u = (20*(1+x/20)).*cos(2*pi*80000*t);
plot(t,u)
grid ON
hold ON
plot(t,x)

display(var(u))