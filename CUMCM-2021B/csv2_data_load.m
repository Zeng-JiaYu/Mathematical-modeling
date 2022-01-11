%% csv2_data_load
clear all;
filename = '2.csv';
csv = importdata(filename);

% 纯数据
data = csv.data(2:end,2:end);
[r,c] = size(data);

% 字符存储 115*12
textdata = csv.textdata(2,2:end);
% 纯数据化为小数形式
% for i = 2:c
%     data(:,i) = data(:,i).* 0.01;  
% end
R = zeros(1,c-1);
x = data(:,1);
for i = 2 : c
    subplot(3,3,i-1);
    y = data(:,i);
     %画图，o表示圆圈
    plot(x,y,'-ob');   
    xlabel(textdata{1,1});               %给x轴加上说明
    ylabel(textdata{1,i}); 
    r = corrcoef(x,y);
    r = r(1,2);
    R(i-1) = r;
end
R = sort(R);



