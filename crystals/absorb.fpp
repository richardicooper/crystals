C $Log: not supported by cvs2svn $
C Revision 1.3  2001/02/26 10:24:12  richard
C Added changelog to top of file
C
C
CODE FOR MABS
      FUNCTION MABS(IPOINT)
C--CALCULATE ABSORPTION CORRECTIONS
C
C     IPOINT = -1 FOR INITIATION
C            =  0 FOR PROCESSING
C            =  1 FOR TERMINATION
C
C----- ALL CORRRECTION CALCULATIONS ARE PERFORMED FOR A ROLLETT MACHINE
C      SEE COMPUTING METHODS IN CRYSTALLOGRAPHY, PAGE 28.
C      IN THIS MACHINE THE HORIZONTALINCIDENT BEAM IS Y, WITH THE +VE
C      SENSE BEING FROM THE CRYSTAL TOWARDS THE SOURCE. Z IS VERTICAL
C      WITH THE POSITIVE SENSE UPWARDS AND X COMPLETES A RIGHT HANDED
C      SYSTEM. ALL ROTATIONS ARE REGARDED AS BEING DERIVED FROM RIGHT
C      HANDED SCREWS, I.E. A +VE ROTATION ABOUT Z TAKES X INTO Y AND
C      ABOUT Y TAKES Z INTO X.
C
C       ALL DIFFRACTOMETER ANGLE CALCULATIONS ARE PERFORMED IN THE
C      COORDINATE SYSTEM DEFINED BY THE MANUFACTURERS, THUS FACILITATIN
C      THE CHECKING OF CODE. CONVERSIONS TO A ROLLETT MACHINE ARE DONE
C      IN THE SUBROUTINE WCVT , WHERE RULES ARE GIVEN FOR PERFORMING TH
C      COMVERSION.
C
\ICOM30
\ISTORE
      DIMENSION DIRCOS(3)
C
\STORE
\XCONST
\XLISTI
\XUNITS
\XSSVAL
C
      COMMON /XABSW/A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,VV,W,X,Y,
     2 Z,DD(4)
      COMMON /XABSWK/IMODE,WAV,WAVSQ,IDIF,IDAT,IFF,IG,ALPHA,IR1,IR2,
     2 IR3,IR4,ISET,NPI,NPV,VK(3),UM(3,3),UB(3,3),V(3,2),FACT(10),
     3 BFACT(10),CFACT(10),THL,ISPC
\XLST01
\XLST06
\XLST6A
\XLST13
\XLST27
\XLST30
\XERVAL
\XOPVAL
C
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
\XIOBUF
C
\QSTORE
\QLST30
C
C
      EQUIVALENCE (FCV(1),FC1),(FCV(2),FC2),(FCV(3),FC3),(FBIS(1),
     2 FTHETA),(FBIS(2),FPHIB),(FBIS(3),FCHIB),(FEUL(1),FPHIE),(FEUL(2)
     3 ,FOME),(FEUL(3),FCHIE),(FKAP(1),FPHIK),(FKAP(2),FOMK),(FKAP(3),
     4 FKAPPA),(FHKL(1),FH),(FHKL(2),FK),(FHKL(3),FL)
C
      SAVE
C
      DATA IVERSN/202/
C
      MABS = -1
C--CHECK IF THIS AN INITIALISATION, CALCULATION OR TERMINATION CALL
      IF(IPOINT)1000,2000,6500
C----- CHECK THAT THE REQUIRED LISTS ATE LOADED
1000  CONTINUE
      IF (KHUNTR( 1 ,0,IDUM,JDUM,KDUM,-1) .NE. 0) GOTO 9900
      IF (KHUNTR( 13 ,0,IDUM,JDUM,KDUM,-1) .NE. 0) GOTO 9900
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--STORED BY ROWS SO MUST TRANSPOSE
      CALL MTRANS(STORE(L1O2))
      TLM=1.
      RT=90.*DTR
      WAV=STORE(L13DC)
      WAVSQ=WAV*WAV
      FLAM(1)=WAV
