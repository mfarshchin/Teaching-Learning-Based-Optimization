function D=Data10
% Design parameters for the benchmark 10-bar truss problem
Coord=360*[2 1 0;2 0 0;1 1 0;1 0 0;0 1 0;0 0 0]; 
Con=[5 3;1 3;6 4;4 2;3 4;1 2;6 3;5 4;4 1;3 2];
Re=[0 0 1;0 0 1;0 0 1;0 0 1;1 1 1;1 1 1];
Load=zeros(size(Coord));Load(2,:)=[0 -1e5 0];Load(4,:)=[0 -1e5 0];
E=ones(1,size(Con,1))*1e7;
A=ones(1,10);
% Available sections
AV=[1.62, 1.8, 1.99, 2.13, 2.38, 2.62, 2.88, 2.93, 3.09, 3.13, 3.38, 3.47, 3.55, 3.63, 3.84,...
        3.87, 3.88, 4.18, 4.22, 4.49, 4.59, 4.80, 4.97, 5.12, 5.94, 7.22, 7.97, 11.5, 13.50,...
        13.90, 14.2, 15.5, 16.0, 16.9, 18.8, 19.9, 22.0, 22.9, 28.5, 30.0, 33.5];%in^2
%Allowable Stress
TM=25000;%psi
%Allowable Displacement
DM=2;%inch
%Density
RO=.1;%lb/in^3
LB=ones(1,10)*0.1;
UB=ones(1,10)*33.5;
D=struct('Coord',Coord','Con',Con','Re',Re','Load',Load','E',E','A',A','AV',AV','TM',TM','DM',DM','RO',RO','LB',LB,'UB',UB);