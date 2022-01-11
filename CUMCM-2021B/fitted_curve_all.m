%% fitted_curve_all
clear all;
[input,output,count,no,indexTable,r,combin_data,data] = csv_data_load();

% 画点
m = [350,350];
b = [39.04,39.04];
plot(m,b,'*','Color','y');
hold on;

 % 拟合n次
n = 5;
% 多项式表达式矩阵
exp = zeros(count,n+1);
for i = 1:count        
    [x,y1,y2,index_min,index_max] = get_num(indexTable,data,i);
    y1 = y1 .* 100;
    draw_fitted_curve(x,y1,n);
    exp(i,:) =  polyfit(x,y1,n);
end

