C $Log: not supported by cvs2svn $
C Revision 1.2  2001/02/26 10:28:03  richard
C RIC: Added changelog to top of file
C
C
CODE FOR SMOLAX
      SUBROUTINE SMOLAX
C--SUBROUTINE TO CALCULATE GENERALISED PLANES/LINES  IN A
C  STRUCTURE AND TO CALCULATE ANGLES BETWEEN PERPENDICULARS
C  TO THESE PLANES/LINES
C
C      VERSION     DATE              BY    CHANGE
C      -------     ----              --    ------
C      2.11        JANUARY 2001      DJW   ALSO PUNCH EVALUATE ATOMS
C      2.10        JANUARY 2000      DJW   ADD OUTPUT OF CENTROID, AND
C                                          PUNCH DIRECTIVE
C      2.05        FEBRUARY 1989     DJW   ADD 'LINE' DIRECTIVE
C      2.02        AUGUST 1984       PWB   ONLY LIST COORDINATES OF
C                                          ATOMS WHEN A 'PLANE' CARD
C                                          HAS BEEN GIVEN
C
C--THE FOLLOWING ARRAYS ARE USED :
C
C  VA      THE LATENT ROOTS.
C  EQU     THE COEFFICIENTS OF THE EQUATION FOR THE CURRENT PLANE/LINE .
C  ROF     THE MATRIX THAT TRANSFORMS ORTHOGONAL COORDINATES IN ANGSTROM
C          INTO BEST PLANE/LINE  COORDINATES IN ANGSTROM.
C  RCA     THE MATRIX THAT TRANSFORMS FRACTIONAL COORDINATES INTO
C          BEST PLANE/LINE  COORDINATES IN ANGSTROM.
C  RCF     THE MATRIX THAT TRANSFORMS FRACTIONAL COORDINATES INTO
C          BEST PLANE/LINE  COORDINATES IN FRACTIONS.
C  RPCA    THE INVERSE OF 'RCA'.
C  RPCF    THE INVERSE OF 'RCF'.
C  XCF     THE COORDINATES OF THE CENTROID IN CRYSTAL FACTIONS.
C  XCA     THE COORDINATES OF THE CENTROID IN ORTHOGONAL ANGSTROM.
C  XCR     THE COORDINATES OF THE CENTROID IN BEST PLANE ANGSTROM.
C
C -- VARIABLES
C      JJ          INDICATES WHETHER A PLOT IS REQUIRED
C                    -1      NO PLOT
C                     1      PLOT
C
C      JTYPE       INDICAES PLANE OR LINE
C                     1      LINE
C                     2      PLANE
C
      CHARACTER *5 CTYPE(2), CDEL(2), CQUAL(2), CDEV(2)
C
C
C
C--
\ICOM12
\ISTORE
C
      DIMENSION VA(3),EQU(3),RPCA(3,3),RPCF(3,3),ROF(3,3),RCA(3,3)
      DIMENSION RCF(3,3),XCA(3),XCF(3),XCR(3)
      DIMENSION DCOSA(3)
      DIMENSION DCOSB(3)
      INTEGER BTARG, CTARG
      DIMENSION BTARG(1)
      DIMENSION CTARG(1)
      DIMENSION XWORKS(4)
      DIMENSION PAXIS(3)
C-C-C-DECL. OF VARIABLES TO CALC. POLAR COORD. OF SPECIAL FIGURES
      REAL VECPD, VECPA
C
\STORE
\XUNITS
\XSSVAL
\XLISTI
\XCNTRL
\XCONST
\XLST01
\XLST02
\XLST05
\XLST12
\XLST20
\XLEXIC
\XCHARS
\XERVAL
\XOPVAL
\XIOBUF
C
\QLST12
\QSTORE
C
C
      DATA IVERSN /210/
C
#HOL      DATA BTARG(1) /'AND '/, CTARG(1) /'ALL '/
&HOL      DATA BTARG(1) /4HAND /, CTARG(1) /4HALL /
C
          DATA CTYPE(2) /'plane'/, CTYPE(1) /'line '/
          DATA CQUAL(2) /'best '/, CQUAL(1) /'worst'/
          DATA CDEL(2)  /'     '/, CDEL(1)  /'delta'/
          DATA CDEV(2)  /' Zp  '/, CDEV(1)  /'delta'/
C
C
C----- DISABLE 'PUNCHING'
      JPUNCH = 0
C----- DIS-ENABLE DETAILED PRINTING
C      ISTAT2 = 1
C--SET UP THE TIMING CONTROL
      CALL XTIME1(2)
C--CLEAR THE CORE
      CALL XCSAE
C----- WORKSPACE FOR REPLACEMENT
      IWORK = KSTALL(3)
      JWORK = KSTALL(9)
C----- SPACE FOR ATOM HEADERS
      MQ = KSTALL (100)
C----- COMMAND BUFFER
      IDIMBF = 50
      ICOMBF = KSTALL (IDIMBF)
C----- ZERO THE BUFFER
      CALL XZEROF (ISTORE(ICOMBF), IDIMBF)
C----- COMMON BLOCK OFFSET(-1) FOR INPUT LIST
      IMDINP = 35
C----- INITIALSE LEXICAL PROCESSING
      ICHNG = 1
      CALL XLXINI (INEXTD, ICHNG)
C
C----- INDICATE NO MODIFICATIONS YET
      IMOD5 = 0
C----- INDICATE LIST 20 NOT UPDATED
      IUPDT = 0
\IDIM12
C--INDICATE THAT LIST 12 IS NOT TO BE USED
      DO 1050 I=1,IDIM12
      ICOM12(I)=NOWT
1050  CONTINUE
C--SET THE PLANE/LINE  FLAG TO INDICATE NO ATOMS STORED AT PRESENT
      LEF1=-1
C----- SET THE CALCULATION TYPE TO PLANE
      JTYPE = 2
C----- SET PLANES COUNTER TO ZERO
      NP=0
C--SET THE CONSTANTS FOR THE PLANE COEFFICIENTS STACK
      JN=4
      JL=LFL+1
      GOTO 3000
C
C--MAIN INSTRUCTION CYCLING LOOP
1100  CONTINUE
C----- DO NOT REPLACE ATOMS
      IRPL = 0
      IDIRNM = KLXSNG (ISTORE(ICOMBF), IDIMBF, INEXTD)
      IF (IDIRNM .LT. 0) GOTO 1100
      IF (IDIRNM .EQ. 0) GOTO 4910
C--NEXT RECORD HAS BEEN LOADED  -  BRANCH ON THE TYPE
      GOTO (1250, 2000, 3050, 3850, 2010, 3025, 4825,
     1 1100, 9900, 2005, 2007, 1210, 1200), IDIRNM
1200  CONTINUE
      GOTO 9910
