function job = uipara_cfg_const()
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

node.myname = genvarname(['const' datestr(clock, 'HHMMSS')]);
node.parent = parent;


node.type = 'const';
prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义',...
        'Enter the value'};
name='Input for Const';
numlines=1;
defaultanswer={'Const Name',genvarname(['const' datestr(clock, 'HHMMSS')]),'2'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
node.name = answer{1};%char(inputdlg('Displayed Name','Input const.name',1));
node.tag  = genvarname(answer{2});%genvarname(char(inputdlg('This node''s tag','Input const.tag',1)));
if ~isempty(answer{3})
node.val  = eval(answer{3});
end%char(inputdlg('Displayed Name','Input val',1));
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));


nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
