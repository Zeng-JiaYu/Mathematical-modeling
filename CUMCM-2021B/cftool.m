%% cftool绘制三维图
clear all;

[~,~,~,~,indexTable,~,~,data] = csv_data_load();

% 温度 
tem = data(:,1);
% 乙醇转化率
rate_1 = data(:,1);
% C4烯烃选择性   
rate_2 = data(:,4);

% 打开cftools
%cftool;