close all; clc;

fs = 10000;
kf = 30;
kp = 1.5;

t = 0:1/fs:10-1/fs;

Am = 1;     fm = 20;
s1 = Am*cos(2*pi*fm*t);
Ac = 1;     fc = 100;
s2 = Ac*cos(2*pi*100*t);

s3 = fmmod(s1,fc,fs,kf*Am);
s4 = pmmod(s1,fc,fs,kp*Am);

%% plot of s1(t)
figure
subplot(3,1,1)
plot(t,s1)
title('Message Signal s1(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of FM signal, s3(t)
subplot(3,1,2)
plot(t,s3)
title('FM Modulated Signal s3(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of PM signal, s4(t)
subplot(3,1,3)
plot(t,s4)
title('PM Modulated Signal s4(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on