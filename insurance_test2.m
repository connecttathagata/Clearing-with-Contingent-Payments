n = 5;
% System Parameters
x=[80 0 27.5 20 50].';
L0=[0 0 0 0 0;40 0 20 40 0;40 0 0 0 0;40 10 20 0 0;40 0 0 0 0];
Insure = zeros(n,n); Insure(5,4) = L0(2,4)/sum(L0(2,:));
L = @(h,v,q)L0 + h*max(-v(2),0)*Insure;

maxiter = 100;
v = zeros(n,maxiter);

%Applying the Algorithm
for ii = 1:maxiter
    h = (ii-1)/maxiter;
    v(:,ii) = FDA(x,@(v,q)L(h,v,q));
end
plot((0:(maxiter-1))/maxiter , v(1,:));