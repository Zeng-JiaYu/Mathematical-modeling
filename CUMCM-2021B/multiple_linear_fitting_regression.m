%% multiple_linear_fitting_regression
clear all;
[input,output,count,no,indexTable,~,combin_data,data] = csv_data_load();
temp = input(:,7);
x = [input(:,2:5),temp];
y = output(:,2);
[b,bint,r,rint,stats] = regress(y,x);

scatter3(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),y,'filled');
hold on
x1fit = min(x1):100:max(x1);
x2fit = min(x2):10:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('Weight')
ylabel('Horsepower')
zlabel('MPG')
view(50,10)
hold off