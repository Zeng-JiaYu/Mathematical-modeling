%% bp_neural_network
%% 清空环境变量
while(1)
    clear all;
    clc;

    %% 导入数据
    
    [input,output,count,no,indexTable,r,combin_data,data] = csv_data_load();
    temp = [input,output];
    rowrank = randperm(size(temp, 1)); % 随机打乱的数字，从1~行数打乱
    tempB = temp(rowrank, :); %%按照rowrank打乱矩阵的行数
    input = tempB(:,1:7);
    output = tempB(:,8:10);
    
    % 生成输入全集
    x1 = [1 2];
    x2 = [1 67/33 33/67 50/90]; 
    x3 = [200 50 90 33 67 100 10 25 75]; 
    x4 = [1 2 0.5 5];
    x5 = [1.68 0.9 0.3 2.1];
    x6 = [1,2];
    x7 = [250 300 350 400 450 500];
    [x7,x6,x5,x4,x3,x2,x1] = ndgrid(x7,x6,x5,x4,x3,x2,x1);
    INPUT = [x1(:) x2(:) x3(:),x4(:) x5(:) x6(:),x7(:)]; %所有排列组合情况

                                
    %input = [input,output(:,3)];
    %% 产生训练集和测试集
    % 训练集 80 examples
    P_train = input(1:90,:)';
    T_train = output(1:90,1)';

    % 测试集 17 examples
    P_test = input(85:end,:)';
    T_test = output(85:end,1)';
    N = size(P_test,2);

    %% 数据归一化
    [p_train,ps_input] = mapminmax(P_train,0,1);
    p_test = mapminmax('apply',P_test,ps_input);
    [t_train,ps_output] = mapminmax(T_train,0,1);
    
    %% BP 神经网络创建、训练及仿真测试
    % 创建网络
    s = 40;% 隐含层神经元个数，连接权值962
    net = newff(P_test,T_train,s); 

    % 设置训练参数
    net.trainParam.epochs = 1000;   %迭代次数
    net.trainParam.goal = 0.00001;     %mse均方差误差小于这个值训练结束
    net.trainParam.lr = 0.01;        %学习率

    %% 训练网络
    net = train(net,P_train,T_train);

    %% 仿真测试
    t_sim = sim(net,P_test);

    %% 数据反归一化
    T_sim = mapminmax('reverse',t_sim,ps_output);

    %% 性能评价
    % 相对误差 error
    error = abs(T_sim - T_test)./T_test;
    % 决定系数 R^2
    R2 = (N*sum(T_sim.*T_test)-sum(T_sim)*sum(T_test))^2 ...
        / ((N*sum((T_sim).^2)-(sum(T_sim))^2) ...
        *(N*sum((T_test).^2)-(sum(T_test))^2)); 
    % 结果对比
    result = [T_test' T_sim' error'];
    disp(R2)
%     disp('-----------------------误差计算--------------------------');
%     disp(['隐含层节点数为',s,'时的误差结果如下：'])
%     disp(['平均绝对误差MAE为：',num2str(MAE1)])
%     disp(['均方误差MSE为：       ',num2str(MSE1)])
%     disp(['均方根误差RMSE为：  ',num2str(RMSE1)])
    [c,l]=size(T_test);
    MAE1=sum(abs(error))/l;
    MSE1=error*error'/l;
    RMSE1=MSE1^(1/2);
   


    
    if (R2 > 0.85)
        INPUT = INPUT';
        [INPUT,PS] = mapminmax(INPUT,0,1);
        o = zeros(13824,1);
        for i = 1 : 13824
            o(i) = sim(net,INPUT(:,i));
        end
        FlattenedData1 = INPUT(:)'; % 展开矩阵为一列，然后转置为一行。
        MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % 归一化。
        MappedData1 = reshape(MappedFlattened1, size(INPUT)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序
        
        FlattenedData2 = o(:)'; % 展开矩阵为一列，然后转置为一行。
        [MappedFlattened2,PS] = mapminmax(FlattenedData2, 0, 1); % 归一化。
        MappedData2 = reshape(MappedFlattened2, size(o)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序
        MappedData22 = mapminmax('reverse',MappedFlattened2,PS);
        maxnum = min(MappedData22);
        break;
    end
end

%% 绘图
    figure(1);
    plot(1:N, T_test, 'b:*', 1:N, T_sim, 'r-o');
    legend('真实值', ' BP预测值');
    xlabel('预测样本');
    ylabel('乙醇转化率');
    string = {'测试集乙醇转化率预测结果(BP)'; ...
        ['R^2=' num2str(R2) '(BP)']};
    title(string);




