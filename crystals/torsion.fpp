C $Log: not supported by cvs2svn $
C Revision 1.2  2001/02/26 10:30:24  richard
C Added changelog to top of file
C
C
CODE FOR HTORS
      SUBROUTINE HTORS
C--MAIN TORSION ANGLE CALCULATION ROUTINE
C
C--
      DIMENSION LATOM(4)
      CHARACTER *12 CBUFF
      CHARACTER *32 CATOM(4), CBLANK
\ICOM12
\ISTORE
C
\STORE
\XUNITS
\XSSVAL
\XTAPES
\XLISTI
\XCONST
\XLST01
\XLST02
\XLST05
\XLST12
\XLEXIC
\XOPVAL
\XIOBUF
C
\QSTORE
\QLST12
C----- GET THE PUBLICATION FLAG FROM THE LEXICAL COMMON BLOCK
      EQUIVALENCE (IPBFLG,MY)
      DATA IVERSN/202/
      DATA CBLANK /' '/
      DATA AZERO /0.0/
C
      REWIND (MTE)
C
C--SET UP THE TIMING CONTROL
      CALL XTIME1(2)
C--READ THE INPUT CONTROL CARDS WITH THE LEXICAL SCANNER
      ISTAT = KLEXAN ( IULN , IFIRST , LENGTH )
      IF ( ISTAT .LT. 0 ) GO TO 9910
C--CLEAR THE CORE
      CALL XRSL
      CALL XCSAE
C--LOAD THE RELEVANT LISTS
      CALL XFAL01
      CALL XFAL02
      IULN5=KTYP05(MX)
      CALL XLDR05(IULN5)
      IF ( IERFLG .LT. 0 ) GO TO 9900
\IDIM12
C--INDICATE THAT LIST 12 IS NOT TO BE USED
      DO 1050 I=1,IDIM12
      ICOM12(I)=NOWT
1050  CONTINUE
C--LIST READ IN OKAY  -  SET UP THE INITIAL CONTROL FLAGS
      CALL XILEXP(IULN,IFIRST)
C--PRINT THE INITIAL CAPTIONS
      CALL XPRTCN
      WRITE ( CMON,1100)
      CALL XPRVDU(NCVDU, 2,0)
      WRITE(NCAWU, '(A)') (CMON(II)(:),II=1,2)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') (CMON(II)(:),II=1,2)
1100  FORMAT(' A positive rotation is',
     2 ' clockwise from atom 1 to atom 4,',/
     3 ' when viewed from atom 2 to atom 3')
      WRITE ( CMON,1150)
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(/A)') CMON(1 )(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(/A)') CMON(1 )(:)
1150  FORMAT(53X, ' Torsion angle in degrees')
C--SET THE ERROR COUNTERS
      LEF=0
      LSTLEF=0
C
C----- SET UP A BUFFER FOR THE PUBLICATION LISTING
      IPUB = KSTALL (24)
C--PROCESS THE NEXT CARD FROM THE DISC
1200  CONTINUE
      IF(KLDNLR(I))2950,1250,1200
C--CHECK THAT THE FUNCTION IS FOR AN 'ATOM' CARD
1250  CONTINUE
      IF(MG-1)1200,1300,1200
C--CHECK IF A NEW CAPTION IS REQUIRED
1300  CONTINUE
      IF(LEF-LSTLEF)1350,1400,1350
C--NEW CAPTION IS REQUIRED
1350  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1150)
      ENDIF
C--RESET THE ERROR COUNTER
1400  CONTINUE
      LSTLEF=LEF
C
C--START OF 'ATOM' CARD
      NATOM=0
C--SET ASIDE AN AREA IN WHICH GENERATED PARAMETERS CAN BE STORED
      JUNK=NFL
      NFL=NFL+MD5
C--SET UP THE POINTER FOR THE FIRST ATOM FOUND  -  A STACK IS FORMED HER
      IBASE=NFL
C--SET UP THE NUMBER OF WORDS IN THE STACK
      NW=9
C--SET THE RUNNING POINTER TO THE STACK  -  'JD'
      JD=NFL-NW
C--CHECK FOR ARGUMENTS
      IF(ME)1500,1500,1600
C--NO ARGUMENTS FOUND
1500  CONTINUE
      CALL XPCLNN(LN)
      WRITE ( CMON,1550)
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(A)') CMON(1 )(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
1550  FORMAT(' No arguments found')
      GOTO 1200
C--ARGUMENTS TO BE PROCESSED  -  CHECK FOR AN OPERAND
1600  CONTINUE
      IF(ISTORE(MF))1750,1650,1650
C--ARGUMENT IS OF THE WRONG TYPE
1650  CONTINUE
      CALL XPCLNN(LN)
      WRITE ( CMON,1700)
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(A)') CMON( 1)(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
1700  FORMAT(' Only atoms may appear on an ''ATOM'' card')
      GOTO 2650
