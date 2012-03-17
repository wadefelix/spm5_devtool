function makecodes()
% ���ɴ���
% Generate the codes
% -----------------------------------------------
% Copyright (C) 2008

% Ver: 20080910
% WadeFelix RenV, 2008-09-10


h_box = findobj('Tag','rvbatch_box');
nodescell = get(h_box,'UserData');

if isempty(nodescell)
    return
end

codestr = {};
for ii = numel(nodescell):-1:1
    str = job2str(nodescell{ii});
    codestr = {codestr{:} str{:}};
end

% ����������ͷ
fstr = {['function ' nodescell{1}.myname ' = lsrc_config_' genvarname(nodescell{1}.name) '()'],...
    '% ���ú���'};
codestr = {fstr{:} codestr{:}};
% ����Ӻ���(���ݴ�����)ͷ,����������Ҫ���Լ�д
subfstr = {['function ' 'execute_' nodescell{1}.tag '(job)'],...
    '% �������ݵĺ���,��Ҫ���Լ�����д',...
    '% ���Ȱ���һ��ע�ͼ�������һ��,�Ϳ��Կ���job�����е�����',...
    '% save job.mat job;'...
    };

try
helpstr = makehelptext(1,{''});
    for ih = 1:numel(helpstr)
    if ischar(helpstr{ih})
    helpstr{ih} = ['%�����ο� ' helpstr{ih}];
    elseif iscellstr(helpstr{ih})
        helpstr{ih} = sprintf('%%�����ο� %s\n', helpstr{ih}{:});
    end

    end
    helpstr = sprintf('%s\n', helpstr{:});
catch
    helpstr = '%helpU';
end
codestr = { codestr{:} '' subfstr{:}  '' helpstr ''};
codestr = sprintf('%s\n', codestr{:});

fname = fullfile(spm('Dir'),'toolbox',['lsrc_config_' genvarname(nodescell{1}.name) '.m']);
if exist(fname,'file') && ~strcmpi(questdlg({'�����ļ�',fname,'�Ƿ��滻ԭ�ļ�?'},'�滻ԭ�ļ�?'),'yes')
    return
end
fid = fopen(fname,'w');
% fprintf(fid,'%s\n', codestr{:});
fprintf(fid,'%s\n', codestr);
fclose(fid);
edit(fname);
% %         clipboard('copy', sprintf('%s\n', str{:}));



function str = job2str(c)
% ��ÿ��node��ת��Ϊ�ַ���
% -----------------------------------------------
% Copyright (C) 2008

% WadeFelix RenV, 2008-09-03
str = {};
fdnames = fieldnames(c);
if ~isfield(c,'myname');
    c.myname = genvarname([c.type datestr(clock, 'HHMMSS')]);
end

for i = 1:numel(fdnames)
    switch fdnames{i}
        case 'children'
            if ~isempty(c.children)
                temp = '';
                    for jj = c.children
                        temp = [temp ' ' nodescell{jj}.myname];
                    end
                switch c.type
                case {'repeat' 'choice'}
                    str = {str{:},[c.myname '.values = {' ,temp, '};']};
                case 'branch'
                    str = {str{:},[c.myname '.val = {' ,temp, '};']};
                end
            end
        case 'name'
            str = {str{:},[c.myname '.name = ' mat2str(c.(fdnames{i})) ';']};
        case 'tag'
        str = {str{:},[c.myname '.tag  = ' mat2str(c.(fdnames{i})) ';']};
        case 'type'
        str = {str{:},[c.myname '.type = ' mat2str(c.(fdnames{i})) ';']};
        case 'filter'
        str = {str{:},[c.myname '.filter = ' mat2str(c.(fdnames{i})) ';']};
        case 'ufilter'
        str = {str{:},[c.myname '.ufilter = ' mat2str(c.(fdnames{i})) ';']};
        case 'strtype'
        str = {str{:},[c.myname '.strtype = ' mat2str(c.(fdnames{i})) ';']};
        case 'num'
        str = {str{:},[c.myname '.num  = ' mat2str(c.(fdnames{i})) ';']};
        case 'labels'
        s2 = regexp(c.(fdnames{i}), '\|', 'split');
        str = {str{:},[c.myname '.labels = {' sprintf('''%s'' ',s2{:}) '};']};
        case 'values'
            switch c.type
                case 'menu'
%                     str = {str{:},[c.myname '.values  = ' mat2str(c.(fdnames{i}){:}) ';']};
                    s2 = regexp(c.(fdnames{i}), '\|', 'split');
                    str = {str{:},[c.myname '.values = {' sprintf('''%s'' ',s2{:}) '};']};
                case {'repeat' 'choice'}
                    
            end
        case 'prog'
        str = {str{:},[c.myname '.prog = ' c.(fdnames{i}) ';']};
        case 'val'
            switch c.type
                case 'entry'
                    s2 = regexp(c.(fdnames{i}), '\|', 'split');
                    str = {str{:},[c.myname '.val = {' sprintf('''%s'' ',s2{:}) '};']};
                case 'const'
                    str = {str{:},[c.myname '.val  = ' mat2str(c.(fdnames{i})) ';']};
            end
        case 'help'
        strh = ['{' sprintf('''%s'' ',c.(fdnames{i}){:}) '}'];
        str = {str{:},[c.myname '.help = ' strh ';']};
    end
end

str = { '' '' str{:} };
end


    function helptext = makehelptext(node,helptext)
        switch nodescell{node}.type
            case {'branch' 'choice'}
                if isfield(nodescell{node},'children') && ~isempty(nodescell{node}.children)
                    helptext = repmat(helptext,1,numel(nodescell{node}.children));
                    for JJ = 1:numel(nodescell{node}.children)
                        if node == 1
                            h_temp = makehelptext(nodescell{node}.children(JJ),{[helptext{JJ} 'job' '.']});
                            if numel(h_temp) == 1
                            helptext(JJ) = h_temp;
                            else
                                helptext(JJ) = {h_temp};
                            end
                        else
                        helptext(JJ) = makehelptext(nodescell{node}.children(JJ),{[helptext{JJ} nodescell{node}.tag '.']});
                        end
                    end
                end
            case 'repeat'
                if isfield(nodescell{node},'children') && ~isempty(nodescell{node}.children)
                helptext = makehelptext(nodescell{node}.children(1),{['cell:' helptext{:} ]});
                end
%             case 'choice'
                
            case 'entry'
                helptext = {[helptext{:} nodescell{node}.tag ' is an entry']};
            case 'files'
                helptext = {[helptext{:} nodescell{node}.tag ' is(are) file(s)']};
            case 'menu'
                helptext = {[helptext{:} nodescell{node}.tag ' is a menu']};
            case 'const'
                helptext = {[helptext{:} nodescell{node}.tag ' is a const']};
        end
    end

end


