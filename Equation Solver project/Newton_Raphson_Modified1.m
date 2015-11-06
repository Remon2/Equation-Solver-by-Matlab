function [array,root,t,precision]=Newton_Raphson_Modified1(fn,iteration , x0,m, epsilon)
tic;
iter = 0;
root = x0;
array = cell(iteration,1);
%array =java.util.ArrayList;
 s=horzcat('Number of iteration','                          ','Xi','                          ','Ea%');   
   array{1} = s;
 error = 100;
 epsilon = epsilon*100;
while (error >epsilon)
    if(iter<iteration)
    oldRoot = root;
     f1=replaceByValue(fn,root);
     fx=evaluateByValue(f1);
     fxDash = differentiate(fn,root);
     root = root -m*(fx/fxDash);
       f1=replaceByValue(fn,root);
     fx=evaluateByValue(f1);
     
      iter =iter+1;
      if(fx ==0)
          
         s=horzcat('-                                ',num2str(iter),'                           ',num2str( root ),'                         ',num2str(0.0000),'%');    
           array{iter+1} = s;
         t = toc;
          precision = 2 - log(abs(error)/0.5);
         return;
     end;
     disp('iteration  ');
     disp(iter);
     disp(' root ');
     disp(root);
     error = abs((((root) -( oldRoot))/(root)))*100;
     disp('relative error = ');
     disp(error); 
     s=horzcat('-                               ',num2str(iter),'                      ',num2str( root ),'                      ',num2str(error),'%');   
     array{iter+1} = s;
    else
        t = toc;
         precision = 2 - log(abs(error)/0.5);
        return;
    end;
end
 precision = 2 - log(abs(error)/0.5);
t = toc;
end