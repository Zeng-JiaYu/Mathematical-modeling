%% fit_mul_better
clear all;

[input,output,count,no,indexTable,r,combin_data,data] = csv_data_load();

% 拟合n次
n = 5;
% 多项式表达式矩阵
exp = zeros(count,n+1);
% 计算结果矩阵
anss = zeros(count,3);

for i = 1:count
    [x,y1,y2,index_min,index_max] = get_num(indexTable,data,i);
    y = y1.*y2;

    subplot(7,3,i);

    draw_fitted_curve(x,y,n);

    exp(i,:) =  polyfit(x,y,n);

    anss(i,1) = polyval(exp(i,:),350);
    anss(i,2) = polyval(exp(i,:),400);
    anss(i,3) = polyval(exp(i,:),450);
end

% cftool;