% The code has been taken from MATLAB CENTRAL file exchange written by Budiman Minasny(https://www.mathworks.com/matlabcentral/fileexchange/4352-latin-hypercube-sampling).

% function for latin hypercube sampling.
function s=lhs(xmin,xmax,nsample)
% s=lhs(xmin,xmax,nsample)
% LHS from uniform distribution
% Input:
%   xmin    : min of data (1,nvar)
%   xmax    : max of data (1,nvar)
%   nsample : no. of samples
% Output:
%   s       : random sample (nsample,nvar)
%   Budiman (2003)
nvar  =length(xmin);
ran   =rand(nsample,nvar);
s     =zeros(nsample,nvar);
for j=1: nvar
   idx      =randperm(nsample);
   P        =(idx'-ran(:,j))/nsample;
   s(:,j)   =xmin(j) + P.* (xmax(j)-xmin(j));
end
