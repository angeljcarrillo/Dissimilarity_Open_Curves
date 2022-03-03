function dissimilarityBerkeleyCS_PL(path,m, epsilon)
%% PATH = LOCAL PATH+ \Demo\MPEG7CS\MPEG7CS_C\ 
dirListing = dir(path);
for i=1:length(dirListing) 
Data{i}=dirListing(i,1).name; 
f{i} = fullfile(path, Data{i});%----
end

f(:,1:2)=[];
close_curve={};
ID={};
SCC={};
TAU={};
ACC={};

%% LOAD IMAGE, TEST ACC =2 0R -2 CONTOURS
for i=1:1:length(f)
    s=load(f{:,i});
    pointlist= s.pointlist; 
    if mod(i,2) == 1 
        pointlist=pointlist/2;
    else
        pointlist=pointlist*2;
    end   
    scc=SCCF(pointlist(:,2),pointlist(:,1),1); 
    tau=sum(abs(scc));
    acc=sum(scc);
    TAU={TAU{:,:} tau};
    ACC={ACC{:,:} acc};
    SCC={SCC{:,:} scc};
    close_curve={close_curve{:,:} pointlist};
%% ID NAME   
     id = strsplit(f{:,i},'\');
     ID={ID{:,:} id(1,end)}; %      
end
puntosT=close_curve; 
maxS=m;
%% DISCRETIZE CONTOURS BY m
 vec=puntosT;
for u=1:1:length(puntosT)
   vec{:,u}=optimazeCurve(maxS,puntosT{:,u}); %
end
%% CLASSES
C1=[];
C2=[];
C3=[];
C4=[];
C5=[];

C1=[C1 1*ones(1,44)];
C2=[C2 2*ones(1,55)];
C3=[C3 3*ones(1,92)];
C4=[C4 4*ones(1,48)];
C5=[C5 5*ones(1,32)];
%%
labels=[C1 C2 C3 C4 C5 ];

%% VALUE SELECTION
vecT={vec{:,1:20} vec{:,45:72} vec{:,100:145} vec{:,192:215} vec{:,240:255}};
labelsT=[labels(:,1:20) labels(:,45:72) labels(:,100:145) labels(:,192:215) labels(:,240:255) ];
IDT={ID{:,1:20} ID{:,45:72} ID{:,100:145} ID{:,192:215} ID{:,240:255}};

%% VALIDTAION
vecV={vec{:,21:44} vec{:,73:99} vec{:,146:191} vec{:,216:239} vec{:,256:271}};
labelsV=[labels(:,21:44) labels(:,73:99) labels(:,146:191) labels(:,216:239) labels(:,256:271) ];
IDV={ID{:,21:44} ID{:,73:99} ID{:,146:191} ID{:,216:239} ID{:,256:271}};
%% SELEC VECTOR VALUE OR VALIDATION
vecF=vecV;
labelsF=labelsV;
%
VPT=[];
ACCT=[];
indexClass=[12,31,53,115,122];
%% run 
for i=1:1:length(indexClass)
Momega=[];

%% DISSIMILARITY
    for j=1:1:length(vecF)
        %[hd D] = HausdorffDist(vecF{:,indexClass(:,i)},vecF{:,j});
        %[cm, cSq] = DiscreteFrechetDist(vecF{:,indexClass(:,i)},vecF{:,j});
        omega=dissimilarityMeasureF2(vecF{:,indexClass(:,i)},vecF{:,j},epsilon);
        Momega=[Momega omega];
    end
  %% FIND THE FIRST HALF LESS VALUES
  minClasses=[10,10,10,10,10];
[~, idx] = mink(Momega, minClasses(:,i));
    s1=load(f{:,indexClass(:,i)});
    pointlist1= s1.pointlist;
%% CONTOUR TO FIND DISSIMILARITY
%     figure(1)
%     plot(pointlist1(:,1),pointlist1(:,2),'',pointlist1(:,1),pointlist1(:,2),'k*','LineWidth',10.0)
%     title('Simple curves to compare versus 270 simple curves')
%    set(gca,'Visible','off')
    %%
arrayVald=[];
    for h=1:1:length(idx)
        s2=load(f{:,idx(:,h)});
        pointlist2= s2.pointlist;
        %% RECOVERY IMAGES
%         figure(2)
%         plot(pointlist2(:,1),pointlist2(:,2),'',pointlist2(:,1),pointlist2(:,2),'k*','LineWidth',10.0)
%         title(strcat('The','..',string(h),' retrived contour'))
%          set(gca,'Visible','off')
%         pause(1)
       
        %%
        arrayVald=[arrayVald;labelsF(idx(:,h))];
    end
    VP=find(arrayVald==i);
    Acc=length(VP)/length(arrayVald);
    VPT=[VPT length(VP)];
    ACCT=[ACCT Acc];
end
ACCFULL=sum(VPT)/50;

figure (3)
width = 0.4;
barh(ACCT,width,'red');
yticklabels({'Apple','Bottle','Giraffes','Mug','Swan'})
xlabel('Precision')
ylabel('Classes')


end
