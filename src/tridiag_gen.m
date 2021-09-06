function A = tridiag_gen(n)
  A = rand(n);
  A = triu(A);
  A = A - triu(A,2);
  A = A+A';
  A = A+diag(1:n);
end
