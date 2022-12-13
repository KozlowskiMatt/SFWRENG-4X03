function netbp_full
%NETBP_FULL
%   Extended version of netbp, with more graphics
%
%   Set up data for neural net test
%   Use backpropagation to train 
%   Visualize results
%
% C F Higham and D J Higham, Aug 2017
%

clear all;
data=load('dataset.mat');       
x1 = (data.X(:,1))';              % store x1 values
x2 = data.X(:,2 )';               % store x2 values
y = (data.Y)';                    % store y values

global totalrows
totalrows= length(data.X);       % total number of rows

figure(1)
clf
a1 = subplot(1,1,1);
plot(x1(1:totalrows/2),x2(1:totalrows/2),'ro','MarkerSize',12,'LineWidth',4)   % update range
hold on
plot(x1(totalrows/2+1:totalrows),x2(totalrows/2+1:totalrows),'bx','MarkerSize',12,'LineWidth',4)
a1.XTick = [0 1];
a1.YTick = [0 1];
a1.FontWeight = 'Bold';
a1.FontSize = 16;
xlim([0,1])
ylim([0,1])

%print -dpng pic_xy.png

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize weights and biases 
rng(5000);
W2 = 0.5*randn(4,2); % from 2 -> 4
W3 = 0.5*randn(4,4); % from 2 -> 4
W4 = 0.5*randn(2,4);
b2 = 0.5*randn(4,1);
b3 = 0.5*randn(4,1);
b4 = 0.5*randn(2,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forward and Back propagate 
% Pick a training point at random


eta = 0.38; %0.37 0.39 0.4 0.41 
Niter = 1e6;

accuracy_history= zeros(Niter,1);
counter_value = 0;

savecost = zeros(Niter,1);
for counter = 1:Niter
    k = randi(totalrows);   
    x = [x1(k); x2(k)];
    % Forward pass
    a2 = activate(x,W2,b2);
    a3 = activate(a2,W3,b3);
    a4 = activate(a3,W4,b4);
    % Backward pass
    delta4 = a4.*(1-a4).*(a4-y(:,k));
    delta3 = a3.*(1-a3).*(W4'*delta4);
    delta2 = a2.*(1-a2).*(W3'*delta3);
    % Gradient step
    W2 = W2 - eta*delta2*x';
    W3 = W3 - eta*delta3*a2';
    W4 = W4 - eta*delta4*a3';
    b2 = b2 - eta*delta2;
    b3 = b3 - eta*delta3;
    b4 = b4 - eta*delta4;
    % Monitor progress
    [newcost,accuracy]= cost(W2,W3,W4,b2,b3,b4)   % display cost to screen
   
    accuracy_history(counter)= accuracy;
    savecost(counter) = newcost;
    if accuracy >= 0.97
        counter_value = counter % to state the final counter value
        break;
    end
disp(counter)
end
figure(2)
clf
semilogy([1:1e4:Niter],savecost(1:1e4:Niter),'b-','LineWidth',2)
xlabel('Number of iterations')
ylabel('Value of cost function')
title("Value of cost function vs Number of iterations")
%set(gca,'FontWeight','Bold','FontSize',18)
print -dpng pic_cost.png

%%%%%%%%%%% Display shaded and unshaded regions 
N = 500;
Dx = 1/N;
Dy = 1/N;
xvals = [0:Dx:1];
yvals = [0:Dy:1];
for k1 = 1:N+1
    xk = xvals(k1);
    for k2 = 1:N+1
        yk = yvals(k2);
        xy = [xk;yk];
        a2 = activate(xy,W2,b2);
        a3 = activate(a2,W3,b3);
        a4 = activate(a3,W4,b4);
        Aval(k2,k1) = a4(1);
        Bval(k2,k1) = a4(2);
     end
end
[X,Y] = meshgrid(xvals,yvals);

figure(3)
clf
a2 = subplot(1,1,1);
Mval = Aval>Bval;
contourf(X,Y,Mval,[0.5 0.5])
hold on
colormap([1 1 1; 0.8 0.8 0.8])
plot(x1(1:totalrows/2),x2(1:totalrows/2),'ro','MarkerSize',12,'LineWidth',4)
plot(x1(totalrows/2+1:totalrows),x2(totalrows/2+1:totalrows),'bx','MarkerSize',12,'LineWidth',4)
a2.XTick = [0 1];
a2.YTick = [0 1];
a2.FontWeight = 'Bold';
a2.FontSize = 16;
xlim([0,1])
ylim([0,1])

print -dpng pic_bdy_bp.png


figure(4)
clf
semilogy([1:1e4:Niter],accuracy_history(1:1e4:Niter),'b-','LineWidth',2);
xlabel("Number of iterations");
ylabel("Accuracy");
title("Accuracy vs Number of iterations");

  function [costval,accuracy]= cost(W2,W3,W4,b2,b3,b4)
        
     count=0;    
     costvec = zeros(totalrows,1); 
     for i = 1:totalrows
         x =[x1(i);x2(i)];
         a2 = activate(x,W2,b2);
         a3 = activate(a2,W3,b3);
         a4 = activate(a3,W4,b4);
         costvec(i) = norm(y(:,i) - a4,2);
         % Check varaince between input and output
         if (y(1,i) < y(2,i)) && (a4(1)<a4(2))  
             count = count+1;
         elseif (y(1,i) > y(2,i)) && (a4(1)>a4(2))
             count = count+1;
         end
     end
     costval = norm(costvec,2)^2;
     accuracy = count/totalrows;       %  calculate accuracy
   end % of nested function
                                                
% row ,col
end