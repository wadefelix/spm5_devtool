function node = uipara_cfg_entry()
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

node.myname = genvarname(['entry' datestr(clock, 'HHMMSS')]);
node.parent = parent;


node.type = 'entry';

% 'strtype'
% The type of values that are entered by typing.  e.g. 'e' for evaluated.
% The valid value types are:
%   's'   string
%   'e'   evaluated expression
%   'n'   natural number (1..n)
%   'w'   whole number (0..n)
%   'i'   integer
%   'r'   real number
%   'c'   indicator vector (e.g., 0101... or abab...)
%   'x'   contrast matrix
%   'p'   permutation
typeslong = {'string' 'evaluated expression' 'natural number (1..n)' ...
    'whole number (0..n)' 'integer' 'real number' ...
    'indicator vector (e.g., 0101... or abab...)' 'contrast matrix' ...
    'permutation'};
typeshort = {'s' 'e' 'n' 'w' 'i' 'r' 'c' 'x' 'p'};
[s,v] = listdlg('PromptString','Select the type of this entry',...
                'SelectionMode','single',...
                'ListString',typeslong);
node.strtype = typeshort{s};


prompt={'输入显示名称，建议使用有意义的名字',...
        '输入tag，和上面一样有意义',...
        'Enter the size of the required value, as [1 1]',...
        'Enter the default value'};
name='Input for Entry';
numlines=1;
defaultanswer={'Entry Name',genvarname(['entry' datestr(clock, 'HHMMSS')]),'[1 Inf]',''};
options.Resize='on';
% options.WindowStyle='normal';
% options.Interpreter='none';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);

node.name = answer{1};%char(inputdlg('Displayed Name','Input choice.name',1));
node.tag  = genvarname(answer{2});%genvarname(char(inputdlg('This node''s tag','Input choice.tag',1)));
node.num = eval(answer{3});%[ '[ ' char(inputdlg('Input num','Input num',1)) '];'];
if ~isempty(answer{4})
node.val = eval(answer{4});
end%char(inputdlg('Input val','Input val',1));
node.help = cellstr(char(inputdlg('Help Text','Input help text',30,{'Your Help Text'},options)));

nodescell = updatenodescell(nodescell,node);

set(h_box,'UserData',nodescell);
