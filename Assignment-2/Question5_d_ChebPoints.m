x = zeros(1,15);
a = 0;
b = 2;
for i =1:16
    x(1,i) = 0.5*(a+b) + 0.5*(b-a)*cos(((2*(i-1)+1)/(32))*pi);
end
x
p = polyfit(x,sqrt(x),14);

x_plotted = linspace(a,b,100);
f = sqrt(x_plotted);
p_func2 = polyval(p,x_plotted)

plot(x_plotted,f,"-","LineWidth",2);
hold on
plot(x_plotted,p_func2,":",'LineWidth',2);
legend("f(x)","p(x)");
ylim([0 1.5]);
title("f(x) vs. Interpolation p(x) using Chebyshev points for interpolation");
figure

semilogy(x_plotted,abs(f - p_func2),'-k')
legend("Error of f(x) and p(x) using Chebyshev points")
ylim([0 1.5])
figure


