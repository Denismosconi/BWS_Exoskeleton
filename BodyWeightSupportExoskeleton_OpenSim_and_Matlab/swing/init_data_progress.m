%
n_BL = 3;   %ÿ��block����Ŀ��
n_L = 4;    %ÿ������Ĳ�����
n = 6;  %����ĸ�����
p = 3;  %����ĸ�����
Weight = zeros(p,n_L,n_BL^n);
Miu = zeros(n_L,n_BL,n);
for i = 1:n     %miu����ֵ��
    Miu(1,1,i) = 0.5;
    Miu(1,2,i) = 3;
    Miu(1,3,i) = 7;
    Miu(2,1,i) = 1;
    Miu(2,2,i) = 4;
    Miu(2,3,i) = 7.5;
    Miu(3,1,i) = 1.5;
    Miu(3,2,i) = 5;
    Miu(3,3,i) = 8;
    Miu(4,1,i) = 2;
    Miu(4,2,i) = 6;
    Miu(4,3,i) = 8.5;
end
Sigma = 10*ones(n_L,n_BL,n);
yita = zeros(n_BL,1);
%
save data_Weight Weight;
save data_Miu Miu;
save data_Sigma Sigma;
save data_Yita yita;