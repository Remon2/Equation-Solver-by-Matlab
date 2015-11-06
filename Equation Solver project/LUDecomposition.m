function x = LUDecomposition(A)

[n,t] = size(A); 
B = A;

for k = 1: n-1; 
    for i = k: n-1; 
        m =  B(i+1,k)/B(k,k);
        for j= 1:t; 
            B(i+1,j) = B(i+1,j) - m*B(k,j);
        end
        B(i+1,k)=m;   %
    end
end


if B(i,i) == 0

   x='This system has no solutions!!';
    return;
end

i = n; x(i,1) = B(i,t)/B(i,i);

for i = 1:1:n-1;
    s = 0;
    for k = 1: 1: i-1; 
        s = s + B(i, k) * x(k, 1); 
    end
    
if B(i,i) == 0

    x= 'This system has no solutions!!';
    return;
end
    
 x(i,1)=(B(i,t)-s)/B(i,i); 
end;

for i = n-1:-1:1;
    s = 0;
    for k = n: -1: i+1; 
        s = s + B(i, k) * x(k, 1); 
    end
 x(i,1)=(B(i,t)-s)/B(i,i); 
end;

end