C--CONSTANTS FOR Y290
      THL=DTR*STORE(L13DC+6)
C--- CONSTANTS FOR CAD4
      CON1=STORE(L13DC+3)
      CON2=STORE(L13DC+4)
      CON3=STORE(L13DC+5)
C--- CLEAR MAXIMUM CORRECTIONS
      CALL XZEROF(FACT(1),10)
      CALL XZEROF(BFACT(1),10)
      DO 1200 I=1,10
C--- SET MINIMUM CORRECTIONS
      CFACT(I)=100000.
1200  CONTINUE
C--DETERMINE SETTING TYPE
      IDAT=ISTORE(L13DT+2)
C----- DETERMINE DIFFRACTOMETER TYPE
      IDIF=ISTORE(L13DT)-5
      IF(IDIF .LE. 0) GOTO 1250
C
C------ CHECK IF ANY CORRECTIONS ARE GIVEN
C----- CHECK IF ROD OR PLATE
      ISPEC = MAX0( ITUBE,IPLATE)
      IF (ISPEC) 1206,1206,1203
1203  CONTINUE
C----- SET DEFAULT ADDRESS FOR TUBE
      ISPC = ITU
      IF (ITUBE) 1204,1204,1252
C----- MOVE PLATE DETAILS INTO ROD SLOTS
1204  CONTINUE
C----- REGARD PLATE AS BEING 2 HALF PLATES
      STORE(IPL+5) = 0.5 * STORE(IPL+5)
      ISPC = IPL
      GOTO 1252
1206  CONTINUE
      IF(IPHI) 1201,1201,1252
1201  CONTINUE
      IF(ITHETA) 1202,1202,1252
1202  CONTINUE
C----- NOTHING GIVEN  - SET TYPE TO ZERO
      GOTO 1250
1250  CONTINUE
      IDIF=0
      GO TO 1900
1252  CONTINUE
C----- APPARATUS IS NOT PHOTOGRAPHIC ?
      IF(IDIF)1250,1250,1253
1253  CONTINUE
C----- IS SETTING DATA GIVEN ?
      IF(IDAT)1250,1250,1210
1210  CONTINUE
      IF(IDAT-8)1300,1300,1250
C--PHI CURVES
1300  CONTINUE
      WRITE(NCAWU,1301)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1301)
      ENDIF
