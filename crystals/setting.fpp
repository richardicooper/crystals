C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:07  rich
C New CRYSTALS repository
C
C Revision 1.3  2004/10/22 10:45:13  rich
C NCAWU removed.
C
C Revision 1.2  2001/02/26 10:30:23  richard
C Added changelog to top of file
C
C
CODE FOR WSTUP
      SUBROUTINE WSTUP ( IBLOCK , IDIM0 )
C
C----- SET UP THE ORIENTATION MATRIX APPROPRIATE FOR THE DIFFRACTOMETER
C      IN USE
C
      DIMENSION IBLOCK(IDIM0),DIRCOS(3)
C
      INCLUDE 'ISTORE.INC'
      INCLUDE 'ICOM13.INC'
C
      COMMON /XABSW/A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,VV,W,X,Y,
     2 Z,DD(4)
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
      COMMON /XABSWK/IMODE,WAV,WAVSQ,IDIF,IDAT,IFF,IG,ALPHA,IR1,IR2,
     2 IR3,IR4,ISET,NPI,NPV,VK(3),UM(3,3),UB(3,3),V(3,2),FACT(10),
     3 BFACT(10),CFACT(10),THL,ISPC
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST13.INC'
      INCLUDE 'XLST50.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
      INCLUDE 'QLST13.INC'
C
      EQUIVALENCE (FCV(1),FC1),(FCV(2),FC2),(FCV(3),FC3),(FBIS(1),
     2 FTHETA),(FBIS(2),FPHIB),(FBIS(3),FCHIB),(FEUL(1),FPHIE),(FEUL(2)
     3 ,FOME),(FEUL(3),FCHIE),(FKAP(1),FPHIK),(FKAP(2),FOMK),(FKAP(3),
     4 FKAPPA),(FHKL(1),FH),(FHKL(2),FK),(FHKL(3),FL)
C
C
C
      INCLUDE 'IDIM13.INC'
C ---- COPY THE LOAD DETAILS TO THE CORRECT COMMON BLOCK
      CALL XMOVEI ( IBLOCK , ICOM13 , IDIM13 )
C----- LOAD LIST 1
      CALL XFAL01
      HLFPI=0.5*PI
C-- ORIETATION MATRIX IS STORED BY ROWS, SO MUST TRANSPOSE
      CALL MTRANS(STORE(L1O2))
      WAV=STORE(L13DC)
      WAVSQ=WAV*WAV
C--CONSTANTS FOR Y290
      THL=DTR*STORE(L13DC+6)
C--- CONSTANTS FOR CAD4
      CON1=STORE(L13DC+3)
      CON2=STORE(L13DC+4)
      CON3=STORE(L13DC+5)
      FLAM(1)=WAV
C----- DETERMINE DIFFRACTOMETER TYPE
      IDIF=ISTORE(L13DT)-5
C--DETERMINE SETTING TYPE
C----- SET DEFAULT TO 'MATRIX'
      IDAT=5
      DO 1450 I=4,8
        CALL XDIRFL(I,ICOM13,IDIM13)
C--CHECK IF THE FIRST PARAMETER FOR THIS DIRECTIVE HAS BEEN INPUT
        IF ( ISTORE(LR62D+10) .GT. 0 ) IDAT = I - 3
1450  CONTINUE
      ISTORE(L13DT+2) = IDAT
C
      IF(IDIF .LE. 0) RETURN
C---- ADD 'AREA' JAN 97
      GOTO(1100,3300,3300,1100,3300,1000),IDIF
1000  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
C
C
C----- CAD 4
1100  CONTINUE
C-----   MOST OF THE CODE DEALING WITH CAD4 IS TAKEN FROM
C-----   THE NONIUS DIFFRACTOMETER PROGRAMME.
C
C
      IDOT=0
      IHKLFL=0
C----- ORTHOGONALISATION MATRIX
      CALL XMOVE(STORE(L1O2),CD(1,1),9)
      K=1
      GOTO(1400,3200,2700,2900,1300,1200),IDAT
1200  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
1300  CONTINUE
C----- MATRIX READ IN BY ROWS
      GO TO 3900
1400  CONTINUE
C----- 2 REFLECTIONS
      KK=L132R
1500  CONTINUE
      FH=STORE(KK)
      FK=STORE(KK+1)
      FL=STORE(KK+2)
      JK=KK+3
