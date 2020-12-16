close all, clc

sgtitle('Question 1')

fs = 10000;
time = -8:1/fs:8;

%plot of x(t)
subplot(3,2,1:2)
plot(time,signalx(time))
xlabel("t")
ylabel(" x(t) ")
title("b) plot of x(t) ")

%plot of x(t-3)
subplot(3,2,3)
plot(time,signalx(time-3))
xlabel("t")
ylabel(" x(t) ")
title("c) plot of x(t-3)")

%plot of x(3-t)
subplot(3,2,4)
plot(time,signalx(3-time))
xlabel("t")
ylabel(" x(t) ")
title("d) plot of x(3-t) ")

%plot of x(2t)
subplot(3,2,5)
plot(time,signalx(2*time))
xlabel("t")
ylabel(" x(t) ")
title("e) plot of x(2t) ")

%plot of x(t/2)
subplot(3,2,6);
plot(time,signalx(time/2))
xlabel("t")
ylabel(" x(t) ")
title("f) plot of x(t/2) ")

function out = signalx(x)
out = [];
for a = 1:length(x)
    t = x(a);
    if t > -2 && t <= 0
        out(end+1)= 2;
    elseif t > 0 && t <= 8
        out(end+1) = (2*exp(-t/2));
    else
        out(end+1) = 0;
    end
end
end