C
1210  CONTINUE
C----- MOLAX ITSELF
C--LOAD THE RELEVANT LISTS
      CALL XFAL01
      CALL XFAL02
      CALL XFAL20
      IF ( IERFLG .LT. 0 ) GO TO 9900
      IULN5=KTYP05( ISTORE(ICOMBF + IMDINP))
      CALL XLDR05(IULN5)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--LIST READ IN OKAY  -  SET UP THE INITIAL CONTROL FLAGS
      GOTO 1100
C
C
C--'ATOM' INSTRUCTION
1250  CONTINUE
      LEF1=-1
      LEF=0
C----- STORE THE 'END' OF THE ATOM STACK
      IBASE = LFL
C--RECORD THE NUMBER OF ATOMS FOUND TO DATE
      M=N
      Z=1.
C--CHECK FOR SOME ARGUMENTS
      IF(KFDARG(I))1300,1400,1400
C--ERROR(S)  -  INCREMENT THE ATOM ERROR COUNT
1300  CONTINUE
      LEF2=LEF2+1
      GOTO 1100
C--CHECK IF THERE ARE MORE ARGUMENTS ON THIS CARD
1350  CONTINUE
      IF(KOP(8))1850,1400,1400
C--CHECK IF NEXT ARGUMENT IS A NUMBER
1400  CONTINUE
      IF(KSYNUM(Z))1500,1450,1500
1450  CONTINUE
      ME=ME-1
      MF=MF+LK2
C--READ THE NEXT GROUP OF ATOMS
1500  CONTINUE
      IF(KATOMU(LN))1550,1550,1600
C--ERRORS  -  INCREMENT THE ATOM ERROR COUNT
1550  CONTINUE
      LEF2=LEF2+1
      GOTO 4850
C--MOVE ATOMS TO STACK WITH CORRECT CO-ORDINATES
1600  CONTINUE
      DO 1800 J=1,N5A
      LFL=LFL-MD5A
      IF(NFL+27-LFL)1700,1650,1650
C--ERRORS
1650  CONTINUE
      LEF2=LEF2+1
      GOTO 4900
C--TRANSFORM THE ATOM AND MOVE IT ACROSS
1700  CONTINUE
      IF(KATOMS(MQ,M5A,LFL))1550,1550,1750
C--ATOM MOVED OKAY  -  SET THE WEIGHT
1750  CONTINUE
      STORE(LFL+7)=Z
C--INCREMENT FOR THE NEXT ATOM
      M5A=M5A+MD5A
1800  CONTINUE
      N=N+N5A
      GOTO 1350
C--CHECK THAT THERE IS AT LEAST ONE ATOM ON THIS CARD
1850  CONTINUE
      LEF2=LEF2+LEF
C----- STORE THE 'START' OF THE ATOM STACK
      JBASE = LFL
      LFL = LFL - 1
      IF(M-N)1100,1900,1900
C--NO ATOMS ON THIS CARD
1900  CONTINUE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1950)
      WRITE(NCAWU,1950)
      WRITE ( CMON ,1950)
      CALL XPRVDU(NCVDU, 1,0)
1950  FORMAT(' No atoms found')
      GOTO 1300
C
2000  CONTINUE
      JTYPE = 2
      GOTO 2006
C--'LINE' INSTRUCTION
2005  CONTINUE
      JTYPE = 1
2006  CONTINUE
      LEF1=1
C----- NO PLOTS TO BE DONE
      JJ=-1
      GOTO 2040
C
C-----  'PUNCH'
2007  CONTINUE
C      SET PUNCH 'ON'
      JPUNCH = 1
      GOTO 1100
C
C
2010  CONTINUE
C----- 'PLOT' INSTRUCTION
      JJ=1
      JTYPE = 2
2040  CONTINUE
C -- CHECK THERE ARE SOME ATOMS WHOSE PLANE/LINE  CAN BE CALCULATED
      IF ( N .LE. 0 ) GO TO 9920
C--INCREMENT THE NUMBER OF PLANE/LINE   CARDS READ
      NP=NP+1
C--CHECK IF ANY ERRORS HAVE BEEN GENERATED DURING THE INPUT OF THE ATOMS
      IF(LEF2)2150,2150,2050
2050  CONTINUE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2100)
      WRITE(NCAWU,2100)
      WRITE ( CMON ,2100)
      CALL XPRVDU(NCVDU, 1,0)
2100  FORMAT(' Instruction ignored because of previous errors')
      GOTO 3000
2150  CONTINUE
C--PRINT THE PAGE HEADING
      CALL XPRTCN
C--PRINT THE AXIS CARD AND ITS NUMBER
      IF (ISSPRT .EQ. 0) WRITE (NCWU,2300) NP
      WRITE(NCAWU,2300) NP
      WRITE ( CMON ,2300) NP
      CALL XPRVDU(NCVDU, 1,0)
2300  FORMAT(' Results for axis number ',I4)
C--COMPUTE THE PRINCIPAL AXES
      ISTAT = KMOLAX (STORE(JBASE+4), N, MD5A, XCF, VA, ROF,RCA,XWORKS)
      CALL XMOVE(VA, PAXIS, 3)
      IF (JTYPE .EQ. 1) THEN
C----- REVERSE ORDER TO GET BEST LINE SYSTEM
        DUM = VA(1)
        VA(1) = VA(3)
        VA(3) = DUM
        DO 2360 I = 1, 3
          DUM = RCA(I,1)
          RCA(I,1) = RCA(I,3)
          RCA(I,3) = DUM
          DUM = ROF(1,I)
          ROF(1,I) = ROF(3,I)
          ROF(3,I) = DUM
2360    CONTINUE
      ENDIF
C
      IF ( ISTAT .GE. 0 ) GO TO 2450
      IF ( N .GT. JTYPE ) GOTO 2450
C
C--ATOMS DO NOT DEFINE A PLANE/LINE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2400) CTYPE(JTYPE)
      WRITE(NCAWU,2400) CTYPE(JTYPE)
      WRITE ( CMON ,2400) CTYPE(JTYPE)
      CALL XPRVDU(NCVDU, 1,0)
2400  FORMAT(' Input atoms do not define a ', A)
      GOTO 3000
C--CALCULATE THE ROTATION MATRICES FROM 'CRYSTAL ANGSTROM'
2450  CONTINUE
      CALL XMLTMT(ROF,STORE(L1O1+9),RCF,3,3,3)
C--CALCULATE THE EQUATION OF THE PLANE/LINE
      CALL XMOLEQ(XCF,ROF,EQU,F,RCA )
C-C-C-CALCULATION OF POLAR COORDINATES OF ORIENTATION VECTOR
C-C-C-DECLINAT
      IF (ROF(3,1) .GE. 0.0) THEN
       VECPD=(ACOS(ROF(3,3)))*360.0/TWOPI
      ELSE
       VECPD=(-ACOS(ROF(3,3)))*360.0/TWOPI
      ENDIF
