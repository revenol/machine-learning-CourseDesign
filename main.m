clear all; close all; clc
nursery=load('nursery.data.csv');
[ndata, D] = size(nursery);        %ndata��������Dά��
R = randperm(ndata);         %1��n��Щ��������ҵõ���һ���������������Ϊ����
test_num=ndata*0.3;
nursery_test = nursery(R(1:test_num),:);  %��������ǰ30%���ݵ���Ϊ��������
R(1:test_num) = [];
nursery_train = nursery(R,:);          %ʣ�µ�������Ϊѵ������
num_training = size(nursery_train,1);%num_training��ѵ��������
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
    fprintf('��%d�Σ���ȷΪ%d\n',i,sum);
end
% result=classify(data,tree);
p=roundn((sum/test_num)*100,-2);
fprintf('������ȷ��Ϊ%.2f\n',p);