C--PICK UP ATOM SPECIFICATION AND FIND THE ATOMS IN LIST 5
1750  CONTINUE
      JC = 0
      IF(KATOMU(JC))2650,2650,1800
C--UPDATE THE NUMBER OF ATOMS FOUND
1800  CONTINUE
      NATOM=NATOM+N5A
C--LOOP OVER THE ATOMS FOUND AND STORE THEM
      DO 1950 JE=1,N5A
      JD=JD+NW
      NFL=NFL+NW
      IF(NFL+27-LFL)1850,1850,2800
C--GENERATED THE MOVED PARAMETERS
1850  CONTINUE
      IF(KATOMS(MQ,M5A,JUNK))2650,2650,1900
C--MOVE THE GENERATED COORDINATES TO THEIR PLACE ON THE STACK
1900  CONTINUE
      CALL XMOVE(STORE(JUNK+4),STORE(JD),3)
C--STORE THE ADDRESS OF THE ATOM IN LIST 5
      ISTORE(JD+3)=M5A
C--STORE THE SYMMETRY OPERATORS USED TO GENERATE THE NEW COORDS.
      ISTORE(JD+4)=ISTORE(MQ+7)
      ISTORE(JD+5)=ISTORE(MQ+8)
      ISTORE(JD+6)=ISTORE(MQ+9)
      ISTORE(JD+7)=ISTORE(MQ+10)
      ISTORE(JD+8)=ISTORE(MQ+11)
C--UPDATE FOR THE NEXT ATOM
      M5A=M5A+MD5A
1950  CONTINUE
C--CHECK FOR END OF CARD NOW
      IF(KOP(8))2000,1600,1600
C--END OF CARD  -  CHECK THE NUMBER OF ATOMS FOUND
2000  CONTINUE
      IF(NATOM-4)2050,2150,2150
C--NOT ENOUGH ATOMS
2050  CONTINUE
      CALL XPCLNN(LN)
      WRITE ( CMON,2100)
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(A)') CMON(1 )(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
2100  FORMAT(' Not enough atoms provided')
      GOTO 2650
C--SET POINTERS TO THE FIRST THREE ATOMS IN THE STACK
2150  CONTINUE
      IBASE1=IBASE
      IBASE2=IBASE+NW
      IBASE3=IBASE+NW+NW
C--SET POINTERS TO THE REMAINING ATOMS IN THE STACK
      IBASE4=IBASE3
      NATOM=NATOM-3
C--SET UP SPACE FOR ROTATION MATRIX AT 'MAT'
      MAT=NFL
      NFL=NFL+9
C--STORE FIRST TWO VECTORS AT 'IBASE1', 'IBASE2'
      STORE(IBASE1)=STORE(IBASE1)-STORE(IBASE2)
      STORE(IBASE1+1)=STORE(IBASE1+1)-STORE(IBASE2+1)
      STORE(IBASE1+2)=STORE(IBASE1+2)-STORE(IBASE2+2)
      STORE(IBASE2)=STORE(IBASE3)-STORE(IBASE2)
      STORE(IBASE2+1)=STORE(IBASE3+1)-STORE(IBASE2+1)
      STORE(IBASE2+2)=STORE(IBASE3+2)-STORE(IBASE2+2)
C--ORTHOGONALISE FIRST TWO VECTORS, THEN NORMALISE
      JB=IBASE1
      DO 2250 JA=1,2
      CALL XMLTTM(STORE(L1O1),STORE(JB),STORE(NFL),3,3,1)
      CALL XMOVE(STORE(NFL),STORE(JB),3)
      IF(NORM3(STORE(JB)))2850,2200,2200
C--POINT TO THE SECOND VECTOR
2200  CONTINUE
      JB=IBASE2
2250  CONTINUE
C--SET A POINTER FOR THE ATOM NUMBER
      JQ=1
C--PRINT THE FIRST THREE ATOMS OF THE TORSION ANGLE
      JPUB = IPUB
      DO 2400 JA=IBASE1,IBASE3,NW
      JF=ISTORE(JA+3)
C--FIX THE SERIAL NUMBER
      JG=NINT(STORE(JF+1))
      JB=JA+4
      JD=JA+8
C----- COMPRESS ATOMS INTO CHARACTER FORM
      CALL CATSTR (STORE(JF)    ,STORE(JF+1)  ,ISTORE(JB)
     1 ,ISTORE(JB+1) ,ISTORE(JB+2) ,ISTORE(JB+3) ,ISTORE(JB+4),
     2 CATOM(JQ), LATOM(JQ))
C----- STORE THE 3 ATOMS IF NECESSARY
      IF (IPBFLG) 2370,2370,2360
2360  CONTINUE
      STORE(JPUB) = STORE(JF)
      STORE(JPUB+1) = STORE(JF+1)
      ISTORE(JPUB+2) = ISTORE(JB)
      ISTORE(JPUB+3) = ISTORE(JB+1)
      ISTORE(JPUB+4) = ISTORE(JB+2)
      ISTORE(JPUB+5) = ISTORE(JB+3)
      ISTORE(JPUB+6) = ISTORE(JB+4)
      JPUB = JPUB+7
