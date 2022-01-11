%% 计算拟合优度
function r = goodness_of_fit(x,y)
    % x为真实值，y为拟合值
    mean_x = mean(x);
    sum_x = 0;
    sum_y = 0;
    size = length(x);
    for i = 1:size
        sum_x = (y(i)-mean_x)^2+sum_x;
        sum_y = (x(i)-mean_x)^2+sum_y;
    end
    r = sum_x/sum_y;
end