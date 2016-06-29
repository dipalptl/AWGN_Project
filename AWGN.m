clear all;
samples=10000;
for i=1:samples
    g(i)=sum(read(1,12))-6;
end
%com123

% generate two independent uniform distributed random variables 
x1=rand(samples,1);
x2=rand(samples,1);

k=kstest(x1,x2)

% transform the distributions 
f=sqrt(-log(x1));
g=sqrt(2.0)*cos(2*pi*x2);

%AWGN distribution
n=f.*g;

%plot histogram
hist(n,500);

%standard deviation
std(n)

%mean 
mean(n)

a = rand(1, 10000);
b = rand(1, 10000);

k1=kstest(a,b)

mullr1 = sqrt(-2 * log(a)) .* sin(2 * pi * b);
mullr2 = sqrt(-2 * log(a)) .* cos(2 * pi * b);
hist([mullr1,mullr], 20);

k2=kstest(mullr1,mullr2)

function [output]=central_limit(n) % Central Limit

for loop=1:n
    x(loop,:)=ceil(6*rand(1,10000)) ;  % Generate 10000 random numbers from seed 1 to 6
    %independent distributed variables
end

for loop=1:length(x(1,:)),     % Add column to find more number
    y(loop)=sum(x(:,loop));
end

number = [1 2 5 10 15 20 30 50 100];
for loop=number,
    central_limit(loop);
    pause;
end