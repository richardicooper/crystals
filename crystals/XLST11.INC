      integer L11,M11,MD11,N11,L11R,M11R,MD11R,N11R, 
     2 L11P,M11P,MD11P,N11P,L11IR,M11IR,MD11IR,N11IR 

      COMMON/XLST11/L11,M11,MD11,N11,L11R,M11R,MD11R,N11R, 
     2 L11P,M11P,MD11P,N11P,L11IR,M11IR,MD11IR,N11IR 
     
C      L11+30 ! flag for type of inversion, negative value means an approximate inversion
C             ! 1 ldlt inversion in single precision
C             ! 2 ldlt inversion in double precision
C             ! 3 eigen values filtering