1301  FORMAT (///,2X,' An absorption correction may be computed'/)
C--- CHECK IF PHI CORRECTION REQUESTED
      IFF=NFL
      IF(IPHI)1490,1490,1310
1310  CONTINUE
      LN=106
      IREC=4001
      NPI=MDPHI
      IQQ=KCHNFL(NPI+4)
      CALL XMOVE(STORE(LPHI),STORE(IFF  ),NPI)
      K=IFF+NPI
C--- EXTEND PHI VALUE CURVE BEYOND 180
      STORE(K  )=180.+STORE(IFF  )
      STORE(K+1)=180.+STORE(IFF+1)
      STORE(K+2)=180.+STORE(IFF+2)
      STORE(K+3)=180.+STORE(IFF+3)
      NPV=NPHIC
C--FORMAT H K L I E I(I)
C--NO. OF CURVES
C
      IREC=4002
C
      MPHID=LPHID
      MPHIC=LPHIC
      DO 1400 I=1,NPV
      J=NFL
      IQQ=KCHNFL(MDPHID+MDPHIC+5)
      CALL XMOVE(STORE(MPHIC),STORE(J),MDPHIC)
      J=J+MDPHIC+1
      CALL XMOVE(STORE(MPHID),STORE(J),MDPHID)
      J=J+MDPHID
C--- EXTEND INTENSITY VALUES CURVE
      CALL XMOVE(STORE(MPHID),STORE(J),4)
      MPHID=MPHID+MDPHID
      MPHIC=MPHIC+MDPHIC
1400  CONTINUE
      NPI=NPI+4
C
C
1490  CONTINUE
C--THETA CURVE
      IF(ITHETA)1800,1800,1600
1600  CONTINUE
C--CONVERT TO RADIANS
      CALL XMULTR(STORE(IT),DTR,STORE(IT),NTI)
1800  CONTINUE
C--- WORK MATRIX ADDRESSES
      IR1=NFL
      IR2=NFL+9
      IR3=NFL+18
      IR4=IR3+9
      IQQ=KCHNFL(36)
      IBUF=NFL
      LN=106
      IREC=5001
      IQQ=KCHNFL(MD6)
C--- PROCESS CORRECTION DATA
      CALL WPRCS
      IF ( IERFLG .LT. 0 ) GO TO 9900
1900  CONTINUE
C--END OF INITIALISATION
C---  INITIALISE OVERALL CORRECTION
      AFACT =1.
      MABS=0
      RETURN
C
C--COMPUTE THE CORRECTION FOR THE CURRENT REFLECTION
2000  CONTINUE
      MABS=-1
      AFACT=1.
      IF(IDIF)6300,6300,2050
2050  CONTINUE
      IMODE=0
      IF(STORE(M6+21)-.0001)2100,2100,2200
C--- THETA NOT SET - ANGLES TO BE CALCULATED
2100  CONTINUE
      IMODE=1
C----- CALCULATE THETA
2200  CONTINUE
      STH=STHETA(STORE(M6))
      CTH=SQRT(1.-STH*STH)
      TH=ATAN2(STH,CTH)
      GO TO (2400,2650,2700,2400,2300),IDIF
2300  CONTINUE
      CALL GUEXIT( 2000 )
C--CAD4
2400  CONTINUE
      IF(IMODE)2500,2500,2600
C--COPY AND CONVERT ANGLES
2500  CONTINUE
      J=IBUF+21
      K=M6+21
      CALL WAIN(IDIF,J,K)
2550  CONTINUE
      CALL WCVT(IDIF,J,J)
2560  CONTINUE
      OM=STORE(J+1)
      CHI=STORE(J+2)
      PHI=STORE(J+3)
      GO TO 3200
C- CALCULATE ANGLES
2600  CONTINUE
      CALL XMOVE(STORE(M6),FHKL(1),3)
      CALL HTOW(1)
      CALL HTOW(2)
      J=IBUF +21
      STORE(J+1)=FBIS(1)
      STORE(J+2)=FBIS(3)
      STORE(J+3)=FBIS(2)
      GOTO 2550
C----- ROLLETT MACHINE
2650  CONTINUE
C--Y290
2700  CONTINUE
      IF(IMODE)2750,2750,2770
C----- COPY AND CONVERT ANGLES
2750  CONTINUE
      J=IBUF+21
      M=M6+21
      CALL WAIN(IDIF,J,K)
      GO TO 2560
2770  CONTINUE
C----- CALCULATE ANGLES
      CALL XMLTMM(UB,STORE(M6),VK,3,3,1)
      OM = SQRT(VK(1)*VK(1)+VK(2)*VK(2))
      IF ((OM.LE.ZERO) .AND. (ABS(VK(3)).LE.ZERO)) THEN
        CHI = 0.0
      ELSE
        CHI=ATAN2(VK(3),OM)
      ENDIF
      IF ((ABS(VK(2)).LE.ZERO) .AND. (ABS(VK(1)).LE.ZERO)) THEN
        PHI = 0.0
      ELSE
        PHI=ATAN2(-VK(2),VK(1))
      ENDIF
      OM=TH
      IF(TH-THL)3200,3200,2800
C--FIXED CHI
2800  CONTINUE
      IF(VK(3))3000,2900,2900
2900  CONTINUE
      OM=TH+CHI-RT
      CHI=RT
      PHI=PHI+RT
      GOTO 3100
3000  CONTINUE
      OM=TH-CHI-RT
      CHI=-RT
      PHI=PHI+RT
3100  CONTINUE
      GOTO 3200
C
C
C----- COMPUTE THE CORRECTIONS --------
C
C
3200  CONTINUE
      STORE(M6+22)=OM
      STORE(M6+23)=CHI
      STORE(M6+24)=PHI
C----- NOTE THAT ANGLES ARE NOW FOR A ROLLETT MACHINE.
C----- COMPUTING METHODS IN CRYSTALLOGRAPHY,PAGE 28
      SC=SIN(CHI)
      IF(IPHI)4600,4600,3400
C
C
C--PHI CORRECTIONS
3400  CONTINUE
C---  PROJECTION OF SCATTERING VECTOR ONTO PLANE
C---  PERPENDICULAR TO PHI AXIS
      AL=((1.+STH*STH*(SC*SC-2.))/(1.-STH*STH*SC*SC))
      IF(AL-1.)3600,3600,3500
3500  CONTINUE
      AL=1.
3600  CONTINUE
      AL=0.5*ACOS(AL)
      FACT(8)=AL
      EP=ABS(2.*STH*SC)
      K=IFF+NPI+3
      J=K
      A=1000000
      DO 3900 I=1,NPV
      B=ABS(EP-STORE(K+1))
      IF(B-A)3700,3800,3800
3700  CONTINUE
      A=B
      J=K
3800  CONTINUE
      K=K+NPI+5
3900  CONTINUE
      C=PHI+AL-2.*PI
4000  CONTINUE
      IF(C-STORE(IFF+1))4100,4100,4200
4100  CONTINUE
      C=C+PI
      GOTO 4000
4200  CONTINUE
      A=WINPL(IFF  ,J+2,C,NPI)
      FACT(9)=A
      A=STORE(J)/A
      C=PHI-AL-2.*PI
4300  CONTINUE
      IF(C-STORE(IFF+1))4400,4400,4500
4400  CONTINUE
      C=C+PI
      GOTO 4300
4500  CONTINUE
      B=WINPL(IFF  ,J+2,C,NPI)
      FACT(1)=0.5*(A+STORE(J)/B)
      AFACT=AFACT*FACT(1)
      FACT(10)=B
      BFACT(1)=AMAX1(BFACT(1),FACT(1))
      CFACT(1)=AMIN1(CFACT(1),FACT(1))
4600  CONTINUE
      IF(ITHETA)4800,4800,4700
C
C
C--THETA CORRECTION
4700  CONTINUE
      A=WINPL(IT,ITC,TH,NTI)
      FACT(2)=A
      BFACT(2)=AMAX1(BFACT(2),FACT(2))
      CFACT(2)=AMIN1(CFACT(2),FACT(2))
      AFACT=AFACT*A
4800  CONTINUE
C----- CHECK FOR ROD OR PLATE CORRECTION
      IF (ISPEC) 5900,5900,4900
C
C
C
C------ SPECIMEN IS ROD OR PLATE SHAPED.
C       COMPUTATION IS SUBSTANTIALLY THE SAME.
4900  CONTINUE
      I=0
C----- SET MAXIMUM CORRECTION
      D=STORE(ISPC +5)
C----- ROTATE ABOUT Z
      A=PHI*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR1)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- ROTATE ABOUT Y
      A=CHI*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(2) = 1.
      IF (NROT(DIRCOS,A,STORE(IR2)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- ROTATE ABOUT Z
      A=OM*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR3)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
      CALL XMLTMM(STORE(IR2),STORE(IR3),STORE(IR4),3,3,3)
      CALL XMLTMM(STORE(IR3),STORE(IR4),STORE(IR1),3,3,3)
C----- COMPONENETS OF SPECIMEN IN STANDARD SETTING
      CALL XMLTMM(STORE(IR1),STORE(ISPC),STORE(IR4),3,3,1)
C      IF (NORM3(STORE(IR4)) .LE. 0.0 ) STOP 'ZERO LENGTH VECTOR'
      IF (NORM3(STORE(IR4)) .LE. 0.0 ) CALL GUEXIT ( 2001 )
C----- DIFFRACTED BEAM
      VK(1)=SIN(2.*TH)
      VK(2)=-COS(2.*TH)
      VK(3)=0.
C----- COSINE OF ANGLE BETWEEN BEAM AND AXIS
      A=STORE(IR4)*VK(1)+STORE(IR4+1)*VK(2)+STORE(IR4+2)*VK(3)
      A = ABS(A)
      IF(ITUBE) 4920,4920,4910
4910  CONTINUE
C     ROD
      A=SQRT(1.-A*A)
4920  CONTINUE
C----- PLATE
      IF(STORE(ISPC+3)-A)5100,5000,5000
5000  CONTINUE
      I=1
C--COMPONENTS OF INCIDNT BEAM ARE 0 1 0
5100  CONTINUE
      B = ABS(STORE(IR4+1))
      IF(ITUBE) 4940,4940,4930
4930  CONTINUE
C----- ROD
      B=SQRT(1.-B*B)
4940  CONTINUE
C----- PLATE
      IF(STORE(ISPC+3)-B)5300,5200,5200
5200  CONTINUE
      I=1
5300  CONTINUE
      C=A*B/(A+B)
      IF(STORE(ISPC+3)-C)5500,5400,5400
5400  CONTINUE
      I=1
5500  CONTINUE
      D=EXP(STORE(ISPC+4)/C)
      IF(I)5800,5800,5600
5600  CONTINUE
      WRITE ( CMON,5700) STORE(M6), STORE(M6+1), STORE(M6+2),
     2 A,B,C,D
      CALL XPRVDU(NCVDU, 2,0)
      WRITE(NCAWU, '(A)') (CMON(II )(:),II=1,2)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') (CMON(II )(:),II=1,2)
5700  FORMAT(1X,3F4.0,' Excessive shape correction',/,
     1 ' Inclinations ',3F7.3,'  Correction ',F12.3)
C----- SET MAXIMUM CORRECTION
      D = STORE(ISPC +5)
5800  CONTINUE
      FACT(3)=D
      BFACT(3)=AMAX1(BFACT(3),FACT(3))
      CFACT(3)=AMIN1(CFACT(3),FACT(3))
      AFACT=AFACT*D
C
5900  CONTINUE
      IF(IPRINT)5950,6200,5950
5950  CONTINUE
C---  FULL LISTING
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,6100) STORE(M6),STORE(M6+1),STORE(M6+2),STORE(M6+3),
     1 STORE(M6+12),TH,OM,CHI,PHI,AFACT
      ENDIF
      IF(IPRINT)6000,6200,6200
