function x = LUPartialPivoting(A)
[n, t] = size(A); 
B = A;

for u = 1: n-1    
maximum = abs(B(u, u)); 
r = u;
    for i = u+1: n
        if maximum < abs(B(i, u))
            maximum =abs(B(i,u)); 
            r = i;
        end
    end

row1(1,:) = B(r,:); 
row2(1,:) = B(u,:);
B(u,:) = row1; 
B(r,:) = row2;

for k = u+1: n; 
    m = B(k,u)/B(u,u);
    for j = u: t; 
       B(k,j) = B(k,j) - m * B(u,j); 
    end
     B(k,u)=m;   %
end

i = n; x(i,1) = B(i,t) / B(i,i);

for i = 1:1:n-1;
    s = 0;
    for k = 1: 1: i-1; 
        s = s + B(i, k) * x(k); 
    end
 x(i,1)=(B(i,t)-s)/B(i,i); 
end;

for i = n-1: -1: 1; 
    s = 0;
    for k = n: -1: i+1; 
        s = s + B(i, k) * x(k); 
    end
    x(i) = (B(i,t)-s) / B(i,i); 
end; 

end