function [ x, ex ] = scalar_newton_SOR( f, df, x0, w, a, b, tol, nmax )
%
% NEWTON Newton's Method
%   Newton's method for finding successively better approximations to the 
%   zeroes of a real-valued function.
%
% Input:
%   f - input funtion
%   df - derived input function
%   x0 - inicial aproximation
%   tol - tolerance
%   nmax - maximum number of iterations
%
% Output:
%   x - aproximation to root
%   ex - error estimate
%
% Example:
%	[ x, ex ] = newton( 'exp(x)+x', 'exp(x)+1', 0, 0.5*10^-5, 10 )
%
% Author:	Tashi Ravach
% Version:	1.0
% Date:     16/04/2007
%
    'Commencing Newton Iterations'
    x0
    f
    df
    w
    if nargin == 4
        tol = 1e-4;
        nmax = 1e1;
    elseif nargin == 5
        nmax = 1e1;
    elseif nargin ~= 6
        error('newton: invalid input parameters');
    end
    
    f = inline(f);
    df = inline(df);
    x(1) = x0 - w*(f(x0)/df(x0));
    ex(1) = abs(x(1)-x0);
    k = 2;
    while (ex(k-1) >= tol) && (k <= nmax)          
        x(k) = (1-w)*x(k-1) + w *(( x(k-1) - (f(x(k-1))/df(x(k-1)))));
        ex(k) = abs(x(k)-x(k-1));
        k = k+1;
    end
    if norm(x) > 1e5
        x
    end

    x = x(k-1);
end