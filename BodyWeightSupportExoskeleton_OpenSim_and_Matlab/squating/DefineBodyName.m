function [name] = DefineBodyName()
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

name = cell(60,1);

for i = 1:60
    b_name = ['Body' num2str(i)];
    eval( [ 'name{' num2str(i) '} = b_name;' ] );
end

end

