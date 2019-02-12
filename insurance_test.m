n = 5;

%System Parameters
x=[80 0 10 20 50].';
L0=[0 0 0 0 0;40 0 20 0 0;40 0 0 0 0;40 10 20 0 0;40 0 0 0 0];
Insure = zeros(n,n); Insure(5,2) = 1;
L = @(h,v)L0 + h*max(-v(2),0)*Insure;

maxiter = 10;
v = zeros(n,maxiter);

%Applying the Algorithm
for ii = 8
    h = (ii-1)/maxiter;
    v(:,ii) = FDA_Insurance(x,@(v)L(h,v));
end
plot((0:(maxiter-1))/maxiter , v(1,:));