close all; clc;
Fc = 15000; %Change this to tune to required station(15k/25kHz)
AM_Fc = 16000; %Change this to tune to required station(10k/16kHz)
A = 5; %Change the value in decibels

[x,fs]=audioread('audio.wav');
[y,fs]=audioread('music.wav');
[z,fs]=audioread('song.wav');
% All have same fs due to same recording source.
x = x(:,1);
y = y(:,1);
z = z(:,1);
% changing audio length to 5sec
x = x(1:5*fs);
y = y(1:5*fs);
z = z(1:5*fs);
% Increasing sampling rate
fs = 2*fs;
x = resample(x,2,1);
y = resample(y,2,1);
z = resample(z,2,1);
w = wgn(length(x),1,0); %this is the white noise
% soundsc(y,fs);%->to play the audio
t = (0:1/fs:(length(y)-1)/fs);

%% Changing the power of the interferer w.r.t. the original signal
z_power = var(z);
w_power = var(w);

z_new_power1 = var(x)*10^(A/10);
z_new_power2 = var(y)*10^(A/10);
w_new_power1 = var(x)*10^(A/10);
w_new_power2 = var(y)*10^(A/10);

ratio1 = z_new_power1/z_power;
ratio2 = z_new_power2/z_power;
ratio3 = w_new_power1/w_power;
ratio4 = w_new_power2/w_power;

z1 = z.*sqrt(ratio1);
z2 = z.*sqrt(ratio2);
w1 = w.*sqrt(ratio3);
w2 = w.*sqrt(ratio4);
%w1 = bandpass(w1, [10000, 20000], fs);
%w2 = bandpass(w2, [20000, 30000], fs);

%% FM modulation, jamming & demodulation
fm = 2000;
m = 1;

x1 = fmmod(x,15000,fs,m*fm);
y1 = fmmod(y,25000,fs,m*fm);

x1_jammer = fmmod(z1,15000,fs,m*fm);
y1_jammer = fmmod(z2,25000,fs,m*fm);

f = x1 + y1 + x1_jammer + y1_jammer;
f1 = x1 + y1 + w1 + w2;

fb = bandpass(f, [Fc-5000, Fc+5000], fs);
fb1 = bandpass(f1, [Fc-5000, Fc+5000], fs);

f_demod = fmdemod(fb,Fc,fs,m*fm);
f1_demod = fmdemod(fb1,Fc,fs,m*fm);

audiowrite('fm-fm jamming.wav',f_demod,fs);
audiowrite('fm-wgn jamming.wav',f1_demod,fs);
% soundsc(f_demod,fs);%->to play the audio

%% AM modulation & demodulation
[b, a] = butter(8,2000/(fs/2));

% To remove aliasing
x_filtered = filter(b,a,x);
y_filtered = filter(b,a,y);
z1_filtered = filter(b,a,z1);
z2_filtered = filter(b,a,z2);

s1 = ammod(x_filtered,10000,fs,0,1);
s2 = ammod(y_filtered,16000,fs,0,1);

s3 = ammod(z1_filtered,10000,fs,0, 1);
s4 = ammod(z2_filtered,16000,fs,0, 1);

s = s1 + s2 + s3 + s4;
s_noise = s1 + s2 + w1 + w2;

s = bandpass(s, [AM_Fc-2000, AM_Fc+2000], fs);
s_noise = bandpass(s_noise, [AM_Fc-2000, AM_Fc+2000], fs);

s_demod = amdemod(s,AM_Fc,fs,0,1);
s_noise_demod = amdemod(s_noise,AM_Fc,fs,0,1);

audiowrite('am-am jamming.wav',s_demod,fs);
audiowrite('am-wgn jamming.wav',s_noise_demod,fs);
% soundsc(s_noise_demod,fs);%->to play the audio

%% plots of FM spectrums
fm_noJAM = x1 + y1;
[freq, Gn] = ampspectrum(fm_noJAM, fs);
fm_JAM_signal = f;
[freq1, Gn1] = ampspectrum(fm_JAM_signal, fs);
fm_JAM_noise = f1;
[freq2, Gn2] = ampspectrum(fm_JAM_noise, fs);

figure
plot(freq,Gn)
title('No jamming FM spectrum')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on

figure
plot(freq1,Gn1)
title('Spectrum of Jammed FM signal with another FM signal')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on

figure
plot(freq2,Gn2)
title('Spectrum of Jammed FM signal with noise')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on

%% plots of AM spectrums
am_noJAM = s1 + s2;
[freq3, Gn3] = ampspectrum(am_noJAM, fs);
am_JAM_signal = s1 + s2 + s3 + s4;
[freq4, Gn4] = ampspectrum(am_JAM_signal, fs);
am_JAM_noise = s1 + s2 + w1 + w2;
[freq5, Gn5] = ampspectrum(am_JAM_noise, fs);
figure
plot(freq3,Gn3)
title('No jamming AM spectrum')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on

figure
plot(freq4,Gn4)
title('Spectrum of Jammed AM signal with another AM signal')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on

figure
plot(freq5,Gn5)
title('Spectrum of Jammed AM signal with noise')
xlabel('Frequency(in Hz)')
ylabel('Amplitude')
grid on
%% function to return amplitude spectrum
function [freq, Gn] = ampspectrum(s3, fs)
    N = length(s3);
    s3_fts = fftshift((fft(s3)))/N;
    freq = -fs/2: fs/N: fs/2-fs/N;
    Gn = (abs(s3_fts));
end