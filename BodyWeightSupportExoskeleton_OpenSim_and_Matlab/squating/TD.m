function [x1_k1,x2_k1] = TD(u,x1_k,x2_k,r,h)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% r = 200;  % ���������ٶȵ��ٶ����ӣ�
% h = 0.001;  % ���������˲����õ��˲����ӣ�

x1_k1 = x1_k + h*x2_k;

%% ���w��
d = r*h;
d0 = h*d;
y = x1_k - u + h*x2_k;
a0 = sqrt(d^2 + 8*r*abs(y));
if abs(y)>d0
    a = x2_k + (a0 - d)/2*sign(y);
else
    a = x2_k + y/h;
end

if abs(a)>d
    w = -r*sign(a);
else
    w = -r*a/d;
end
%%

x2_k1 = x2_k + h*w;

end

