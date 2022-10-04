function y = expm1mx(x)
j = 20;
%%% Use Taylor series expansion of (e^x - x- 1)x^2
%%% = 1/2 + x/3! + x^2/4! + x^3/5!
y = 1/2;
for (i=1:j)
    y = y + (x.^i)/my_factorial(2+i);
end

%%% Creating a factorial function
    function fact = my_factorial(i)
    if i == 1
        fact = 1;
    else
        fact = i * my_factorial(i-1);
    end
    end
end