close all, clc

sgtitle('Question 2')

fs = 1000;
t = -1:1/fs:4;
t1 = -2:1/fs:8;

%% for signal 1
x1 = zeros(1,length(t));
for i=1:length(t)
    if (t(i)< 2)&& (t(i)>0)
        x1(i)=1;
    else
        x1(i)= 0;
    end
end

%% for signal 2
x2 = zeros(1,length(t));
for i=1:length(t)
    if (t(i)< 3)&& (t(i)>0)
        x2(i)=1;
    else
        x2(i)= 0;
    end
end

%% plot of x1(t)
subplot(5,1,1)
plot(t,x1)
xlabel("t")
ylabel(" x1(t) ")
title("b) plot of x1(t) ")

%% plot of x2(t)
subplot(5,1,2)
plot(t,x2)
xlabel("t")
ylabel(" x2(t) ")
title("b) plot of x2(t) ")

%% plot of convolution without using conv function
Y = contconv(x1,x2);
subplot(5,1,3)
plot(t1,Y/fs)
xlabel("t")
ylabel(" x1(t)*x2(t) ")
title("b) plot of convolution without using conv function ")

%% plot of convolution using conv function
new = conv(x1,x2);
subplot(5,1,4)
plot(t1,new/fs)
xlabel("t")
ylabel(" x1(t)*x2(t) ")
title("b) plot of convolution using conv function")

%% plot of convolution of x1 with itself
z = conv(x1, x1);
subplot(5,1,5)
plot(t1,z/fs)
xlabel("t")
ylabel(" x1(t)*x1(t) ")
title("b) plot of convolution without using conv function ")

%% convolution function
function Y = contconv(x1, x2)
m = length(x1);
n = length(x2);
p = m+n;
X=[x1,zeros(1,n)];
H=[x2,zeros(1,m)];
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