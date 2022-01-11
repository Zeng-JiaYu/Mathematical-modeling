%% poly_fit_mul
clear all;

    [input,output,count,no,indexTable,r,combin_data,data] = csv_data_load();
    
    n = 5;
    exp = zeros(count,11);
    anss = zeros(count,3);
    for i = 1:count
        [x,y1,y2] = get_num(indexTable,data,i);
        exp1 = polyfit(x,y1,n);
        exp2 = polyfit(x,y2,n);
        exp(i,:) = conv(exp1,exp2);
        anss(i,1) = polyval(exp(i,:),350);
        anss(i,2) = polyval(exp(i,:),400);
        anss(i,3) = polyval(exp(i,:),450);
    end

    
%% 输入：编号 输出：乙醇转化率和C4烯烃选择性数据
function [x,y1,y2] = get_num(indexTable,data,index)

    [index_min,index_max] = get_minmax_index(indexTable,index);
    
    x = data(index_min:index_max,1);
    y1 = data(index_min:index_max,2);
    y2 = data(index_min:index_max,4);
end
    
