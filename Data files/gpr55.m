% Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022
% This code is to evaluate the UD lamina properties from the fiber properties using GPR model
% provide the input data in to "test_vaidya" array in this code to evaluate corresponding composite properties usign GPR

clc
clear all
close all
tbl   = readtable('C:\Users\JAI SHREE KRISHNA\Downloads\gprsev.csv');
tbl   = table2array(tbl);
r=1;
for i=734
predictors = tbl(1:i,1:8);
E22   = tbl(1:i,10);
nu12  = tbl(1:i,11);
G12   = tbl(1:i,12);
E11   = tbl(1:i,9);
G23   = tbl(1:i,13);
%gprMdl1  = fitrgp(predictors,E22,'OptimizeHyperparameters',{'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',10));
rng default
% gprMdl2   = fitrgp(predictors, nu12, 'OptimizeHyperparameters', {'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',10));
% gprMdl3   = fitrgp(predictors, G12 , 'OptimizeHyperparameters', {'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',30));
gprMdl4     = fitrgp(predictors, G23 , 'OptimizeHyperparameters', {'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',30));
% gprMdl5   = fitrgp(predictors, E11 , 'OptimizeHyperparameters', {'KernelFunction','Sigma'},  'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations',10));
% gprMdl2   = fitrgp(predictors, E22 , 'KernelFunction','rationalquadratic',...

%'OptimizeHyprparameters','auto','HyperparameterOptimizationOptions',...
%struct('AcquisitionFunctionName','expected-improvement-plus'));
%ypred1 = resubPredict(gprMdl1);
%ypred2 = resubPredict(gprMdl2);

test        = tbl(487:686,1:8);
y_act22     = tbl(487:686,10);
test1= tbl(1:9,1:8);
[y_result22,ysd22,y_act22ci] = predict(gprMdl1,test);
err1(r,3)   = mse(y_act22,y_result22)
err1(r,2)   = resubLoss(gprMdl1);
err1(r,1)   = i;

y_actn12    = tbl(187:686,11);
[y_resultn12,~,y_actn12ci] = predict(gprMdl2,test1);
err2(r,3)   = mse(y_actn12,y_resultn12)
err2(r,2)   = resubLoss(gprMdl2);
err2(r,1)   = i;

y_actg12    = tbl(187:686,12);
[y_resultg12,yg12sd,y_actg12ci] = predict(gprMdl3,test);
err3(r,3)   = mse(y_actg12,y_resultg12)
err3(r,2)   = resubLoss(gprMdl3);
err3(r,1)   = i;

y_actg23    = tbl(1:734,13);
[y_resultg23,ysdg23,y_actg23ci] = predict(gprMdl4,test);
err4(r,3)   = mse(y_actg23,y_resultg23)
err4(r,2)   = resubLoss(gprMdl4);
err4(r,1)   = i;

y_acte11    = tbl(187:686,9);
[y_resulte11,~,y_acte11ci] = predict(gprMdl5,test1);
err5(r,3)   = mse(y_acte11,y_resulte11)
err5(r,2)   = resubLoss(gprMdl5);
err5(r,1)   = i;
r=r+1
end

hold off;
figure(1);
plot(y_act22,y_act22,'r');
hold on
plot(y_act22, y_result22, 'b.',"MarkerSize",15);
xlabel('FEM predicted E22 value');
ylabel('GPR predicted E22 value');

figure(2);
plot(y_actn12,y_actn12,'r');
hold on
plot(y_actn12, y_resultn12, 'b.',"MarkerSize",15);
xlabel('FEM predicted Nu12 value');
ylabel('GPR predicted Nu12 value');

figure(3);
plot(y_actg12,y_actg12,'r');
hold on
plot(y_actg12, y_resultg12, 'b.',"MarkerSize",15);
hold on

% plot(y_actg23+(1.96*0.04),'b',"MarkerSize",10);
% plot(y_resultg23,'black',"MarkerSize",15);
% plot(y_actg23-(1.96*0.04),'r',"MarkerSize",10);
% 
% 
% xlabel('samples');
xlabel('FEM predicted G12 value');
ylabel('GPR predicted G12 value');
%legend('UPPER BOUND','GPR PREDICTION','LOWER BOUND')

figure(4);
plot(y_actg23,y_actg23,'r');
hold on
plot(y_actg23, y_resultg23, 'b.',"MarkerSize",15);
xlabel('FEM predicted G23 value');
ylabel('GPR predicted G23 value');

figure(5);
plot(y_acte11,y_acte11,'r');
hold on
plot(y_acte11, y_resulte11, 'b.',"MarkerSize",15);
xlabel('FEM predicted E11 value');
ylabel('GPR predicted E11 value');

test_vaidya = [230.00 15.00 0.20 15.00 7.00 4.00 0.35 0.60
496.52 06.38 0.25 17.92 02.78 3.50 0.38 0.55
224.62 14.77 0.44 17.49 05.38 4.00 0.37 0.56
348.00 14.60 0.37 4.80 9.70 3.40 0.33 0.50
265.30 15.70 0.22 15.80 8.50 18.00 0.36 0.50
594.60 24.70 0.34 17.50 16.20 10.60 0.35 0.30
222.00 11.50 0.24 19.70 6.50 19.70 0.39 0.69
263.80 15.90 0.34 30.10 11.20 9.50 0.48 0.30
223.60 20.50 0.37 7.20 11.60 15.90 0.34 0.30
487.10 16.60 0.34 37.20 12.30 16.80 0.39 0.40];

