function [Designs,PObj,Obj]=Teaching(TL,Designs,PObj,Obj,Teacher,WMeanPos)
%% This function applies teaching phase


for I=1:size(Designs,1)
    TF=randi([1,2],1,size(Teacher,2));
    Diff_Mean=rand(1,size(Teacher,2)).*TF.*(Teacher-WMeanPos);
    NewDesigns(I,:)=Designs(I,:)+sign(Teacher-Designs(I,:)).*abs(Diff_Mean);
end

%% Check feasibility of the designs
for i=1:size(Designs,1)
    for j=1:size(Teacher,2)
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

    
