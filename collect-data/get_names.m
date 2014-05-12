function outNames = get_names(dirName)
dirList = dir(dirName);
names = {dirList.name};
outNames = {};
for i = 1 : numel(names)
    name = names{i};
    if ~isequal(name, '.') && ~isequal(name, '..')
        [~, name, ext] = fileparts(names{i});
        outNames{end+1} = [name ext];
    end
end    
end