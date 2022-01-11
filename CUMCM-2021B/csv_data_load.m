%% csv_data_load
function [input,output,count,no,indexTable,r,combin_data,data] = csv_data_load()
    clear all;
    filename = '1.csv';
    csv = importdata(filename);
    
    % 纯数据114*8
    data = csv.data;
    [r,c] = size(data);
    % 纯数据化为小数形式
    for i = 2:c
        data(:,i) = data(:,i).* 0.01;  
    end
    
    % 字符存储 115*12
    textdata = csv.textdata;
    
    % 催化剂组合编号 no 和 催化剂组合 combin
    no = textdata(: ,2);
    combin = textdata(:,3);
    % 获取催化剂编号列表
    count = 0;
    indexTable = zeros(length(no)-1,1);
    for i = 2:length(no)
        if no(i,1) ~= ""   % 有值
            count = count + 1;
        end
        indexTable(i-1,:) = count;  
    end
    % 删除no和combin中空行
    no(cellfun(@isempty,no))=[];
    no = no(2:end,:);
    combin(cellfun(@isempty,combin))=[];
    combin = combin(2:end,:);
    
    %combin处理
    combin_data = zeros(count,6);
    for i = 1:count
        str = combin{i,1};
        temp = strrep(str, ' ', '');
        % 1 催化剂
        if ~contains(temp,'石英砂')
            combin_data(i,1) = 1;
        else
            combin_data(i,1) = 2;
        end
        % 2 混料比
        str_temp = extractBetween(temp,'','mg');
        str_temp = char(str_temp{1,1});
        temp1 = str2double(str_temp);
        str_temp1 = extractBetween(temp,'SiO2-','mg');
        str_temp1 = char(str_temp1{1,1});
        temp2 = str2double(str_temp1);
        combin_data(i,2) = temp1/temp2;
        % 3 混料系数
        combin_data(i,3) = temp2;
        % 4 Co负载量
        str_temp = extractBetween(temp,'mg','wt');
        combin_data(i,4) = str2double(char(str_temp{1,1}));
        % 5 乙醇浓度
        str_temp = extractBetween(temp,'浓度','ml/min');
        combin_data(i,5) = str2double(char(str_temp{1,1}));
        % 6 装料方式
        if i < 15
            combin_data(i,6) = 1;
        else
            combin_data(i,6) = 2;
        end
        
    end

    input = zeros(r,7);
    output = zeros(r,3);
    flag = 1;
    for i = 1:size(indexTable)
        if indexTable(i) == flag
            input(i,1:6) = combin_data(flag,:);
        else
            flag = indexTable(i);
            input(i,1:6) = combin_data(flag,:);
        end
    input(i,7) = data(i,1);
    end
    
    output(:,1) = data(:,2);
    output(:,2) = data(:,4);
    output(:,3) = data(:,2).* data(:,4);
 end
    