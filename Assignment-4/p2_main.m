function y = p2_main(n)
close all;
%%% ======= PART A ======= %%% 
x_start = 1.94;
x_end = 2.07;
delta_x = (x_end - x_start)/n;

func_1= @(x) (x-2)^9;
func_2 = @(x) x^9 - 18*x^8 +144*x^7 -672*x^6 + 2016*x^5 -4032*x^4 + 5376*x^3 - 4608*x^2 + 2304*x -512;

func_1_points = zeros([n,2]);
func_2_points = zeros([n,2]);

for i=1:n+1
    temp = x_start + (i-1)*delta_x;

    func_1_points(i,1) = temp;
    func_1_points(i,2) = func_1(temp);

    func_2_points(i,1) = temp;
    func_2_points(i,2) = func_2(temp);
end

figure(1)
plot(func_1_points(:,1),func_1_points(:,2),'b');
legend("(x-2)^9");

figure(2)
plot(func_2_points(:,1),func_2_points(:,2),'k');
legend("Expanded form");


%%% ======= PART B ======= %%%
a = 1.94;
b = 2.07;
tol = 1e-06;

ans_1 = bisection(func_1,a,b,tol);
ans_2 = bisection(func_2,a,b,tol);

fprintf("\nA root of the simplified function over [1.94,2.07] is: root = %.10f\n",vpa(ans_1));
fprintf("A root of the expanded function over [1.94,2.07] is: root = %.10f\n",vpa(ans_2));
end