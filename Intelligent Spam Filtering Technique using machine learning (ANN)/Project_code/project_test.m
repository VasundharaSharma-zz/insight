
% Clearing Workspace before starting the Test Sequence
clearvars;
load ('abilene_data.mat'); % Contains the Abilene Traffic Data Set


% [~, ~, raw] = xlsread('C:\Users\Hiii\Documents\MATLAB\abilene_routers.xlsx');
%# Read the Router Names in the given data
routers = unique(abilene_routers);

total_sj_pairs = length(traffic(1,:));
mean_traffic_time_step1 = sum(traffic(1,:))/total_sj_pairs;
% disp(mean_traffic_time_step1);

%# Computing total traffic across each node(Router) at a given time step 

%# Setting Traffic time step value to 1 ; can be changed to read different time-step traffic values 
tstep = 2000;

%# traffic for the same AS Routing ie. src=dest
atla_st = traffic(tstep,1);
chin_st = traffic(tstep,13);
dnvr_st = traffic(tstep,25);
hstn_st = traffic(tstep,37);
ipls_st = traffic(tstep,49);
kscy_st = traffic(tstep,61);
losa_st = traffic(tstep,73);
nycm_st = traffic(tstep,85);
snva_st = traffic(tstep,97);
sstl_st = traffic(tstep,109);
wash_st = traffic(tstep,121);

%# Computing Total Traffic for each router at a given time step (sum of traffic across all direct links)

 atla_t = sum(traffic(tstep,4:5:11));
 chin_t = sum(traffic(tstep,16:19));
 dnvr_t = sum(traffic(tstep,28:31:32));
 hstn_t = sum(traffic(tstep,34:39:40));
 ipls_t = sum(traffic(tstep,45:46:50));
 kscy_t = sum(traffic(tstep,58:59:60));
 losa_t = sum(traffic(tstep,70:75));
 nycm_t = sum(traffic(tstep,79:88));
 snva_t = sum(traffic(tstep,91:95:98));
 sstl_t = sum(traffic(tstep,102:108));
 wash_t = sum(traffic(tstep,111:118));

%# Created a vector containing all the traffic values for the 11 routers
all_traffic = [atla_t chin_t dnvr_t hstn_t ipls_t kscy_t losa_t nycm_t snva_t sstl_t wash_t];

%# Computing Traffic between any source destination pair for each of router present in the topology

 atla_sd = sum(traffic(tstep,1:11));
 chin_sd = sum(traffic(tstep,12:22));
 dnvr_sd = sum(traffic(tstep,23:33));
 hstn_sd = sum(traffic(tstep,34:44));
 ipls_sd = sum(traffic(tstep,45:55));
 kscy_sd = sum(traffic(tstep,56:66));
 losa_sd = sum(traffic(tstep,67:77));
 nycm_sd = sum(traffic(tstep,78:88));
 snva_sd = sum(traffic(tstep,89:99));
 sstl_sd = sum(traffic(tstep,100:110));
 wash_sd = sum(traffic(tstep,111:121));
 
 all_traffic_sd = [atla_sd chin_sd dnvr_sd hstn_sd ipls_sd kscy_sd losa_sd nycm_sd snva_sd sstl_sd wash_sd];
 
 %# Computing CTS Values for all Routers
 
 for i=1:length(all_traffic_sd)
     router_cts(i) = all_traffic_sd(i)*0.09;
     disp(router_cts(i))
 end
 disp('Router CTS values:');
 disp(router_cts)
 
 %# Computing Effective Additional Sampling Cost for all Routers 
 
 for i=1:length(all_traffic_sd)
     router_sampling(i) = all_traffic_sd(i)/11;
     disp(router_sampling(i));
 end
 disp('Router Additional Sampling Cost:');
 disp(router_sampling); 
 
 %#calculating linear co-efficient for each router specific variable denoted by p(r); for r = 1 to 11
 
%# Calculating the Objective Function based on mimimizing the cost of not filtering malacious traffic
%  lc_atla = atla_sd - (router_cts(1)/2);
%  lc_chin = chin_sd - (router_cts(2)/2);
%  lc_dnvr = dnvr_sd - (router_cts(3)/2);
%  lc_hstn = hstn_sd - (router_cts(4)/2);
%  lc_ipls = ipls_sd - (router_cts(5)/2);
%  lc_kscy = kscy_sd - (router_cts(6)/2);
%  lc_losa = losa_sd - (router_cts(7)/2);
%  lc_nycm = nycm_sd - (router_cts(8)/2);
%  lc_snva = snva_sd - (router_cts(9)/2);
%  lc_sstl = sstl_sd - (router_cts(10)/2);
%  lc_wash = wash_sd - (router_cts(11)/2);

