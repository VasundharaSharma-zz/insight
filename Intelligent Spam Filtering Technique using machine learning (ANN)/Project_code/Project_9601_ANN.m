
% Clearing Workspace before starting the Test Sequence
clc; clear all;
clearvars;
tic; %# for claculating ANN execution time
pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2';
addpath(genpath(pwd));
% declaring vector vec for storing the performance values for calculating
% mean and variance
vec =[];
load('project_9601_feature_vector.mat'); % Contains the Input data Matrix and Classifier Cell Array for the Spam PU2 Data Set
spam_Input = transpose(feature_matrix);


for i=1:10

inputs = spam_Input;
targets = spam_Target;

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing (Holdout Technique Used Here)
% For a list of all data division functions type: help nndivide
%#net.divideFcn = 'dividerand';  % Divide data randomly
%#net.divideMode = 'sample';  % Divide up every sample
%#net.divideParam.trainRatio = 70/100;
%#net.divideParam.valRatio = 15/100;
%#net.divideParam.testRatio = 15/100;
 N = length(inputs);
 
% These are the various CrossValidation and Iterative HoldOut Techniques used for the experiment. 
%#Indices = crossvalind('Resubstitution',N,[0.8,0.2]);
%#Indices = crossvalind('HoldOut',N,0.8);
%#Indices = crossvalind('LeaveMOut',N,2);
%#Indices = crossvalind('HoldOut',N,0.5);
%#Indices = crossvalind('Kfold',N,2);
Indices = crossvalind('Kfold',N,10);
for i=1:10
     test = (Indices == i); 
     train1 = ~test;

 
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainscg';  % Scaled conjugate gradient

% Choose a Performance Function
% Following Performance Metrics were Used in the Experiment 
%#net.performFcn = 'mae'; Mean Absolute Error
%#net.performFcn = 'sse'; Squared Sum Error
%#net.performFcn = 'sae'; Squared Absolute Error
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
% Train the Network
[net,tr] = train(net,inputs,targets);
a = sim(net,inputs(:,train1));
     b=sim(net,inputs(:,test));
end


% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};

% Capturing the Perf_Value for each run out of total 10 cycles

MSEval = tr.best_perf;
vec = [vec MSEval];

trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

% View the Network
%  view(net)

% Plots

% figure, plotperform(tr)
% figure, plottrainstate(tr)
 figure, plotconfusion(targets,outputs)
% figure, plotroc(targets,outputs)
% figure, ploterrhist(errors)
end
% Displaying the Vector with all the Error 
% calculate mean and variance for the Accuracy Rate of the Predicted Values
p = [];
n = length(vec);
for i = 1:n
    vec(i) = 100 - vec(i)*100;
    p(i) = i;
    
end
plot(p,vec);

M = mean(vec);
V = var(vec);
disp('Mean:')
disp(M)
disp('Variance:');
disp(V)
Timespent = toc;
disp('ANN spam classifier execution Time is:');
disp(Timespent);