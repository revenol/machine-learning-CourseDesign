clear all; close all; clc
nursery=load('nursery.data.csv');
[ndata, D] = size(nursery);        %ndata样本数，D维数
R = randperm(ndata);         %1到n这些数随机打乱得到的一个随机数字序列作为索引
test_num=ndata*0.3;
nursery_test = nursery(R(1:test_num),:);  %以索引的前30%数据点作为测试样本
R(1:test_num) = [];
nursery_train = nursery(R,:);          %剩下的数据作为训练样本
num_training = size(nursery_train,1);%num_training；训练样本数
featurelabels=[1,2,3,4,5,6,7,8];
% trainfeatures=[1,1,1,1,1,2,2,2,2,2,3,3,3,3,3;
%     0,0,1,1,0,0,0,1,0,0,0,0,1,1,0;
%     0,1,0,0,0,0,1,0,1,1,0,0,0,1,0;
%     0,0,0,1,0,0,0,1,1,1,1,1,0,0,0;
%     1,2,2,1,1,1,2,2,3,3,3,2,2,3,1
%     ];
%  targets=[0,0,1,1,0,0,0,1,1,1,1,1,1,1,0];
trainfeatures=nursery_train(:,1:8)';
targets=nursery_train(:,9)';
tree=maketree(featurelabels,trainfeatures,targets,0);
%printTree(tree);
sum=0;
for i=1:test_num
    data=nursery_test(i,1:8);
    result=classify(data,tree);
    if(nursery_test(i,9)==result)
        sum=sum+1;
    end
    fprintf('第%d次，正确为%d\n',i,sum);
end
% result=classify(data,tree);
p=roundn((sum/test_num)*100,-2);
fprintf('测试正确率为%.2f\n',p);

