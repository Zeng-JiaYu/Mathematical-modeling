%% draw_line 
% 输入：两种催化剂组合 
% 输出：包含乙醇转化率和C4烯烃选择性随温度变化折线图
% function draw_lineChart(no,indexTable,data,index1,index2)
    
    % 乙醇转化率
    subplot(1,2,1);
    draw_subLineChart(indexTable,data,7,0,'m')
    draw_subLineChart(indexTable,data,8,0,'c')
    draw_subLineChart(indexTable,data,9,1,'r')
    draw_subLineChart(indexTable,data,12,1,'b')
    lgd = legend('A7','A8','A9','A12','Location','southoutside','NumColumns',2);
    
    % C4烯烃选择性
    subplot(1,2,2);
    draw_subLineChart(indexTable,data,7,1,'m')
    draw_subLineChart(indexTable,data,8,1,'c')
    draw_subLineChart(indexTable,data,9,1,'r')
    draw_subLineChart(indexTable,data,12,1,'b')
    lgd = legend('A7','A8','A9','A12','Location','southoutside','NumColumns',2);
% end

%% sub_draw_line 
% 输入：催化剂组合编号、因变量、折线图颜色
function draw_subLineChart(indexTable,data,index,flag,color)
    
    [index_min,index_max] = get_minmax_index(indexTable,index);
    
    x = data(index_min:index_max,1);
    if flag == 0
        y = data(index_min:index_max,2);
    else 
        y = data(index_min:index_max,4);
    end

    plot(x,y,strcat('-o',color))    %画图，o表示圆圈，r表示红色red
    xlabel('温度(°C)');               %给x轴加上说明
    if flag == 0
        ylabel('乙烯转化率(%)'); 
    else 
        ylabel('C4烯烃选择性(%)'); 
    end
    grid on;                   %添加网格线
    set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);  %将网格线变成虚线
    hold on;
end

