function [geo_path] = SelectGeoPathName()
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

geo_path = cell(60,1);


for i = 1:60
    path = ['ExoGeometry1/body (' num2str(i) ')'];
    eval( [ 'geo_path{' num2str(i) '}= path;' ] );
% geo_path{1} = 'ExoGeometry/1';
end

end

