
clear all; 

tspan = [0, 100];
y0 = [2, 1]';
a = [-0.1 -199.9; 0 -200];

f = @(t, y) (a*y);


tol= [1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7,1e-8,1e-9,1e-10,1e-11,1e-12];

inc=1;
for i=tol
opts = odeset('AbsTol', i, 'Stats','on');
%[t, y,st] = ode23s(f, tspan, y0, opts);
[t, y, st] = ode45(f, tspan, y0, opts);

%avg(inc)= vpa(abs((100-0)/length(t)));      % h = (b-a)/n
avgstep(inc)=vpa(mean(diff(t)));   % changed 

st(2)
error_y1(inc)=vpa(abs((exp(-0.1*100)+exp(-200*100))-y(length(y),1)));
error_y2(inc)=vpa(abs(exp(-200*100)-y(length(y),2)));

disp(i);

fun_eval(inc)=st(3);
inc=inc+1;

end

tolerance = tol';
function_iterations=fun_eval';
error_y1_at_t_100=error_y1';
error_y2_at_t_100=error_y2';
average_step_size=avgstep';
output = table(tolerance,function_iterations,error_y1_at_t_100,error_y2_at_t_100,average_step_size)


