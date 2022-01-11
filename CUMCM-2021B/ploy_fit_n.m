%% ploy_fit_n
function [x0,y0] = ploy_fit_n(x,y,n)
    % 拟合n次函数
    a = polyfit(x,y,n);  
    % 步长为foot,计算拟合结果
    %x0 = x(1):foot:x(end);     
    x0 = x;
    y0 = polyval(a,x); 
end