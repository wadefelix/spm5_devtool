function node = uipara_cfg_menu()
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

node.myname = genvarname(['menu' datestr(clock, 'HHMMSS')]);
node.parent = parent;

prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义',...
        'Enter the labels,such as label_1|label_2|label_3',...
        'Enter the values,such as value_1|value_2|value_3,如果非字符串，请最后手动更改'};
name='Input for Menu';
numlines=1;
defaultanswer={'Menu Name',genvarname(['menu' datestr(clock, 'HHMMSS')]),'label_1|label_2|label_3','1|2|3'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);

node.type = 'menu';
node.name = answer{1};%char(inputdlg('Displayed Name','Input menu.name',1));
node.tag  = genvarname(answer{2});%genvarname(char(inputdlg('This node''s tag','Input menu.tag',1)));
node.labels  = answer{3};%char(inputdlg('Displayed Name','Input labels',1));
node.values = answer{4};%eval(answer{4});%char(inputdlg('Displayed Name','Input values',1));
defaulthelp = {'Your Help Text','values的值都被当作字符串了','如果字符串类型的values值不是您想要的，请进行修改'};
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{sprintf('%s\n',defaulthelp{:})},options)));

nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
