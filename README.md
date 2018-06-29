# machine-learning-CourseDesign

------

## 广东工业大学机器学习课程设计

### 概要介绍
这是一份课程设计，所用数据是从UCI上下载的[托儿所录取儿童标准数据](http://archive.ics.uci.edu/ml/datasets/Nursery)
主要用途是，根据8个标准，对儿童能否进入托儿所进行一个评判分析。这里主要使用的是决策树的方法进行分类

### 文件介绍
为此目录文件的大致介绍，按首字母排列  
classify.m——分类方法，决策树形成后，再次输入数据，进行分类，得到结果  
data.csv——处理后的数据文件  
main.m——主文件  
maketree.m——形成决策树的方法  
nursery.data.txt——初始数据文件  
splitData.m——辅助方法，按特征分割数据  