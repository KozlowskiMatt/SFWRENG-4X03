function y = Question_7c()
%%% QUESTION 7c %%%
clear all
close all
x=pi/4;
h = 10.^(-16:.1:.1);
f = @(x) sin(x).*exp(cos(x));
fpaccurate = exp(cos(x)).*cos(x) - exp(cos(x)).*(sin(x)^2)
fp = (f(x+h) - f(x-h))./(2*h)

error = abs(fpaccurate - fp);
M = 10.873;
loglog(h,error,'.','MarkerSize',10);
hold on;
loglog(h,1/6*M*h.^2+eps./h,'LineWidth',2);
xlabel('h');
ylabel('error');
title("Approximating f'(x), f(x) = sin(x)*exp(cos(x)), @ x = pi/4");
xlim([h(1) h(end)]);
legend ("error in (f(x+h) - f(x-h))/(2*h)", "h^2*M/6 + eps/h");
set (gca, 'FontSize', 12)
print ("-depsc2","deriverr.eps");

end