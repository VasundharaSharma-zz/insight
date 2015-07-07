%# Author: Vasundhara Sharma email: vvasundh@uwo.ca
%# Project: ECE 9601A - LC Based Feature Extraction Approach for Spam Filtering
%# This Code evaluates svm Classification for the Spam Filtering Feature Vector
clc; clear all;
clearvars;
tic; %# for evaluating SVM classifier execution time 
pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2';
addpath(genpath(pwd));
load('project_9601_workspace.mat');
load('project_9601_feature_vector.mat'); % The Workspace has the vector 'maildata' with the data for all the features and cell array 'mailtype' with the classification 
vec =[];

for l=1:10 %# no. of loops for the same experiment

[~,~,labels]            = unique(class_matrix);% Labels: S/L
data                    = zscore(feature_matrix); % Scale features
numInst                 = size(data,1);
numLabels               = max(labels);
options = optimset('maxiter',1000000);
xdata=feature_matrix(1:end,:); % taking all features of the Spam data set for evaluation
group=class_matrix(1:end,1);
 %# Validation technique 10-fold is used in this experiment for its predictive accuracy
 indices = crossvalind('Kfold',group,10);
       
       cr = classperf(group);
          for i = 1:10
           test = (indices == i); train = ~test;
          
         %# different training kernel functions have been used in this experiment.

         %#svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
         %#          'kernel_function','rbf', 'rbf_sigma',0.4, 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'QP');
         %#svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
          %#          'kernel_function','rbf', 'rbf_sigma',8, 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'QP');
         %#svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
          %#          'kernel_function','polynomial', 'polyorder', 1, 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'QP','quadprog_opts', options);
         %# Commenting Other Kernel Functions
         %#svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
         %#   'kernel_function','quadratic', 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'QP', 'quadprog_opts', options);
         svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
                   'kernel_function','linear', 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'QP');
         %#svmStruct = svmtrain(feature_matrix(train,:),class_matrix(train,:), ...
         %#          'kernel_function','mlp', 'boxconstraint', Inf, 'boxC',10^-1, 'Method', 'SMO');
         OutLabel = svmclassify(svmStruct,feature_matrix(test,:));
         cr = classperf(cr, OutLabel, test);
         end
%# Evaluate the performance of the svm classification       
disp('Predictive Error in SVM classification is:');
cr.ErrorRate
%# get accuracy
disp('Predictive Accuracy in SVM classification is:');
cr.CorrectRate
Aval = cr.CorrectRate;
vec = [vec Aval];

%# get confusion matrix
%# columns:actual, rows:predicted, last-row: unclassified instances
disp('Obtained Confusion Matrix:');
cr.CountingMatrix
end

% Plotting Accuracy Percentage for the range of 10 readings
n = length(vec);
p = [];
for i = 1:n
    vec(i) = vec(i)*100;
    p(i) = i;
end

figure
plot(p,vec)
title('Accuracy Plot for SVM quadratic kernel');
h = xlabel('no. of readings for a single experiment');
t = ylabel('accuracy prediction in percentage');
set(h,'Color','blue');
set(t,'Color','blue')
axis([1 10 95 100]);
axis normal;

% Calculating Mean and Variance for the accurate prediction
M = mean(vec);
V = var(vec);
disp('Mean:')
disp(M)
disp('Variance:');
disp(V)
Timespent = toc;
disp('SVM spam classifier execution Time is:');
disp(Timespent);

