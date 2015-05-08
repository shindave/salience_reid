%
% Created by Rui Zhao, on May 20, 2013. 
% This code is release under BSD license, 
% any problem please contact Rui Zhao rzhao@ee.cuhk.edu.hk
%
% Please cite as
% Rui Zhao, Wanli Ouyang, and Xiaogang Wang. Unsupervised Salience Learning
% for Person Re-identification. In IEEE Conference of Computer Vision and
% Pattern Recognition (CVPR), 2013. 
%
function [score, ind] = ocsvm_max(xnn, kernel_type)
% estimate density distribution for a set of data xnn, 
% and locate the largest density data point
% kernel_type: the kernel used in OCSVM
%               - 1: rbf
%               - 2: linear
%               - 3: polynomial
%               - 4: sigmoid

if kernel_type == 1
   svm_paras = '-s 2 -n 0.5 -g 0.07 -q';
end

if kernel_type == 2
   svm_paras = '-s 2 -t 0 -n 0.5 -g 0.07 -q';
end

if kernel_type == 3
   svm_paras = '-s 2 -t 1 -n 0.5 -g 0.07 -q';
end

if kernel_type == 4
   svm_paras = '-s 2 -t 3 -n 0.5 -g 0.07 -q';
end

if kernel_type == 5
   
end

model = svmtrain(ones(size(xnn, 1), 1), xnn, svm_paras);
w = model.SVs'*model.sv_coef;
b = -model.rho;
[score, ind] = max(xnn*w + b);