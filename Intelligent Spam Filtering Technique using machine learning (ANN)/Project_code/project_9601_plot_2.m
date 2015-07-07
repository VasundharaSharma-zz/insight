 x = 0.1:0.1:0.9;
 recall = [82.1,80.4,89.3,92.2,97.6,97.6,97.6,97.6,97.6];
 precision = [97.4,97.4,98.7,98.8,99.4,100.0,100.0,87.23,91.2];
 accu = [94.4,94.0,96.8,97.7,99.2,99.5,99.5,96.7,92.5];
 f1 = [89.1,88.1,93.8,95.4,98.5,98.7,98.7,92.1,94.3];
 
% m = ['h','o','*','.','x','s','d','^','v','>','<','p','h'];


plot(x,recall,'--r*',x,precision,'-.bo',x,accu,':gx',x,f1,'-mv');
 
 legend('recall','precision','accuracy','f1');
 ylabel('Measure values');
 xlabel('The Percentage of terms selected');