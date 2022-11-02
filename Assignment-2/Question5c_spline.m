%%Question 5c 
a = 0; 
b = 2;
x = linspace(a,b,15);
y = sqrt(x);

%%p = polyfit(x,y,14)

x_plotted = linspace(a,b,100);
f = sqrt(x);
y_spline = spline(x,f,x_plotted)
f = sqrt(x_plotted)

%PLOT 3
plot(x_plotted,f,"-","LineWidth",2)
hold on
plot(x_plotted,y_spline,":",'LineWidth',3)
legend("f(x)","spline(x)")
ylim([-0.1 1.5])
hold off
%END OF PLOT 3