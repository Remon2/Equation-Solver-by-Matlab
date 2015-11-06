function [ output ] = plotValidation( equation)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
output='';

equation=lower(equation);
if(isempty(equation))
    output='Empty Function!!!';
    return;
end
i=1;
while i<=length(equation)
    
    if(equation(i)=='x')
        if(i+1<=length(equation)&&equation(i+1)=='^')
           output=strcat(output,'x','.');
        elseif(i+2<=length(equation)&&equation(i+1)==')' && equation(i+2)=='^')
            output=strcat(output,'x',')','.'); 
            i=i+1;
        else
          output=strcat(output,equation(i));  
        end  
    elseif(i+1<=length(equation)&&equation(i)==')' &&equation(i+1)=='^' )
          output=strcat(output,equation(i),'.');
   elseif(equation(i)~='x')
        
          output=strcat(output,equation(i));
    end
    i=i+1;    
end