function p = selectparent(nodescell)
% 选择父节点
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10
[str ps]= rv_get_strings(nodescell);
[p] = listdlg('PromptString','选择父节点',...
                'SelectionMode','single',...
                'ListString',str);
p = ps(p);
end
function [str ps]= rv_get_strings(nodescell)

addcurlevel(1,0);
% str = cell(1,numel(nodescell));
str = {};
ps = [];
for ii = 1:numel(nodescell)
    switch nodescell{ii}.type
        case {'branch' ,'repeat','choice'}
            str = {str{:},[repmat('.   ',1,nodescell{ii}.curlevel) '-' nodescell{ii}.name]};
            ps = [ps ii];
    end
%     str{ii} = [repmat('.   ',1,nodescell{ii}.curlevel) '-' nodescell{ii}.name];
end


    function addcurlevel(ii,curlevel)
        nodescell{ii}.curlevel = curlevel;
        if isfield(nodescell{ii},'children') && ~isempty(nodescell{ii}.children)
            for I = 1:numel(nodescell{ii}.children)
                addcurlevel(nodescell{ii}.children(I),curlevel+1)
            end
        end
    end


end