6000  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,6100)FACT
      ENDIF
6100  FORMAT(1X,10F10.3)
6200  CONTINUE
C
6300  CONTINUE
      BFACT(10)=AMAX1(BFACT(10),AFACT)
      CFACT(10)=AMIN1(CFACT(10),AFACT)
C----- COMPUTE PATH LENGTH RELATIVE TO BASE OF TBAR=1
      TBAR=1.+ALOG(AFACT)
      STORE(M6+9)=TBAR
      AFACT=SQRT(AFACT)
      STORE(M6+27)=STORE(M6+27)*AFACT
      MABS=0
      RETURN
C
C--TERMINATION MESSAGES
6500  CONTINUE
C
C -- IF NO ABSORPTION CORRECTION WAS PERFORMED, THEN RETURN NOW
C
      IF ( IDIF .EQ. 0 ) RETURN
C
C----- LOAD DATA IF LIST 30 NOT ALREADY IN CORE
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL30
      IF (IERFLG .LT. 0) GOTO 6520
CDJW FEB03 - LEAVE LIST 30 INDEX RANGES ALONE
C      LIX = L6DTL
C      STORE(L30IX) = STORE(LIX)
C      STORE(L30IX+1) = STORE(LIX+1)
C      LIX = LIX + MD6DTL
C      STORE(L30IX+2) = STORE(LIX)
C      STORE(L30IX+3) = STORE(LIX+1)
C      LIX = LIX + MD6DTL
C      STORE(L30IX+4) = STORE(LIX)
C      STORE(L30IX+5) = STORE(LIX+1)
      IF (CFACT(10) .EQ. 100000.) THEN
        STORE(L30AB+4) = 1.
      ELSE
        STORE(L30AB+4) = CFACT(10)
      ENDIF
      IF (BFACT(10) .EQ. 0.) THEN
        STORE(L30AB+5) = 1.
      ELSE
        STORE(L30AB+5) = BFACT(10)
      ENDIF
      ISTORE(L30AB+8) = 2
      CALL XWLSTD ( 30, ICOM30, IDIM30, -1, -1)
 6520  CONTINUE
      WRITE ( CMON,6599)BFACT(10),CFACT(10)
      CALL XPRVDU(NCVDU, 2,0)
      WRITE(NCAWU, '(A)') (CMON(II )(:),II=1,2)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') (CMON(II )(:),II=1,2)
      WRITE ( CMON,6600)
      WRITE(NCAWU, '(A)') CMON(1 )(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
C----- SET DIFFRACTOMETER TYPE TO ROLLETT
      ISTORE(L13DT)=7
6599  FORMAT( ' Maximum correction to I is ',F7.2,
     1       /' Minimum correction to I is ',F7.2)
6600  FORMAT(
     1 ' The setting angles stored in list 6 are now for a ',
     2 ' ''Rollett'' machine.'  )
      MABS=0
      CALL XOPMSG (IOPABS, IOPEND, IVERSN)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPABS , IOPABN , 0 )
      MABS = -1
      RETURN
