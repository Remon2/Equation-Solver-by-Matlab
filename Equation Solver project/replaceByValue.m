function [ output ] = replaceByValue( equation,value )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
output='';
value=num2str(value);
equation=lower(equation);
if(isempty(equation))
    output='Empty Function!!!';
    return;
end

for i=1:length(equation)
    if(equation(i)=='x')
        if(i==1 || i==length(equation))
           output=strcat(output,'(',value,')');
        elseif(i>1 && i+1<=length(equation)&& equation(i-1)~='e' && equation(i+1)~='p')
            output=strcat(output,'(',value,')'); 
        else
           output=strcat(output,equation(i));
        end  
    
    elseif(equation(i)~='x')
        
          output=strcat(output,equation(i));
    end
   
        
end