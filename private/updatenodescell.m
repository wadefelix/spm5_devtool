function nodescell = updatenodescell(nodescell,node,action)
% 添加或删除结点
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10

if nargin < 3
    action = 'add';
end

switch action
    case 'add'
        nodescell = addnode(nodescell,node);
    case 'del'
        nodescell = delnode(nodescell,node);
end

end
function nodescell = addnode(nodescell,node)
p = node.parent;
pc = findinsertloc(p);
% pc = max(nodescell{p}.children);
% if isempty(pc)
%     pc = p;
% end

numofnodes = numel(nodescell);

for ii = 1:numofnodes
    ppc = nodescell{ii}.parent > pc;
    nodescell{ii}.parent(ppc) = nodescell{ii}.parent(ppc) + 1;
    if isfield(nodescell{ii},'children') && ~isempty(nodescell{ii}.children)
    ppc = nodescell{ii}.children > pc;
    nodescell{ii}.children(ppc) = nodescell{ii}.children(ppc) + 1;
    end
end

for ii = numofnodes : -1 :pc+1
    nodescell{ii+1} = nodescell{ii};
end
nodescell{pc+1} = node;
if isfield(nodescell{p},'children')
nodescell{p}.children = [nodescell{p}.children,pc+1];
else
    nodescell{p}.children = pc+1;
end

function pc = findinsertloc(p)
if isfield(nodescell{p},'children') && ~isempty(nodescell{p}.children)
    pc = findinsertloc(max(nodescell{p}.children));
else
    pc = p;
end
end

end


function nodescell = delnode(nodescell,node)
p = nodescell{node};
if isfield(p,'children') && ~isempty(p.children)
    p.children = sort(p.children,'descend');
    for ii = p.children
        nodescell = delnode(nodescell,ii);
    end
end
if isfield(p,'parent') && ~isempty(p.parent)
nodescell{p.parent}.children(nodescell{p.parent}.children==node) = [];
% else
%     return
end

numofnodes = numel(nodescell);
for ii = node:numofnodes-1
    nodescell{ii} = nodescell{ii+1};
end
nodescell(numofnodes) = [];
for ii = 1:numel(nodescell)
    if isfield(nodescell{ii},'children') && ~isempty(nodescell{ii}.children)
        nodescell{ii}.children(nodescell{ii}.children>node) = nodescell{ii}.children(nodescell{ii}.children>=node) -1;
    end
end
end
