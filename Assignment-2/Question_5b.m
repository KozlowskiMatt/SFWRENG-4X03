%%Question 5b
a = 0; 
b = 2;
x = linspace(a,b,15);
y = sqrt(x);

p = polyfit(x,y,14)

x_plotted = linspace(a,b,100);
f = sqrt(x_plotted);
p_func2 = polyval(p,x_plotted);

semilogy(x_plotted,abs(f - p_func2),'-k')
legend("error of f(x) and p(x)")
ylim([0 1.5])