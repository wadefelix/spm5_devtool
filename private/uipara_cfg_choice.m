function node = uipara_cfg_choice()
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

node.myname = genvarname(['choice' datestr(clock, 'HHMMSS')]);
node.parent = parent;


prompt={'������ʾ���ƣ�����ʹ�������������',...
        '����tag��������һ��������'};
name='Input for choice';
numlines=1;
defaultanswer={'Choice Name',genvarname(['choice' datestr(clock, 'HHMMSS')])};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);

node.type = 'choice';
node.name = answer{1};
node.tag  = genvarname(answer{2});
node.children = [];%node.values  = {};
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));



nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
