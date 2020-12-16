close all; clc;

fs = 10000;
kp = 1.5;

t = 0:1/fs:10-1/fs;

Am = 1;     fm = 20;
s1 = Am*cos(2*pi*fm*t);
Ac = 1;     fc = 100;
s2 = Ac*cos(2*pi*100*t);

s4 = pmmod(s1,fc,fs,kp*Am);
s41 = pmdemod(s4,fc,fs,kp*Am);
%% plot of s1(t)
figure
plot(t,s1)
title('Message Signal s1(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of PM signal, s4(t)
figure
plot(t,s4)
title('PM Modulated Signal s4(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of demodulated PM signal, s41(t)
figure
plot(t,s41)
title('Demodulated PM Signal s41(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
hold on
plot(t,s1)
hold off
legend('demodulated PM signal','message signal')