function v = FDA_Insurance(x,L)

%Problem Parameters
tol = 1e-8;
n = length(x);
pbar = @(v)sum(L(v),2);
A = @(v)diag(max(pbar(v) , tol))\L(v); %Relative Liabilities

k = 1;
D = zeros(n,1);
zn = zeros(n,1);
v = x + A(zn).'*pbar(zn) - pbar(zn);%Wealth

while 1 %Fixed Point Iterations
    k = k + 1;
    if isequal(D , v < tol)
        break
    end
    D = (v < tol);
    Lam = diag(D);
    vhat = v;

    v0 = vhat - 2*tol;
    while norm(vhat - v0) >= tol
        v0 = vhat;
        vhat = x + A(Lam*v0).'*max(pbar(Lam*v0) + Lam*v0 , 0) - pbar(Lam*v0);
    end
    v = vhat;
end

if max(abs(v - (x + A(v).'*max(pbar(v) + min(v , 0) , 0) - pbar(v)))) > tol
    keyboard
end