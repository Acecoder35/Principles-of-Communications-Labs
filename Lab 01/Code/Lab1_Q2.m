close all, clc

sgtitle('Question 2')

fs = 10000;
t = linspace(0,1,fs);
f = 100;
y = 2*sin(2*pi*t*f);
dft_ys = fftshift(fft(y))/length(fft(y));
freq = linspace(-fs/2,fs/2,fs);

%analog continuos
subplot(2,2,1)
plot(t,y)
title('a) sinusoidal signal of amplitude 2 V and frequency 100 Hz')
xlabel('t')
ylabel('x(t)')
xlim([0,0.01])

%amplitude spectrum
subplot(2,2,2)
plot(freq,abs(dft_ys))
title('b) amplitude spectrum of amplitude 2 V and frequency 100 Hz')
xlabel('frquency in Hz')
ylabel('Amplitude')
xlim([-200,200])

%phase spectrum
subplot(2,2,3)
plot(freq,unwrap(angle(dft_ys)))
title('c) phase spectrum of amplitude 2 V and frequency 100 Hz')
xlabel('frquency in Hz')
ylabel('phase')
xlim([-1000,1000])