close all; clc;

fs = 10000;
kf = 30;

t = 0:1/fs:10-1/fs;

Am = 1;     fm = 20;
s1 = Am*cos(2*pi*fm*t);
Ac = 1;     fc = 100;
s2 = Ac*cos(2*pi*100*t);

s3 = fmmod(s1,fc,fs,kf*Am);
s31 = fmdemod(s3,fc,fs,kf*Am);

s3_fts =fftshift((fft(s3)));
N = length(s3_fts);
freq = -fs/2: fs/length(s3_fts): fs/2-fs/length(s3_fts);
Gn=(abs(s3_fts/N).^2);

s31_1 = fmdemod(s3,fc + 1,fs,kf*Am);
s31_5 = fmdemod(s3,fc + 5,fs,kf*Am);
s31_10 = fmdemod(s3,fc + 10,fs,kf*Am);
%% plot of s1(t)
figure
plot(t,s1)
title('Message Signal s1(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of s2(t)
figure
plot(t,s2)
title('Carrier Signal s2(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of FM signal, s3(t)
figure
plot(t,s3)
title('FM Modulated Signal s3(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
%% plot of demodulated FM signal, s31(t)
figure
plot(t,s31)
title('Demodulated FM Signal s31(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
hold on
plot(t,s1)
hold off
legend('demodulated FM signal','message signal')
%% Plot of power spectrum of the FM signal, s3(t)
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('s3(t)')
title ('Power spectrum of the FM signal with kf = 50Hz/V')
xlim([-300 300])
%% Effect of offset in demodulation
figure
subplot(3,1,1)
plot(t,s31_1)
title('Demodulated FM Signal with offset = 1Hz')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
subplot(3,1,2)
plot(t,s31_5)
title('Demodulated FM Signal with offset = 5Hz')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on
subplot(3,1,3)
plot(t,s31_10)
title('Demodulated FM Signal with offset = 10Hz')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.1])
grid on