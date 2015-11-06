function [ arr,xThird,time,precision ] = Secant( equation,MaxIter,epsilon,xFirst,xSecond )
tic;
xThird=0;
curIter=0;
curEpsilon=100;
curtemp=100;
arr = cell(MaxIter,1);
arr{1}='Number OfIteration         Xi-1          Xi           Xi+1         Ea ';
while(curEpsilon>epsilon )
    if(curIter<MaxIter)
    f1=replaceByValue(equation,xFirst);
    f1Value=evaluateByValue(f1);
    f2=replaceByValue(equation,xSecond);
    f2Value=evaluateByValue(f2);
    xDiff=xFirst-xSecond;
    if((f1Value-f2Value)==0)
          time = toc;
           precision = 2 - log(abs(curtemp)/0.5);
         return;
     end;
    xThird=xSecond-((f2Value*xDiff)/(f1Value-f2Value));
     curEpsilon=abs((xThird-xSecond)/xThird);
     curtemp=curEpsilon*100;
     
    xFirst=xSecond;
    xSecond=xThird;
    curIter=curIter+1;
      s=horzcat('-                           ',num2str(curIter),'                 ',num2str( xFirst ),'            ',num2str(xSecond),'               ', num2str( xThird),'                   ',num2str( curtemp),'%');
    arr{curIter+1}=s;
     f1=replaceByValue(equation,xThird);
     fx=evaluateByValue(f1);
     
     if(fx ==0)
         time = toc;
          precision = 2 - log(abs(curtemp)/0.5);
         return;
     end;
    else
        time = toc;
         precision = 2 - log(abs(curtemp)/0.5);
        return;
    end
end
time=toc;
 precision = 2 - log(abs(curtemp)/0.5);

end