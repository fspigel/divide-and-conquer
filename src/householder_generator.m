function P = householder_generator(A, k)
  if(norm(A(k,1:k-2))+norm(A(k,k+2:end))<1e-8)
    P=eye(size(A,1));
    return;
  end
  
  n = size(A,1);
  a = A(k+1,k);
  sign_a = sign(a);
  if sign_a == 0
    sign_a = 1;
  end
  
  alpha = -1 * sign_a * sqrt(sum(A(k+1:end,k).^2));
  r = sqrt((alpha^2 - a*alpha)/2);
  v = zeros(n,1);
  k
  r
  A(k,:)
  v(k+1) = (a-alpha)/(2*r);
  for j = k+2:n
    v(j) = A(j,k)/(2*r);
  endfor
  P = eye(n) - 2*v*v';
endfunction
