clc;
clear all;
close all;

x = [0.1:1/22:1];
d = (1+0.6*sin(2*pi*x/0.7)+0.3*sin(2*pi*x))/2;
 w11 = randn(1);
 w12 = randn(1);

w1 = [w11 randn(1) randn(1) randn(1) randn(1)];
w2 = [w12 randn(1) randn(1) randn(1) randn(1)];
b = [randn(1) randn(1) randn(1) randn(1) randn(1)];
b1 = randn(1);

niu = 0.1;

 v_1 = w1(1)*x(1)+ b(1);
 y_1 = 1/(1+exp(-v_1));
 e = d(1) - y_1;

while abs(e) >=  0.1
for n = 1:length(x)
    for i = 1:length(w1)
   v1 = w1(i)*x(n)+b(i);
   y1(i) = 1/(1+exp(-v1));
    end
    v2 = b1;
for g = 1:length(w2)
   v2 =v2+y1(g)*w2(g);
end
   e = d(n) - v2;
    b1 = b1 + niu*e; 
   for z=1:length(w2)
      w2(z) = w2(z)+niu*e*y1(z);
      b(z) = b(z) + niu*e;  
      w1(z) = w1(z)*niu*sig(y1(z),w2(z),e)*x(n);
   end
end
end

% TIKRINIMAS
yy = [];
for n = 1:length(x)
    for i = 1:length(w1)
   v1 = w1(i)*x(n)+b(i);
   y2(i) = 1/(1+exp(-v1));
    end
    v2 = b1;
for z = 1:length(w2)
v2 = y2(i)*w2(i);
end
    yy = [yy v2];
end

figure(1)
    plot(x,d,'*',x,d,'blue',x,d+yy,'o',x,d+yy,'red'); grid on;
    legend('Data','Pries apmokyma','Data','Po apmokymo');

function y = sig(y1,w2,e)
y = y1*(1-y1)*e*w2;
end