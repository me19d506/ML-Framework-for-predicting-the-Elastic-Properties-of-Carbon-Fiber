% Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022

%{
This code is to identify the fiber properties using the UD lamina and
matrix properties by minimizing the difference between experimental and GPR
predictions.
%}


clc
clear all
close all

% Provide the elastic properties of UD lamina and matrix here c represents the composite
Em      = 3.7;
num     = 0.4;
Gm      =Em/(2*(1+num));

E11c    =135.37;
E22c    =11.36;
E33c    =11.53;
nu12c   =0.2;
nu13c   =0.17;
nu23c   =0.37;
G12c    =5.4;
G23c    =3.23;
G13c    =5.4;

Vf      =0.6;
Vm      =1-Vf;

% complaince and stiffness matrix for the given UD lamina and epoxy input properties
Sudact  = [(1/E11c) (-nu12c/E11c) (-nu13c/E11c) 0 0 0; (-nu12c/E11c) (1/E22c) (-nu23c/E22c) 0 0 0; (-nu13c/E11c) (-nu23c/E22c) (1/E33c) 0 0 0; 0 0 0 (1/G23c) 0 0; 0 0 0 0 (1/G13c) 0; 0 0 0 0 0 (1/G12c)];
Cudact  = inv(Sudact);
%
Sm      = [(1/Em) (-num/Em) (-num/Em) 0 0 0; (-num/Em) (1/Em) (-num/Em) 0 0 0; (-num/Em) (-num/Em) (1/Em) 0 0 0; 0 0 0 (1/Gm) 0 0; 0 0 0 0 (1/Gm) 0; 0 0 0 0 0 (1/Gm)];
Cm      = inv(Sm);
%
% Evaluating the initial guess (Cf{1}) from Rule-of-Mixture (ROM) and secondary (Cf{2}) from Mori-Tanaka(MT)
Cf{1}   = (Cudact - Vm*Cm)./Vf;                       %ROM
I       = eye( 6,6 );
zeta    = [0 0 0 0 0 0; (num/(2-2*num)) (5-(4*num))/(8-8*num) (4*num-1)/(8-8*num) 0 0 0; (num/(2-2*num)) (4*num-1)/(8-8*num) (5-(4*num))/(8-8*num) 0 0 0; 0 0 0 ((3-4*num)/(8-8*num)) 0 0; 0 0 0 0 1/4 0; 0 0 0 0 0 1/4]; % Eshelby tensor
Tf      = inv(I + zeta*((Sm*Cf{1}) - I));             % strain concentration factor
Cf{2}   = ((Cudact*(Vm*I+Vf*Tf))-Vm*Cm)*inv(Vf*Tf);   %MT
%
% Secant optimization scheme
%
% Predictions for first two iterations
for p=1:2
    Sf{p}    = inv(Cf{p});
    E1f{p}   = 1/Sf{p}(1,1);
    E2f{p}   = 1/Sf{p}(2,2);
    E3f{p}   = 1/Sf{p}(3,3);
    G23f{p}  = 1/(2*Sf{p}(4,4));
    G31f{p}  = 1/(2*Sf{p}(5,5));
    G12f{p}  = 1/(2*Sf{p}(6,6));
    nu12f{p} = E1f{p}*(-Sf{p}(1,2));
    nu13f{p} = E1f{p}*(-Sf{p}(1,3));
    nu23f{p} = E2f{p}*(-Sf{p}(2,3));
    
    % predicting UD lamina properties from trained GPR model for the given fiber properties 
    test1(p,:) = [cell2mat(E1f(1,p)) cell2mat(E2f(1,p)) cell2mat(nu12f(1,p)) cell2mat(G12f(1,p)) cell2mat(G23f(1,p)) Em num Vf]; 
    
    % stiffness and compliance matrix of the UD lamina predicted 
    pred_E22s{p}    = num2cell(predict(gprMdl1,(test1(p,:))));
    pred_E33s{p}    = pred_E22s{p};
    pred_nu12s{p}   = num2cell(predict(gprMdl2,(test1(p,:))));
    pred_nu13s{p}   = pred_nu12s{p};
    pred_G12s{p}    = num2cell(predict(gprMdl3,(test1(p,:))));
    pred_G23s{p}    = num2cell(predict(gprMdl4,(test1(p,:))));
    pred_E11s{p}    = num2cell(predict(gprMdl5,(test1(p,:))));
    pred_E22        = cell2mat(pred_E22s{p});
    pred_E33        = cell2mat(pred_E33s{p});
    pred_nu12       = cell2mat(pred_nu12s{p});
    pred_nu13       = cell2mat(pred_nu13s{p});
    pred_G12        = cell2mat(pred_G12s{p});
    pred_G23        = cell2mat(pred_G23s{p});
    pred_E11        = cell2mat(pred_E11s{p});
    pred_nu23       = (pred_E22/(2*pred_G23))-1;
    pred_G13        = pred_G12;
    Sudml{p}        = [(1/pred_E11) (-pred_nu12/pred_E11) (-pred_nu13/pred_E11) 0 0 0; (-pred_nu12/pred_E11) (1/pred_E22) (-pred_nu23/pred_E22) 0 0 0; (-pred_nu13/pred_E11) (-pred_nu23/pred_E22) (1/pred_E33) 0 0 0; 0 0 0 (1/pred_G23) 0 0; 0 0 0 0 (1/pred_G13) 0; 0 0 0 0 0 (1/pred_G12)];
    Cudml{p}        = inv(Sudml{p});
