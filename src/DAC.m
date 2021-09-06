function [Q, L] = DAC(T, tol)
  n = size(T,1);
  Q = zeros(size(T));
  L = zeros(size(T));
  T
  if n == 1
    Q = 1;
    L = T;
    return;
  end
  
  m = round(n/2);
  bm = T(m, m+1);
  
  T1 = T(1:m, 1:m);
  T2 = T(m+1:n, m+1:n);
  
  T1(m, m) = T1(m, m) - bm;
  T2(1, 1) = T2(1, 1) - bm;
  
  [Q1, L1] = DAC(T1, tol);
  [Q2, L2] = DAC(T2, tol);
  
  u = zeros(n, 1);
  u(1:m) = Q1(m, :)';
  u(m+1:n) = Q2(1, :)';
  B = bm*(u*u');
  
  Q(1:m, 1:m) = Q1;
  Q(m+1:n, m+1:n) = Q2;
  
  D = zeros(size(T));
  D(1:m, 1:m) = L1;
  D(m+1:n, m+1:n) = L2;
  
  d = diag(D);
  %check if u(i) = 0 for any i
  L_status = zeros(n,1);
  counter = 0;
  i = 1;
  size(u)
  u
  while i <= n-counter
    'beep'
    sign(u(i)^2-tol)
    bm;
    u(i)
    bm*u(i);
    if abs(u(i)^2) < tol
      'boop'
      u(i)
      L_status(i+counter) = 1;
      L(i+counter,i+counter) = d(i);
      u(i) = [];
      d(i) = [];
      i = i-1;
      counter = counter+1;
    end
    i = i+1
  end
  size(u)
  u
  i = 1;
  while i < n-1-counter
    if d(i) == d(i+1)
      'beep'
      L_status(i+counter) = 2;
      L(i+counter,i+counter) = d(i);
      u(i) = [];
      d(i) = [];
      i = i-1;
      counter = counter+1;
    end
    i = i+1;
  end
  size(u)
  u
  
  sroots = secular_roots(bm, d, u, 1e-10);
  counter = 1;
  for i = 1:n
    if L_status(i) == 0
      L(i,i) = sroots(counter);
      counter = counter + 1;
    end
  end
  
  %L = diag(scalar_roots(bm, diag(D), u, 1e-10));
  
  Q2 = zeros(n);
  %(D-L(i)*eye(n))\u
  
  for i = 1:n
    %Q2(:,i) = (D-L(i)*eye(n))\u;
  end
  
  [Q2, ~] = eig(D+B);
  
  Q = Q*Q2;
  
  n
  norm(T-Q*L*Q')
end