C---- CONVERT TO EULERIAN
      CALL WAIN(IDIF,JK,JK)
      KK=KK+9
1600  CONTINUE
      M=3
1700  CONTINUE
C-----   LOOPS 2 TIMES TO GET:
C-----   E TO B
C-----   B TO C
      CALL HFROM(M)
      M=M-1
      IF(M.GE.2)GOTO 1700
      CALL XMLTMM (CD, FHKL, PD(1,K), 3 , 3, 1)
1900  CALL VPROD(PD(1,K),PD(1,K),SI)
      CALL VPROD(FCV,FCV,CO)
      SI=SQRT(SI)
      CO=SQRT(CO)
      M=1
2000  PD(M,K)=PD(M,K)/SI
      QD(M,K)=FCV(M)/CO
      M=M+1
      IF(M.LE.3)GOTO 2000
      K=K+1
      IF(K.LE.2)GOTO 1500
      GOTO 2200
2100  QD(1,1)=-QD(1,1)
      QD(2,1)=-QD(2,1)
      QD(3,1)=-QD(3,1)
2200  CONTINUE
      CALL ANGV2(PD(1,1),PD(1,2),ANGP)
      CALL ANGV2(QD(1,1),QD(1,2),ANGQ)
      CO=ANGQ-ANGP
      IF(((HLFPI-ANGP)*(HLFPI-ANGQ)) .LT. 0.0) GOTO 2100
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,3100)CO
      ENDIF
      SI=1.0/SIN(ANGQ)
      CO=SIN(CO)*SI
      SI=SI*SIN(ANGP)
      M=1
2300  QD(M,2)=SI*QD(M,2)+CO*QD(M,1)
      M=M+1
      IF(M.LE.3)GOTO 2300
      CALL VMULT(PD(1,1),PD(1,2),PD(1,3))
      CALL VMULT(QD(1,1),QD(1,2),QD(1,3))
      CALL MATINV(PD,SD,SI)
      M=1
2400  CALL XMLTMM(QD,SD(1,M),PD(1,M),3,3,1)
      M=M+1
      IF(M.LE.3)GOTO 2400
      M=1
2500  CALL XMLTMM(PD,CD(1,M),RD(1,M),3,3,1)
      M=M+1
      IF(M.LE.3)GOTO 2500
      CALL MATINV(RD,CD,DET)
      CALL WRMAT
      CALL XMOVE(RD(1,1),UB(1,1),9)
      GOTO 4000
2700  CONTINUE
C----0 REAL AXIS
      FCV(1) = CD(1,3)
      FCV(2)=CD(2,3)
      FCV(3)=CD(3,3)
      KK=L13RL
      PD(1,1)=STORE(KK)
      PD(2,1)=STORE(KK+1)
      PD(3,1)=STORE(KK+2)
      KK=KK+3
      GOTO 1900
2900  CONTINUE
C----- RECIPROCAL AXIS
      KK=L13RC
      FH=STORE(KK)
      FK=STORE(KK+1)
      FL=STORE(KK+2)
      KK=KK+3
      FCV(1) = 0.
      FCV(2)=0.0
      FCV(3)=1.0
      GOTO 1600
3100  FORMAT(/' Initial azimuth =',F7.2)
3200  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
3300  CONTINUE
C
C
C
C
C----- Y290 H&W
C----- ALL ANGLES IN BASE SYSTEM
      GOTO(3500,3800,3400,3400,3900,3400),IDAT
3400  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
3500  CONTINUE
C----- 2 REFLECTIONS
      K=L132R
      ISET=K
C----- CONVERT TO RADIANS
      CALL WAIN(2,K+3,K+3)
      CALL WAIN(2,K+12,K+12)
      DO 3600 J=1,2
      STH=STHETA(STORE(K))
      CTH=SQRT(1.-STH*STH)
C----- COMPONENTS OF SCATTERING VECTOR IN EQUATORIAL PLANE
      VK(1)=CTH
      VK(2)=STH
      VK(3)=0
