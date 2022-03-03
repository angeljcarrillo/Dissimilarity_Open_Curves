function K = matchOpt(U,Z)% vector de curvas, alpha, segmentos
 minR=mean(abs(U-Z));
 K=Z;
 R=Z;
 for i=1:1:(length(U)-1)
     R=circshift(R,1);
     minN=mean(abs(U-R));
     if minN<minR
     K=R;
     end
 end
