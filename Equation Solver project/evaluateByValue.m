function [value] = evaluateByValue( equation )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

if strcmp(equation,'Empty Function!!!')==1
    value='Empty Function!!!';
    return
else
    try
        value=eval(equation);
    catch
        value='Error';
    end
end



