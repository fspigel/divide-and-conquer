function [Q,L] = eig_by_DAC(A, tol)
  [A_tri, Q1] = tridiagonalize(A);
  [Q2, L] = DAC(A_tri, tol);
  Q = Q1'*Q2
endfunction
