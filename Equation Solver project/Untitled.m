function Untitled(str)
% validate as number
str1 = str;
str1 = strrep(str1, '.', '');
str1 = strrep(str1, '-', '');
global v
v = isstrprop(str1, 'digit'); 
end

