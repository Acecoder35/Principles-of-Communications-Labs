close all; clc;
sgtitle('Question 3')

fs = 1000;
t = linspace(0,1,fs-1);

a = 1 + (0.5*cos(2*pi*5*t));
b = cos(2*pi*100*t);
x3 = a.*b;
dft_x3 = fftshift(fft(x3))/length(fft(x3));
freq = linspace(-fs/2,fs/2,fs-1);

var = 9;
w = sqrt(var).*randn(1, size(t,2));
c = x3 + w;
%% Time domain plot
subplot(3,1,1);
plot(t, x3); grid ON
xlabel("t in secs."); ylabel("x3(t)");
title("Time domain plot of x3(t)")
%% Amplitude spectrum plot
subplot(3,1,2);
plot(freq,abs(dft_x3)); grid ON
xlabel('frquency in Hz');ylabel('Amplitude');
title("Amplitude spectrum plot of x3(t)")
%% Time domain plot of corrupted signal
subplot(3,1,3);
plot(t,c); grid ON
xlabel("t in secs."); ylabel("corrupted x3(t)");
title("Time domain plot of corrupted x3(t)")