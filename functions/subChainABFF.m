function EP=subChainABFF(U,Z,epsilon)
p11=U;
p22=Z;

%% SCC
vU=SCCF(p11(:,2),p11(:,1),1);
vZ=SCCF(p22(:,2),p22(:,1),1);
%% SCC
% vU=[0.10 0.10 0.10 0.10 0.10 0.10 0.10 0.10 0.10 -0.10 -0.10 -0.10];
% vZ=[0.10 0.10 0.10 0.10 0.10 0.10 0.10 0.10 -0.10 -0.10 0.20 0.00];
% epsilon=0.20;
%%

vA=vU;
vB=vZ;
%%
subCA={};
subCB={};
chainA=[];
chainB=[];
ACCA=0;
ACCB=0;
for i=1:1:length(vA)
    
    ACCA=ACCA+sum(vA(:,i));
    ACCB=ACCB+sum(vB(:,i));
    
    if abs(ACCA)<=epsilon || abs(ACCB)<=epsilon
        chainA=[chainA vA(:,i)];
        chainB=[chainB vB(:,i)];
    else
        subCA={subCA{:,:} chainA};
        subCB={subCB{:,:} chainB};
        ACCA=0;
        ACCB=0;
        chainA=[];
        chainB=[];
        chainA=[chainA vA(:,i)];
        chainB=[chainB vB(:,i)];
        ACCA=sum(vA(:,i));
        ACCB=sum(vB(:,i));
    end   
    
    
end
subCA={subCA{:,:} chainA};
subCB={subCB{:,:} chainB};
%% CLEAR
subCA= subCA(~cellfun('isempty',subCA));
subCB= subCB(~cellfun('isempty',subCB));
%% ENERGY OF SUB-CHAINS
Et=[];
for u=1:1:length(subCA)
    Ai=subCA{:,u};
    Bi=subCB{:,u};
    E=sum(abs(Ai-Bi))/length(Ai);   
    Et=[Et E];
end
EP=sum(Et)/length(Et);