C-C-C-AZIMUTH
      IF (ABS(ROF(3,1)) .LT. ZEROSQ) THEN
       IF (ROF(3,2) .GE. 0.0) THEN
        VECPA = 90.0
       ELSE
        VECPA = -90.0
       ENDIF
      ELSE
       VECPA = (ATAN(ROF(3,2)/ROF(3,1)))*360.0/TWOPI
      ENDIF
C--COMPUTE THE ORTHOGONAL COORDINATES OF THE CENTROID AND PRINT THEM
      CALL XMLTTM(STORE(L1O1),XCF,XCA,3,3,1)
      IF (JJ .NE. 1) THEN
      WRITE(CMON,2499) (XCF(I),I=1,3)
2499  FORMAT('Centroid, fractions',3X,4F10.3)
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2500)(XCA(I),I=1,3),(XCF(I),I=1,3)
2500  FORMAT(//44H Centroid in orthogonal angstrom and crystal,
     2 10H fractions//3F10.3,10X,3F10.5)
C--PRINT THE LATENT ROOTS AND THE DIRECTION COSINES
      WRITE(NCWU,2550) CTYPE(JTYPE),(VA(I),(ROF(I,J),J=1,3),I=1,3)
2550  FORMAT(//1X,' Rotation matrix from orthogonal',
     2 ' to best ',A,' co-ordinates'//1X,' latent roots',13X,'L',9X,'M',
     3 9X,'N',9X,'w.r.t. A*, B'' and C'//(1X,F10.5,9X,3F10.5))
C--PRINT THE ROTATION MATRICES FROM CRYSTAL FRACTIONS
      WRITE(NCWU,2600)CTYPE(JTYPE),
     1 ((RCA(I,J),J=1,3),(RCF(I,J),J=1,3),I=1,3)
      ENDIF
2600  FORMAT(//1X,' Transformation from crystal fractions w.r.t.',
     2 ' centroid to best ',A,' coordinates',
     3 ' in angstrom and fractions'//3(14X,3F10.4,11X,3F10.5/))
      ENDIF
C
C--CALCULATE THE INVERSE MATRICES
      I=KINV2(3,RCA,RPCA,9,0,VA,VA,3)
      I=KINV2(3,RCF,RPCF,9,0,VA,VA,3)
      IF (JJ .NE. 1) THEN
C--PRINT THE INVERSE ROTATION MATRICES
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2650)CTYPE(JTYPE),
     1 ((RPCA(I,J),J=1,3),(RPCF(I,J),J=1,3),I=1,3)
2650  FORMAT(//1X,' Transformation to crystal fractions w.r.t.',
     2 ' centroid from best ',A,' co-ordinates in angstrom and',
     3 ' fractions'//3(14X,3F10.4,11X,3F10.5/))
C--PRINT THE EQUATION OF THE PLANE/LINE
C-C-C-PRINT EQUATION OF PLANE/LINE AND ORIENT. VECTOR IN POLAR COORD.
      WRITE(NCWU,2700)CTYPE(JTYPE), (EQU(I),I=1,3),F
      WRITE(NCWU,2705)CTYPE(JTYPE), VECPD, VECPD/100, VECPA, VECPA/100
      ENDIF
2700  FORMAT(//1X,' Equation of the ',A,' :'//F10.5,' * X +',F10.5,
     2 ' * Y +',F10.5,' * Z  =',F10.3,20X,
     3 'X, Y and Z are in crystal fractions')
2705  FORMAT(/,A,'-vector (in polar coord.):',
     2       'Input ONLY in units of 100 DEGREES !!!',//,
     3       'DECLINAT =',F9.2,5X,'DECLINAT/100 =',F9.4,/,
     4       'AZIMUTH  =',F9.2,5X,'AZIMUTH /100 =',F9.4)
        WRITE ( NCAWU , 2715 ) CTYPE(JTYPE), ( EQU(I),I=1,3 ) , F
        WRITE(NCAWU,2720)CTYPE(JTYPE),VECPD,VECPD/100, VECPA,VECPA/100
2715    FORMAT( / , 1X , 'Equation of the ',A,' :' , / ,
     2 11X, F10.5,'*X + ' , F10.5, '*Y + ' , F10.5, '*Z = ' , F10.3 ,/,
     3 1X , 20X , 'X, Y and Z are in crystal fractions' )
2720  FORMAT(/,A,'-vector (in polar coord.): ',
     2       'Input ONLY in units of 100 DEGREES !!!',//,
     3       'DECLINAT =',F9.2,5X,'DECLINAT/100 =',F9.4,/,
     4       'AZIMUTH  =',F9.2,5X,'AZIMUTH /100 =',F9.4)
C
C--PRINT AN EXPLANATORY CAPTION
      IF (JJ .NE. 1) THEN
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2900) CTYPE(JTYPE), CDEV(JTYPE)
      WRITE(NCAWU,2900) CTYPE(JTYPE), CDEV(JTYPE)
      WRITE ( CMON ,2900) CTYPE(JTYPE), CDEV(JTYPE)
      CALL XPRVDU(NCVDU, 1,0)
2900  FORMAT(' Deviations from the ',A,
     2 ', in angstrom, are given by ', A)
      ENDIF
C--PRINT THE CO-ORDINATES OF THE ATOMS DEFINING THE PLANE:/LINE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2750) CQUAL(JTYPE), CDEL(JTYPE)
      ENDIF
2750  FORMAT(1X,' Co-ordinates of the defining atoms' ,
     2 ' projected onto the ', A, ' plane'//4X,'Type',5X,'Serial',7X,
     3 'Weight',7X,'XP',8X,'YP',8X,'ZP', 7X, A /)
      WRITE(NCAWU,2751) CQUAL(JTYPE), CDEL(JTYPE)
      WRITE ( CMON ,2751) CQUAL(JTYPE), CDEL(JTYPE)
      CALL XPRVDU(NCVDU, 3,0)
2751  FORMAT(' Co-ordinates of the defining atoms' ,
     2 ' projected onto the ', A,' plane'/4X,'Type',5X,'Serial',7X,
     3 'XP',8X,'YP',8X,'ZP', 7X, A/)
      ENDIF
C
      IF (JPUNCH .NE. 0) WRITE(NCPU,'(''# Plane no '',I4)') NP
C--COMPUTE A FEW ADDRESSES
      JO = JBASE + (N-1) * MD5A
      I=JO
C--LOOP OVER EACH ATOM IN TURN
      DO 2850 II = JBASE, JO, MD5A
      CALL XSUBTR(STORE(I+4),XCF,STORE(I+4),3)
      CALL XMLTMM(RCA,STORE(I+4),STORE(I+10),3,3,1)
      IF (JJ .NE. 1) THEN
      DEL = SQRT( STORE(I+10)**2+ STORE(I+11)**2 )
      IF (ISSPRT .EQ. 0) THEN
        IF (JTYPE .EQ. 1) THEN
          WRITE(NCWU,2800)STORE(I),STORE(I+1),STORE(I+7),STORE(I+10),
     2 STORE(I+11),STORE(I+12), DEL
        ELSE
          WRITE(NCWU,2800)STORE(I),STORE(I+1),STORE(I+7),STORE(I+10),
     2 STORE(I+11),STORE(I+12)
        ENDIF
      ENDIF
2800  FORMAT(5X,A4,F9.0,5X,F9.3,1X,4F10.3)
      IF (JTYPE .EQ. 1) THEN
      WRITE ( NCAWU,2801)STORE(I),STORE(I+1),STORE(I+10),
     2 STORE(I+11),STORE(I+12), DEL
      WRITE ( CMON ,2801)STORE(I),STORE(I+1),STORE(I+10),
     2 STORE(I+11),STORE(I+12), DEL
      CALL XPRVDU(NCVDU, 1,0)
      ELSE
      WRITE ( NCAWU,2801)STORE(I),STORE(I+1),STORE(I+10),
     2 STORE(I+11),STORE(I+12)
      WRITE ( CMON ,2801)STORE(I),STORE(I+1),STORE(I+10),
     2 STORE(I+11),STORE(I+12)
      CALL XPRVDU(NCVDU, 1,0)
      ENDIF
2801    FORMAT(5X,A4,F9.0,2X,4F10.3)
      ENDIF
      IF (JPUNCH .NE. 0) THEN
         WRITE ( NCPU,2802)STORE(I),STORE(I+1),STORE(I+10),
     2   STORE(I+11),STORE(I+12)
      ENDIF
2802    FORMAT('ATOM ',A4,F9.0,' X= ',3F10.3)
      I=I-MD5A
2850  CONTINUE
C----- DO WE WANT THE OVERALL GOODIES ON SCREEN?
      IF (JJ .NE. 1) THEN
C---- COMPUTE AXIS RATIOS
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2505) PAXIS(3)/PAXIS(1),
     1 1. - (PAXIS(2)+ PAXIS(3))/ (2.*PAXIS(1)),
     2 1. - (2.*PAXIS(3)) / (PAXIS(1) + PAXIS(2))
      ENDIF
      WRITE(NCAWU,2505) PAXIS(3)/PAXIS(1),
     1 1. - (PAXIS(2)+ PAXIS(3))/ (2.*PAXIS(1)),
     2 1. - (2.*PAXIS(3)) / (PAXIS(1) + PAXIS(2))
      WRITE ( CMON ,2505) PAXIS(3)/PAXIS(1),
     1 1. - (PAXIS(2)+ PAXIS(3))/ (2.*PAXIS(1)),
     2 1. - (2.*PAXIS(3)) / (PAXIS(1) + PAXIS(2))
      CALL XPRVDU(NCVDU, 2,0)
