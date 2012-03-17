function updatenodeinbox()
% 更新节点显示列表
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10

h_box = findobj('Tag','rvbatch_box');
nodescell = get(h_box,'UserData');

if isempty(nodescell)
    set(h_box,'String','');
    return
end
[str] = rv_get_strings(nodescell);
set(h_box,'String',str);
end

function str = rv_get_strings(nodescell)

addcurlevel(1,0);
str = cell(1,numel(nodescell));
for ii = 1:numel(nodescell)
    str{ii} = [repmat('.   ',1,nodescell{ii}.curlevel) '-' nodescell{ii}.name];
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
