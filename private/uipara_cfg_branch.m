function node = uipara_cfg_branch()
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10


h_box = findobj('Tag','rvbatch_box');
nodescell = get(h_box,'UserData');

parent = selectparent(nodescell);
if isempty(parent)
    return
end

node.myname = genvarname(['branch' datestr(clock, 'HHMMSS')]);
node.parent = parent;


prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义'};
name='Input for branch';
numlines=1;
defaultanswer={'branch Name',genvarname(['branch' datestr(clock, 'HHMMSS')])};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);

node.type = 'branch';
node.name = answer{1};
node.tag  = genvarname(answer{2});
node.children = [];%node.values  = {};
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));



nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
