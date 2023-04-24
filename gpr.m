% Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022
% It trains GPR model with data results.xlsx attached and generates gpr_workspace.mat and gpr55.m as outputs


% Uncomment as appropriate
%clc
%clear all
%close all

% reading the csv file as obtained by datasetcration.m file and save the results obtained by FE model in same csv file 
% from column 9 in E11, E22, nu12, G12, G23 order
tbl   = readtable('Provide path for csv file');
tbl   = table2array(tbl);
r     = 1;
for i=1:10:500 % Provide the number of training samples here
predictors = tbl(1:i,1:8);%input features
E22   = tbl(1:i,10);
nu12  = tbl(1:i,11);
G12   = tbl(1:i,12);
E11   = tbl(1:i,9);
G23   = tbl(1:i,13);

% creation of models and obtimization of hyperparameters
gprMdl1   = fitrgp(predictors,E22,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',200));
rng default
gprMdl2   = fitrgp(predictors,nu12,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',200));
gprMdl3   = fitrgp(predictors,G12,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',200));
gprMdl4   = fitrgp(predictors,G23,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',200));
gprMdl5   = fitrgp(predictors,E11,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',200));

% checking model accuracy
ypred1    = resubPredict(gprMdl1);                      % E22 predicted by gpr
ypred2    = resubPredict(gprMdl2);                      % nu12 predicted by gpr
test      = tbl(501:700,1:8);                           % test data
y_act22   = tbl(501:700,10);                            % actual values of e22 from test dataset
[y_result22,sd_22,y_act22ci] = predict(gprMdl1,test);   % prediction from gpr involving standard deviation, upper and lower bound 
err1(r,3) = mse(y_act22,y_result22)                     % error calculation of test dataset
err1(r,2) = resubLoss(gprMdl1);                         % error calculation of training dataset
err1(r,1) = i;

y_actn12  = tbl(501:700,11);
[y_resultn12,sd_n12,y_actn12ci] = predict(gprMdl2,test);
err2(r,3) = mse(y_actn12,y_resultn12)
err2(r,2) = resubLoss(gprMdl2);
err2(r,1) = i;

y_actg12  = tbl(501:700,12);
[y_resultg12,sd_g12,y_actg12ci] = predict(gprMdl3,test);
err3(r,3) = mse(y_actg12,y_resultg12)
err3(r,2) = resubLoss(gprMdl3);
err3(r,1) = i;

y_actg23  = tbl(501:700,13);
[y_resultg23,sd_g23,y_actg23ci] = predict(gprMdl4,test);
err4(r,3) = mse(y_actg23,y_resultg23)
err4(r,2) = resubLoss(gprMdl4);
err4(r,1) = i;

y_acte11  = tbl(501:700,9);
[y_resulte11,sd_e11,y_acte11ci] = predict(gprMdl5,test);
err5(r,3) = mse(y_acte11,y_resulte11)
err5(r,2) = resubLoss(gprMdl5);
err5(r,1) = i;

r=r+1
end
% save the workspace
hold off;
% figure(1);
% plot(y_act22,y_act22,'r');
% hold on
% plot(y_act22, y_result22, 'b.',"MarkerSize",15);
% xlabel('FEM predicted E22 value');
% ylabel('GPR predicted E22 value');
% 
% figure(2);
% plot(y_actn12,y_actn12,'r');
% hold on
% plot(y_actn12, y_resultn12, 'b.',"MarkerSize",15);
% xlabel('FEM predicted Nu12 value');
% ylabel('GPR predicted Nu12 value');
% 
% figure(3);
% plot(y_actg12,y_actg12,'r');
% hold on
% plot(y_actg12, y_resultg12, 'b.',"MarkerSize",15);
% hold on
% 
% % plot(y_actg23+(1.96*0.04),'b',"MarkerSize",10);
% % plot(y_resultg23,'black',"MarkerSize",15);
% % plot(y_actg23-(1.96*0.04),'r',"MarkerSize",10);
% % 
% % 
% % xlabel('samples');
% xlabel('FEM predicted G12 value');
% ylabel('GPR predicted G12 value');
% %legend('UPPER BOUND','GPR PREDICTION','LOWER BOUND')
% 
% figure(4);
% plot(y_actg23,y_actg23,'r');
% hold on
% plot(y_actg23, y_resultg23, 'b.',"MarkerSize",15);
% xlabel('FEM predicted G23 value');
% ylabel('GPR predicted G23 value');
% 
% figure(5);
% plot(y_acte11,y_acte11,'r');
% hold on
% plot(y_acte11, y_resulte11, 'b.',"MarkerSize",15);
% xlabel('FEM predicted E11 value');
% ylabel('GPR predicted E11 value');
