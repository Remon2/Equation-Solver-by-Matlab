function y = Validate(str)
% validate as number
str1 = str;
str1 = strrep(str1, '.', '');
str1 = strrep(str1, '-', '');
str1 = strrep(str1, ' ', '');
%length(str1)
S = strtrim(str1);
v = isstrprop(S, 'digit'); 
%v
Lia = ismember(0,v);
 if(Lia == 1)
    y = 0;
 else
    y = 1;
 end
 % '1' if valid
 % '0' if not valid
end