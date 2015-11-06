function co = parsing(str , splitstr )

%C = textscan(str, '%s', 'delimiter', ',');
%tmp = regexp(str,'([^ ,:]*)','tokens');
%C = cat(2,tmp{:});
%splitstr = ',';
co = regexp(str,splitstr,'split');
end