clear all;
close all;
data_old = load('/home/lili/Workspace/MegaNet-tf/STL10_CoarseGray1.mat')

data_new_train = load('/home/lili/Workspace/MegaNet-tf/matlab_code/stl10_matlab/train.mat')
data_new_test  = load('/home/lili/Workspace/MegaNet-tf/matlab_code/stl10_matlab/test.mat')

new_X_train = data_new_train.X;
new_X_test  = data_new_test.X;
n_train = size(new_X_train,1);
n_test  = size(new_X_test,1);
Xg_train    = zeros(n_train,9216);
Xg_test    = zeros(n_test,9216);


for i=1:n_train
    %figure(1)
    %imshow(reshape(new_X_train(i,:),96,96,3))
    new_xh_train = (rgb2gray(reshape(new_X_train(i,:),96,96,3)));
    %figure(2)
   % imshow(new_xh_train)
    Xg_train(i,:) = (1/256)*(double(new_xh_train(:))-128);
   % figure(3)
   % imagesc(reshape(Xg_train(i,:),96,96))
end   


for i=1:size(new_X_test,1)
    %imshow(reshape(new_X_train(i,:),96,96,3))
    new_xh_test = (rgb2gray(reshape(new_X_test(i,:),96,96,3)));
    %figure(2)
   % imshow(new_xh_train)
    Xg_test(i,:) = (1/256)*(double(new_xh_test(:))-128);
end   

Labels_std_train = data_new_train.y;

N_train=size(Labels_std_train,1)

for i=1:N_train
    label_std_train= Labels_std_train(i,:);
    label_std_train_1=zeros(1,10);
    for j=1:10
        if label_std_train==j;
            label_std_train_1(1,j)=1;
        end
    end
    Labels_std_train_1(i,:)=label_std_train_1;
end

Labels_std_test = data_new_test.y;

N_test=size(Labels_std_test,1)

for i=1:N_test
    label_std_test= Labels_std_test(i,:);
    label_std_test_1=zeros(1,10);
    for j=1:10
        if label_std_test==j;
            label_std_test_1(1,j)=1;
        end
    end
    Labels_std_test_1(i,:)=label_std_test_1;
end


field1 = 'Ctrain';  value3 = Xg_train;
field2 = 'Cval';  value4 =  Xg_test;
field3 = 'Ytrain';  value1 =  Labels_std_train_1;
field4 = 'Yval';  value2 =  Labels_std_test_1;

S = struct(field1,value1,field2,value2,field3,value3,field4,value4)

save stl_data_old.mat -struct S
