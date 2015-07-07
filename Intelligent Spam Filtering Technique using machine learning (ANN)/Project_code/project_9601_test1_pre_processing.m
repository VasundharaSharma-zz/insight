%# Author: Vasundhara Sharma email: vvasundh@uwo.ca
%# Project: ECE 9601A - LC Based Feature Extraction Approach for Spam Filtering
%# This Code file preprocesses the mail files for term selection and DS Generation using AIS concepts
clearvars;
clc;
%# Read all legitimate mail files to Class Cl Directory
pwd = 'C:\University\ECE-9601A\Project\Project_Dataset\PU_corpora\pu_corpora_public\pu2';
addpath(genpath(pwd));

vec =[];

fileName1 = 'mails/*legit*.txt';
fileName2 = 'mails/*spmsg*.txt';

startRow = 1;
endRow = inf;

files1 = dir(fullfile(pwd,fileName1));
files2 = dir(fullfile(pwd,fileName2));

%############################################################
%# Legitimate Mail Pre-Processing and DS creation Starts here
%############################################################

for i = 1:size(files1,1)
    count = 0;

      fid = fopen(files1(i,1).name);
      A{i} = textscan(fid, '%s', 'Delimiter',' ');
      n = length(A);
      fclose(fid);
      
end

for i = 1:n 
    B =(A{1,i}{1,1});
    b = transpose(B);
    p = length(b);
    %# Create Legitimate Mails Matrix 
    for x = 1:p 
     L(i,x) = b(:,x);
    end
    
end

%############################################################
%# Starting Term Selection from the Spam and Legitimate Mails
%############################################################

L = L(:,2:end); %# for omitting 'Subject' token from the list of terms
for i = 1:numel(L)  
   Ll{i} = num2str(L{i});
end

Legit = unique(Ll);

for i = 2:length(Legit)
    count = 0;
    for j = 1:size(files1,1)
      fid = fopen(files1(j,1).name);
      lines = textscan(fid,'%[^\n]'); %reads line by line 
      fclose(fid); 
      
      for k = 1:2 % to read the whole mail files for the tokens
         LL = strfind(lines{1,1}{k,1},Legit{i});
      end
%        fprintf('found in %s the token %d\n', files1(j,1).name,Spam{i});
         if ~isempty(LL)
         count = count + 1;
       end
    end
    %# can print to check the tokens and their count, takes time to execute
    fprintf('Token %s Count %d\n',Legit{i},count);
    %#Storing the tokens and their document frequency count 
    LT{1} = 0;
    LC{1} = 0;
    LT{i} = cell2mat(Legit(i));
    LC{i} = num2str(count);
    
end
%# Resulting Token List (in cells)
TC = [LT;LC];
TC = str2double(TC);
TC = transpose(TC);


%# Sorting TC to get the terms in descending order of frequency
LC_Sort = sortrows(TC,2);
% TC_Sort = str2double(TC_Sort);
%# Percentage of Tokens to be retained for Feature Extraction, denoted by m
m = 0.4;
out =  length(LC_Sort)*m;
out = uint32(out);
start = length(LC_Sort) - out;

%# Creating Preselected List of high frequency tokens
j = 0;
for i = start:(length(LC_Sort)- 1)
  j = j+1;
  presel_L{j} = LC_Sort(i);
end

%#######################################################
%# Spam Mail Pre-Processing and DS creation Starts here
%#######################################################

for j = 1:size(files2,1)
    fid = fopen(files2(j,1).name);
      P{j} = textscan(fid, '%s', 'Delimiter',' ');
      n = length(P);
      fclose(fid);
end
for i = 1:n 
    Q =(P{1,i}{1,1});
    q = transpose(Q);
    r = length(q);
    %# Create Spam Mails Matrix 
    for y = 1:r 
     S(i,y) = q(:,y);
    end
    
end

%# Starting Term Selection from the Spam Mails 
S = S(:,2:end); %# for omitting 'Subject' token from the list of terms
for i = 1:numel(S)  
   Sl{i} = num2str(S{i});
end

Spam = unique(Sl);

for i = 2:length(Spam)
    count = 0;
    for j = 1:size(files2,1)
      fid = fopen(files2(j,1).name);
      lines = textscan(fid,'%[^\n]'); %reads line by line 
      fclose(fid); 
      
      for k = 1:2 % to read the whole mail files for the tokens
         SL = strfind(lines{1,1}{k,1},Spam{i});
      end
%        fprintf('found in %s the token %d\n', files1(j,1).name,Spam{i});
         if ~isempty(SL)
         count = count + 1;
       end
    end
    %# can print to check the tokens and their count, takes time to execute
    fprintf('Token %s Count %d\n',Spam{i},count);
    %#Storing the tokens and their document frequency count 
    ST{1} = 0;
    SC{1} = 0;
    ST{i} = cell2mat(Spam(i));
    SC{i} = num2str(count);
    
end
%# Resulting Token List (in cells)
TC = [ST;SC];
TC = str2double(TC);
TC = transpose(TC);


%# Sorting TC to get the terms in descending order of frequency
TC_Sort = sortrows(TC,2);
% TC_Sort = str2double(TC_Sort);
%# Percentage of Tokens to be retained for Feature Extraction, denoted by m
m = 0.6;
out =  length(TC_Sort)*m;
out = uint32(out);
start = length(TC_Sort) - out;

%# Creating Preselected List of high frequency tokens
j = 0;
for i = start:(length(TC_Sort)- 1)
  j = j+1;
  presel_S{j} = TC_Sort(i);
end

save project_9601_workspace.mat;




    







