function y = spacing(a,b,n)

%Answer to question 6 of 4X03 Assignment 1
%%inputs a = 1, b = 2, n = 20
h = (b-a)/n;
x_tilda = zeros([1 (n+1)]); % For method 1
x_hat = zeros([1 (n+1)]); %For method 2

x_tilda(1) = a;

 %%% Method 1 %%%

for i=2:n+1
    x_tilda(i) = x_tilda(i-1) +h;
end

%%% Method 2 %%%

for i=1:n+1
    x_hat(i) = a +(i-1)*h;
end
COMPARE = 1.95;
%%% COMPARE can be changed to any value
%%% to get accurate difference, ensure that x_tilda(n) and x_hat(n) are
%%% ~equal to the value you are comparing them too
tilda_better = vpa(abs(COMPARE-x_tilda(n)))
hat_better = vpa(abs(COMPARE-x_hat(n)))

if (tilda_better < hat_better)
    fprintf("Method 1 is better\n\n")
else
    fprintf("Method 2 is better\n\n")
end
end