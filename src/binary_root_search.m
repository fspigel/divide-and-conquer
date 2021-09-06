% Binary Root Search implementation
%
% INPUT:
%   f - a continuous, monotonic function with
%       at least one root in the interval <a, b>
%       f need not be continuous over [a,b]
%   a - left-hand boundary of the search
%   b - right-hand boundary of the search
%   tol - accuracy tolerance: the process stops when |f(x0)| < tol
%   kmax - maximum number of iterations - if reached, algorithm stops 
%

function x0 = binary_root_search(f_string, a, b, tol, kmax)
    %determine a1, b1 such that
    % - f is continuous over closed interval [a, b]
    % - f has a root in that interval
    d = (b-a)/2;
    a1 = b;
    b1 = a;
    f = inline(f_string);
    k=0;
    while k < kmax
      k = k + 1;
      a0 = a1;
      b0 = b1;
      a1 = a1 - d;
      b1 = b1 + d;
      if f(a+d) * f(b-d) < 0
        a1 = a+d;
        b1 = b-d;
        break;
      end
      d = d/2;
    endwhile
    [a1,b1];
    %correct f into an increasing monotonic function
    if f(a1) > f(b1)
      f = inline(['-1 * (' f_string ')']);
    end
    %commence binary search
    for k = 1:kmax
      x0 = (a1+b1)/2;
      if abs(f(x0)) < tol
        return;
      end
      
      if f(x0) < 0
        a1 = x0;
      else
        b1 = x0;
      endif
    endfor
    abs(f(x0));
end