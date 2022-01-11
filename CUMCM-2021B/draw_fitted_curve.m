%% draw_fitted_curve
function draw_fitted_curve(x,y,n)

    [x0,y0] = ploy_fit_n(x,y,n,0.01);
    
    % 画图
    plot(x,y,'o',x0,y0,'r');
    
    % 添加曲线名称
    % legend('附件2中350°C条件下C4烯烃选择性','拟合前','拟合后');   
    
    % 横纵坐标限制
    % axis([250 350 0 0.27])
    
    % 设置横纵坐标标签
    xlabel('温度(°C)');               
    ylabel('C4 烯烃收率(%)'); 
    
    %添加网格线
    grid on;   
    
    %将网格线变成虚线
    set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);  
end