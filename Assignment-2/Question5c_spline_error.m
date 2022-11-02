a = 0; 
b = 2;
x = linspace(a,b,15);
y = sqrt(x);

%%p = polyfit(x,y,14)

x_plotted = linspace(a,b,100);
f = sqrt(x);
y_spline = spline(x,f,x_plotted)
f = sqrt(x_plotted)

semilogy(x_plotted,abs(f - y_spline),'-k')
legend("error of f(x) and p(x)")
ylim([0 1.5])