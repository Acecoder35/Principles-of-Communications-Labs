close all; clc;
sgtitle('Question 2')

fs = 1000;
t = linspace(0,1,fs-1);

a = 2*cos(2*pi*5*t);
b = cos(2*pi*100*t);
x2 = a.*b;
dft_x2 = fftshift(fft(x2))/length(fft(x2));
freq = linspace(-fs/2,fs/2,fs-1);
%% Time domain plot
subplot(2,1,1);
plot(t, x2); grid ON
xlabel("t in secs."); ylabel("x2(t)");
title("Time domain plot of x2(t)")
%% Amplitude spectrum plot
subplot(2,1,2);
plot(freq,abs(dft_x2)); grid ON
xlabel('frquency in Hz');ylabel('Amplitude');
title("Amplitude spectrum plot of x2(t)")