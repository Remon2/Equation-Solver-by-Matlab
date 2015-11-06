function [array,root,t,precision]=  Fixed_Point(fn , iteration , epsilon,x0)
 iter = 0;
 root = x0;
 error=100;
 tic;
array = cell(iteration,1);
 s=horzcat('Number of iteration','                         ','Xi','                          ','Ea%');    
 array{1}=s;
 epsilon = epsilon*100;
 while (error>epsilon &&iter<iteration)
     oldRoot=root;
     f1=replaceByValue(fn,root);
     root=evaluateByValue(f1);
     iter =iter+1;
      s=horzcat('-                            ',num2str(iter),'                      ',num2str( root ),'                    ',num2str(error),'%');    
     array{iter+1}=s;
      f1=replaceByValue(fn,root);
      fx=evaluateByValue(f1);
     if(fx ==0)
         t = toc;
          precision = 2 - log(abs(error)/0.5);
         return;
     end;
     disp('iteration  ');
     disp(iter);
     disp(' root ');
     disp(root);
     error = abs(((root - oldRoot)/root))*100;
     disp('relative error = ');
     disp(error);   
 end
 precision = 2 - log(abs(error)/0.5);
 t = toc;
end