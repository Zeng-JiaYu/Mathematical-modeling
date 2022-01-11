%% get_ploy_n 获取1~10阶多项式拟合优度

clear all;
[~,~,count,~,indexTable,~,~,data] = csv_data_load();
N = 10;
x = randn(N);
y = exp(x);
l = get_best_n(x,y);
disp(l);
function l = get_best_n(x,y,N)

    X = ones(N);
    last_obj = -log(0);
    obj = 0.0;
    l = 0;
    while true
        l = l+1;
        X =[X x.^l];
        sum_resid = 0;
        for i=1:N
            xx=X;
            xx=[xx(1:i-1,:);xx(i+1:end,:)];
            xy=X;
            xy = xy-X(i)*y(i);
            beta = xx/xy;
            [r,c] = size(X);
            for j = 1 : c
                sum_resid = sum_resid + (y(i)-X(i,j)*beta).^2;
            end
        end
        obj = sum_resid(1)/N;
        if last_obj<obj
            l = l-1;
            break
        end
        last_obj = obj;
    end
end


function l = get_better_n()
    clear all;
    
    flag = 1;
    l = zeros(count,10);

    for i = 1:count      
        [index_min,index_max] = get_minmax_index(indexTable,i);
        x = data(index_min:index_max,1);
        if flag == 1
            y = data(index_min:index_max,2);        % 乙烯转化率
        end
        if flag == 2
            y = data(index_min:index_max,4);        % C4烯烃转化率
        end
        for n = 1:10
            a = polyfit(x,y,n);
            y0 = polyval(a,x); 
            l(i,n) = goodness_of_fit(y,y0);
        end
    end
 end