close all, clc

sgtitle('Question 1')

%analog continuos
subplot(2,2,1);
t = 0:0.001:2;
x = sin(2*pi*t);
plot(t, x)
title('a) analog continuos signal of sin(2*pi*t)')
xlabel('t')
ylabel('x(t)')

%analog discontinuos
subplot(2,2,2);
n = 0:0.05:2;
x = sin(2*pi*n);
stem(n, x)
title('b) analog discontinuos signal of sin[2*pi*n]')
xlabel('n')
ylabel('x[n]')

%digital continuos
subplot(2,2,3);
t = 0:0.001:2;
x = sin(2*pi*t);
y = sign(x);
plot(t, y)
title('c) digital continuos signal of sin(2*pi*t)')
xlabel('t')
ylabel('x(t)')

%digital discontinuos
subplot(2,2,4);
n = 0:0.05:2;
x = sin(2*pi*n);
y = sign(x);
stem(n, y)
title('d) digital discontinuos signal of sin[2*pi*n]')
xlabel('n')
ylabel('x[n]')