[y_resulte22vaidya,~,test_vaidya22ci]     = predict(gprMdl1,test_vaidya)
%[y_resultn12vaidya,~,test_vaidyan12ci]   = predict(gprMdl2,unnamed)
[y_resultg12vaidya,~,test_vaidyag12ci]    = predict(gprMdl3,test_vaidya)
[y_resultg23vaidya,~,test_vaidyag23ci]    = predict(gprMdl4,test_vaidya)
%[y_resulte11vaidya,~,test_vaidya11ci]    = predict(gprMdl5,test_vaidya)

std11    = sqrt(((test_vaidya11ci(:,2) - y_resulte11vaidya ).^2 + (test_vaidya11ci(:,1) - y_resulte11vaidya).^2)./2)
std22    = sqrt(((test_vaidya22ci(:,2) - y_resulte22vaidya).^2 + (test_vaidya22ci(:,1) - y_resulte22vaidya).^2)./2)
stdn12   = sqrt(((test_vaidyan12ci(:,2) - y_resultn12vaidya).^2 + (test_vaidyan12ci(:,1) - y_resultn12vaidya).^2)./2)
stdg12   = sqrt(((test_vaidyag12ci(:,2) - y_resultg12vaidya).^2 + ( test_vaidyag12ci(:,2)- y_resultg12vaidya).^2)./2)
stdg23   = sqrt(((test_vaidya11ci(:,2) - y_resulte11vaidya).^2 + (y_resulte11vaidya - y_resulte11vaidya).^2)./2)
 
figure(6);
x_axis   = 1:500;
x_plot   =[x_axis, fliplr(x_axis)];
hold on;
y_plot   = [y_act22ci(:,1)',flipud(y_act22ci(:,2))'];
%xlim([0 50])
plot(x_axis,y_result22,'b' )
plot(x_axis,y_act22,'black')
fill(x_plot,y_plot,1,'facecolor','red','edgecolor','none','facealpha','0.4');
ylabel('E22 value');
xlabel('Test samples');
legend('GPR','Actual', 'Bound');

hold off;

figure(7);
plot(y_actn12, 'r');
hold on;
plot(y_resultn12,'b');
plot(y_actn12ci(:,2),'k:');
plot(y_actn12ci(:,1),'k:');
ylabel('Nu12 value');
xlabel('Test samples');
legend('Actual','GPR','Upper Bound','Lower Bound');

hold off;

figure(8);
y_plot = [y_actg23ci(:,1)',flipud(y_actg23ci(:,2))'];
plot(y_actg12,'r');
hold on;
plot(y_resultg12,'b');
plot(y_actg12ci(:,2),'k:');
plot(y_actg12ci(:,1),'k:');
ylabel('G12 value');
xlabel('Test samples');
legend('Actual','GPR','Upper Bound','Lower Bound');

hold off;

figure(9);
plot(y_actg23,'r');
hold on;
plot(y_resultg23,'b');
plot(y_actg23ci(:,2),'k:');
plot(y_actg23ci(:,1),'k:');
ylabel('G23 value');
xlabel('Test samples');
legend('Actual','GPR','Upper Bound','Lower Bound');

hold off;

figure(10);
plot(y_acte11,'r');
hold on;
plot(y_resulte11,'b');
plot(y_acte11ci(:,2),'k:');
plot(y_acte11ci(:,1),'k:');
ylabel('E11 value');
xlabel('Test samples');
legend('Actual','GPR','Upper Bound','Lower Bound');

hold off;

std11    = sqrt(((y_acte11ci(:,2) - y_resulte11).^2 + (y_acte11ci(:,1) - y_acte11).^2)./2);
std22    = sqrt(((y_act22ci(:,2) - y_result22).^2 + (y_act22ci(:,1) - y_act22).^2)./2);
stdn12   = sqrt(((y_actn12ci(:,2) - y_resultn12).^2 + (y_actn12ci(:,1) - y_actn12).^2)./2);
stdg12   = sqrt(((y_actg12ci(:,2) - y_resultg12).^2 + (y_actg12ci(:,1) - y_actg12).^2)./2);
stdg23   = sqrt(((y_actg23ci(:,2) - y_resultg23).^2 + (y_actg23ci(:,1) - y_actg23).^2)./2);

plot(std11, 'r')
hold on;
plot(std22, 'b')
plot(stdn12, 'g')
plot(stdg12, 'black')
plot(stdg23, 'm')
legend('E11','E22','Nu12','G12','G23')

%% pearson
[y_resulte22p,~,tp22ci]    = predict(gprMdl1,INPUT_p)
[y_resultn12p,~,p12ci]     = predict(gprMdl2,INPUT_p)
[y_resultg12p,~,pg12ci]    = predict(gprMdl3,INPUT_p)
[y_resultg23p,~,pg23ci]    = predict(gprMdl4,INPUT_p)
[y_resulte11p,~,p11ci]     = predict(gprMdl5,INPUT_p)

[rho,PVAL]  = corr(INPUT_p,y_resulte22p,'type','Spearman')
histogram(rho)
barh(rho)

%% SHAP
explainer   = shapley(gprMdl1)

x = y_plot';

plot(unnamed(:,1),'b')
hold on;
plot(unnamed(:,2),'r')

