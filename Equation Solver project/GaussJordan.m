function x = GaussJordan(A)
[n,t] = size(A);
B = A;
 for k=1:n
    for i=1:n
      if i ~= k
        item = B(i,k);
        scale = B(k,k);
        for j=1:t
          %scalling
          if scale == 0
            x='This system has no solutions!!';
            return;
          end
          B(k,j)=B(k,j)/scale;
         
          %change row
          B(i,j)= B(i,j)-item*B(k,j);
        end
      end
    end
 end
 for u=1:n
     x(u)=B(u,t);
 end
end