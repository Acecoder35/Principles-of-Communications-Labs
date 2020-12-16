close all, clc

sgtitle('Question 2')

fs = 1000;
time = -1:1/fs:4;
t1 = -2:1/fs:8;

%plot of x1(t)
subplot(5,1,1)
plot(time,X_out1(time))
xlabel("t")
ylabel(" x1(t) ")
title("plot of x1(t) ")

%plot of x2(t)
subplot(5,1,2)
plot(time,X_out2(time))
xlabel("t")
ylabel(" x2(t) ")
title("plot of x2(t) ")

%plot of convolution without using conv function
Y = contconv(X_out1(time), X_out2(time));
subplot(5,1,3)
plot(t1,Y/fs)
xlabel("t")
ylabel(" x1(t)*x2(t) ")
title("plot of convolution without using conv function ")

%plot of convolution using conv function
new = conv(X_out1(time), X_out2(time));
subplot(5,1,4)
plot(t1,new/fs)
xlabel("t")
ylabel(" x1(t)*x2(t) ")
title("plot of convolution using conv function")

%plot of convolution of x1 with itself
z = conv(X_out1(time), X_out1(time));
subplot(5,1,5)
plot(t1,z/fs)
xlabel("t")
ylabel(" z(t) ")
title("plot of convolution of x1 with itself ")

function out1 = X_out1(x)
out1 = [];
for a = 1:length(x)
    t = x(a);
    if t <= 2 && t > 0
        out1(end+1)= 1;
    else
        out1(end+1) = 0;
    end
end
end

function out2 = X_out2(x)
out2 = [];
for a = 1:length(x)
    t = x(a);
    if t <= 3 && t > 0
        out2(end+1)= 1;
    else
        out2(end+1) = 0;
    end
end
end

%convolution function
function Y = contconv(a, b)
m = length(a);
n = length(b);
X=[a,zeros(1,n)];
H=[b,zeros(1,m)];
for i=1:n+m-1
    Y(i)=0;
    for j=1:m
        if(i-j+1>0)
            Y(i)=Y(i)+X(j)*H(i-j+1);
        else
        end
    end
end
end