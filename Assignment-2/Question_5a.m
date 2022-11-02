%%Question 5a
a = 0; 
b = 2;
x = linspace(a,b,15);
y = sqrt(x);

p = polyfit(x,y,14)

x_plotted = linspace(a,b,100);
f = sqrt(x_plotted);
p_func2 = polyval(p,x_plotted);

plot(x_plotted,f,"-","LineWidth",2);
hold on
plot(x_plotted,p_func2,":",'LineWidth',3);
legend("f(x)","p(x)");
ylim([0 1.5]);
title("f(x) vs. Interpolation p(x) using polyfit function of degree 14");