2505  FORMAT ( /' Spherical index = ', F6.2, ' cylindrical index = ',
     1 F6.2, ' Discoidal index = ', F6.2)
        WRITE(NCAWU,2510) ( XCF(I), I = 1,3),
     1           ( (RCA(I,J), J=1,3), I=1,3)
2510    FORMAT (/,' Centroid, in crystal fractions ',
     1  ' Transformation from crystal fractions ',/ 33X,
     2  ' to best plane, (orthogonal angstroms)',
     3  / 3F9.4, 3(/, 32X, 3F9.4) )
      ENDIF
C------ DO WE WANT A PLOT?
      IF(JJ) 2920,2920,2910
2910  CONTINUE
      JJ=NFL
      KK=KCHNFL(135)
      KK=135
      CALL PPLOT ( JBASE , MD5A , N , 10 , KK , ISTORE(JJ) )
      NFL=JJ
2920  CONTINUE
C--PUT DIRECTION COSINES INTO STORE
      K=JL+1
      DO 2950 I=1,3
      STORE(K)=ROF(3,I)
      K=K+1
2950  CONTINUE
C--MARK THE PLANE/LINE AS ACCEPTABLE
      LEF1=0
      ISTORE(JL)=0
C--RESET THE POINTERS FOR THE NEXT PLANE/LINE
3000  CONTINUE
      JL=JL-JN
      ISTORE(JL)=NOWT
      LFL=JL-1
      N=0
      LEF2=0
      GOTO 1100
C
C----- 'REPLACE' INSTRUCTION
3025  CONTINUE
      IRPL = 1
C
C--'EVALUATE' INSTRUCTION  -  CHECK IF WE CAN PRINT THE ATOMS
3050  CONTINUE
      IF(LEF1)3100,3200,2050
C--ERROR BECAUSE NO PLANE/LINE HAS BEEN CALCULATED
3100  CONTINUE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,3150) CTYPE(JTYPE)
      WRITE(NCAWU,3150) CTYPE(JTYPE)
      WRITE ( CMON ,3150) CTYPE(JTYPE)
      CALL XPRVDU(NCVDU, 1,0)
3150  FORMAT(' Instruction ignored' ,
     2 '  -  no ', A ,' has been calculated' ,
     3 ' or errors have been detected' )
      GOTO 1100
C
C
C
C--START TO PROCESS THE CARD
3200  CONTINUE
      IF(KFDARG(I))1100,3250,3250
C--PRINT A CAPTION
3250  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF (IRPL .EQ. 0) WRITE(NCWU,3300) CQUAL(JTYPE)
      ENDIF
3300  FORMAT(//' Co-ordinates of other atoms',
     2 ' projected onto the ',A,' plane'//4X,'Type',5X,'Serial',20X,
     3 'XP',8X,'YP',8X,'ZP'/)
C--CHECK THE CORE AREA
      LFL=LFL-MD5A
      IF(NFL+27-LFL)3350,3350,4900
C--ENOUGH CORE  -  COMPUTE THE CENTROID IN BEST PLANE COORDS.
3350  CONTINUE
      CALL XMLTMM(ROF,XCA,XCR,3,3,1)
C--CHECK THE TYPE OF THE NEXT ARGUMENT
      IF(ISTORE(MF))3400,3500,3500
C--CHARACTERS  -  CHECK FOR 'ALL'
3400  CONTINUE
      IF(KCOMP(1,ISTORE(MF+2),CTARG,1,1))3500,3500,3750
C--CHECK IF THERE ARE MORE ARGUMENTS TO BE PROCESSED
3450  CONTINUE
      IF(KOP(8))1100,3500,3500
C--FIND THE NEXT GROUP OF ATOMS
3500  CONTINUE
      IF(KATOMU(LN))4850,4850,3550
C--LOOP OVER EACH OF THE ATOMS WE HAVE FOUND
3550  CONTINUE
      IF (JPUNCH .NE. 0)
     1 write(ncpu,'(a)') '# EVALUATED ATOMS'
      DO 3700 J=1,N5A
