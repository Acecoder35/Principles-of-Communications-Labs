close all; clc;

fs = 100000;
t = 0:1/fs:10-1/fs;

s1 = 0.5*cos(2*pi*200*t);
s2 = 1*cos(2*pi*2000*t);

s31 = ammod(s1,2000,fs,0);
s31_demod = amdemod(s31,2000,fs,0);

s31_fts =fftshift((fft(s31)));
N = length(s31_fts);
freq = -fs/2: fs/length(s31_fts): fs/2-fs/length(s31_fts);
Gn=(abs(s31_fts/N).^2);

display(var(s31))

noise1 = awgn(s31,5);
demod_noise1 = amdemod(noise1,2000,fs,0);

noise2 = awgn(s31,15);
demod_noise2 = amdemod(noise2,2000,fs,0);
%% plot of s1(t)
figure
plot(t,s1)
title('Signal s1(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% plot of s2(t)
figure
plot(t,s2)
title('Signal s2(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% plot of DSB-SC signal, s31(t)
figure
plot(t,s31)
title('Signal s31(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% Plot of power spectrum of the DSB-SC signal, s31(t)
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('s31(t)')
title ('Power spectrum of the DSB-SC signal')
xlim([-5000 5000])
%% plot of demodulated DSB-SC signal, s31_demod(t)
figure
plot(t,s31_demod)
title('demodulation of DSB-SC signal, s31(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% plot of demodulated DSB-SC signal over noisy channel at SNR=5
figure
plot(t,demod_noise1)
title('demodulated DSB-SC signal over noisy channel at SNR=5')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
hold on
plot(t,s1)
hold off
legend('demodulated DSB-SC signal','s1(t)')
%% plot of demodulated DSB-SC signal over noisy channel at SNR=15
figure
plot(t,demod_noise2)
title('demodulated DSB-SC signal over noisy channel at SNR=15')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
hold on
plot(t,s1)
hold off
legend('demodulated DSB-SC signal','s1(t)')