end
%evaluating the difference between actual and predicted stiffness matrix
phi{1} = Cudact - cell2mat(Cudml(1,1));         % difference between actual and predicted(ROM)
phi{2} = Cudact - cell2mat(Cudml(1,2));         % difference between actual and predicted(MT)
o=10^-6;
iteration=0;

% evaluating for the iterations greateer than two
for h=3:5
    % solving matrix element wise
    for m=1:3
        for n=1:3
            Cf{h}(m,n) = Cf{h-1}(m,n) - (phi{h-1}(m,n))*(Cf{h-1}(m,n) - Cf{h-2}(m,n))/(phi{h-1}(m,n) - phi{h-2}(m,n));
        end
    end
    for m=4:6
            Cf{h}(m,m) = Cf{h-1}(m,m) - (phi{h-1}(m,m))*(Cf{h-1}(m,m) - Cf{h-2}(m,m))/(phi{h-1}(m,m) - phi{h-2}(m,m));
    end
    
     Sf{h}          = inv(Cf{h});
     E1f{h}         = 1/Sf{h}(1,1);
     E2f{h}         = 1/Sf{h}(2,2);
     E3f{h}         = 1/Sf{h}(3,3);
     G23f{h}        = 1/(2*Sf{h}(4,4));
     G31f{h}        = 1/(2*Sf{h}(5,5));
     G12f{h}        = 1/(2*Sf{h}(6,6));
     nu12f{h}       = E1f{h}*(-Sf{h}(1,2));
     nu13f{h}       = E1f{h}*(-Sf{h}(1,3));
     nu23f{h}       = E2f{h}*(-Sf{h}(2,3));
     test1(h,:)     = [cell2mat(E1f(1,h)) cell2mat(E2f(1,h)) cell2mat(nu12f(1,h)) cell2mat(G12f(1,h)) cell2mat(G23f(1,h)) Em num Vf];% fiber properties
     pred_E22s{h}   = num2cell(predict(gprMdl1,(test1(h,:))));
     pred_E33s{h}   = pred_E22s{h};
     pred_nu12s{h}  = num2cell(predict(gprMdl2,(test1(h,:))));
     pred_nu13s{h}  = pred_nu12s{h};
     pred_G12s{h}   = num2cell(predict(gprMdl3,(test1(h,:))));
     pred_G23s{h}   = num2cell(predict(gprMdl4,(test1(h,:))));
     pred_E11s{h}   = num2cell(predict(gprMdl5,(test1(h,:))));

     pred_E22       = cell2mat(pred_E22s{h}); 
     pred_E33       = cell2mat(pred_E33s{h});
     pred_nu12      = cell2mat(pred_nu12s{h});
     pred_nu13      = cell2mat(pred_nu13s{h});
     pred_G12       = cell2mat(pred_G12s{h});
     pred_G23       = cell2mat(pred_G23s{h});
     pred_E11       = cell2mat(pred_E11s{h});
     pred_nu23      = (pred_E22/(2*pred_G23))-1;
     pred_G13       = pred_G12;
     Sudml{h}       = [(1/pred_E11) (-pred_nu12/pred_E11) (-pred_nu13/pred_E11) 0 0 0; (-pred_nu12/pred_E11) (1/pred_E22) (-pred_nu23/pred_E22) 0 0 0; (-pred_nu13/pred_E11) (-pred_nu23/pred_E22) (1/pred_E33) 0 0 0; 0 0 0 (1/pred_G23) 0 0; 0 0 0 0 (1/pred_G13) 0; 0 0 0 0 0 (1/pred_G12)];
     Cudml{h}       = inv(Sudml{h});
     term           = cell2mat(Cudml(1,h));
     phi{h}         = Cudact - term;
     iteration      =iteration+1;
     
     
     % if the difference is less than the tolerance stop the iterations and
     % Cf matric in that iteration will be the stiffness matrix of fibers
     if max(abs(phi{h}))<o %(stopping condition )
         break
     end
end 
      




