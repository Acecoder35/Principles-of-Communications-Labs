close all; clc;
sgtitle('Question 1')

fs = 1000;
t = linspace(0,1,fs-1);

a = 5;
b = 3*cos((2*pi*50*t)+(pi/8));
c = 6*cos((2*pi*300*t)+(pi/2));
x1 = a+b+c;
dft_x1 = fftshift(fft(x1))/length(fft(x1));
freq = linspace(-fs/2,fs/2,fs-1);
%% Amplitude spectrum plot
subplot(2,1,1);
plot(freq, abs(dft_x1)); grid ON
xlabel('frquency in Hz'); ylabel('Amplitude');
title("Amplitude spectrum plot of x1(t)")
%% Phase spectrum plot
subplot(2,1,2);
plot(freq,(angle(dft_x1))); grid ON
xlabel('frquency in Hz'); ylabel('Phase');
title("Phase spectrum plot of x1(t)")
