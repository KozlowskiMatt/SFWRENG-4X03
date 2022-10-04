clear all;
close all;
f = @(x) (exp(x)-1-x)./x.^2;
N = [-16:1:0];
x = 10.^N;

accurate = f(vpa(x));

error_f = abs((f(x)-accurate)./accurate);
loglog(x,error_f,"o--");
y=expm1mx(x);
error = abs((accurate-y)./accurate);
hold on;
loglog(x,error,"o--");
legend("rel. error in f(x)", "rel. error in expm1mx")
print("-depsc2", "expm1mx.eps")