C
      END
C
C
CODE FOR WPRCS
      SUBROUTINE WPRCS
C
\STORE
C
      DIMENSION DIRCOS(3)
C
C
\XCONST
\ISTORE
C
      COMMON /XABSW/A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,VV,W,X,Y,
     2 Z,DD(4)
      COMMON /CAD/FCV(3),PD(3,3),QD(3,3),RD(3,3),SD(3,3),SI,CO,FKAP(3),
     2 FBIS(3),FPSI,FEUL(3),FHKL(3),CD(3,3),FLAM(3),DET,CON1,CON2,CON3
C
C
      COMMON /XABSWK/IMODE,WAV,WAVSQ,IDIF,IDAT,IFF,IG,ALPHA,IR1,IR2,
     2 IR3,IR4,ISET,NPI,NPV,VK(3),UM(3,3),UB(3,3),V(3,2),FACT(10),
     3 BFACT(10),CFACT(10),THL,ISPC
\XLST01
\XLST02
\XLST06
\XLST6A
\XLST27
\XLST13
\XERVAL
\XOPVAL
C
\QSTORE
\XUNITS
\XSSVAL
\XIOBUF
C
C
C
      EQUIVALENCE (XCRU,NCRU),(XCWU,NCWU),(XCRRU,NCRRU)
