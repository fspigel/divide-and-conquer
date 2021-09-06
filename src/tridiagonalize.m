function [A, P] = tridiagonalize(A)
  n = size(A,1);
  P = eye(n);
  for i = 1:n-2
    P_current = householder_generator(A,i);
    A = P_current*A*P_current';
    P = P_current*P;
  endfor
  for i = 1:n
    for j = 1:n
      if abs(A(i,j)) < 1e-12
        A(i,j) = 0;
      endif
    endfor
  endfor
endfunction
