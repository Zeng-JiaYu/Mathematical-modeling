%% get_num
% 输入：编号 输出：乙醇转化率和C4烯烃选择性数据
function [x,y1,y2,index_min,index_max] = get_num(indexTable,nums,index)

    [index_min,index_max] = get_minmax_index(indexTable,index);
    
    x = nums(index_min:index_max,1);
    y1 = nums(index_min:index_max,2);
    y2 = nums(index_min:index_max,4);
   
end