C
      EQUIVALENCE (FCV(1),FC1),(FCV(2),FC2),(FCV(3),FC3),(FBIS(1),
     2 FTHETA),(FBIS(2),FPHIB),(FBIS(3),FCHIB),(FEUL(1),FPHIE),(FEUL(2)
     3 ,FOME),(FEUL(3),FCHIE),(FKAP(1),FPHIK),(FKAP(2),FOMK),(FKAP(3),
     4 FKAPPA),(FHKL(1),FH),(FHKL(2),FK),(FHKL(3),FL)
C
C
C----- INDICATE TO NONIUS CODE THAT THERE IS A MATRIX
      DET = 1.
C
C
C
C----- PROCESS CORRRRRECTION DATA
      IF(IPHI)1600,1600,1100
1100  CONTINUE
      K=IFF-1
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1300)NPI,(STORE(K+I),I=1,NPI)
      ENDIF
      DO 1200 I=1,NPI
      STORE(K+I)=DTR*STORE(K+I)
1200  CONTINUE
1300  FORMAT(/I4,' Phi values',/(1X,10F10.2))
      K=IFF+NPI
      KK=NPI+4+K
      DO 1500 L=1,NPV
      STORE(K+4)=2.*STHETA(STORE(K))
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1400)(STORE(I),I=K,KK)
      ENDIF
