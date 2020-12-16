close all; clc;

Fc = 25000; %Change this to tune to required station

[x,fs]=audioread('audio.wav');
[y,fs]=audioread('music.wav');
% All have same fs due to same recording source.
x = x(:,1);
y = y(:,1);
% changing audio length to 5sec as asked
x = x(1:5*fs);
y = y(1:5*fs);
% Increasing sampling rate
fs = 2*fs;
x = resample(x,2,1);
y = resample(y,2,1);
% soundsc(y,fs);%->to play the audio
t = (0:1/fs:(length(y)-1)/fs);

fm = 2000;
m = 1;

x1 = fmmod(x,15000,fs,m*fm);
y1 = fmmod(y,25000,fs,m*fm);

z = x1 + y1;
SNR = 5;
z_noise = awgn(z, SNR);

zb = bandpass(z, [Fc-5000, Fc+5000], fs);
z_demod = fmdemod(zb,Fc,fs,m*fm);
% soundsc(z_demod,fs);%->to play the audio
 
z_noiseb = bandpass(z_noise, [Fc-5000, Fc+5000], fs);
z_noise_demod = fmdemod(z_noiseb,Fc,fs,m*fm);
% soundsc(z_noise_demod,fs);%->to play the audio

%% plot of audio signal x(t)
figure
plot(t,x)
title('Audio Signal x(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
grid on
%% plot of music signal y(t)
figure
plot(t,y)
title('Music Signal y(t)')
xlabel('Time(t in sec)')
ylabel('Amplitude')
grid on
%% plot of FM signal, z(t)
figure
plot(t,z)
title('FM Modulated Signal z(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% plot of demodulated FM signal, z_demod(t)
figure
plot(t,z_demod)
title('Demodulated FM Signal no noise')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% plot of demodulated noisy FM signal, z_noise_demod(t)
figure
plot(t,z_noise_demod)
title('Demodulated FM Signal with SNR = 5')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% plot of power spectrum at Fc = 15KHz
[freq, Gn] = powerspectrum(x1, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('x1(t)')
title ('Power spectrum of the FM signal at Fc = 15KHz')
%% plot of power spectrum at Fc = 25KHz
[freq, Gn] = powerspectrum(y1, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('y1(t)')
title ('Power spectrum of the FM signal at Fc = 25KHz')
%% plot of power spectrum of combined transmitted signal
[freq, Gn] = powerspectrum(z, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('z(t)')
title ('Power spectrum of combined transmitted signal')
%% plot of power spectrum of received signal
[freq, Gn] = powerspectrum(z_demod, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('z-demod(t)')
title ('Power spectrum of received signal(no noise)')
%% plot of power spectrum of received signal with noise
[freq, Gn] = powerspectrum(z_noise_demod, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('z-noise-demod(t)')
title ('Power spectrum of received signal with SNR = 5')
%% plot of power spectrum of signal after tuning to station
[freq, Gn] = powerspectrum(zb, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('zb(t)')
title ('Power spectrum of signal after tuning(no noise)')
%% plot of power spectrum of signal after tuning to station with noise
[freq, Gn] = powerspectrum(z_noiseb, fs);
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('z-noiseb(t)')
title ('Power spectrum of signal after tuning(SNR = 5)')
%% function to return power spectrum
function [freq, Gn] = powerspectrum(s3, fs)
    N = length(s3);
    s3_fts = fftshift((fft(s3)))/N;
    freq = -fs/2: fs/N: fs/2-fs/N;
    Gn = (abs(s3_fts).^2);
end