2370  CONTINUE
      JQ=JQ+1
2400  CONTINUE
C--FORM ROTATION MATRIX FROM THESE VECTORS
      CALL XMOVE(STORE(IBASE2),STORE(MAT+6),3)
      IF(NCROP3(STORE(IBASE2),STORE(IBASE1),STORE(MAT+3)))2700,2450,
     2 2450
C--FORM TRANSPOSED ROTATION MATRIX AT 'MAT'
2450  CONTINUE
      IF(NCROP3(STORE(MAT+3),STORE(IBASE2),STORE(MAT)))2700,2500,2500
C
C--LOOP OVER ALL THE NEXT ATOM IN THE STACK AND COMPUTE IS ANGLE
2500  CONTINUE
      IBASE4=IBASE4+NW
C--DECREMENT THE NUMBER OF ATOMS
      NATOM=NATOM-1
C--FORM THIRD VECTOR AT IBASE4
      STORE(IBASE4)=STORE(IBASE4)-STORE(IBASE3)
      STORE(IBASE4+1)=STORE(IBASE4+1)-STORE(IBASE3+1)
      STORE(IBASE4+2)=STORE(IBASE4+2)-STORE(IBASE3+2)
C--ORTHOGONALISE TO 'IBASE1'
      CALL XMLTTM(STORE(L1O1),STORE(IBASE4),STORE(IBASE1),3,3,1)
C--NORMALISE
      IF(NORM3(STORE(IBASE1)))2850,2550,2550
C--ROTATE TO IBASE4
2550  CONTINUE
      CALL XMLTTM(STORE(MAT),STORE(IBASE1),STORE(IBASE4),3,3,1)
C--CALCULATE ANGLE OF VECTOR
      ANGLE=ATAN2(STORE(IBASE4+1),STORE(IBASE4))*RTD
      JF=ISTORE(IBASE4+3)
      JG=NINT(STORE(JF+1))
      JB=IBASE4+4
      JD=IBASE4+8
C--- NOTE THAT TWO ITEMS ARE OUTPUT EVEN WHEN ESDS ARE NOT COMPUTED
      IF(IPBFLG .GT. 0) WRITE (MTE) 'T', ANGLE, AZERO,
     1 (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2  JPUB=IPUB, IPUB+14, 7),
     3  STORE(JF), STORE(JF+1), (ISTORE(JE), JE=JB,JD)
C
C----- COMPRESS ATOMS INTO CHARACTER FORM
      CALL CATSTR (STORE(JF)    ,STORE(JF+1)  ,ISTORE(JB)
     1 ,ISTORE(JB+1) ,ISTORE(JB+2) ,ISTORE(JB+3) ,ISTORE(JB+4),
     2 CATOM(4), LATOM(4))
        WRITE ( CMON ,2806)(
     1 CBLANK(1: 15-LATOM(II)), CATOM(II)(1:LATOM(II)),II=1,4)
     2 ,ANGLE
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(A)') CMON( 1)(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
2806  FORMAT (2A, ' to ', 2A, ' to ', 2A, ' to ', 2A, F8.3)
C--CHECK IF THERE ARE MORE ATOMS
      IF(NATOM)1200,1200,2500
C
C--CARD PROCESSING ABANDONED
2650  CONTINUE
      CALL XPCA(ISTORE(MD+4))
      GOTO 1200
C
C--FIRST THREE ATOMS ARE CO-LINEAR
2700  CONTINUE
      WRITE ( CMON,2750)
      CALL XPRVDU(NCVDU, 1,0)
2750  FORMAT(' First three atoms are colinear')
      GOTO 2650
C
C--NOT ENOUGH CORE AVAILABLE
2800  CONTINUE
      CALL XICA
      GOTO 2950
C
C--ATOM APPEARS MORE THAN ONCE
2850  CONTINUE
      CALL XPCLNN(LN)
      WRITE ( CMON,2900)
      CALL XPRVDU(NCVDU, 1,0)
      WRITE(NCAWU, '(A)') CMON(1 )(:)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
2900  FORMAT(' An atom has appeared more than once for an angle')
      GOTO 2650
C
C--TERMINATION OF THE PROCESSING
2950  CONTINUE
      IESD = 0
      IF (IPBFLG .EQ. 1) THEN
        CALL XPRTDA (4,IESD,NCPU)
      ELSE  IF (IPBFLG .EQ. 2) THEN
        CALL XPRTDA (14,IESD,NCPU)
      ENDIF
      CALL XOPMSG (IOPTOR, IOPEND, IVERSN)
      CALL XTIME2(2)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPTOR , IOPABN , 0 )
      GO TO 2950
9910  CONTINUE
C -- INPUT ERROR
      CALL XOPMSG ( IOPTOR , IOPABN , 0 )
      GO TO 9900
      END
