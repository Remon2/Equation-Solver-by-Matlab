function [ arr,xr,time,precision ] = FalseMethod( equation,MaxIter,epsilon ,low,high)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
tic;
xr=low;
curIter=0;
curEpsilon=100;
arr = cell(MaxIter,1);

fLow=replaceByValue(equation,low);
fLowValue=evaluateByValue(fLow);
fUpper=replaceByValue(equation,high);
fUpperValue=evaluateByValue(fUpper);
if  fUpperValue<0 &&fLowValue<0
    xr='Error in initial conditions';
    time=toc;
return ;
else
arr{1}='NumOfIteration                 XLow                     XUpper                         Xr                      Ea ';
while(curEpsilon>epsilon)
    
   
    if  curIter< MaxIter

    xTemp=xr;
    xr=(low*fUpperValue-high*fLowValue)/(fUpperValue-fLowValue);
    fxr=replaceByValue(equation,xr);  
    fxrValue=evaluateByValue(fxr);
    curEpsilon=abs((xr-xTemp)/xr);
    curTemp= curEpsilon*100;
       curIter=curIter+1;
        s=horzcat('-                                ',num2str(curIter),'                    ',num2str( low ),'                        ',num2str(high),'                     ', num2str( xr),'                 ',num2str( curTemp),'%');
    arr{curIter+1}=s;
    if fxrValue>0
        high=xr;
        fUpperValue=fxrValue;
    elseif fxrValue<0
        low=xr;
        fLowValue=fxrValue;
    elseif fxrValue==0
        time=toc;
        precision = 2 - log(abs(curTemp)/0.5);
        return;
    end
      
    else
        time=toc;
        precision = 2 - log(abs(curTemp)/0.5);
        return;
    end
end
end
precision = 2 - log(abs(curTemp)/0.5);
time=toc;
end