C--GENERATE THE TRANSFORMED COORDS.
      IF(KATOMS(MQ,M5A,LFL))4850,4850,3600
C--COMPUTE THE BEST PLANE COORDS.
3600  CONTINUE
      CALL XMLTMM(RCA,STORE(LFL+4),STORE(LFL+7),3,3,1)
C--SUBTRACT THE CENTROID
      CALL XSUBTR(STORE(LFL+7),XCR,STORE(LFL+7),3)
      IF (JPUNCH .NE. 0) THEN
         WRITE ( NCPU,2802)STORE(LFL),STORE(LFL+1),STORE(LFL+7),
     2   STORE(LFL+8),STORE(LFL+9)
      ENDIF
      IF (IRPL .EQ. 0) THEN
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,3650)STORE(LFL),STORE(LFL+1),STORE(LFL+7),STORE(LFL+8)
     2 ,STORE(LFL+9)
      ENDIF
3650  FORMAT(5X,A4,F9.0,15X,3F10.3)
      WRITE(NCAWU,3651)STORE(LFL),STORE(LFL+1),STORE(LFL+7)
     2 ,STORE(LFL+8),STORE(LFL+9)
      WRITE ( CMON ,3651)STORE(LFL),STORE(LFL+1),STORE(LFL+7)
     2 ,STORE(LFL+8),STORE(LFL+9)
      CALL XPRVDU(NCVDU, 1,0)
3651  FORMAT(5X,A4,F9.0,2X,3F10.3)
      ELSE
C----- FLATTEN THE STRUCTURE
            STORE(LFL+9) = 0.
C----- ADD THE CENTROID
            CALL XADDR( STORE(LFL+7), XCR, STORE(IWORK), 3)
C----- RESTORE TO FRACTIONAL
            CALL XMLTMM( RPCA, STORE(IWORK), STORE(M5A+4), 3, 3, 1)
            IMOD5 = 1
      ENDIF
      M5A=M5A+MD5A
3700  CONTINUE
      GOTO 3450
C
C--PRINT ALL THE ATOMS IN LIST 5
3750  CONTINUE
      J=L5
      DO 3800 I=1,N5
      CALL XMLTMM (RCA, STORE(J+4), STORE(IWORK), 3, 3, 1)
      CALL XSUBTR (STORE(IWORK), XCR, STORE(JWORK), 3)
      IF (IRPL .EQ. 0) THEN
      IF (ISSPRT .EQ. 0) THEN
            WRITE(NCWU,3650) STORE(J),STORE(J+1), STORE(JWORK),
     1      STORE(JWORK+1), STORE(JWORK+2)
      ENDIF
            WRITE(NCAWU,3651) STORE(J),STORE(J+1), STORE(JWORK),
     1      STORE(JWORK+1), STORE(JWORK+2)
      ELSE
C----- FLATTEN THE STRUCTURE
            STORE(JWORK+2) = 0.
C----- ADD THE CENTROID
            CALL XADDR( STORE(JWORK), XCR, STORE(IWORK), 3)
C----- RESTORE TO FRACTIONAL
            CALL XMLTMM( RPCA, STORE(IWORK), STORE(J+4), 3, 3, 1)
            IMOD5 = 1
      ENDIF
      J=J+MD5
3800  CONTINUE
      GOTO 1100
C
C--'ANGLE' INSTRUCTION
3850  CONTINUE
      JG=-1
C--CHECK IF THERE IS A NUMBER NEXT ON THE CARD
3900  CONTINUE
      IF(ME)3950,3950,4050
C--ERROR IN THE INPUT NUMBER
3950  CONTINUE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,4000)
      ENDIF
      WRITE(NCAWU,4000)
4000  FORMAT(/34H Argument missing or of wrong type)
      GOTO 4850
C--READ THE NUMBER
4050  CONTINUE
      IF(KSYNUM(Z))3950,4100,3950
C--WE HAVE FOUND A NUMBER  -  UPDATE THE CARD POSITION
4100  CONTINUE
      JA=NINT(Z)
      ME=ME-1
      MF=MF+LK2
C--CHECK THAT THE SERIAL NUMBER IS REASONABLE
      IF(JA)4250,4250,4150
4150  CONTINUE
      IF(JA-NP)4200,4200,4250
C--NOW CHECK IF THIS PLANE HAS BEEN PROCESSED
4200  CONTINUE
      K=JL+(NP-JA+1)*JN
      IF(ISTORE(K))4250,4350,4350
C--ILLEGAL PLANE OR PLANE SERIAL  -  PRINT OUT THE ERROR MESSAGE
4250  CONTINUE
      CALL XPCLNN(LN)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,4300)JA
      ENDIF
      WRITE(NCAWU,4300) JA
4300  FORMAT(/1X,' There is no axis  with serial number ',I4)
      GOTO 4850
C--CHECK IF THIS IS THE FIRST OR SECOND PLANE
4350  CONTINUE
      IF(JG)4400,4600,4600
C--THIS IS THE FIRST PLANE
4400  CONTINUE
      JH=JA
      DCOSA(1)=STORE(K+1)
      DCOSA(2)=STORE(K+2)
      DCOSA(3)=STORE(K+3)
      JG=JG+1
C--CHECK IF THERE IS MORE ON THE CARD
      IF(ME)3950,3950,4450
C--CHECK IF THE NEXT ARGUMENT IS 'AND'
4450  CONTINUE
      IF(ISTORE(MF))4500,3950,3950
C--CHECK THE CHARACTERS
4500  CONTINUE
      IF(KCOMP(1,ISTORE(MF+2),BTARG,1,1))3950,3950,4550
C--THE ARGUMENT IS 'AND'  -  UPDATE THE CARD POSITION
4550  CONTINUE
      ME=ME-1
      MF=MF+LK2
      GOTO 3900
C--THIS IS THE SECOND PLANE NUMBER
4600  CONTINUE
      JK=JA
      DCOSB(1)=STORE(K+1)
      DCOSB(2)=STORE(K+2)
      DCOSB(3)=STORE(K+3)
      F=0.
      DO 4650 J=1,3
4650  F=F+DCOSA(J)*DCOSB(J)
      IF(ABS(F)-1.0)4750,4750,4700
4700  F=SIGN(1.0,F)
4750  F=ACOS(F)*RTD
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,4800)JH,JK,F
      ENDIF
      WRITE(NCAWU,4800) JH, JK, F
      WRITE (CMON ,4800) JH, JK, F
      CALL XPRVDU(NCVDU, 5,0)
