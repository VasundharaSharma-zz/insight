clearvars;
clc;
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
   
disp(class_matrix);
