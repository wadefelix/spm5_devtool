function node = uipara_cfg_files()
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

node.myname = genvarname(['files' datestr(clock, 'HHMMSS')]);
node.parent = parent;


prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义',...
        'Enter the size of the required value, as [1 1]',...
        'Enter the filter, any|image|dir|mat|xml|batch or Other strings act as a filter to regexp.',...
        'Enter the ufilter,user-editable filter'};
name='Input for Files';
numlines=1;
defaultanswer={'Files Name',genvarname(['files' datestr(clock, 'HHMMSS')]),'[1 Inf]','any','.*'};
options.Resize='on';
% options.WindowStyle='normal';
% options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);

node.type = 'files';
node.name = answer{1};
node.tag  = genvarname(answer{2});
node.filter = answer{4};
node.ufilter = answer{5};
node.num = eval(answer{3});%char(inputdlg('Displayed Name','Input num',1));
% node.children = [];%node.values  = {};
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));



nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
