function [c,k] = error_trapz(f,a,b)
% calculate the error in ch^k using the trapezoidal rule
actual = integral(f,a,b)
n_1 = 10000;
n_2 = 15000;

syms c_1 c_2 k_10 k_20

h_1 = (b-a)/n_1;
h_2 = (b-a)/n_2;

X_1 = a:h_1:b;
X_2 = a:h_2:b;

temp_1 = f(X_1);
temp_2 = f(X_2);

trap_1 = trapz(X_1,temp_1);
trap_2 = trapz(X_2,temp_2);

error_1 = actual -trap_1;
error_2 = actual - trap_2;

%Develop System of equations (method 1)
Y_1 = log(error_1) == k_10*log(c_1*h_1);
Y_2 = log(error_2) == k_10*log(c_1*h_2);

%Develop System of equations (method 2)
Y_3 = error_1 == c_2*(h_1)^k_20;
Y_4 = error_2 == c_2*(h_2)^k_20;

Y_LOG = [Y_1,Y_2];
Y_EXP = [Y_3,Y_4];

A_LOG = solve(Y_LOG,[k_10,c_1]);%% Method 1
A_EXP = solve(Y_EXP,[k_20,c_2]); %% Method 2

c = A_LOG.c_1;
k = A_LOG.k_10;

end