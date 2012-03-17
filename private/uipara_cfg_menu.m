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

prompt={'������ʾ���ƣ�����ʹ�������������',...
        '����tag��������һ��������',...
        'Enter the labels,such as label_1|label_2|label_3',...
        'Enter the values,such as value_1|value_2|value_3,������ַ�����������ֶ�����'};
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
defaulthelp = {'Your Help Text','values��ֵ���������ַ�����','����ַ������͵�valuesֵ��������Ҫ�ģ�������޸�'};
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{sprintf('%s\n',defaulthelp{:})},options)));

nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
