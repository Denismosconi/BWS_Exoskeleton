function [x_worldo,x0_worldo,x0_bodyo,flag,y_body] = xDistanceCalculate(t,x0_body,x0_world,last_flag,model,state)
%UNTITLED ����x����ǰ���ľ��룻
% ����x0_world, x_world, x0_body, x_body;
% x_body: ���׾������x����ľ��룻
% x0_body: �л�ʱ�̽��׾������x����ľ��룬�豣�棻
% x_world: �������������ϵx����ľ��룬ʵ����Ҫ��ֵ��
% x0_world: �л�ʱ���������������ϵx����ľ��룬�豣�棻

import org.opensim.modeling.*;

T = 2*pi/5.23;
gait = mod(t,T); % �����t�ĳ�ʼʱ��Ϊ��ʼ���ߵ�ʱ�̣����ǿ�ʼ�����ʱ�̣����ε�ʱ��ע�⡣
if gait>=0.1 && gait<0.7
    now_flag = 0;
else
    now_flag = 1;
end

k = 1;
Data = zeros(k,11); % ����ľ���ת�������Ǵ�Moran_Simbody3�ļ����п��������ģ�Ϊ��ͳһ���ݸ�ʽ�����ﶨ������ôһ��Data���飻
if now_flag == 1
    hip_flexion_r = Coordinate.safeDownCast(model.updComponent('hip_r/hip_flexion_r'));
    hip_adduction_r = Coordinate.safeDownCast(model.updComponent('hip_r/hip_adduction_r'));
    hip_rotation_r = Coordinate.safeDownCast(model.updComponent('hip_r/hip_rotation_r'));
    knee_angle_r = Coordinate.safeDownCast(model.updComponent('knee_r/knee_angle_r'));
    hip_flexion_angle_r = hip_flexion_r.getValue(state);
    hip_adduction_angle_r = hip_adduction_r.getValue(state);
    hip_rotation_angle_r = hip_rotation_r.getValue(state);
    knee_angle_angle_r = knee_angle_r.getValue(state);
    Data(k,8:11) = [hip_flexion_angle_r,hip_adduction_angle_r,hip_rotation_angle_r,knee_angle_angle_r];
else
    hip_flexion_l = Coordinate.safeDownCast(model.updComponent('hip_l/hip_flexion_l'));
    hip_adduction_l = Coordinate.safeDownCast(model.updComponent('hip_l/hip_adduction_l'));
    hip_rotation_l = Coordinate.safeDownCast(model.updComponent('hip_l/hip_rotation_l'));
    knee_angle_l = Coordinate.safeDownCast(model.updComponent('knee_l/knee_angle_l'));
    hip_flexion_angle_l = hip_flexion_l.getValue(state);
    hip_adduction_angle_l = hip_adduction_l.getValue(state);
    hip_rotation_angle_l = hip_rotation_l.getValue(state);
    knee_angle_angle_l = knee_angle_l.getValue(state);
    Data(k,8:11) = [hip_flexion_angle_l,hip_adduction_angle_l,hip_rotation_angle_l,knee_angle_angle_l];
end

T_p2fr = [-0.072437596574806778; -0.067724542200774104; 0.085552182659071663];
p_T_fr = [ [R(-Data(k,10),-Data(k,9),Data(k,8));zeros(1,3)] [T_p2fr;1] ];

f_fr2tr_tx_x = [-2.0944 -1.74533 -1.39626 -1.0472 -0.698132 -0.349066 -0.174533 0.197344 0.337395 0.490178 1.52146 2.0944];
f_fr2tr_tx_y = [-0.0032 0.00179 0.00411 0.0041 0.00212 -0.001 -0.0031 -0.005227 -0.005435 -0.005574 -0.005435 -0.00525];
f_fr2tr_tx_scale = 1.14724;
f_fr2tr_tx = spline(f_fr2tr_tx_x*f_fr2tr_tx_scale,f_fr2tr_tx_y*f_fr2tr_tx_scale,Data(k,11));
f_fr2tr_ty_x = [-2.0944 -1.22173 -0.523599 -0.349066 -0.174533 0.159149 2.0944];
f_fr2tr_ty_y = [-0.4226 -0.4082 -0.399 -0.3976 -0.3966 -0.395264 -0.396];
f_fr2tr_ty_scale = 1.14724;
f_fr2tr_ty = spline(f_fr2tr_ty_x*f_fr2tr_ty_scale,f_fr2tr_ty_y*f_fr2tr_ty_scale,Data(k,11));
T_fr2tr = [f_fr2tr_tx;f_fr2tr_ty;0];
fr_T_tr = [ [R(0,0,Data(k,11));zeros(1,3)] [T_fr2tr;1] ];

T_tr2ar = [0; -0.42506489000000003; 0];
tr_T_ar = [ [eye(3);zeros(1,3)] [T_tr2ar;1] ];

Point_ar = [0;0;0;1];

Point_p = p_T_fr * fr_T_tr * tr_T_ar * Point_ar;
x_body = Point_p(1);
y_body = Point_p(2);

% ����Ƿ��������л���
% last_flag=1 ��ʾ���ȣ�last_flag=0 ��ʾ���ȣ�
if now_flag == last_flag % ��ʾδ�л���
    x_worldo = x0_world + (x0_body - x_body);
    x0_worldo = x0_world;
    x0_bodyo = x0_body;
else                     % ��ʾ�л��ˣ�����
    % x0_body��x0_world��Ҫ���£�
    pelvis_tx = Coordinate.safeDownCast(model.updComponent('ground_pelvis/pelvis_tx'));
    x_worldo = pelvis_tx.getValue(state);
    x0_worldo = x_worldo;
    x0_bodyo = x_body;
end
flag = now_flag;    

end

