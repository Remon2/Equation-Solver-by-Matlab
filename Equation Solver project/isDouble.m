function [ output ] = isDouble( str )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if isempty(str)
    output=0;
    return;
end
dot=0;
for i=1:length(str)
    if(str(i)~='-' && str(i)~='0' &&str(i)~='1' &&str(i)~='2' &&str(i)~='3' &&str(i)~='4' &&str(i)~='5' &&str(i)~='6' &&str(i)~='7' &&str(i)~='8' &&str(i)~='9'&&str(i)~='.')
            output=0;
            return;
    end
    if str(i)=='.'
        dot=dot+1;
    end 
end
if dot>1
     output=0;
     return;
end
output=1;
end

