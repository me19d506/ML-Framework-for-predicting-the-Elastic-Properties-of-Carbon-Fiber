% Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022
% It Generates attribute (fiber and matrix properties, and fiber volume fraction) values of each instance for PAN based carbon fiber and 
% epoxy matrix by latin hypercube sampling (LHS) within the bounds specified
% The data generated is represented in Figure3 of the manuscript


% Uncomment as appropriate
% clc
% clear all
% close all

%% latin hypercube dataset generation
n=1000; % no. of dataset

% Elastic Properties of the fiber - assumed to be transversely isotropic 
% Make sure lhsu.m should be along with this code to call the function and set the attribute values.
E1f     = lhs(160,600,n); % in GPA
E2f     = lhs(8,30,n); % in GPA
nu12f   = lhs(0.2,0.4,n);
G12f    =  lhs(2,40,n);% in GPA
nu23f   = lhs(0.05,0.5,n);
G23f    = (E2f./2.*(1+nu23f));% in GPA

% Elastic Properties of the matrix - assumed to be isotropic
Em      = lhs(0.5,20,n);% in GPA
num     = lhs(0.3,0.49,n);
Gm      = (Em./(2.*(1+num)));

% Volume fraction of the composite
Vf      = lhs(0.3,0.7,n);
 
% Generate the samples
INPUT_p = [E1f E2f nu12f G12f G23f nu23f Em num Gm Vf];
INPUT   = round(INPUT,1);% rounded to 1 place of decimel

% save the INPUT to csv file 
