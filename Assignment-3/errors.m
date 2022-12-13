function y = errors(tol)
%To compute the trapezoidal, midpoint, and simpsons rule of evaluating the
%integral  

a = 0;
b = pi/2;

func = @(x) exp(2.*x).*sin(x);
actual = integral(func,a,b);

% ==== TRAPEZOIDAL RULE ERROR (WORKING) === %
%Max value of f^2(x) = 3*exp(pi)
n_trap = ceil(sqrt((3*exp(pi)*((b-a)^3))/(12*tol)));
x=0;
trap_integral = 0;
delta_x_trap = (b-a)/n_trap;
for i=1:(n_trap-1)
    x = a +i*delta_x_trap;
    trap_integral = trap_integral + 2*func(x);
end
trap_integral = trap_integral + func(pi/2);
trap_integral = (delta_x_trap/2)*trap_integral;
error_trap = abs(vpa(trap_integral - actual));


% ==== MIDPOINT RULE ERROR === %
% Max value for f^2(x) = 3*exp(pi)
midpoint_integral = a;
n_midpoint = ceil(sqrt((3*exp(pi))*((b-a)^3)/(24*tol)));

delta_x_midpoint = (b-a)/n_midpoint;
for i = 1:n_midpoint
    x1 = a + (i-1)*delta_x_midpoint;
    x2 = a + i*delta_x_midpoint;
    x_evaluator = (x1+x2)/2;
    midpoint_integral = midpoint_integral + func(x_evaluator);
end
midpoint_integral = delta_x_midpoint*midpoint_integral;
error_midpoint = abs(vpa(midpoint_integral - actual));

% ==== SIMPSON RULE ERROR === %

% f^4(x) max = 7*exp(pi) over the domain [a,b]. Please note that the number of
% sub-intervals must be even. 
n_simpson = ceil(((7*exp(pi)*(b-a)^5)/(tol*180))^(1/4))+1;
if mod(n_simpson,2) == 1
    n_simpson = n_simpson +1; % if n_simpson is odd, add 1 to make it even
end
simpson_integral = a;
delta_x_simpson = (b-a)/n_simpson;
for i =1:(n_simpson-1)
    x = 0 +i*delta_x_simpson;
    if (mod(i,2) == 1)
        simpson_integral = simpson_integral + 4*func(x);
    else
        simpson_integral = simpson_integral + 2*func(x);
    end

end

simpson_integral = simpson_integral + func(b);
simpson_integral = (delta_x_simpson/3)*simpson_integral;
error_simpson = abs(vpa(simpson_integral - actual));

% === PRINT STATEMENTS === %
fprintf("tol = %.3e\n",tol);
fprintf("Trapezoid n = %d,\t error = %.6e\n",n_trap,error_trap);
fprintf("Midpoint  n = %d,\t error = %.6e\n",n_midpoint,error_midpoint);
fprintf("Simpson   n =    %d,\t error = %.6e\n",n_simpson,error_simpson);
end