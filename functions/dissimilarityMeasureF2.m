function omega = dissimilarityMeasureF2(U,Z,EPSILON)
UZ=subChainABFF(U,Z,EPSILON);
ZU=subChainABFF(Z,U,EPSILON);
omega=sum([UZ ZU])/2;