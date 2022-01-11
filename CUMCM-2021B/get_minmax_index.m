%% 获取最大最小坐标
function [index_min,index_max] = get_minmax_index(indexTable,index)
    temp = 0;
    for i = 1:length(indexTable)
        if indexTable(i,1) == index && temp == 0 % 有值
            index_min = i;
            temp = 1;
            continue;
        elseif indexTable(i,1) ~= index && temp == 1
            index_max = i-1;
            break;
        elseif i == 114
            index_max = 114;
        end
    end