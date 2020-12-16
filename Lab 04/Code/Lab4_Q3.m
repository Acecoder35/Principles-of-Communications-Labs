close all; clc;

fs = 100000;
t = 0:1/fs:10;

s1 = 0.5*cos(2*pi*200*t);
s2 = 1*cos(2*pi*2000*t);

s32 = ssbmod(s1,2000,fs,0);
s32_demod = ssbdemod(s32,2000,fs,0);

s32_fts =fftshift((fft(s32)));
N = length(s32_fts);
freq = -fs/2: fs/length(s32_fts): fs/2-fs/length(s32_fts);
Gn=(abs(s32_fts/N).^2);

display(var(s32))

noise = awgn(s32,15);
demod_noise = ssbdemod(noise,2000,fs,0);
%% plot of SSB-SC signal, s31(t)
figure
plot(t,s32)
title('Signal s32(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% Plot of power spectrum of the Amplitude modulated signal, s3(t)
figure
plot(freq,Gn/4)
xlabel('Frequency(Hz)')
ylabel('s3(t)')
title ('Power spectrum of the SSB-SC signal')
xlim([-5000 5000])
grid on
%% plot of demodulated signal, s3_demod(t)
figure
plot(t,s32_demod)
title('Signal s3 demod(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% plot of demodulated DSB-SC signal over noisy channel at SNR=15
figure
plot(t,demod_noise)
title('Demodulated Signal s1(t) in noisy channel(SNR=15dB)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
hold on
plot(t,s1)
hold off