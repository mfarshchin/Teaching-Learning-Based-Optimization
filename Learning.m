function [Designs]=Learning(TL,Designs,PObj)
%% This function applies learning phase

for I=1:size(Designs,1)
    % Selection
    A=(randperm(size(Designs,1)))';
    First=A(1);
    Second=A(2);
    if PObj(First)>PObj(Second)
        First=A(2);
        Second=A(1);
    end
    BetterDesign=Designs(First,:);
    WorseDesign =Designs(Second,:);
    NewDesigns(I,:)=WorseDesign+rand(1,size(Designs,2)).*(BetterDesign-WorseDesign);
end
%% Check feasibility of the designs
for i=1:size(Designs,1)
    for j=1:size(Designs,2)
        if NewDesigns(i,j)<TL.LB(1,j)
            NewDesigns(i,j)=TL.LB(1,j);
        elseif NewDesigns(i,j)>TL.UB(1,j)
            NewDesigns(i,j)=TL.UB(1,j);
        end
    end
end
          
%% Evaluate the new designs
[NPObj,NObj]=Analyser(NewDesigns);
    
%% Check individuals for improvement and update the designs that are improved
for I=1:size(Designs,1)
    if NPObj(I,1)<PObj(I,1)
        PObj(I,1)=NPObj(I,1);
        Obj(I,1)=NObj(I,1);
        Designs(I,:)=NewDesigns(I,:);
    end
end
