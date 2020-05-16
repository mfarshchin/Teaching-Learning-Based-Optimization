function TLBOTruss

%% This function implements the basic Teaching Learning Based Optimization (TLBO) algorithm for truss optimization
% For more information about this method and a more efficient TLBO
% algorithm check the following paper: 
% References: 
% 1: Multi-class teaching–learning-based optimization for truss design with
% frequency constraints  (http://www.sciencedirect.com/science/article/pii/S0141029615006732)
% 2: Design of space trusses using modified teaching learning based
% optimization (http://www.sciencedirect.com/science/article/pii/S0141029614000236)
% Programmer: Mohammad Farshchin, Ph.D candidate at The UofM
% Email: Mohammad.Farshchin@gmail.com
% Last modified: Nov 2012

%% Initialization
global D

%% Optimization parameters
D=Data10;                                                                  % Read design parameters of the benchmark 10-bar truss from Data10 file
TL.Itmax=200;                                                              % Maximum number of iterations
TL.PopSize=75;                                                             % Population size
TL.LB=D.LB;                                                                % Lowerbound row vector (LB)
TL.UB=D.UB;                                                                % Upperbound row vector (UB)

%% Randomely generate initial designs between LB and UB
Cycle=1;
for I=1:TL.PopSize
    Designs(I,:)=TL.LB+rand(1,size(TL.LB,2)).*(TL.UB-TL.LB);               % Row vector
end

%% TLBO main loop
Best{1}=[];
for Cycle=2:TL.Itmax
    %% Evaluate the designs generated in the previous iteration
    [PObj,Obj]=Analyser(Designs);
    %% Specify best designs and keep them
    [Best{Cycle},Designs,PObj,WMeanPos]=Specifier(PObj,Obj,Designs,Best{Cycle-1});
    %% Apply Teaching 
    [Designs,PObj,Obj]=Teaching(TL,Designs,PObj,Obj,Best{Cycle}.GBest.Design,WMeanPos);
    [Best{Cycle},Designs,PObj,WMeanPos]=Specifier(PObj,Obj,Designs,Best{Cycle-1});
    %% Apply Learning
    [Designs]=Learning(TL,Designs,PObj);
    % Plot time history of the best solution vs. iteration
    hold on;plot(Cycle,Best{Cycle}.GBest.PObj,'b*');xlabel('Iteration');ylabel('Best solution');pause(0.0001)
    % Print current best solution
    fprintf('Cycle=%3d & Best solution=%6.8g\n',Cycle,Best{Cycle}.GBest.PObj)
end

%% Save results
save('TimeHist.mat','Best')