C----- OMEGA ROTATION
      A=-STORE(K+4)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR1)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- CHI
      A=-STORE(K+5)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(2) = 1.
      IF (NROT(DIRCOS,A,STORE(IR2)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- PHI
      A=-STORE(K+6)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR3)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- TOTAL ROTATION
C     [R] = [P].[X].[W]
      CALL XMLTMM(STORE(IR2),STORE(IR1),STORE(IR4),3,3,3)
      CALL XMLTMM(STORE(IR3),STORE(IR4),STORE(IR1),3,3,3)
C----- FIND SCATTERING VECTOR WHEN CIRCLES RETURNED TO ZERO
      CALL XMLTMM(STORE(IR1),VK(1),V(1,J),3,3,1)
      K=K+9
3600  CONTINUE
C----- SET UP COORDINATE SYSTEM SUCH THAT X IS PARALLEL TO V[I,1]
C                        Y IS PERPENDICULAR TO V[I,1] & V[I,2]
      CALL WMET(STORE(IR1),V)
C----- ORTHOGONALISE INDICES & SET UT COORDINATE SYSTEM [H]
      CALL XMLTMM(STORE(L1O2),STORE(ISET),V(1,1),3,3,1)
      CALL XMLTMM(STORE(L1O2),STORE(ISET+9),V(1,2),3,3,1)
      CALL WMET(STORE(IR2),V)
      IF (NORM3(STORE(IR2)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      IF (NORM3(STORE(IR2+3)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      IF (NORM3(STORE(IR2+6)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      IF (NORM3(STORE(IR1)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      IF (NORM3(STORE(IR1+3)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      IF (NORM3(STORE(IR1+6)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- [H] IS AN ORTHOGONAL ROTATION METRIX SO [H]T=[H]-1
      CALL XTRANS(STORE(IR2),STORE(IR3),3,3)
      CALL XMLTMM(STORE(IR1),STORE(IR3),UM,3,3,3)
      CALL XMLTMM(UM,STORE(L1O2),UB,3,3,3)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,3710)UM(1,1),UM(1,2),UM(1,3),UM(2,1),
     1 UM(2,2),UM(2,3),UM(3,1),UM(3,2),UM(3,3)
      ENDIF
3710  FORMAT(16H Rotation matrix   ,
     1 /(/,20X,3F10.4))
      GOTO 4000
3800  CONTINUE
C----- 3 REFLECTIONS
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
3900  CONTINUE
C----- ORIENTATION MATRIX
C----- MATRIX READ IN BY ROWS,BUT STORED,BY COLUMNS
      CALL XTRANS(STORE(L13OM),UB(1,1),3,3)
4000  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,4100)UB(1,1),UB(1,2),UB(1,3),UB(2,1),UB(2,2),
     1 UB(2,3),UB(3,1),UB(3,2),UB(3,3)
      ENDIF
4100  FORMAT(//19H Orientation matrix   ,
     1 /(/,20X,3F10.4))
      CALL XMOVE(UB(1,1),STORE(L13OM),9)
C----- AND NOW COPY THE LIST 13 DETAILS BACK FOR LOADING TO DISC
      CALL XMOVEI ( ICOM13, IBLOCK, IDIM13 )
      RETURN
      END
CODE FOR WRMAT
      SUBROUTINE WRMAT
C
C
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
C----- TAKEN FROM NONIUS
C----- CD IS ORIENTATION MATRIX = L1O2
C
C
      CALL MTRANS(CD)
      N=1
1100  K=N
1200  CALL VPROD(CD(1,N),CD(1,K),SD(N,K))
      K=K+1
      IF(K.LE.3)GOTO 1200
      N=N+1
      IF(N.LE.3)GOTO 1100
      N=1
1300  CONTINUE
      N=N+1
      IF(N.LE.3)GOTO 1300
      IF(DET.EQ.0.0)GOTO 1400
      SD(1,1)=SQRT(SD(1,1))
      SD(2,2)=SQRT(SD(2,2))
      SD(3,3)=SQRT(SD(3,3))
      CALL ANGV2(CD(1,2),CD(1,3),SD(2,1))
      CALL ANGV2(CD(1,1),CD(1,3),SD(3,1))
      CALL ANGV2(CD(1,1),CD(1,2),SD(3,2))
      SI=1.0/DET
      CALL MTRANS(CD)
      RETURN
1400  CONTINUE
      WRITE ( CMON ,1500)
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
1500  FORMAT(' Singular Matrix')
      RETURN
      END
CODE FOR HFROM
      SUBROUTINE HFROM(NR)
C     1=CTOH,2=BTOC,3=ETOB,4=KTOE,5=MTOK
C
C
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
C
C
C
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
C
      EQUIVALENCE (FCV(1),FC1),(FCV(2),FC2),(FCV(3),FC3),(FBIS(1),
     2 FTHETA),(FBIS(2),FPHIB),(FBIS(3),FCHIB),(FEUL(1),FPHIE),(FEUL(2)
     3 ,FOME),(FEUL(3),FCHIE),(FKAP(1),FPHIK),(FKAP(2),FOMK),(FKAP(3),
     4 FKAPPA),(FHKL(1),FH),(FHKL(2),FK),(FHKL(3),FL)
C
C
      DATA PI/3.14159263694/
      MIXUP=0
      GOTO(1000,1300,1400,1800,1900),NR
1000  IF(DET.EQ.0.0)GOTO 1100
      CALL XMLTMM(CD,FCV,FHKL,3,3,1)
      RETURN
1100  N=1
1200  FHKL(N)=0.0
      N=N+1
      IF(N.LE.3)GOTO 1200
      MIXUP=1
      RETURN
1300  FC1=-(SIN(FPHIB)*COS(FCHIB)*2.0*SIN(FTHETA))/FLAM(1)
      FC2=(COS(FPHIB)*COS(FCHIB)*2.0*SIN(FTHETA))/FLAM(1)
      FC3=(SIN(FCHIB)*2.0*SIN(FTHETA))/FLAM(1)
      RETURN
1400  IF(FTHETA.GT.0.0)GOTO 1500
      FTHETA=-FTHETA
      FOME=FOME+PI+2.0*FTHETA
      FOME=BETW(FOME,PI)
1500  T1=COS(FOME-FTHETA)
      T2=SIN(FOME-FTHETA)
      SI=T1*(SIN(FCHIE))
      CO=SQRT((COS(FCHIE))**2+((SIN(FCHIE))*T2)**2)
      FCHIB=ATAN2(SI,CO)
      IF(CO.NE.0.0)GOTO 1600
      FPHIB=0.0
      SI=-SIN(FCHIE)*SIN(FPHIE)
      CO=COS(FPHIE)*T1
      GOTO 1700
1600  SI=-T2
      CO=T1*COS(FCHIE)
      FPHIB=FPHIE-ATAN2(SI,CO)
      FPHIB=BETW(FPHIB,PI)
      SI=T2*SIN(FCHIE)
      CO=COS(FCHIE)
1700  FPSI=ATAN2(SI,CO)
      RETURN
1800  FKAPPA=BETW(FKAPPA,PI)
      SI=CON2*SIN(0.5*FKAPPA)
      CO=COS(0.5*FKAPPA)
      SI=ATAN2(SI,CO)
      FOME=FOMK+SI
      FPHIE=FPHIK+SI
      FOME=BETW(FOME,PI)
      FPHIE=BETW(FPHIE,PI)
      SI=SQRT(CON1)*SIN(0.5*FKAPPA)
      CO=SQRT(ABS(1.0-SI*SI))
      FCHIE=2.0*ATAN2(SI,CO)
      RETURN
1900  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      END
CODE FOR ORTH
      SUBROUTINE ORTH(A,B,MIXUP)
C
C
      DIMENSION A(3),B(3)
      MIXUP=1
      CALL VPROD(A,A,TEMP1)
1000  CALL VPROD(B,B,TEMP2)
      IF(TEMP1.GT.TEMP2)GOTO 1200
      IF(TEMP2.GT.(TEMP1*625.0))GOTO 1400
      CALL VPROD(A,B,TEMP2)
      TEMP2=-TEMP2/TEMP1
      TEMP2=FLOAT(INT(TEMP2+SIGN(0.5,TEMP2)))
      IF(TEMP2.EQ.0.0)RETURN
      N=1
1100  B(N)=B(N)+A(N)*TEMP2
      N=N+1
      IF(N.LE.3)GOTO 1100
      MIXUP=0
      GOTO 1000
1200  TEMP1=TEMP2
      N=1
1300  TEMP2=A(N)
      A(N)=B(N)
      B(N)=TEMP2
      N=N+1
      IF(N.LE.3)GOTO 1300
      MIXUP=0
      GOTO 1000
1400  MIXUP=-1
      A(1)=0.0
      A(2)=0.0
      A(3)=0.0
      RETURN
      END
CODE FOR ANGV2
      SUBROUTINE ANGV2(A,B,C)
C
C
      DIMENSION A(3),B(3),T(3)
C
      INCLUDE 'XCONST.INC'
C
      CO=A(1)*B(1)+A(2)*B(2)+A(3)*B(3)
      CALL VMULT(A,B,T)
      T(1)=T(1)*T(1)+T(2)*T(2)+T(3)*T(3)
      SI=SQRT(T(1))
      C=ATAN2(SI,CO)
      RETURN
      END
CODE FOR BETW
      FUNCTION BETW(A,R)
      BETW=A-2.0*R*FLOAT(INT((SIGN(R,A)+A)/(2.0*R)))
      RETURN
      END
CODE FOR HTOW
      SUBROUTINE HTOW(NR)
C     1=HTOC,2=CTOB,3=BTOE,4=ETOK,5=KTOW
C
C
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
      INCLUDE 'XCONST.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
C
C
C
C
      EQUIVALENCE (FCV(1),FC1),(FCV(2),FC2),(FCV(3),FC3),(FBIS(1),
     2 FTHETA),(FBIS(2),FPHIB),(FBIS(3),FCHIB),(FEUL(1),FPHIE),(FEUL(2)
     3 ,FOME),(FEUL(3),FCHIE),(FKAP(1),FPHIK),(FKAP(2),FOMK),(FKAP(3),
     4 FKAPPA),(FHKL(1),FH),(FHKL(2),FK),(FHKL(3),FL)
C
C
      MIXUP=0
      GOTO(1000,1100,1300,1800,2100),NR
1000  CALL XMLTMM(RD,FHKL,FCV,3,3,1)
      RETURN
1100  FPHIB=ATAN2(-FC1,FC2)
      CO=SQRT(FC1*FC1+FC2*FC2)
      FCHIB=ATAN2(FC3,CO)
      SI=SQRT(CO*CO+FC3*FC3)*FLAM(1)/2.0
      IF(SI.GE.1.0)GOTO 1200
      CO=SQRT(1.0-SI*SI)
      FTHETA=ATAN2(SI,CO)
      RETURN
1200  FTHETA=PI/2.0
      MIXUP=1
      RETURN
1300  SI=SIN(FPSI)*COS(FCHIB)
      CO=SIN(FCHIB)
      FOME=ATAN2(SI,CO)+FTHETA
      SI=-SIN(FPSI)
      CO=SIN(FCHIB)*COS(FPSI)
      FPHIE=ATAN2(SI,CO)+FPHIB
      SI=SQRT(SIN(FCHIB)**2+(SIN(FPSI)*COS(FCHIB))**2)
      CO=COS(FCHIB)*COS(FPSI)
      FCHIE=ATAN2(SI,CO)
      IF(FCHIB)1400,1600,1500
1400  FCHIE=-FCHIE
      FOME=FOME+PI
      FPHIE=FPHIE+PI
1500  FPHIE=BETW(FPHIE,PI)
      FOME=BETW(FOME,PI)
      RETURN
1600  IF(SIN(FPSI))1400,1700,1500
1700  FCHIE=0.0
      FPHIE=FPHIB
      FOME=FTHETA
      RETURN
1800  FCHIE=BETW(FCHIE,PI)
      SI=SIN(0.5*FCHIE)
      CO=CON1-SI*SI
      IF((CON3-CO).GT.0.0)GOTO 2000
      CO=SQRT(CO)
      FKAPPA=2.0*ATAN2(SI,CO)
      SI=SI*CON2
      FOMK=ATAN2(SI,CO)
1900  FPHIK=FPHIE-FOMK
      FOMK=FOME-FOMK
      FPHIK=BETW(FPHIK,PI)
      FOMK=BETW(FOMK,PI)
      RETURN
2000  FKAPPA=PI
      FOMK=PI/2.0
      MIXUP=1
      GOTO 1900
2100  CONTINUE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      END
CODE FOR WAIN
      SUBROUTINE WAIN(IDI,J,K)
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
      INCLUDE 'XCONST.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      COMMON /XABSWK/IMODE,WAV,WAVSQ,IDIF,IDAT,IFF,IG,ALPHA,IR1,IR2,
     2 IR3,IR4,ISET,NPI,NPV,VK(3),UM(3,3),UB(3,3),V(3,2),FACT(10),
     3 BFACT(10),CFACT(10),THL,ISPC
      INCLUDE 'QSTORE.INC'
C----- CONVERTS DIFFRACTOMETER ANGLES INPUT AT STORE(K) TO STANDARD
C      ANGLES AT (J) .  STANDARD ANLES IN ORDER T W X P (K PSI)
      M=J
      L=K+5
      DO 1000 I=K,L
      STORE(M)=STORE(I)*DTR
      M=M+1
1000  CONTINUE
C---- ADD 'AREA' JAN 97
      GOTO(1400,1300,1300,1200,1300,1100),IDI
1100  CONTINUE
C----- THIS SYSTEM NOT AVAILABLE
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
1200  CONTINUE
C----- CAD-4 - KAPPA
C----- CONVERT T P W K TO T W X P
      FBIS(1)=STORE(J)
      FKAP(2)=STORE(J+1)
      FKAP(3)=STORE(J+4)
      FKAP(1)=STORE(J+3)
      CALL HFROM(4)
      STORE(J+1)=FEUL(2)
      STORE(J+2)=FEUL(3)
      STORE(J+3)=FEUL(1)
      STORE(J+5)=STORE(J+5)
      RETURN
1300  CONTINUE
C----- Y290 H&W
      RETURN
1400  CONTINUE
C----- CAD 4 EULERIAN
C----- SET ABSWK VARIABLES
      FEUL(2)=STORE(J+1)
      FEUL(3)=STORE(J+2)
      FEUL(1)=STORE(J+3)
      FBIS(1)= STORE(J  )
      RETURN
      END
C
CODE FOR WMET
      SUBROUTINE WMET(A,B)
C
C
      DIMENSION A(3,3),B(3,3)
C----- FORM A COORDINATE SYSTEM WITH U PARALLEL TO X, V PERP TO U & Y
      A(1,1)=B(1,1)
      A(2,1)=B(2,1)
      A(3,1)=B(3,1)
C
      A(1,2)=A(2,1)*B(3,2)-A(3,1)*B(2,2)
      A(2,2)=A(3,1)*B(1,2)-A(1,1)*B(3,2)
      A(3,2)=A(1,1)*B(2,2)-A(2,1)*B(1,2)
C
      A(1,3)=A(2,1)*A(3,2)-A(3,1)*A(2,2)
      A(2,3)=A(3,1)*A(1,2)-A(1,1)*A(3,2)
      A(3,3)=A(1,1)*A(2,2)-A(2,1)*A(1,2)
C----- NOTE THAT THE RESULT IS NOT NRMALISED, AND THAT
C      B(I,3) IS NOT USED.
      RETURN
      END
CODE FOR STHETA
      FUNCTION STHETA(A)
C
C
      DIMENSION A(3),B(3)
C
C
      INCLUDE 'STORE.INC'
      INCLUDE 'ISTORE.INC'
C
      COMMON /XABSWK/IMODE,WAV,WAVSQ,IDIF,IDAT,IFF,IG,ALPHA,IR1,IR2,
     2 IR3,IR4,ISET,NPI,NPV,VK(3),UM(3,3),UB(3,3),V(3,2),FACT(10),
     3 BFACT(10),CFACT(10),THL,ISPC
      INCLUDE 'XLST01.INC'
C
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'QSTORE.INC'
      CALL XMLTMM(STORE(L1O2),A,B,3,3,1)
      S=0.5*WAV*SQRT(B(1)*B(1)+B(2)*B(2)+B(3)*B(3))
      IF(S-1.)1200,1200,1000
1000  CONTINUE
      WRITE(CMON, 1100) A, S
      CALL XPRVDU(NCVDU, 2,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON( 1)(:),CMON( 2)(:)
1100  FORMAT(' Sin theta gt than 1',3F6.1,F8.4/
     1 'Check cell parameters and reflection file')
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
1200  CONTINUE
      STHETA=S
      RETURN
      END
CODE FOR WINPL
      FUNCTION WINPL(KX,KY,XIN,NPTS)
C
C
      DIMENSION DELTA(10),A(10)
C
      INCLUDE 'STORE.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      NTERMS=3
C----- BASED ON DATA REDUCTION AND ERROR ANALYSIS FOR THE
C      PHYSICAL SCIENCES. BEVINGTON. MCGRAW-HILL. P 266.
C
C----- WE WILL DO 3 POINT INTERPOLATION ONLY.
      JX=KX-1
      JY=KY-1
C----- FIND APPROPRIATE VALUE OF X(1)
      DO 1500 I = 1, NPTS
      IF(XIN-STORE(I+JX))1100,1300,1500
1100  I1=I-NTERMS/2
      IF(I1)1200,1200,1600
1200  I1=1
      GOTO 1600
1300  YOUT=STORE(I+JY)
      GOTO 3100
1500  CONTINUE
      I1=NPTS-NTERMS+1
1600  I2=I1+NTERMS-1
      IF(NPTS-I2)1700,2100,2100
1700  I2=NPTS
      I1=I2-NTERMS+1
      IF (I1) 1900, 1900, 2100
1900  I1=1
      NTERMS = I2 - I1 + 1
C----- EVALUATE DEVIATIONS DELTA
2100  CONTINUE
      DENOM=STORE(JX+I1+1)-STORE(JX+I1)
      DELTAX=(XIN-STORE(I1+JX))/DENOM
      DO 2200 I=1,NTERMS
      IX=I1+I-1
2200  DELTA(I)=(STORE(IX+JX)-STORE(I1+JX))/DENOM
C----- COEFFICIENTS A
      A(1) = STORE(I1+JY)
      DO 2600 K = 2, NTERMS
      PROD=1.
      SUM=0.
      IMAX=K-1
      IXMAX=I1+IMAX
      DO 2500 I=1,IMAX
      J=K-I
      PROD=PROD*(DELTA(K)-DELTA(J))
2500  SUM=SUM-A(J)/PROD
2600  A(K)=SUM+STORE(IXMAX+JY)/PROD
C----- ACCUMULATE EXPANSION
      SUM = A(1)
      DO 2900 J=2,NTERMS
      PROD=1.
      IMAX=J-1
      DO 2800 I=1,IMAX
2800  PROD=PROD*(DELTAX-DELTA(I))
2900  SUM=SUM+A(J)*PROD
      YOUT = SUM
3100  WINPL=YOUT
      RETURN
      END
CODE FOR WCVT
      SUBROUTINE WCVT(IDI,J,K)
C----- CONVERT ANGLES SPECIFIED IN TERMS OF A PARTICULAR MACHINE TO
C     THOSE IN TERMS OF A ROLLETT MACHINE.
C     ANGLES MUST BE GIVEN IN ORDER TWXP.
C     THE RULES FOR CONVERSION CAN  BE FOUND AS FOLLOWS
C
C     1. IMAGINE A CRYSTAL WITH ITS UPPER FACE CLEARLY MARKED ON
C        A DIFFRACTOMETER WITH ALL ANGLES SET AT ZERO.
C
C     2. ROTATE THE MACHINE ABOUT THE INCIDENT BEAM UNTIL + THETA
C        IS ANTI CLOCKWISE WHEN VIEWED FROM ABOVE.THE IMAGINARY THETA
C        AXIS NOW POINTS VERTICALLY UPWARDS. IF OMEGA ROTATES IN THE
C        SAME SENSE AS THETA ITS SIGN IS POSITIVE.
C
C     3. IF PHI ROTATES IN THE SAME SENSE AS THETA THEN ITS SIGN IS
C        POSITIVE.
C
C     4. ROTATE CHI UNTIL THE MARKED END OF THE CRYSTAL
C        IS AGAIN UPPERMOST. THIS GIVES X(0).
C     5. FIND THE SENSE (+ OR -) OF ROTATION NEEDED TO CAUSE CHI TO
C        ROTATE ANTI-CLOCKWISE AS VIEWED FROM THE X-RAY SOURCE.
C        THEN X(R) = X(0) +/- X(P)
C     6. IN THE ROLLETT MACHINE OMEGA IS THE ANGLE THE SCATTERING VECTO
C        MUST BE ROTATED IN THE HORIZONTAL PLANE FROM BEING PERPENDICUL
C        TO THE INCIDENT BEAM IN ORDER TO SATISFY THE BRAGG CONDITION.
C     7. IN THE ROLLETT MACHINE THETA IS HALF THE ANGLE MADE BETWEEN TH
C        DIFFRACTED BEAM AND THE CONTINUATION OF THE INCIDENT BEAM PAST
C        THE CRYSTAL.
C
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'QSTORE.INC'
      GOTO (1200,1300,1400,1200,1000),IDI
1000  CONTINUE
      WRITE ( CMON ,1010)
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
1010  FORMAT(' This geometry not available ')
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
1200  CONTINUE
C----- CAD 4
C     T,W,P OK
      STORE(J+2)=PI-STORE(K+2)
      RETURN
1300  CONTINUE
C----- ROLLETT
1400  CONTINUE
C----- H&W Y290
      RETURN
      END

