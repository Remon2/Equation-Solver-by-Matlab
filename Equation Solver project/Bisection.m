function [array,xr,t,therError,precision] = Bisection(fn,iteration,xl,xu,epsilon)
tic;
 xr =0;
array = cell(iteration,1);
diff = xu-xl;
low = xl;
 s=horzcat('Number of iteration','                       ','Xl','                           ','Xu','                         ','Xr','                         ','Ea%');    
 array{1}=s;
  f1=replaceByValue(fn,xl);
 fxl=evaluateByValue(f1);
 if(fxl==0)
     xr =xl;
     t=toc;
     therError = diff/(xl);
     precision=0;
     return;
 end
 f1=replaceByValue(fn,xu);
 fxu=evaluateByValue(f1);
 if(fxu==0)
     xr =xu;
     t=toc;
     therError = diff/(xl);
     precision=0;
     return;
 end
 error=5;
 iter = 0;
 oldRoot=0;
 epsilon = epsilon*100;
 while (error>epsilon)
     if iter<iteration
          oldRoot = xr;
         xr = (xl+xu)/2;
         arr1(iter+1) = xl;
         arr2(iter+1) = xu;
         arr3(iter+1) = xr;
         f1=replaceByValue(fn,xl);
         fxl=evaluateByValue(f1);
         f2=replaceByValue(fn,xr);
         fxr=evaluateByValue(f2);
              a=abs(xr-oldRoot);
              b=abs(a/xr);
              error=b*100;
              disp('relative error = ');
              disp(error); 
          iter =iter+1;
            s=horzcat('-                       ',num2str(iter),'                        ',num2str( xl ),'                   ',num2str(xu),'                      ',num2str(xr),'                    ',num2str(error),'%');
          array{iter+1}=s;
         if(fxr ==0)
             therError = diff/((2^iter)*low);
              fid1 = fopen('arr1.txt','w');
             fprintf(fid1,'%0f\n',arr1);
             fid2 = fopen('arr2.txt','w');
             fprintf(fid2,'%0f\n',arr2);
             fid3 = fopen('arr3.txt','w');
             fprintf(fid3,'%0f\n',arr3);
             fid4 = fopen('eq.txt','w');
             fprintf(fid4,'%0s\n',fn);
             precision = 2 - log(abs(error)/0.5);
             t=toc;
             return;
         elseif (fxr*fxl <0)
             xu = xr;
         else
             xl = xr;
         end
          disp('iteration  ');
          disp(iter);
         
     else
         t = toc;
         therError = diff/((2^iter)*low);
          fid1 = fopen('arr1.txt','w');
            fprintf(fid1,'%0f\n',arr1);
             fid2 = fopen('arr2.txt','w');
         fprintf(fid2,'%0f\n',arr2);
            fid3 = fopen('arr3.txt','w');
         fprintf(fid3,'%0f\n',arr3);
         fid4 = fopen('eq.txt','w');
         fprintf(fid4,'%0s\n',fn);
         precision = 2 - log(abs(error)/0.5);
         return;
     end;
 end;
 fid1 = fopen('arr1.txt','w');
 fprintf(fid1,'%0f\n',arr1);
 fid2 = fopen('arr2.txt','w');
 fprintf(fid2,'%0f\n',arr2);
 fid3 = fopen('arr3.txt','w');
 fprintf(fid3,'%0f\n',arr3);
 fid4 = fopen('eq.txt','w');
 fprintf(fid4,'%0s\n',fn);
 therError = diff/((2^iter)*low);
 precision = 2 - log(abs(error)/0.5);
 t = toc;
end