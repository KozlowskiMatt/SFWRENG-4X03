clear all; 

tspan = [0, 100];
y0 = [2, 1]';
a = [-0.1 -199.9; 0 -200];

f = @(t, y) (a*y);

tol= [1e-7];

inc=1;
inc_1=1;
for i=tol
opts = odeset('AbsTol', i, 'Stats','on');
[t, y,st] = ode45(f, tspan, y0, opts);
l=length(t);

avg = vpa((diff(t)));

for i=1:l-1
%avg(inc)= t(i+1)-t(i) ;
tplot(inc)= t(i);
inc=inc+1;
disp(i);
end


end

plot(tplot,avg)
title('Stepsize vs T at tolerance = 10^{-7}')
xlabel("Step");
ylabel("Tolerance");
