function [array,root,t,precision]=Newton_Raphson(fn,iteration , x0, epsilon)
tic;
iter = 0;
root = x0;
%array =java.util.ArrayList;
array = cell(iteration,1);
 s=horzcat('Number of iteration','      ','Xi','      ','Ea%');    
 array{1}=s;
 error = 100;
 epsilon = epsilon*100;
while (error >epsilon)
    if(iter<iteration)
    oldRoot = root;
     f1=replaceByValue(fn,root);
     fx=evaluateByValue(f1);
     fxDash = differentiate(fn,root);
     root = root -(fx/fxDash);
      f1=replaceByValue(fn,root);
      fxo=evaluateByValue(f1);
      if(fxo == 0)
         t = toc;
         precision = 2 - log(abs(error)/0.5);
          return;
      end;
      iter =iter+1;
     disp('iteration  ');
     disp(iter);
     disp(' root ');
     disp(root);
     error = abs(((root - oldRoot)/root))*100;
     disp('relative error = ');
     disp(error); 
     s=horzcat('-                      ',num2str(iter),'         ',num2str( root ),'        ',num2str(error),'%');    
     array{iter+1}=s;
    else
        t = toc;
         precision = 2 - log(abs(error)/0.5);
        return;
    end
end
 precision = 2 - log(abs(error)/0.5);
t = toc;
end