%# Calculating the Objective Function based on mimimizing the cost of not filtering malacious traffic + Sampling cost
%  lc_atla = atla_t + atla_sd - (router_cts(1)/2);
%  lc_chin = chin_t + chin_sd - (router_cts(2)/2);
%  lc_dnvr = dnvr_t + dnvr_sd - (router_cts(3)/2);
%  lc_hstn = hstn_t + hstn_sd - (router_cts(4)/2);
%  lc_ipls = ipls_t + ipls_sd - (router_cts(5)/2);
%  lc_kscy = kscy_t + kscy_sd - (router_cts(6)/2);
%  lc_losa = losa_t + losa_sd - (router_cts(7)/2);
%  lc_nycm = nycm_t + nycm_sd - (router_cts(8)/2);
%  lc_snva = snva_t + snva_sd - (router_cts(9)/2);
%  lc_sstl = sstl_t + sstl_sd - (router_cts(10)/2);
%  lc_wash = wash_t + wash_sd - (router_cts(11)/2);

%# Calculating the Objective Function based on mimimizing the per packet sampling cost on each router for all sd pairs
%  lc_atla = 0.1*router_cts(1) + atla_t - router_sampling(1);
%  lc_chin = 0.1*router_cts(2) + chin_t - router_sampling(2);
%  lc_dnvr = 0.1*router_cts(3) + hstn_t - router_sampling(3);
%  lc_hstn = 0.1*router_cts(4) + hstn_t - router_sampling(4);
%  lc_ipls = 0.1*router_cts(5) + ipls_t - router_sampling(5);
%  lc_kscy = 0.5*router_cts(6) + kscy_t - router_sampling(6);
%  lc_losa = 0.1*router_cts(7) + losa_t - router_sampling(7);
%  lc_nycm = 0.5*router_cts(8) + nycm_t - router_sampling(8);
%  lc_snva = 0.5*router_cts(9) + snva_t - router_sampling(9);
%  lc_sstl = 0.5*router_cts(10) + sstl_t - router_sampling(10);
%  lc_wash = 0.5*router_cts(11) + wash_t - router_sampling(11);
 
 lc_atla = 0.1*router_cts(1) + atla_t;
 lc_chin = 0.1*router_cts(2) + chin_t;
 lc_dnvr = 0.1*router_cts(3) + hstn_t;
 lc_hstn = 0.1*router_cts(4) + hstn_t;
 lc_ipls = 0.1*router_cts(5) + ipls_t;
 lc_kscy = 0.5*router_cts(6) + kscy_t;
 lc_losa = 0.1*router_cts(7) + losa_t;
 lc_nycm = 0.5*router_cts(8) + nycm_t;
 lc_snva = 0.5*router_cts(9) + snva_t;
 lc_sstl = 0.5*router_cts(10) + sstl_t;
 lc_wash = 0.5*router_cts(11) + wash_t;


%# defining function  

f=[lc_atla lc_chin lc_dnvr lc_hstn lc_ipls lc_kscy lc_losa lc_nycm lc_snva lc_sstl lc_wash];
% f = [444444444234 644444444565 64444444444565 7744444444898 8444444444999 544444444455 44444467 33344444443 844444448 8444444 84444488];
A=[];
B=[];
lb= zeros(11,1);
ub= ones(11,1);

M=[]; %# Filtering Rates are not integers, so M is not initialized
e=2^-16;
[filtering_rate, Cost, Algorithm_Status]= IP(f,A,B,[],[],lb,ub,M,e)

disp('The Obtained Filtering Rates for the Routers are:');
disp(filtering_rate);
for i=1:length(filtering_rate)
    total_filtered = all_traffic(i)*filtering_rate(i);
end

disp(total_filtered)


% f=[-17, -12]; %take the negative for maximization problems
% A=[ 10  7; 1 1];
% B=[40; 5];
% lb=[0 0];
% ub=[inf inf];
% M=[1,2];
% e=2^-24;
% [x v s]= IP(f,A,B,[],[],lb,ub,M,e)
