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
[b, a] = butter(8,2000/(fs/2));
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

s1 = ammod(x,10000,Fs,0);
s2 = ammod(y,16000,Fs,0);
s3 = ammod(z,22000,Fs,0);

s = s1 + s2 + s3;
offset = 10;
%% demodulation function
s = bandpass(s, [Fc-2000, Fc+2000], Fs);
s_demod = amdemod(s,Fc,Fs,0);
%soundsc(s_demod,fs);%->to play the audio
s_off_demod = amdemod(s,Fc+offset,Fs,0);
%soundsc(s_off_demod,fs);%->to play the audio
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
s_demod = filter(b,a,s_demod);
dft_s_demods = fftshift(fft(s_demod))/length(fft(s_demod));
frequencies3 = -fs/2:fs/length(s_demod):(fs/2)-(fs/length(s_demod));

figure
sgtitle('Signal s-demod(t)')
subplot(2,1,1)
plot(t,s_demod)
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
subplot(2,1,2)
plot(frequencies3,abs(dft_s_demods))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on
%% plot of demodulated signal with offset, s_off_demod(t)
dft_s_off_demods = fftshift(fft(s_off_demod))/length(fft(s_off_demod));
frequencies4 = -fs/2:fs/length(s_off_demod):(fs/2)-(fs/length(s_off_demod));

figure
sgtitle('Signal s-off-demod(t)')
subplot(2,1,1)
plot(t,s_off_demod)
xlabel('Time(sec)')
ylabel('Amplitude')
grid on
subplot(2,1,2)
plot(frequencies4,abs(dft_s_off_demods))
xlim([0,4000])
xlabel('frequency(Hz)')
ylabel('Amplitude')
grid on