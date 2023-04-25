% Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022

% function is for latin hypercube sampling from uniform distribution.
% reqires min,max and number of samples as input
function f=lhs(min,max,nsample)
nv      =length(min);                               %number of variables
f       =zeros(nsample,nv); 
random  =rand(nsample,nv);                          %random numbers 
            
for k=1: nv
   indx     = randperm(nsample);                    %random permutation of the integers from 1 to nsample without repeating elements.
   P        = (indx'-random(:,k))/nsample;
   f(:,k)   = min(k) + P.* (max(k)-min(k));
end
