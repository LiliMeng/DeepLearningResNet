clear all;
close all;

data_b1 = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/data_batch_1.mat')
data_b2 = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/data_batch_2.mat')
data_b3 = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/data_batch_3.mat')
data_b4 = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/data_batch_4.mat')
data_b5 = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/data_batch_5.mat')

test_data = load('/home/lili/Workspace/MegaNet-tf/cifar-10-batches-mat/test_batch.mat')
train_features = vertcat(data_b1.data,   data_b2.data, data_b3.data, data_b4.data, data_b5.data);
train_labels   = vertcat(data_b1.labels, data_b2.labels, data_b3.labels, data_b4.labels, data_b5.labels);

test_features = test_data.data;
test_labels   = test_data.labels;

n_train = size(train_features,1);
n_test  = size(test_features,1);


Labels_std_train_1=zeros(n_train,10);
for i=1:n_train 
    label_std_train= train_labels(i,:);
    label_std_train_1=zeros(1,10);
    for j=1:10
        if label_std_train==j;
            label_std_train_1(1,j)=1;
        end
    end
    Labels_std_train_1(i,:)=label_std_train_1;
end

Labels_std_test_1=zeros(n_test,10);
for i=1:n_test
    label_std_test= test_labels(i,:);
    label_std_test_1=zeros(1,10);
    for j=1:10
        if label_std_test==j;
            label_std_test_1(1,j)=1;
        end
    end
    Labels_std_test_1(i,:)=label_std_test_1;
end


field1 = 'Ctrain';  value1 = train_features;
field2 = 'Cval';  value2 =  test_features;
field3 = 'Ytrain';  value3 =  Labels_std_train_1;
field4 = 'Yval';  value4 =  Labels_std_test_1;



S = struct(field1,value1,field2,value2,field3,value3,field4,value4)

save cifar10_data.mat -struct S

