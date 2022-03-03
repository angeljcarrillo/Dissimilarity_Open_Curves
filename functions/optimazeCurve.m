function output = optimazeCurve(segmentos,X)% X[x,y]
 pt = interparc(segmentos,X(:,1),X(:,2),'linear');
 px=pt(:,1);
 py=pt(:,2);
 B=[px,py];
 ptD=B;
 %ptD=[ptD; ptD(1,:)];
% figure(1)
% plot(ptD(:,1),ptD(:,2),'',ptD(:,1),ptD(:,2),'b*')
% pause(1)

% plot(C(:,2),C(:,1),'r*',C(:,2),C(:,1),'b-o')
%axis([0 300 0 300])
% axis equal
% grid on
% xlabel X
% ylabel Y
% grid off
output=ptD;
