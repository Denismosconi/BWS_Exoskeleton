function [DesiredData] = GetDesiredData(x,i,CM)
%UNTITLED4 ���ݺ�������ؽڽǶ�����ֵ��
%   x: ʱ�����У�
%   i: ��i���ؽڣ�
%   CM������Ҷ��������ϵ����
%   A����ֵ����ϵ����

a = 10; %�����м���λ�ã�Խ��Խ���ң�
b = 2.5; %���������ٶȣ�Խ��Խ�죻
A = 1/(1+exp(a - b*x));

        a0 = CM(1,i);
        a1 = CM(2,i);
        b1 = CM(3,i);
        a2 = CM(4,i);
        b2 = CM(5,i);
        a3 = CM(6,i);
        b3 = CM(7,i);
        a4 = CM(8,i);
        b4 = CM(9,i);
        a5 = CM(10,i);
        b5 = CM(11,i);
        a6 = CM(12,i);
        b6 = CM(13,i);
        a7 = CM(14,i);
        b7 = CM(15,i);
        a8 = CM(16,i);
        b8 = CM(17,i);
        w = CM(18,i);
        
        f = ...
            a0 + a1*cos(x*w) + b1*sin(x*w) +... 
            a2*cos(2*x*w) + b2*sin(2*x*w) + a3*cos(3*x*w) + b3*sin(3*x*w) +... 
            a4*cos(4*x*w) + b4*sin(4*x*w) + a5*cos(5*x*w) + b5*sin(5*x*w) +... 
            a6*cos(6*x*w) + b6*sin(6*x*w) + a7*cos(7*x*w) + b7*sin(7*x*w) +... 
            a8*cos(8*x*w) + b8*sin(8*x*w); 
        
        if i<5 || i>7
            f = f/180*pi;
        end
        
        
        
        DesiredData = A*f;


end