4800  FORMAT(//1X,' Angle between axis ',I4,' and axis ',I4,' is ' ,
     2 F6.2,9H  Degrees//)
      GOTO 1100
C
C
C----- 'STORE' INSTRUCTION
4825  CONTINUE
      M20M = L20M + MD20M
      M20I = L20I + MD20I
      M20V = L20V + MD20V
      CALL XMOVE (RCA(1,1), STORE(M20M), 9)
      CALL XMOVE (RPCA(1,1), STORE(M20I), 9)
      CALL XMOVE (XCF(1), STORE(M20V), 3)
      IUPDT = 1
      GOTO 1100
C--ERROR EXIT FOR THESE ROUTINES
4850  CONTINUE
      CALL XPCA(ISTORE(MD+4))
      LEF=LEF+1
      GOTO 1100
C
C--NOT ENOUGH CORE
4900  CONTINUE
      CALL XICA
      GOTO 4950
C
C--MAIN TERMINATION ROUTINES
C
4910  CONTINUE
      IF (IMOD5 .GT. 0 ) THEN
            CALL XSTR05( IULN5, 0, 1)
            WRITE(NCAWU,4911)
      IF (ISSPRT .EQ. 0) THEN
            WRITE(NCWU,4911)
      ENDIF
4911        FORMAT(/' LIST 5 has been updated',/)
      ENDIF
      IF (IUPDT .GT. 0) THEN
            CALL XSTR20 ( 20, 0, 1)
            WRITE(NCAWU,4912)
      IF (ISSPRT .EQ. 0) THEN
            WRITE(NCWU,4912)
      ENDIF
4912        FORMAT(/' LIST 20 has been updated',/)
      ENDIF
      GOTO 4960
4950  CONTINUE
      IF (IMOD5 .GT.0) THEN
            N = 5
      IF (ISSPRT .EQ. 0) THEN
            WRITE(NCWU,4951) N
      ENDIF
            WRITE(NCAWU,4951)N
4951        FORMAT(//' WARNING. The requested update to LIST ',
     1      I4,' has not been performed',//)
      ENDIF
      IF (IUPDT .GT. 0) THEN
            N = 20
            WRITE(NCAWU,4951)
      IF (ISSPRT .EQ. 0) THEN
            WRITE(NCWU,4951)
      ENDIF
      ENDIF
4960  CONTINUE
      CALL XOPMSG ( IOPAXS , IOPEND , IVERSN )
      CALL XTIME2(2)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPAXS , IOPABN , 0 )
      GO TO 4950
9910  CONTINUE
C -- INPUT ERRORS
      CALL XOPMSG ( IOPAXS , IOPCMI , 0 )
      GO TO 9900
9920  CONTINUE
C
      IF (ISSPRT .EQ. 0) THEN
      WRITE ( NCWU , 9925 ) CTYPE(JTYPE)
      ENDIF
      WRITE ( NCAWU , 9925 ) CTYPE(JTYPE)
9925  FORMAT ( 1X , 'No atoms have been specified to define a ', A )
      CALL XERHND ( IERWRN )
      GO TO 3000
      END
C
CODE FOR KMOLAX
      FUNCTION KMOLAX(POINTS,NPOINT,ISTEP,CENT,ROOTS,VECTOR,COSINE,
     2 WORK)
C--COMPUTE THE MEAN PLANE THROUGH A SET OF POINTS.
C
C  POINTS  THE ARRAY CONTAINING THE POINTS TO BE FITTED. THE FIRST FOUR
C          LOCATIONS FOR EACH POINT MUST BE SET AS FOLLOWS :
C
C          1  X.
C          2  Y.
C          3  Z.
C          4  THE WEIGHT OF THIS POINT.
C
C  NPOINT  THE NUMBER OF POINTS TO BE FITTED.
C  ISTEP   THE NUMBER OF WORDS PER POINT.
C  CENT    AN ARRAY WHICH CONTAINS THE CENTROID IN CRYSTALS FRACTIONS ON
C          EXIT.
C  ROOTS   THE LATENT ROOTS IN DESCENDING ORDER.
C  VECTOR  THE LATENT VECTORS, STORED BY ROWS. (VECTOR(I,J),J=1,3) IS
C          THE VECTOR CORRESPONDING TO LATENT ROOT 'ROOT(I)'.
C          THIS MATRIX IS SUITABLE FOR TRANFORMING ORTHOGONAL COORDINATE
C          INTO BEST PLANE COORDINATES.
C  COSINE  THE LATENT VECTORS, STORED BY COLUMNS. THIS MATRIX IS
C          SUITABLE FOR TRANSFORMING BEST PLANE COORDINATES INTO ORTHOGO
C          COORDINATES.
C  WORK    SOME WORK SPACE.
C
C--THE RETURN VALUES OF 'KMOLAX' ARE :
C
C  -1  NOT ENOUGH POINTS TO DEFINE A PLANE.
C   0  OKAY.
C
C--
      DOUBLE PRECISION DVECTR,DROOTS,DCOSIN,DWORK,DPOINT
C
      DIMENSION POINTS(ISTEP,NPOINT),CENT(3),ROOTS(3),VECTOR(3,3),
     2 COSINE(3,3),WORK(4)
      DIMENSION DVECTR(3,3),DROOTS(3),DCOSIN(3,3),DWORK(10)
C
\STORE
\XLST01
C
C--CHECK THAT THERE ARE AT LEAST 2 POINTS
      IF(NPOINT-2)1000,1100,1100
C--NOT ENOUGH POINTS
1000  CONTINUE
      KMOLAX=-1
1050  CONTINUE
      RETURN
C--ZERO SOME ARRAYS
1100  CONTINUE
      CALL XZEROF(CENT(1),3)
      DO 1120 I=1,3
      DO 1110 J=1,3
      DVECTR(J,I)=0.0D0
1110  CONTINUE
1120  CONTINUE
C--COMPUTE THE CENTROID
      A=0.
      DO 1200 I=1,NPOINT
      A=A+POINTS(4,I)
      DO 1150 J=1,3
      CENT(J)=CENT(J)+POINTS(J,I)*POINTS(4,I)
1150  CONTINUE
1200  CONTINUE
C--COMPUTE THE WEIGHTED CENTROID VALUES
      DO 1250 I=1,3
      CENT(I)=CENT(I)/A
1250  CONTINUE
C--ACCUMULATE THE NORMAL EQUATIONS
      DO 1450 I=1,NPOINT
      DO 1300 J=1,3
      WORK(J)=POINTS(J,I)-CENT(J)
1300  CONTINUE
C--ORTHOGONALISE THE RESULT
      CALL XMLTTM(STORE(L1O1),WORK(1),ROOTS(1),3,3,1)
C--CONVERT THE RESULTS TO DOUBLE PRECISION
      DO 1310 J=1,3
      DROOTS(J)=DBLE(ROOTS(J))
1310  CONTINUE
      DPOINT=DBLE(POINTS(4,I))
C--ADD INTO THE NORMAL EQUATIONS
      DO 1400 J=1,3
      DO 1350 K=J,3
      DVECTR(K,J)=DVECTR(K,J)+DPOINT*DROOTS(K)*DROOTS(J)
      DVECTR(J,K)=DVECTR(K,J)
1350  CONTINUE
1400  CONTINUE
1450  CONTINUE
C--COMPUTE THE LATENT ROOTS AND VECTORS
c      I=0
c      CALL F02ABF(DVECTR,3,3,DROOTS,DCOSIN,3,DWORK,I)
      INFO = 0
      CALL DSYEV('V','L',3,DVECTR,3,DROOTS,DWORK,10,INFO)

C--TRANSFORM THE RESULT INTO THE CORRECT ORDER
      DO 1470 I=1,3
      ROOTS(I)=SNGL(DROOTS(4-I))
      DO 1460 J=1,3
c      COSINE(I,J)=SNGL(DCOSIN(I,4-J))
      COSINE(I,J)=SNGL(DVECTR(I,4-J))
1460  CONTINUE
1470  CONTINUE
C--CHECK THAT THE MATRIX IS RIGHT HANDED
      IF(XDETR3(COSINE))1550,1000,1650
C--MATRIX IS LEFT HANDED
1550  CONTINUE
      DO 1600 I=1,3
      COSINE(I,3)=-COSINE(I,3)
1600  CONTINUE
C--NORMALISE THE LATENT VECTORS
1650  CONTINUE
      DO 1800 I=1,3
      A=0.
      DO 1700 J=1,3
      A=A+COSINE(J,I)*COSINE(J,I)
1700  CONTINUE
      A=1./SQRT(A)
      DO 1750 J=1,3
      COSINE(J,I)=COSINE(J,I)*A
      VECTOR(I,J)=COSINE(J,I)
1750  CONTINUE
1800  CONTINUE
      KMOLAX=0
      GOTO 1050
      END
C
CODE FOR XMOLEQ
      SUBROUTINE XMOLEQ(CENT,VECTOR,EQU,D,RCP)
C--COMPUTE THE EQUATION OF A MEAN PLANE
C
C  CENT    THE CENTROID IN CRYSTALS FRACTIONS.
C  VECTOR  THE ROTATION MATRIX FROM ORTHOGONAL COORDINATES TO BEST PLANE
C          COORDINATES.
C  EQU     THE THREE TERMS OF THE EQUATION.
C  D       THE DISTANCES OF THE CENTROID TO THE ORIGIN
C  RCP     SET ON EXIT TO THE ROTATION MATRIX FROM CRYSTAL FRACTIONS TO
C          BEST PLANE COORDINATES IN ANGSTROM.
C
C--
C
      DIMENSION CENT(3),VECTOR(3,3),EQU(3),RCP(3,3)
C
\STORE
\XLST01
C
C--COMPUTE THE ROTATION MSTRIX
      CALL XMLTMT(VECTOR,STORE(L1O1),RCP,3,3,3)
C--SET THE EQUATION TERMS
      EQU(1)=RCP(3,1)
      EQU(2)=RCP(3,2)
      EQU(3)=RCP(3,3)
C--COMPUTE THE DISTANCE OF THE ORIGIN FROM THE PLANE
      D=CENT(1)*EQU(1)+CENT(2)*EQU(2)+CENT(3)*EQU(3)
      RETURN
      END
CODE FOR PPLOT
      SUBROUTINE PPLOT(LP,MDP,NP,II,JJ,IVEC)
C----- DISPLAY STRUCTURE PROJECTED DOWN Z AXIS
C----- COORDINATES MUST BE ORTHOGONAL ISOMETRIC
C     LP  START OF ATOM LIST
C     MDP NO OF ITEMS PER ATOM
C     NP  NO OF ATOMS
C     II POSITION OF X COORDINATE (POSN1=0)
C     CW CHARACTER WIDTH (RELATIVE)
C     CH  CHARACTER HEIGHT (RELATIVE)
C     MW  MEDIUM WIDTH (NO OF PRINT POSITIONS)
C     MH  MEDIUM HEIGHT
\ISTORE
      DIMENSION IVEC(JJ),AA(4), A(4),JA(4)
\STORE
\XCHARS
\XUNITS
\XSSVAL
\QSTORE
\XIOBUF
C
C----- POSITION OF 'X'
       JX=LP+II
      JY=JX+1
C     SET BUFFER FOR SORT
      JNFL=NFL
      I=KCHNFL(MDP)
C----- SORT INTO DESCENDING Y
      CALL XSHELR(STORE(LP),MDP,12,NP,MDP*NP,STORE(JNFL))
C----- RESET NFL
      NFL=JNFL
C----- SET INITIAL MINIMA & MAXIMAL VALUES
      AA(1)=1000000.
      AA(2)=-100000.
      AA(3) = STORE(JY)
      AA(4)= STORE(MDP*(NP-1)+JY)
      MP=JX
      DO 50 I=1,NP
C----- MAXIMUM
      IF(AA(2)-STORE(MP)) 10,10,20
10    CONTINUE
      AA(2)=STORE(MP)
20    CONTINUE
C----- MINIMUM
      IF(AA(1)-STORE(MP))40,30,30
30    CONTINUE
      AA(1)=STORE(MP)
40    CONTINUE
      MP=MP+MDP
50    CONTINUE
C----- SHIFT ORIGIN
      MP=JX
      DO 70 I=1,NP
      STORE(MP)=STORE(MP)-AA(1)
      STORE(MP+1) = AA(3) - STORE(MP+1)
      MP=MP+MDP
70    CONTINUE
C----- SET CHARACTER HEIGHT,WIDTH
        CH=1./IPAGE(2)
      CW=1./IPAGE(1)
C----- SET PAGE
      MW=IPAGE(3)-4
      MH=IPAGE(3)
      IUNIT=NCWU
C----- OUTPUT IS TO PRINTER FIRST PASS, THEN TO MONITOR
C----- SEND AXES TO PRINTER
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,72)
      ENDIF
