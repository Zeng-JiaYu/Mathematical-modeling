%% compare_line_charts
% 催化剂组合对比折线图（问题2）

[input,output,count,no,indexTable,r,combin_data,data] = csv_data_load();

%选择催化剂组合编号，绘图
draw_lineChart(no,indexTable,data,7,8);

draw_lineChart(no,indexTable,data,9,12);