1400  FORMAT(/3F4.0,6X,' Imax ',F12.3,3X,' 2Sin(Theta) ',F6.4,/(1X,
     2 10F10.0))
      K=KK+1
      KK=K+NPI+4
1500  CONTINUE
1600  CONTINUE
C
C
      IF(ITUBE)1650,1650,1700
1650  CONTINUE
      IF(IPLATE)1900,1900,1700
1700  CONTINUE
      CALL WAIN(IDIF,IR4,ISPC)
      CALL WCVT(IDIF,IR4,IR4)
C----- ROTATE ABOUT Z
      A=-STORE(IR4+1)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR1)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- ROTATE ABOUT Y
      A=-STORE(IR4+2)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(2) = 1.
      IF (NROT(DIRCOS,A,STORE(IR2)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- ROTATE ABOUT Z
      A=-STORE(IR4+3)*RTD
      CALL XZEROF(DIRCOS(1),3)
      DIRCOS(3) = 1.
      IF (NROT(DIRCOS,A,STORE(IR3)) .LE. 0.0) THEN
      CALL XOPMSG (IOPABS,IOPINT,0)
      CALL XERHND(IERPRG)
      ENDIF
C----- FORM [P].[X].[W]
      CALL XMLTMM(STORE(IR2),STORE(IR1),STORE(IR4),3,3,3)
      CALL XMLTMM(STORE(IR3),STORE(IR4),STORE(IR1),3,3,3)
C----- TUBE LIES ALONNG X
      VK(1)=1.
      VK(2)=0.
      VK(3)=0.
C----- CALC INDICES OF TUBE
      CALL XMLTMM(STORE(IR1),VK(1),STORE(ISPC),3,3,1)
C      IF(NORM3(STORE(ISPC)) .LE. 0.0)STOP 'ZERO LENGTH VECTOR'
      IF(NORM3(STORE(ISPC)) .LE. 0.0) CALL GUEXIT(2001)
C
C----- FIND MINIMUM INCLINATION ANGLE
      B = STORE(ISPC +5) / (STORE(ISPC +5) + ALOG(STORE(ISPC +6)) )
      IF(ITUBE .GT. 0) THEN
      A=ASIN(B)
      ELSE
      A = ACOS(B)
      ENDIF
      STORE(ISPC+3)=RTD*A
C---- SHUFFLE EVERYTHING DOWN
      STORE(ISPC+4)=STORE(ISPC+5)
      STORE(ISPC+5)=STORE(ISPC+6)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1800)(STORE(J),J=ISPC,ISPC+5)
      ENDIF
      WRITE(NCAWU,1800)(STORE(J),J=ISPC,ISPC+5)
      STORE(ISPC+3)=B
1800  FORMAT(//,' Specimen shape correction',/,
     1 ' Components of specimen axis ',3F7.2,/,
     2 ' Limiting inclination ',F7.3,',    MU*T ',F7.3,/,
     3 ' Maximum permitted correction ',F7.3,//)
C
1900  CONTINUE
      RETURN
      END
