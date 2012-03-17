function job = uipara_cfg_job(node)
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10


h_box = findobj('Tag','rvbatch_box');
if isempty(h_box)
    h_box = uicontrol(findobj('tag','UIconfigwindow'),'Style','listbox','Units','normalized','Position',[0.45 0.1 0.5 0.832],'Tag','rvbatch_box','fontsize',12);
end

% job = get(h_box,'UserData');
job.myname = 'job';%genvarname(answer{2});
job.parent = [];


prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义'};
name='Input for Job';
numlines=1;
defaultanswer={genvarname(['Sample Job' datestr(clock, 'yymmdd')]),genvarname(['job' datestr(clock, 'HHMMSS')])};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
if isempty(answer)
    return
end

job.type = 'branch';
job.name = answer{1};
job.tag  = genvarname(answer{2});
job.children = [];%job.val  = {};
job.prog = (['@execute_',job.tag]);
job.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));


nodescell = {job};

set(h_box,'UserData',nodescell);

