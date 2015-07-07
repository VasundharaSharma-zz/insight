%# Author: Vasundhara Sharma email: vvasundh@uwo.ca
%# Project: ECE 9601A - LC Based Feature Extraction Approach for Spam Filtering
%# This Code File uses the Detector Sets and applies Sliding Windows over the mails to generate Feature Vectors
clc;
%# Read all legitimate mail files to Class Cl Directory
pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2';
addpath(genpath(pwd));
load('project_9601_workspace.mat');

fileName = 'part1/*.txt';


startRow = 1;
endRow = inf;

files = dir(fullfile(pwd,fileName));


for i = 2:size(files,1)
    count = 0;
      % disp(files(i,1).name);
      fid = fopen(files(i,1).name);
      A{i} = textscan(fid, '%s', 'Delimiter',' ');
      n = length(A);
      fclose(fid);
      
end

%# Sliding Window Code for creating Feature Vectors

numwin = 10; %# Number of Sliding Windows Applied 
winsize = 5; %# Number of terms in each window
presel_S = cell2mat(presel_S);
presel_L = cell2mat(presel_L);
DS = presel_S; %# Spam Detector Set generated from previous Code
LS = presel_L; %# Legitimate Detector Set generated from previous Code


%# code to compare all the F values (for each file to presel and calculate the density of spam mails)

%#################################################################################
%# Sliding Window Loop 1:
%#################################################################################
for j = 1:n %# total number of files in the set 
    
    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win1 = F(2:winsize,1); %# Change each iteration manually to generate each column of feature vector
    win1 = cellfun(@(x)str2double(x), win1);
    count = 0;
    for x = 1:length(DS)
        for y = 1:length(win1)
            if(win1(y) == DS(x))
                count = count + 1;
            end
        end
        
    end
     SConc1{j,1} = count/winsize;   
    
end


%# code to compare all the F values (for each file to presel and calculate the density of legitimate mails)
for j = 1:n %# total number of files in the set 

    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win1 = F(2:winsize,1); %# Change each iteration manually to generate each column of feature vector
    win1 = cellfun(@(x)str2double(x), win1);
    count = 0;
    for x = 1:length(LS)
        for y = 1:length(win1)
            if(win1(y) == LS(x))
                count = count + 1;
            end
        end
        
    end
     LConc1{j,1} = count/winsize;   
    
end

%#################################################################################
%# Sliding Window Loop 2:
%#################################################################################


for j = 1:n %# total number of files in the set 
    
    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win2 = F(winsize+1:winsize*2,1); %# Change each iteration manually to generate each column of feature vector
    win2 = cellfun(@(x)str2double(x), win2);
    count = 0;
    for x = 1:length(DS)
        for y = 1:length(win2)
            if(win2(y) == DS(x))
                count = count + 1;
            end
        end
        
    end
     SConc2{j,1} = count/winsize;   
    
  end


%# code to compare all the F values (for each file to presel and calculate the density of legitimate mails)
for j = 1:n %# total number of files in the set 

    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win2 = F(winsize+1:winsize*2,1); %# Change each iteration manually to generate each column of feature vector
    win2 = cellfun(@(x)str2double(x), win2);
    count = 0;
    for x = 1:length(LS)
        for y = 1:length(win2)
            if(win2(y) == LS(x))
                count = count + 1;
            end
        end
        
    end
     LConc2{j,1} = count/winsize;   
    
end


%#################################################################################
%# Sliding Window Loop 3:
%#################################################################################


for j = 1:n %# total number of files in the set 
    
    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win3 = F(winsize*2+1:winsize*3,1); %# Change each iteration manually to generate each column of feature vector
    win3 = cellfun(@(x)str2double(x), win3);
    count = 0;
    for x = 1:length(DS)
        for y = 1:length(win3)
            if(win3(y) == DS(x))
                count = count + 1;
            end
        end
        
    end
     SConc3{j,1} = count/winsize;   
    
  end


%# code to compare all the F values (for each file to presel and calculate the density of legitimate mails)
for j = 1:n %# total number of files in the set 

    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win3 = F(winsize*2+1:winsize*3,1); %# Change each iteration manually to generate each column of feature vector
    win3 = cellfun(@(x)str2double(x), win3);
    count = 0;
    for x = 1:length(LS)
        for y = 1:length(win3)
            if(win3(y) == LS(x))
                count = count + 1;
            end
        end
        
    end
     LConc3{j,1} = count/winsize;   
    
end


%#################################################################################
%# Sliding Window Loop 4:
%#################################################################################


for j = 1:n %# total number of files in the set 
    
    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win4 = F(winsize*3+1:winsize*4,1); %# Change each iteration manually to generate each column of feature vector
    win4 = cellfun(@(x)str2double(x), win4);
    count = 0;
    for x = 1:length(DS)
        for y = 1:length(win4)
            if(win4(y) == DS(x))
                count = count + 1;
            end
        end
        
    end
     SConc4{j,1} = count/winsize;   
    
  end


%# code to compare all the F values (for each file to presel and calculate the density of legitimate mails)
for j = 1:n %# total number of files in the set 

    F =(A{1,j}{1,1}); %# Read each file for each winterms size

    win4 = F(winsize*3+1:winsize*4,1); %# Change each iteration manually to generate each column of feature vector
    win4 = cellfun(@(x)str2double(x), win4);
    count = 0;
    for x = 1:length(LS)
        for y = 1:length(win4)
            if(win4(y) == LS(x))
                count = count + 1;
            end
        end
        
    end
     LConc4{j,1} = count/winsize;   
    
end

%######################################################################
%# Creating Feature Vector from the Local Spam and Legit Densities
%######################################################################


	feature_matrix = [SConc1,LConc1,SConc2,LConc2,SConc3,LConc3,SConc4,LConc4];
    feature_matrix = cell2mat(feature_matrix);
    disp(feature_matrix);


%#######################################
%# Creating Mail Types for SVM Training
%#######################################

%# Defining Naming patterns for spam and legitimate mails for deriving class matrix
spam_email = '\d+spmsg\d+\.txt';
legit_email = '\d+legit\d+\.txt';


pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2\part1/*.txt';
files=dir(pwd);
for i = 1:length(files)
    val = 2;
    name=files(i).name;
    disp(name);
    val = isempty(regexpi(name,spam_email,'match'));
    switch val
        case 0
            value = 'S';
        case 1
            value = 'L';
    end
    class_matrix{i} = value; 
end
class_matrix = transpose(class_matrix);   
disp(class_matrix);

%#######################################
%# Creating Mail Types for ANN Training
%#######################################

%# Defining Naming patterns for spam and legitimate mails for deriving class matrix
spam_email = '\d+spmsg\d+\.txt';
legit_email = '\d+legit\d+\.txt';


pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2\part1/*.txt';
files=dir(pwd);
for i = 1:length(files)
    val = 2;
    name=files(i).name;
    disp(name);
    val = isempty(regexpi(name,spam_email,'match'));
    switch val
        case 0
            value1 = 0;
            value2 = 1;
        case 1
            value1 = 1;
            value2 = 0;
    end
    spam_class1{i} = value1;
    spam_class2{i} = value2;
end
 
spam_Target1 = [spam_class1;spam_class2];
spam_Target = cell2mat(spam_Target1);
disp(spam_Target);

save project_9601_workspace.mat;
save project_9601_feature_vector.mat;

    
    
    
