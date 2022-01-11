%% fit_curve_5
x=[250,275,300,325,350];
y=[2.07,5.85,14.97,19.68,36.80];

x_min = 250;
x_max = 350;
n = 5;

[x0,y0] = ploy_fit_n(x,y,n,0.01);
plot(x,y,'o',x0,y0,'r')    %画图，o表示圆圈，r表示红色red

legend('拟合前','拟合后','Location','NorthEast');   %给曲线加上说明
xlabel('温度(°C)');               %给x轴加上说明
ylabel('乙醇转化率(%)');
grid on;                   %添加网格线
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);  %将网格线变成虚线
hold on;