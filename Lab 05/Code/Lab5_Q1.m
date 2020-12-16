close all; clc;

Fc = 16000; %Change this to tune to required station

[x,fs]=audioread('audio.wav');
[y,fs]=audioread('music.wav');
[z,fs]=audioread('song.wav');
%All have same fs due to same recording source.
x = x(:,1);
y = y(:,1);
z = z(:,1);
% Converting to 1D array
[b, a] = butter(10,2000/(fs/2));
% freqz(b,a);
% To remove aliasing
x = filter(b,a,x);
y = filter(b,a,y);
z = filter(b,a,z);
% soundsc(y,fs);%->to play the audio

% changing audio length to 5sec as asked
x = x(1:5*fs);
y = y(1:5*fs);
z = z(1:5*fs);

t = (0:1/fs:(length(y)-1)/fs);
% soundsc(y,fs);%->to play the audio

Fs = 60000;

s1 = ammod(x,10000,Fs,0,1);
s2 = ammod(y,16000,Fs,0,1);
s3 = ammod(z,22000,Fs,0,1);

s = s1 + s2 + s3;

SNR = 10;

% dft_ys=fftshift(fft(y))/length(fft(y));
% frequencies = -fs/2:fs/length(y):(fs/2)-(fs/length(y));
% figure
% plot(frequencies,abs(dft_ys))
% xlim([0,4000])
%% demodulation function
s = bandpass(s, [Fc-2000, Fc+2000], Fs);
[s_demod, ~] = envelope(s);
s_demod = s_demod - 1; %subtracting Ac
s_demod = filter(b,a,s_demod);
%soundsc(s_demod,fs);%->to play the audio
sn = awgn(s,SNR);
[sn_demod, ~] = envelope(sn);
%soundsc(sn_demod,fs);%->to play the audio

%% Audio
figure
sgtitle('audio signal')
subplot(2,1,1)
plot(t,x)
xlabel('time(s)')
ylabel('Amplitude')
grid on
dft_xs = fftshift(fft(x))/length(fft(x));
frequencies1 = -fs/2:fs/length(x):(fs/2)-(fs/length(x));
subplot(2,1,2)
plot(frequencies1,abs(dft_xs))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on
%% Music
figure
sgtitle('music signal')
subplot(2,1,1)
plot(t,y)
xlabel('time(s)')
ylabel('Amplitude')
grid on
dft_ys=fftshift(fft(y))/length(fft(y));
frequencies = -fs/2:fs/length(y):(fs/2)-(fs/length(y));
subplot(2,1,2)
plot(frequencies,abs(dft_ys))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on
%% Song
figure
sgtitle('song signal')
subplot(2,1,1)
plot(t,z)
xlabel('time(s)')
ylabel('Amplitude')
grid on
dft_zs = fftshift(fft(z))/length(fft(z));
frequencies2 = -fs/2:fs/length(z):(fs/2)-(fs/length(z));
subplot(2,1,2)
plot(frequencies2,abs(dft_zs))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on
%% 10KHz Carrier Frequency
figure
plot(t,s1)
title('10KHz Carrier Frequency(audio)')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% 16KHz Carrier Frequency
figure
plot(t,s2)
title('16KHz Carrier Frequency(music)')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% 22KHz Carrier Frequency
figure
plot(t,s3)
title('22KHz Carrier Frequency(song)')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
%% plot of demodulated signal, s_demod(t)
figure
sgtitle('Signal s-demod(t)')
subplot(2,1,1)
plot(t,s_demod)
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
subplot(2,1,2)
dft_s_demods = fftshift(fft(s_demod))/length(fft(s_demod));
frequencies3 = -fs/2:fs/length(s_demod):(fs/2)-(fs/length(s_demod));
subplot(2,1,2)
plot(frequencies3,abs(dft_s_demods))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on
%% plot of demodulated signal, sn_demod(t) through noisy channel
figure
plot(t,sn_demod)
title('Signal s-demod(t) through noisy channel')
xlabel('Time(sec)')
ylabel('Amplitude')
grid on