72    FORMAT(/'  Y',/'  :',/'  :',/'  :',/'  :....... X')
C
      DO 340 LL=1,2
      IF (  (LL .EQ.1) .AND. (ISSPRT .NE. 0)) GOTO 335
      WRITE(IUNIT,75)
75    FORMAT(//)
      IF (LL .EQ. 2) THEN
C        CALL VGACOL ( 'OFF', 'BLA', 'CYA' )
        CALL OUTCOL(2)
      ENDIF
C----- SET SCALE FACTORS
      XG=CW*(MW-3)/AMAX1(5.,(AA(2)-AA(1)))
      YG=CH*MH/AMAX1(5.,(AA(4)-AA(3)))
C----- ENSURE MAXIMUM SCALE IS 1 INCH PER ANGSTROM
      G=AMIN1(XG,YG)
      G=AMIN1(G,1.)
      YG=G/CH
      XG=G/CW
C----- FIND BONDED ATOMS AND HENCE COORDS OF ALL POINTS IN BOND
C----- STORE POINTS IN LIST FROM JNFL
      INFL=JNFL
C----- RESET WORK AREA
      NFL = JNFL
       MP=JX
      JD=0
      NQ=NP-1
      DO 490 I=1,NQ
      KK=I+1
      MQ=MP+MDP
      DO 480 J=KK,NP
      S=(STORE(MP)-STORE(MQ))*(STORE(MP)-STORE(MQ))
      IF (S-2.56) 402,402,470
402   CONTINUE
      S=S+(STORE(MP+1)-STORE(MQ+1))*(STORE(MP+1)-STORE(MQ+1))
      IF( S-2.56) 403,403,470
403   CONTINUE
      S=S+(STORE(MP+2)-STORE(MQ+2))*(STORE(MP+2)-STORE(MQ+2))
      IF (S-2.56) 410,410,470
410   CONTINUE
C----- WE HAVE CONTACT - CONVERT TO PLOTTING UNITS
      A(1)=STORE(MP)*XG
      A(2)=STORE(MP+1)*YG
      A(3)=STORE(MQ)*XG
      A(4)=STORE(MQ+1)*YG
C----- FIND GRADIENT AND INTERCEPT
      S=A(1)-A(3)
C----- LIMIT GRADIENT
      S=SIGN(AMAX1(ABS(S),.001),S)
      AM=(A(2)-A(4))/S
      AC=A(2)-AM*A(1)
C----- CHECK GRADIENT
      IF(ABS(AM)-1.) 420,420,440
420   CONTINUE
C----- STEP ON X
       JB=NINT(AMIN1(A(1),A(3)))
      JC=NINT(AMAX1(A(1),A(3)))
C----- GENERATE ALL POSITIONS IN BOND
      DO 430 K=JB,JC
      KP=KCHNFL(2)
      STORE(INFL)=FLOAT(K)
       STORE(INFL+1)=STORE(INFL)*AM+AC
      INFL=INFL+2
      JD=JD+1
430   CONTINUE
      GO TO 460
440   CONTINUE
C----- STEP ON Y. -- INVERT GRADIENT & INTERCEPT
      AM=1./AM
      AC=AM*AC
       JB=NINT(AMIN1(A(2),A(4)))
      JC=NINT(AMAX1(A(2),A(4)))
C----- GENERATE ALL POSITIONS IN BOND
      DO 450 K=JB,JC
      KP=KCHNFL(2)
      STORE(INFL+1)=FLOAT(K)
      STORE(INFL)=STORE(INFL+1)*AM-AC
      INFL=INFL+2
      JD=JD+1
450   CONTINUE
460   CONTINUE
470   CONTINUE
      MQ=MQ+MDP
480   CONTINUE
      MP=MP+MDP
490   CONTINUE
C      ANY THING TO SORT?
      IF(JD) 205,205,200
200   CONTINUE
C----- SORT THIS LIST INTO ASCENDING Y
      CALL XSHELQ(STORE(JNFL),2,2,JD,2*JD,A(1))
205   CONTINUE
C----- RUN DOWN PAGE, LINE BY LINE
      INFL=JNFL
      KK=1
       K=1
C----- NOTE THAT COUNTER IS RUNNING ON 'Y'
      KP=JY
      DO 320 I=1,MH
C----- CLEAR LINE
       DO 80 J=1,MW
      IVEC(J)=IB
80    CONTINUE
      MP=KP
C----- LOOP OVER ATOMS
      JK=K
      DO 290 J=JK,NP
C----- ANY ATOMS ON THIS LINE?
       IP=NINT(STORE(MP)*YG)
      IF(1+IP-I) 210,210,300
210   CONTINUE
C----- ATOM ON LINE
C----- SERIAL NO. IS IN RELATIVE POSN 1
      JO=MP-II
C----- UNPACK ATOM TYPE
      JQ=ISTORE(JO-1)
      CALL XARS(JQ,JA(1))
      JP=NINT(STORE(JO))
      JP=JP-100*(JP/100)
C----- MOST SIG
      JO=(JP/10)
C----- LEAST SIG
      JP=JP-JO*10
C----- FIND RH BIT
C      ALLOW 3 POSITIONS PER ATOM NAME
      IP=NINT(STORE(MP-1)*XG)+3
      IF(IVEC(IP-2) .NE. IB) GOTO 220
      IVEC(IP-2)=JA(1)
      GOTO 230
220   CONTINUE
      IVEC(IP-2)=IPLUS
230   CONTINUE
       IF(JO) 260,260,240
240   CONTINUE
      IF(IVEC(IP-1) .NE. IB) GOTO 250
      IVEC(IP-1)=NUMB(JO+1)
      GOTO 260
250   CONTINUE
      IVEC(IP-1)=IPLUS
260   CONTINUE
      IF(IVEC(IP) .NE. IB) GOTO 270
      IVEC(IP) = NUMB(JP+1)
      GOTO 280
270   CONTINUE
      IVEC(IP)=IEXP
280   CONTINUE
C----- WE CAN START THE ATOM LIST LOWER DOWN NEXT TIME.
      K=K+1
      KP=KP+MDP
      MP=MP+MDP
290   CONTINUE
300   CONTINUE
C---- ANY BONDS ?
       IF(JD) 530,530,500
500   CONTINUE
C----- FILLIN BOND
      JKK=KK
C----- RUN DOWN BOND LIST
      DO 520 J=JKK,JD
      IP=NINT(STORE(INFL+1))
      IF(1+IP-I) 510 ,510,530
510   CONTINUE
C----- BOND CUTS LINE - FIND X
      IP=NINT(STORE(INFL)+2)
      IF(IVEC(IP) .EQ. IB) IVEC(IP)=IPOINT
C----- WE CAN START LIST LOWER DOWN NEXT TIME
      KK=J+1
      INFL=INFL+2
520   CONTINUE
530   CONTINUE
      WRITE(IUNIT,310) (IVEC(IV),IV=1,MW),IB
      IF (IUNIT .EQ. NCAWU) THEN
       WRITE ( CMON ,310) (IVEC(IV),IV=1,MW),IB
       CALL XPRVDU(NCVDU, 1,0)
      ENDIF
310   FORMAT(2H  ,118A1)
      IF(K-NP) 320,320,330
320   CONTINUE
C----- NO ATOMS LEFT, OR BOTTOM OF PAGE.
330   CONTINUE
C----- RESET NFL
      NFL=JNFL
C----- SPECIFIC FOR TELEVIDEO TERMINALS
335   CONTINUE
      CH=.25
      MW=76
      MH = 76
      IUNIT=NCAWU
      IF (LL .EQ. 2) THEN
C-----  WAIT HALF A SEC
        CALL XPAUSE(500)
C
C        CALL VGACOL ( 'BOL', 'WHI', 'BLU' )
        CALL OUTCOL(1)
C
      ENDIF
340   CONTINUE
C----- RESET STORE LOCATIONS
      NFL=JNFL
      RETURN
      END
