close all; clc;

fs = 100000;
t = 0:1/fs:10-1/fs;

s1 = 0.5*cos(2*pi*200*t);
s2 = 1*cos(2*pi*2000*t);

s3 = ammod(s1,2000,fs,0,1);
s3_demod = amdemod(s3,2000,fs,0,1);

s3_fts =fftshift((fft(s3)));
N = length(s3_fts);
freq = -fs/2: fs/length(s3_fts): fs/2-fs/length(s3_fts);
Gn=(abs(s3_fts/N).^2);

m = 0:1/fs:2;
norm = (1+m.^2/2);
%% plot of Amplitude modulated signal, s3(t)
figure
plot(t,s3)
title('Signal s3(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% Plot of Amplitude spectrum of the Amplitude modulated signal signal, s3(t)
figure
plot(freq,abs(s3_fts/N))
xlabel('Frequency(Hz)')
ylabel('s3(t)')
title ('Amplitude spectrum of the DSB-SC signal')
xlim([-5000 5000])
grid on
%% Plot of power spectrum of the Amplitude modulated signal, s3(t)
figure
plot(freq,Gn)
xlabel('Frequency(Hz)')
ylabel('s3(t)')
title ('Power spectrum of the DSB-SC signal')
xlim([-5000 5000])
grid on
%% plot of demodulated signal, s3_demod(t)
figure
plot(t,s3_demod)
title('Signal s3 demod(t)')
xlabel('Time(sec)')
ylabel('Amplitude')
xlim([0 0.01])
grid on
%% Plotting the graph between the total AM power normalized to carrier power and modulation index
figure
plot (m,norm);
xlabel('modulation index');
ylabel('AM power/carrier power');
title ('Plot of total AM power normalized to carrier power vs modulation index');
grid on