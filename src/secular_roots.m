function x = secular_roots(rho, d, u, tol)
    n = size(d,1);
    x = zeros(n, 1);
    f = '1 ';
    df = '';

    rho
    d;
    u
    sort_d = sort(d);
    
    %generate scalar function as string
    for i=1:n
        current_u = rho*u(i)^2;
        current_d = d(i);
        f = strcat(f, ' + ', num2str(current_u), '/(', num2str(current_d), ' - x)');
        df = strcat(df, ' + ', num2str(current_u), '/(', num2str(current_d), ' - x)^2');
    end
    f
    %find all roots between two neighboring poles
    for i=1:n-1
        a = sort_d(i);
        b = sort_d(i+1);
        x(i) = binary_root_search(f, a, b, tol, n*10); 
%        x0 = (d(i)+d(i+1))/2;
%        x(i) = newton(f, df, x0, tol, 20);
    end
    
    %find the 'outlying' root
    if rho < 0
      %find a such that f(a) > 0
      b = sort_d(1);
      a = sort_d(1) - 1;
      ff = inline(f);
      k = 1;
      while true
        if(ff(a) < 0)
          k = k*2;
          b = a;
          a = a-k;
        else
          x(2:n) = x(1:n-1);
          x(1) = binary_root_search(f, a, b, tol, n*10);
          break;
        end
      end
      
    else
      %find b such that f(b) > 0
      b = sort_d(n) + 1;
      a = sort_d(n);
      ff = inline(f);
      k = 1;
      while true
        if ff(b) < 0
          k = k*2;
          a = b;
          b = b+k;
        else
          x(n) = binary_root_search(f, a, b, tol, n*10);
          break;
        end
      end
    end
end

%1 +0.26208/(1.3377 - x) +0.26208/(2.5923 - x)
%0.26208/(1.3377 - x)^2 +0.26208/(2.5923 - x)^2
%1.9650