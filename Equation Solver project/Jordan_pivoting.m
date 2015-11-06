function x = Jordan_pivoting(A)
[n,t] = size(A);
B = A;
 for k=1:n
    for i=1:n
      if i ~= k
        item = B(i,k);
        scale = B(k,k);
        
         if scale == 0
           for o =1:n
              if o ~= k
               if B(o,k) ~= 0
                   for ti=1:t
                       %%swap
                       yt = B(o,ti);
                       B(o,ti) = B(k,ti);
                       B(k,ti) = yt;
                   end
                   item = B(i,k);
                   scale = B(k,k);
                   break;
               end
              end
           end
         end
         disp('aaaaaaaaaaaaaaa');
          B
        for j=1:t
          %scalling
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
