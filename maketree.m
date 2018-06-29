function tree = maketree(featurelabels,trainfeatures,targets,epsino)
%tree=struct('pro',0,'value',-1,'child',[],'parentpro',-1);
[n,m] = size(trainfeatures); %����n����������������m����ʵ��������
cn = unique(targets);%��ͬ���
l=length(cn);%�������
if l==1%���ֻ��һ���ֻ࣬ʹ�ø�����Ϊ���ı�ǲ�����
    tree.pro=0;%û��Ҷ��
    tree.value = cn;
    tree.child=struct('pro',{},'value',{},'child',{},'parentpro',{});
    return
end
if n==0% ����������0
    H = hist(targets, length(cn)); %��ֱ��ͼ
   [ma, largest] = max(H); %ma�����������࣬largest��cn������λ��
   tree.pro=0;
   tree.value=cn(largest);
   tree.child=struct('pro',{},'value',{},'child',{},'parentpro',{});
   return
end

pnode = zeros(1,length(cn));
%������Ϣ����
for i=1:length(cn)
    pnode(i)=length(find(targets==cn(i)))/length(targets);
end
H=-sum(pnode.*log(pnode)/log(2));
maxium=-1;
maxi=-1;
g=zeros(1,n);
for i=1:n
    fn=unique(trainfeatures(i,:));%��������fn����
    lfn=length(fn);
    gf=zeros(1,lfn);
    %fprintf('feature numbers:%d\n',lfn);
    for k=1:lfn
        onefeature=find(fn(k)==trainfeatures(i,:));%�������е�ÿ�����ԣ���������Ե���Ŀ
        for j=1:length(cn)
            oneinonefeature=find(cn(j)==targets(:,onefeature));
            ratiofeature=length(oneinonefeature)/length(onefeature);
            %fprintf('feature %d, property %d, rationfeature:%f\n',i, fn(k),ratiofeature);
            if(ratiofeature~=0)
                gf(k)=gf(k)+(-ratiofeature*log(ratiofeature)/log(2));
            end
        end  
        ratio=length(onefeature)/m;
        gf(k)=gf(k)*ratio;
    end
    g(i)=H-sum(gf);
    fprintf('%f\n',g(i));
    if g(i)>maxium
        maxium=g(i);
        maxi=i;
    end
end

if maxium<epsino%�����Ϣ����С��epsino
    H = hist(targets, length(cn)); 
   [~, largest] = max(H); 
   tree.pro=0;
   tree.value=cn(largest);
   tree.child=struct('pro',{},'value',{},'child',{},'parentpro',{});
   return
end

tree.pro=1;%1��������һ���ڲ��ڵ㣬0��������һƬҶ��
tv=featurelabels(maxi);
tree.value=tv;
tree.child=struct('pro',{},'value',{},'child',{},'parentpro',{});
featurelabels(maxi)=[];

%�������ָ�����
[data,target,splitarr]=splitData(trainfeatures,targets,maxi);
%tree.child=zeros(1,length(data));
%��������;
fprintf('split data into %d\n',length(data));
for i=1:length(data)
   disp(data(i));
   fprintf('\n');
   disp(target(i));
   fprintf('\n');
end
fprintf('\n');

for i=1:size(data,1)
    result=data{i};
    temptree=maketree(featurelabels,result,target{i},0);
    temptree.parentpro=0;
    tree.pro=1;
    tree.value=tv;
    tree.child(i)=temptree;
    tree.child(i).parentpro = splitarr(i);
    fprintf('temp tree\n');
    disp(tree.child(1));
    fprintf('\n');
end
disp(tree);
fprintf("now root tree,tree has %d childs\n",size(tree.child,2));
fprintf('\n');
for i=1:size(data,1)
    disp(tree.child(i));
    fprintf('\n');
end
fprintf('one iteration ends\n');
end



    
    

