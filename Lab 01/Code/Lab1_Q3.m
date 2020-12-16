close all, clc

sgtitle('Question 3')

N = 2048;

%Power Spectrum of random noise
x = rand(N,1);
w = linspace(0,pi,N);
x_fts = fftshift(fft(x));
Gn=(abs(x_fts).^2)/N;

subplot(2,1,1)
plot(w, Gn)
ylim([0,1]) %limit y-axis range between 0 to 1
title('a) Power Spectrum of random noise versus angular frequency')
xlabel('Angular frequency(Hz)')
ylabel('Power')

%Power Spectrum of white Gaussian noise
wGn = wgn(N,1,5);
wGn_fts = fftshift(fft(wGn));
y = (abs(wGn_fts).^2)/N;

subplot(2,1,2)
plot(w, y)
title('b) Power Spectrum of white Gaussian noise versus angular frequency')
xlabel('Angular frequency(Hz)')
ylabel('Power')

%Power display
display(var(wGn))