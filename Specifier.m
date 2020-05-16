function [NewBest,Designs,PObj,WMeanPos]=Specifier(PObj,Obj,Designs,PreviousBest)

%% This function is to find the best individuals

%% Sort new results
[~,b]=sort(PObj);                                                          % Sort Penalized objective values
Designs=Designs(b,:);                                                      % Sorted designs
Obj=Obj(b,:);                                                              % Sorted objectives
PObj=PObj(b,:);                                                            % Sorted penalized objectives

%% Find mean of each design variable 
WMeanPos=mean(Designs);                                                    % Mean position

%% Find the bests
GBest.PObj=PObj(1);                                                        % Current best
GBest.Obj=Obj(1);                                                          % Current best
GBest.Design=Designs(1,:);                                                 % Current best

% Find current best non penalized individual
C=find(PObj==Obj);
if isempty(C)==1
    NP.Obj=[];
    NP.Design=[];
else
    C=C(1);
    NP.Obj=PObj(C);
    NP.Design=Designs(C,:);
end

%% Compare the current bests with previous ones

if isempty(PreviousBest)==1
    NewBest.GBest=GBest;
elseif GBest.PObj<PreviousBest.GBest.PObj
    NewBest.GBest=GBest;
else
    NewBest.GBest=PreviousBest.GBest;
end

if isempty(PreviousBest)==1
    NewBest.NP=NP;
elseif isempty(PreviousBest.NP.Obj)~=0
    if NP.Obj<PreviousBest.NP.Obj
        NewBest.NP=NP;
    end
else
        NewBest.NP=PreviousBest.NP;
end
%% Keep the best solutions in the population but do not repaeat them more than once
K=0;
for I=1:size(Designs,1)
    if sum(Designs(I,:)==NewBest.GBest.Design)==size(Designs,2)
        K=K+1;
    end
end

if K==0
    Designs(end,:)=NewBest.GBest.Design;
    PObj(end)=NewBest.GBest.PObj;
end

L=0;
for I=1:size(Designs,1)
    if sum(Designs(I,:)==NewBest.NP.Design)==size(Designs,2)
        L=L+1;
    end
end

if L==0
    Designs(end-1,:)=NewBest.NP.Design;
    PObj(end-1,:)=NewBest.NP.Obj;
end










