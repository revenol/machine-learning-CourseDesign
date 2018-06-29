function result=classify(data, tree)
while tree.pro==1
    childset=tree.child;
    v=tree.value;
    tag=0;
    for i=1:size(childset,2)
        child = childset(i);
        if child.parentpro==data(v)
            tree=child;
            tag=1;
            break;
        end
    end
    if tag==0
        child = childset(1);
        tree=child;
    end
end
result=tree.value;
end
    