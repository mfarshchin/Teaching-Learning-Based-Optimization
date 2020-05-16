function [PObj,Obj]=Analyser(Designs)

global D
% This function evaluates the generated designs
for I=1:size(Designs,1)
    D.A=Designs(I,:);
    [~,~,~,Obj(I,1),PObj(I,1)]=ST(D); %Obj: Objective value;   PObj: Penalized objecive value
end

end


%-------------------------------------------------------------------------%
function [F,U,R,WE,GOAL]=ST(D)
% This function analysis the design
% The truss analyser function is taken from this link: http://www.mathworks.com/matlabcentral/fileexchange/14313-truss-analysis
% and is slightly modified to be used in this code
D.A=D.A';
w=size(D.Re);S=zeros(3*w(2));U=1-D.Re;f=find(U);
WE=0;
for i=1:size(D.Con,2)
    H=D.Con(:,i);C=D.Coord(:,H(2))-D.Coord(:,H(1));Le=norm(C);
    T=C/Le;s=T*T';G=D.E(i)*D.A(i)/Le;Tj(:,i)=G*T;
    e=[3*H(1)-2:3*H(1),3*H(2)-2:3*H(2)];S(e,e)=S(e,e)+G*[s -s;-s s];
    WE=WE+Le*D.A(i)*D.RO;
end
U(f)=S(f,f)\D.Load(f);F=sum(Tj.*(U(:,D.Con(2,:))-U(:,D.Con(1,:))));
R=reshape(S*U(:),w);R(f)=0;
TS=(((abs(F'))./D.A)/D.TM)-1;%Tension
US=abs(U')/D.DM-1;%Displacement
PS=sum(TS.*(TS>0));
PD=sum(sum(US.*(US>0)));
GOAL=WE*(1+PS+PD)^2;% Penalty function
end