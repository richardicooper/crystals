C $Log: not supported by cvs2svn $
C Revision 1.16  2001/07/03 08:58:09  ckp2
C Read in Fc^2, if flag for F^2 is set.
C
C Revision 1.15  2001/05/23 14:25:36  ckpgroup
C Store number of raw reflectons read in
C
C Revision 1.14  2001/04/30 11:50:28  ckpgroup
C fix-up omitted rflections when re-indexing matrix has non-integral results' read6.src
C
C Revision 1.13  2001/02/26 10:28:04  richard
C RIC: Added changelog to top of file
C
C
CODE FOR XRD06
      SUBROUTINE XRD06 (IULN)
C--READ THE PLANES, LIST 6
C
C  IULN    THE LIST TYPE THAT IS BEING INPUT AS A LIST 6.
C
C--THE REFLECTIONS ARE INPUT AND STORED ON M/T. AFTER  THIS, THEY ARE
C  READ BACK AND STORED ON THE DISC.
C
C--
      CHARACTER*80 CFORM
\ISTORE
\ICOM06
\ICOM6A
\ICOM13
\ICOM30
C
C
      CHARACTER*24 CCAPT1
      CHARACTER*32 CCAPT2
      DIMENSION AA(10), YCARD1(82), YCARD2(82), IFORM(40)
      DIMENSION IPARTS(4), ICAD4(11), ISLX(4), JSIGMA(1), JRATIO(1)
      DIMENSION JFOT(1), JFOO(1)
      DIMENSION TRANSH(12)
      dimension htemp(3),htemp1(3)
C
\STORE
\XUNITS
\XSSVAL
\UFILE
\XCHARS
\XCARDS
\XCONST
\XLISTI
\XLST01
\XLST06
\XPCK06
\XLST6A
\XLST13
\XLST25
\XLST50
\XLST30
\XTAPES
\XERVAL
\XOPVAL
\XLSVAL
\XIOBUF
C
\QSTORE
\QLST06
\QLST6A
C
      EQUIVALENCE (YCARD1(1),IMAGE(1))
\QLST13
\QLST30
C
C
      DATA NCARD/82/
C
      DATA NFORM/41/
C
      DATA ISLX(1)/'(3F4'/,ISLX(2)/'.0,2'/,ISLX(3)/'F8.2'/
      DATA ISLX(4)/')   '/
      DATA LSLX/4/
C
C
      DATA ICAD4(1)/'(5X,'/,ICAD4(2)/'3F4.'/,ICAD4(3)/'0,F9'/
      DATA ICAD4(4)/'.0,F'/,ICAD4(5)/'7.0,'/,ICAD4(6)/'F4.0'/
      DATA ICAD4(7)/',F9.'/,ICAD4(8)/'0,F4'/,ICAD4(9)/'.0,4'/
      DATA ICAD4(10)/'F7.2'/,ICAD4(11)/')   '/
C
      DATA LCAD4/11/
C
      DATA IPARTS(1)/5/,IPARTS(2)/6/,IPARTS(3)/7/,IPARTS(4)/8/
      DATA JSIGMA(1)/12/
      DATA JRATIO/20/
      DATA JFOT(1)/10/
      DATA JFOO(1)/3/
C
      DATA CCAPT1/'        Observation too small   '/
      DATA CCAPT2/'Transforms to non-integer index '/
C
C--SET THE TIMING FUNCTION
      CALL XTIME1 (2)
c----- un-set data keys
      irfo = nowt
      irft = nowt
      jnfo = nowt
      jnft = nowt
C--BLANK OUT THE FORMAT ARRAY
      CALL XMVSPD (IB,IFORM(1),NFORM-1)
\IDIM06
\IDIM6A
C--SET THE INITIAL FORMAT CONTROL FLAG
      LFORM=1
C--SET UP AN AREA TO HOLD DETAILS OF THE DIRECTIVES FOUND ON INPUT
      LN=IULN
      IREC=1001
      KZ=KCHLFL(NR60)
C--ZERO THIS AREA
      CALL XZEROF (STORE(KZ),NR60)
C--SET UP A COMMON BLOCK FOR INPUT
      KY=IDIM06+IDIM6A
      IREC=1002
      KX=KCHLFL(KY)
C--ZERO THIS COMMON BLOCK
      CALL XZEROF (STORE(KX),KY)
C--INDICATE THAT NO CARDS HAVE BEEN READ
      NCARDS=0
C--INDICATE THAT WE ARE POCESSING NO DIRECTIVE
      IDIR=-1
C--READ THE NEXT DIRECTIVE CARD FROM THE INPUT STREAM
50    CONTINUE
      LAST=IDIR
      IDIR=KRDNDC(ISTORE(KX),KY)
C--CHECK THE REPLY
      IF (IDIR) 600,100,150
C--CONTINUATION CARD  -  RESET THE POINTER
100   CONTINUE
      IDIR=LAST
      GO TO 200
C--NEW DIRECTIVE  -  INDICATE THAT IT HAS BEEN INPUT
150   CONTINUE
      I=KZ+IDIR
      ISTORE(I-1)=1
C--CHECK FOR A 'FORMAT' DIRECTIVE
200   CONTINUE
      IF (IDIR-5) 500,250,500
C--FORMAT STATEMENT  -  FIND THE KEYWORD/FORMAT EXPRESSION
250   CONTINUE
      IDWZAP=0
      IF (KFNDNP(IDWZAP)) 50,50,300
C--COMPUTE THE LENGTH OF DATA ON THIS CARD
300   CONTINUE
      M=LFORM
      N=LASTCH-NC+1
C--COMPUTE THE NEW MAXIMUM LENGTH OF THE FORMAT
      LFORM=LFORM+(N+NWCHAR-1)/NWCHAR
C--CHECK FOR OVERFLOW OF THE FORMAT AREA
      IF (LFORM-NFORM) 450,450,350
C--FORMAT STATEMNT IS TOO LONG
350   CONTINUE
      CALL XMONTR (0)
      CALL XERHDR (0)
      WRITE (CMON,400)
      CALL XPRVDU (NCVDU,1,0)
      WRITE (NCAWU,'(a)') CMON(1)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
400   FORMAT (' Format statement is too large')
      GO TO 5250
C--STORE THE NEW FORMAT OR PART OF FORMAT
450   CONTINUE
      CALL XFA4CS (IMAGE(NC),IFORM(M),N)
C--UPDATE THE POINTERS
      NC=LASTCH+1
      GO TO 50
C--NORMAL DIRECTIVE TO BE INPUT  -  FIND THE KEYWORD
500   CONTINUE
      IDWZAP=0
      IF (KFNDNP(IDWZAP)) 50,50,550
C--READ THE VALUE
550   CONTINUE
      IF (KRDPV(ISTORE(KX),KY)) 50,500,500
C
C--END OF THE DIRECTIVES  -  CHECK FOR ERRORS DURING THE INPUT
600   CONTINUE
      LN=IULN
      IF (LEF) 5250,650,5250
C--PRESERVE THE CARD INPUT COMMON BLOCK
650   CONTINUE
      CALL XMOVE (YCARD1(1),YCARD2(1),NCARD)
C--SET THE POINTERS READY FOR INPUT
      NC=LASTCH
C--STORE THE LIST 6 PART OF THE COMMON BLOCK
      CALL XMOVEI (ISTORE(KX),ICOM06(1),IDIM06)
C--STORE THE TEMPORARY PART OF THE COMMON BLOCK
      I=KX+IDIM06
      CALL XMOVE (ISTORE(I),ICOM6A(1),IDIM6A)
Cdjwnov2000
C----- save the matrix and tolerance
      CALL XMOVE (STORE(L6MR),TRANSH,9)
      TOLER=STORE(L6MR+9)
csquare it for later use (sint/lam)sq
      TWIND=STORE(L6MR+10) * STORE(L6MR+10)
Cdjw dec97
C ITYPE COPY FIXED FREE COMPRESSED TWIN (HKLI) FIXED FREE COMP
C        1     2    3       4        5           6    7    8
      IF (ITYPE6.GT.8) THEN
         WRITE (CMON,'(a)') 'Invalid READ type'
         CALL XPRVDU (NCVDU,1,0)
         WRITE (NCAWU,'(a)') CMON(1)
         IF (ISSPRT.EQ.0) WRITE (NCAWU,'(a)') CMON(1)
         GO TO 5250
      END IF
      IF (ITYPE6.EQ.5) THEN
C----- TWINNED DATA - MOVE OVER THE DEFAULT POINTERS
C     L6BMP ETC (TWINNED DEFAULTS) MOVED TO LODFK
         CALL XMOVE (ICOM6A(9),ICOM6A(29),4)
      END IF
Cdjw dec97
C--SET THE NUMBER OF REJECTED REFLECTIONS TO ZERO
      N6DEAD=0
      N6NEG=0
C----- load list 25 to find number of twin elements
      ELEM=1.
      N25=1
      IF (KEXIST(25).EQ.1) THEN
         CALL XFAL25
         IF (IERFLG.LT.0) GO TO 5450
      END IF
Cdjwoct2000 > moved from lower down
C--LOAD LIST 13 FOR THE TWIN DATA
      CALL XFAL13
      IF (IERFLG.LT.0) GO TO 5450
      WAVE=STORE(L13DC)
Cdjwnov2000 > nolonger used at all. Type
C      determind from input keys
C--POINT INITIALLY TO '/FO/'
C      IFO=3
C--CHECK IF THIS CRYSTAL IS TWINNED
C      IF(ISTORE(L13CD+1))3550,3500,3500
C--DATA IS FROM A TWINNED CRYSTAL  -  ALTER THE POINTER TO /FOT/
C      IFO=10
Cdjwoct2000 < moved from lower down
C--ZERO THE CORE BUFFER
      M6=L6
      CALL XZEROF (STORE(M6),MD6)
C--BLANK OUT THE CONTROL BLOCK
      CALL XZEROF (STORE(L6P),MD6P*N6P)
C--CHECK IF THE READ KEYS HAVE BEEN INPUT
      IF (ISTORE(KZ+2)) 750,750,850
C--NO KEYS HAVE BEEN INPUT  -  SET UP THE DEFAULTS
750   CONTINUE
      MD6IMP=MIN0(MD6IMP,MDIDFK)
C--CHECK THAT THERE ARE SOME NUMBERS TO BE MOVED
      IF (MD6IMP) 3500,3500,800
C--MOVE THE DEFAULT KEYS ACROSS
800   CONTINUE
      CALL XMOVE (STORE(LIDFK),STORE(L6IMP),MD6IMP)
      GO TO 900
C--CHECK IF THERE ARE SOME INPUT KEYWORDS
850   CONTINUE
      IF (MD6IMP) 3500,3500,900
C--CHECK IF THE PHASE HAS BEEN INPUT AS BOSS PHASES REQUIRE CONVERSION
900   CONTINUE
      KH=KCOMP(1,IPARTS(2),ISTORE(L6IMP),MD6IMP,1)-1
C--CHECK IF THE 'SIGMA' VALUE IS BEING INPUT
      ISIGMA=KCOMP(1,JSIGMA,ISTORE(L6IMP),MD6IMP,1)
C--CHECK IF THE KEYS TO BE STORED HAVE BEEN INPUT
C -- CHECK IF 'RATIO' ( OF FO AND SIGMA ) HAS BEEN INPUT
      IRATIO=KCOMP(1,JRATIO,ISTORE(L6IMP),MD6IMP,1)
C -- CHECK IF 'FO ' OR 'FOT' HAS BEEN INPUT
      IRFO=KCOMP(1,JFOO,ISTORE(L6IMP),MD6IMP,1)
      IRFT=KCOMP(1,JFOT,ISTORE(L6IMP),MD6IMP,1)
C----- determine input type from keys
C----- set default to untwinned
      IFO=3
      IF (IRFT.GT.0) THEN
         IFO=10
         IF (N25.LE.1) THEN
            WRITE (CMON,'(a)') 'Warning - You have no twin law'
            CALL XPRVDU (NCVDU,1,0)
            WRITE (NCAWU,'(a)') CMON(1)
            IF (ISSPRT.EQ.0) WRITE (NCAWU,'(a)') CMON(1)
         END IF
      END IF
      IF (ISTORE(KZ+3)) 950,950,1150
C--NO STORAGE KEYS HAVE BEEN INPUT  -  SET THE DEFAULTS
950   CONTINUE
cjan2001 Reset output defaults if twin data input
c     l6bmp etc (twinned defaults) moved to lodfk
      if (irft .gt. 0) call xmove (icom6a(9),icom6a(29),4)
      MD6DMP=MIN0(MD6DMP,MDODFK)
C--CHECK IF ANY OUTPUT KEYS ARE INDICATED
      IF (MD6DMP) 1000,1000,1100
C--NO OUTPUT DATA
1000  CONTINUE
      CALL XERHDR (0)
      WRITE (CMON,1050)
      CALL XPRVDU (NCVDU,1,0)
      WRITE (NCAWU,'(a)') CMON(1)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
1050  FORMAT (' Insufficient output coefficients per reflection',' have
     1been indicated')
      GO TO 5200
C--MOVE THE DEFAULT VALUES ACROSS
1100  CONTINUE
      CALL XMOVE (STORE(LODFK),STORE(L6DMP),MD6DMP)
      GO TO 1200
C--CHECK IF ANY OUTPUT KEYS HAVE BEEN INDICATED
1150  CONTINUE
      IF (MD6DMP) 1000,1000,1200
C--CHECK IF THE INDICES SHOULD BE PACKED ON OUTPUT TO THE DISC
1200  CONTINUE
      IPACKW=KCOMP(1,I14,ISTORE(L6DMP),MD6DMP,1)
C -- CHECK IF 'FO ' OR 'FOT' HAS BEEN SAVED
      JNFO=KCOMP(1,JFOO,ISTORE(L6DMP),MD6DMP,1)
      JNFT=KCOMP(1,JFOT,ISTORE(L6DMP),MD6DMP,1)
Cdjwoct200
      IF ((IRFT.GT.0).AND.(JNFT.EQ.0)) THEN
         WRITE (CMON,'(a/a)') 'Twinned data input but not stored - ','Ch
     1eck the List 6 keys'
         call outcol(3)
         CALL XPRVDU (NCVDU,2,0)
         call outcol(1)
         WRITE (NCAWU,'(a)') CMON(1),CMON(2)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1),CMON(2)
         GO TO 5450
      END IF
Cdjwoct2000
C--CHECK IF THE PHASE AND THE BATCH NUMBER SHOULD BE PACKED
      IPHSEW=KCOMP(1,I15,ISTORE(L6DMP),MD6DMP,1)
C -- CHECK IF THE JCODE AND RATIO SHOULD BE PACKED TOGETHER
      JCDRAW=KCOMP(1,I31,ISTORE(L6DMP),MD6DMP,1)
C--CHECK IF A AND B PARTS SHOULD BE GENERATED FROM INPUT /FC/ AND PHASE
      KD=-1
      DO 1400 I=1,4
C--CHECK IF THIS IS /FC/ AND PHASE OR THE TWO PARTS
         IF (I-2) 1250,1250,1300
C--/FC/ AND PHASE MUST HAVE BEEN INPUT
1250     CONTINUE
         IF (KCOMP(1,IPARTS(I),ISTORE(L6IMP),MD6IMP,1)) 1450,1450,1400
C--A AND B PARTS MUST BE ABOUT TO BE STORED
1300     CONTINUE
         IF (KCOMP(1,IPARTS(I),ISTORE(L6DMP),MD6DMP,1)) 1450,1450,1350
C--A AND B PARTS MUST NOT HAVE BEEN INPUT
1350     CONTINUE
         IF (KCOMP(1,IPARTS(I),ISTORE(L6IMP),MD6IMP,1)) 1400,1400,1450
1400  CONTINUE
C--CONVERSION IS REQUIRED
      KD=1
C--CONVERT THE INPUT POINTERS TO ABSOLUTE VALUES
1450  CONTINUE
      M6IMP=L6IMP+MD6IMP-1
      DO 1500 I=L6IMP,M6IMP
         ISTORE(I)=ISTORE(I)+M6
1500  CONTINUE
C--CONVERT THE DISC POINTERS TO ABSOLUTE VALUES
      CALL XABP06 (1)
C--SET THE INPUT UNIT NUMBER
      IF (IUNIT) 1550,1600,1600
C--NORMAL REFLECTION INPUT CHANNEL
1550  CONTINUE
      IUNIT=NCARU
      GO TO 1650
C--DATA IN THE NORMAL INSTRUCTION CHANNEL  -  NOT USUAL
1600  CONTINUE
      IF (IEOF.LE.0) THEN
C----- READ FROM CURRENT 'USE' FILE
         IUNIT=NCUFU(IFLIND)
      ELSE
C----- SRQ IN USE - FIND CALLING I/O UNTIT
         IUNIT=NCUFU(IFLIND-1)
      END IF
C--SET UP THE DEFAULT NUMBER OF REFLECTIONS PER CARD
1650  CONTINUE
      NGROUP=1
      INCREM=1
C--SET THE END POINTER FOR THE INPUT BUFFER
      M6IB=L6IB+MD6IB-1
C--INITIALISE THE REFLECTION VALUE COLLECTION
      DO 1700 I=1,MD6
         CALL XIRTAC (I)
1700  CONTINUE
      M6R=L6R
      CALL XFAL01
      IF (IERFLG.LT.0) GO TO 5450
C--CHECK IF THIS IS A SIMPLE COPY
      IF ((ITYPE6.EQ.1).OR.(ITYPE6.EQ.5)) GO TO 1750
C--CHECK IF THIS IS AN APPEND OPERATION
      IF (IAPPND) 2400,1750,1750
C
C--AN APPEND OR COPY IS REQUIRED
1750  CONTINUE
      I=KHUNTR(IULN,0,IADDL,IADDR,IADDD,0)
C--MOVE TO THE END OF THE RECORD CHAIN FOR THE CURRENT LIST 6
1800  CONTINUE
      IF (KCHNCB(IADDR)) 1800,1800,1850
C--PRESERVE THE LAST POINTER
1850  CONTINUE
      LASTPN=ISTORE(IADDR)
C--PRESERVE THE OUTPUT INDEX COMPRESS FLAG
      KW=IPACKW
C--PRESERVE THE PHASE/BATCH FLAGS
      KT=IPHSEW
C -- PRESERVE THE JCODE/RATIO FLAG
      KS=JCDRAW
C--PRESERVE THE LIST 6 COMMON BLOCK
      CALL XMOVEI (ICOM06(1),ISTORE(KX),IDIM06)
C--INITIATE THE READ FROM LIST 6
      CALL XFLT06 (IULN,0)
      IF (IERFLG.LT.0) GO TO 5450
C--ELIMINATE THE LAST LIST 6 LOADED FROM THE CORE CHAIN
      ISTORE(IADDR)=LASTPN
C--CONVERT THE MOVE POINTERS TO POINT TO THE ORIGINAL LIST 6
      M6DMP=L6DMP+MD6DMP-1
      IRFO=-1
      IRFT=-1
      DO 1900 I=L6DMP,M6DMP
C---- SET POINTERS TO INFORMATION ON DISK
         IF ((ISTORE(I)-M6).EQ.JFOO(1)) IRFO=JFOO(1)
         IF ((ISTORE(I)-M6).EQ.JFOT(1)) IRFT=JFOT(1)
         ISTORE(I)=ISTORE(I)-M6+ISTORE(KX+1)
1900  CONTINUE
C--PRESERVE THE MOVE POINTERS
      KP=L6DMP
      KQ=M6DMP
C--PRESERVE THE NEW READ FLAGS
      CALL XMOVEI (ICOM06(5),ISTORE(KZ),4)
C--RESTORE THE INPUT DATA TO THE COMMON BLOCK
      CALL XMOVEI (ISTORE(KX),ICOM06(1),IDIM06)
C--RESET THE OUTPUT PACKING FLAGS
      IPACKW=KW
      IPHSEW=KT
      JCDRAW=KS
C--CHECK FOR A COPY OPERATION
      IF ((ITYPE6.EQ.1).OR.(ITYPE6.EQ.5)) THEN
         GO TO 1950
      ELSE
         GO TO 2000
      END IF
C--COPY  -  SET UP THE OUTPUT TYPE
1950  CONTINUE
      N6D=ISTORE(KZ+3)
C -- IF COPY IS TO DISC, CHECK THAT ENOUGH SPACE WILL BE AVAILABLE
      IF (MEDIUM.GT.0) I=KLSSPC(IULN,ICOM06,IDIM06,3)
      CALL XSTR06 (IULN,MEDIUM,-1,-1,0)
      GO TO 2050
C--NOW INITIALISE THE OUTPUT SEQUENCE
2000  CONTINUE
      CALL XSTR06 (IULN,-1,-1,1,0)
C--RESET THE READ FLAGS
2050  CONTINUE
      CALL XMOVEI (ISTORE(KZ),ICOM06(5),4)
C--LOAD THE NEXT REFLECTION  -  SET ALL THE POINTERS
2100  CONTINUE
      L6DMP=KP
      M6DMP=KQ
C--LOAD THE REFLECTION
      IF (KLDRNR(1)) 2350,2150,2150
2150  CONTINUE
Cdjwnov2000  apply the matrix  note l6=m6
      CALL XZEROF (TRANSH(10),3)
      DO 2200 I=0,2
         TRANSH(10)=TRANSH(10)+TRANSH(1+I)*STORE(M6+I)
         TRANSH(11)=TRANSH(11)+TRANSH(4+I)*STORE(M6+I)
         TRANSH(12)=TRANSH(12)+TRANSH(7+I)*STORE(M6+I)
2200  CONTINUE
      DO 2250 I=10,12
         IF (ABS(TRANSH(I)-FLOAT(NINT(TRANSH(I)))).GT.TOLER) THEN
C--CHECK IF THIS IS THE FIRST REJECTED REFLECTION
            CALL XL6RRP (N6NEG,1000,IFO,CCAPT2)
            N6DEAD=N6DEAD+1
            GO TO 2100
         END IF
2250  CONTINUE
      CALL XMOVE (TRANSH(10),STORE(M6),3)
Cdjw dec97        twins - sort out  Fo to FOT
C--- PUT SOMETHING INTO FO
      IF ((JNFO.GT.0).AND.(IRFO.LE.0).AND.(IRFT.GT.0)) STORE(M6+JFOO(1))
     1=STORE(M6+JFOT(1))
C---- PUT SOMETING INTO FOT
      IF ((JNFT.GT.0).AND.(IRFT.LE.0).AND.(IRFO.GT.0)) STORE(M6+JFOT(1))
     1=STORE(M6+JFOO(1))
C----- PUT SOMETHING INTO ELEMENTS
cdec2000
c
      if ((jnft.gt.0).and.(store(m6+11).le.zero)) then
        elem = 0.
        if (n25 .gt. 1) then
         elem = 1.
         m25 = l25+md25
c----- save the base index
         call xmove(store(m6), htemp1, 3)
         do 700 i=2,n25
c----- create a twin index (matrix stored by rows)
            call xmlttm(store(m25), htemp1, store(m6),3,3,1)
c----- find difference vector
            htemp(1) = float(nint(store(m6)))-store(m6)
            htemp(2) = float(nint(store(m6+1)))-store(m6+1)
            htemp(3) = float(nint(store(m6+2)))-store(m6+2)
c--compute the length sq in rlus
            ii = 1
      t=store(l1s)*htemp(ii)*htemp(ii)+store(l1s+1)*htemp(ii+1)
     2 *htemp(ii+1)+store(l1s+2)*htemp(ii+2)*htemp(ii+2)+store(l1s+3)
     3 *htemp(ii+1)*htemp(ii+2)+store(l1s+4)*htemp(ii)*htemp(ii+2)
     4 +store(l1s+5)*htemp(ii)*htemp(ii+1)
            if (t .gt. twind) goto 698
            elem=10.*elem+float(i)
698         continue
           m25 = m25 + md25
700     continue
c----- restore the base index
        call xmove(htemp1, store(m6), 3)
        endif
        store(m6+11)=elem
      endif
c^^^
C--RESET THE MOVE POINTERS
      L6DMP=ISTORE(KX+16)
      M6DMP=ISTORE(KX+17)
C--STORE THE REFLECTION
      CALL XSLR (1)
C--ACCUMULATE THE TOTALS
      DO 2300 I=1,MD6
         CALL XACRT (I)
2300  CONTINUE
      GO TO 2100
C--END OF THE REFLECTIONS  -  RESTORE THE COMMON BLOCK COMPLETELY
2350  CONTINUE
      L6DMP=ISTORE(KX+16)
      M6DMP=ISTORE(KX+17)
      MD6R=MD6W
      CALL XZEROF (STORE(M6),MD6)
      GO TO 2450
C
C--INITIALISE THE OUTPUT OF THE REFLECTIONS TO M/T
2400  CONTINUE
      CALL XSTR06 (IULN,-1,-1,1,0)
C--RESET THE CURRENT LIST TYPE
2450  CONTINUE
      LN=IULN
      IREC=0
C----- INITIALISE THE ABSORPTION CORRECTION
      I=MABS(-1)
      IF (IERFLG.LT.0) GO TO 5450
      LN=IULN
C--BRANCH ON THE TYPE OF OUTPUT
      GO TO (5000,2550,3250,3450,5000,4050,4050,4050,2500),ITYPE6
C3600  STOP 'LIST 6 ERROR'
2500  CALL GUEXIT (2019)
C
C--FIXED FORMAT INPUT
2550  CONTINUE
      IF (DENSTY-ZERO) 2600,2600,2650
C--THE NUMBER OF REFLECTIONS PER CARD IS ZERO  -  DEFAULT TO ONE
2600  CONTINUE
      DENSTY=1.
C--RECOMPUTE THE NUMBER OF REFLECTIONS PER CARD AND THE NUMBER OF CARDS
2650  CONTINUE
      NGROUP=MAX0(1,NINT(DENSTY))
      INCREM=MAX0(1,NINT(1./DENSTY))
C--RECREATE THE INPUT DATA AREA
      MD6IB=MD6IB*NGROUP
      L6IB=KCEDR(106,1,1004,MD6IB,N6IB,41)
      M6IB=L6IB+MD6IB-1
C--CHECK IF A FORMAT HAS BEEN PROVIDED
      IF (LFORM-1) 2700,2700,2900
C--NO FORMAT INPUT  -  SET UP THE DEFAULT VALUE
2700  CONTINUE
      IF (ITYPE6-6) 2800,2750,2800
C--THIS IS REFLECTION INPUT IN FIXED FORMAT  -  CHECK LIST 13
2750  CONTINUE
      IDIF=ISTORE(L13DT)-5
C     NORMAL         EQUI           ANTI           PRECESSION     NONE
C     CAD4           ROLLETT        Y290           KAPPA
      GO TO (2850,2850,2850,2850,2850,2800,2850,2850,2800),IDIF+5
C--'CAD4' DATA
2800  CONTINUE
      CALL XMOVEI (ICAD4(1),IFORM(1),LCAD4)
      LFORM=LCAD4
      GO TO 2900
C--'SHELX' INPUT FORMAT IS THE DEFAULT TO BE USED
2850  CONTINUE
      CALL XMOVEI (ISLX(1),IFORM(1),LSLX)
      LFORM=LSLX
C--COMPRESS THE FORMAT FOR USE
2900  CONTINUE
      CALL XFCCS (IFORM(1),IFORM(1),LFORM)
C----- CONVERT TO CHARACTERS
      WRITE (CFORM,'(20A4)') (IFORM(IZZ),IZZ=1,LFORM)
CNOV2000 CHECK THAT THE FORMAT IS ALL-FLOATING
      IF (KCITOF(CFORM).LE.0) THEN
         WRITE (CMON,'(A)') 'FORMAT card error'
         GO TO 5200
      END IF
C--READ THE NEXT REFLECTION
2950  CONTINUE
      call xzerof (store(l6ib),m6ib)
      READ (IUNIT,CFORM,END=3200,ERR=3100) (STORE(I),I=L6IB,M6IB)
      NCARDS=NCARDS+INCREM
C--CHECK FOR BLANK ENTRY
      DO 3000 I=L6IB,M6IB
         IF (NINT(STORE(I))) 3050,3000,3050
3000  CONTINUE
      GO TO 2950
C--CHECK FOR THE END OF THE REFLECTIONS
3050  CONTINUE
      IF (STORE(L6IB)+511.) 5000,4100,4100
C--END OF FILE DURING THE READ  -  CHECK IF THIS IS ON THE INPUT UNIT
C----- ERROR DURING READ -
3100  CONTINUE
      IF (NCARDS.LE.0) THEN
         WRITE (CMON,'(A)') ' Check the reflection filename, and format'
         CALL XPRVDU (NCVDU,1,0)
         WRITE (NCAWU,'(A)') CMON(1)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         LEF=-1
      ELSE
         WRITE (CMON,3150)
         CALL XPRVDU (NCVDU,3,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,3150)
         WRITE (NCAWU,3150)
3150     FORMAT (' Error during reading reflections'/' Some reflections
     1may be lost'/' They should be terminated with an h value of -512')
         CALL XPAUSE (500)
         BACKSPACE (UNIT=IUNIT,ERR=3200)
      END IF
      GO TO 5000
3200  CONTINUE
      IF (IUNIT.EQ.NCARU) GO TO 5000
C--NORMAL CONTROL INPUT UNIT  -  INDICATE END OF FILE
      IEOF=-1
      GO TO 5000
C
C--FREE FORMAT REFLECTION INPUT
3250  CONTINUE
      NW=MD6IMP-1
      IF (NW) 3500,3500,3300
C--READ THE FIRST WORD OF THE NEXT REFLECTION
3300  CONTINUE
      IF (KRD06(STORE(L6IB),1,-1)) 5000,3350,5200
C--CHECK FOR END OF FILE
3350  CONTINUE
      IF (STORE(L6IB)+511.) 5000,3400,3400
C--READ THE REMAINDER OF THE DATA
3400  CONTINUE
      IF (KRD06(STORE(L6IB+1),NW,0)) 5200,4100,5200
C
C--THIS IS A COMPRESSED INPUT  -  COMPUTE THE NUMBER OF COEFFICIENTS
3450  CONTINUE
      NW=MD6IMP-3
C--CHECK IF ANY COEFFICIENTS ARE INDICATED
      IF (NW) 3500,3500,3600
C--NO DATA
3500  CONTINUE
      CALL XERHDR (0)
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,3550)
      END IF
3550  FORMAT (' Insufficient input coefficients per reflection',' Have b
     1een indicated')
      GO TO 5200
C--SET THE TRUE POINTER FOR THE MULTIPLIERS
3600  CONTINUE
      M6MLT=L6MLT+3
C--INVERT THE MULTIPLIERS
      DO 3650 I=1,NW
         AA(I)=1./STORE(M6MLT)
         M6MLT=M6MLT+1
3650  CONTINUE
C--READ THE NEXT 'KL' PAIR
3700  CONTINUE
      IF (KRD06(STORE(L6IB+1),2,0)) 5200,3750,5200
C--READ THE NEXT 'H' VALUE
3750  CONTINUE
      IF (KRD06(STORE(L6IB),1,0)) 5200,3800,5200
C--CHECK IF THIS VALUE INDICATES THE END OF THIS 'KL' PAIR
3800  CONTINUE
      IF (STORE(L6IB)-511.) 3850,3850,3700
C--CHECK IF THIS VALUE OF 'H' INDICATES THE END OF THE REFLECTIONS
3850  CONTINUE
      IF (STORE(L6IB)+511.) 5000,3900,3900
C--READ THE COEFFICIENTS
3900  CONTINUE
      IF (KRD06(STORE(L6IB+3),NW,0)) 5200,3950,5200
C--MULTIPLY UP THE COEFFICIENTS
3950  CONTINUE
      L=L6IB
      DO 4000 K=1,NW
         STORE(L+3)=STORE(L+3)*AA(K)
         L=L+1
4000  CONTINUE
      GO TO 4100
C
C--INPUT FROM A BOSS TAPE  -  READ THE TITLES AND DETAILS
C----- THE LINK TO THE 'BOSS' SYSTEM IS NO LONGER SUPPORTED
      GO TO 5000
C
C--REFLECTION INPUT, INCLUDING SCALING AND ABSORPTION CORRECTIONS
4050  CONTINUE
      I=MSCALE(-1)
      IF (IERFLG.LT.0) GO TO 5450
      GO TO (5000,2550,3250,3450,5000,2550,3250,3450,2500),ITYPE6
C
C--UPDATE AND STORE THE REFLECTION
4100  CONTINUE
      L=L6IB
C--LOOP OVER EACH INPUT GROUP
      DO 4850 K=1,NGROUP
         STORE(M6+27)=1.
         STORE(M6+11)=0.
         STORE(M6+12)=0.
C--MOVE THE DATA FROM THE INPUT BUFFER TO THE CORE BUFFER
         DO 4150 I=L6IMP,M6IMP
            J=ISTORE(I)
            STORE(J)=STORE(L)
            L=L+1
4150     CONTINUE
C----- CHECK INDICES
         IF ((ABS(STORE(M6))+ABS(STORE(M6+1))+ABS(STORE(M6+2))).LE.ZERO)
     1     GO TO 4850
Cnov2000 now apply a matrix
         CALL XZEROF (TRANSH(10),3)
         DO 4200 ITMP=0,2
            TRANSH(10)=TRANSH(10)+TRANSH(1+ITMP)*STORE(M6+ITMP)
            TRANSH(11)=TRANSH(11)+TRANSH(4+ITMP)*STORE(M6+ITMP)
            TRANSH(12)=TRANSH(12)+TRANSH(7+ITMP)*STORE(M6+ITMP)
4200     CONTINUE
         DO 4250 ITMP=10,12
            IF (ABS(TRANSH(ITMP)-FLOAT(NINT(TRANSH(ITMP)))).GT.TOLER)
     1       THEN
C--CHECK IF THIS IS THE FIRST REJECTED REFLECTION
               CALL XL6RRP (N6NEG,1000,IFO,CCAPT2)
               N6DEAD=N6DEAD+1
               GO TO 4850
            END IF
4250     CONTINUE
         CALL XMOVE (TRANSH(10),STORE(M6),3)
c--- set element flag
      if ((jnft.gt.0).and.(store(m6+11).le.zero)) then
       elem = 0.
        if (n25 .gt. 1) then
         elem = 1.
         m25 = l25+md25
c----- save the base index
         call xmove(store(m6), htemp1, 3)
         do 4257 i=2,n25
c----- create a twin index (matrix stored by rows)
            call xmlttm(store(m25), htemp1, store(m6),3,3,1)
c----- find difference vector
            htemp(1) = float(nint(store(m6)))-store(m6)
            htemp(2) = float(nint(store(m6+1)))-store(m6+1)
            htemp(3) = float(nint(store(m6+2)))-store(m6+2)
c--compute the length sq in rlus
            ii = 1
      t=store(l1s)*htemp(ii)*htemp(ii)
     1 +store(l1s+1)*htemp(ii+1)*htemp(ii+1)
     2 +store(l1s+2)*htemp(ii+2)*htemp(ii+2)
     3 +store(l1s+3)*htemp(ii+1)*htemp(ii+2)
     4 +store(l1s+4)*htemp(ii)*htemp(ii+2)
     5 +store(l1s+5)*htemp(ii)*htemp(ii+1)
            if (t .gt. twind) goto 4256
            elem=10.*elem+float(i)
4256        continue
           m25 = m25 + md25
4257    continue
c----- restore the base index
        call xmove(htemp1, store(m6), 3)
        endif
        store(m6+11)=elem
      endif
c
C
C--CHECK IF WE SHOULD COMPUTE SIN(THETA)/LAMBDA SQUARED
         IF (L1S) 4350,4350,4300
C--COMPUTE IT
4300     CONTINUE
         STORE(M6+16)=SNTHL2(I)
C--ENSURE A MINIMUM BATCH NUMBER OF ONE
4350     CONTINUE
         STORE(M6+13)=AMAX1(STORE(M6+13),1.)
C----- ENSURE POSITIVE JCODES AND LESS THAN 10
         STORE(M6+18)=AMIN1(9.,AMAX1(0.,STORE(M6+18)))
C--ENSURE A MINIMUM SERIAL OF ZERO
         STORE(M6+19)=AMAX1(STORE(M6+19),0.)
C--CHECK IF WE SHOULD COMPUTE THE A-PART AND B-PART FROM /FC/ AND PHASE
         IF (KD) 4450,4400,4400
C--COMPUTE THE PARTS
4400     CONTINUE
         STORE(M6+7)=STORE(M6+5)*COS(STORE(M6+6))
         STORE(M6+8)=STORE(M6+5)*SIN(STORE(M6+6))
C--BRANCH ON THE INPUT TYPE
4450     CONTINUE
         GO TO (4600,4600,4600,4600,4600,4500,4500,4500,2500),ITYPE6
C6400  STOP 323
         CALL GUEXIT (323)
C--REFLECTION INPUT  -  APPLY ANY SCALES AND COEFFICIENTS
4500     CONTINUE
         IF (MSCALE(0)) 4850,4550,4550
C--AND NOW APPLY ANY ABSORPTION CORRECTION THAT IS REQUIRED
4550     CONTINUE
         IF (MABS(0)) 4850,4600,4600
C--CHECK IF WE SHOULD TAKE THE SQUARE ROOT
4600     CONTINUE
         JFO=M6+IFO
C--ARE WE INPUTTING /FO/ **2 ?
         IF (ISQ) 4650,4700,4700
4650     CONTINUE
Cdjwmap99[
         CALL XSQRT (STORE(JFO),FSIGN,FABS,STORE(M6+12),SIG)
         STORE(JFO)=FSIGN
         STORE(M6+12)=SIG
Cdjwmap99]
Cric2001[
C If F's are squared, Fc's probably are aswell.
         STORE(M6+5) = SQRT (ABS(STORE(M6+5)))
Cric2001]
C
C--APPLY THE SCALE STORED IN THE 'CORRECTIONS' SLOT
4700     CONTINUE
         STORE(JFO)=STORE(JFO)*STORE(M6+27)
         STORE(M6+12)=STORE(M6+12)*STORE(M6+27)
c^^moved from above -Feb 2001
Cdjw dec97        twins - sort out  Fo to FOT
c--- put something into fo
      if ((jnfo.gt.0).and.(irfo.le.0).and.(irft.gt.0)) store(m6+jfoo(1))
     1=store(m6+jfot(1))
c---- put someting into fot
      if ((jnft.gt.0).and.(irft.le.0).and.(irfo.gt.0)) store(m6+jfot(1))
     1=store(m6+jfoo(1))
c----- put something into elements
cdec2000
C----- RESET TO UNITY SINCE WE DONT NEED IT AGAIN
         STORE(M6+27)=1.
C--CHECK THAT THE GIVEN VALUES OF /FO/ ARE NOT ZERO
         IF (STORE(JFO).GT.ZERO) GO TO 4750
C--CHECK IF THIS IS THE FIRST REJECTED REFLECTION
         CALL XL6RRP (N6NEG,1000,IFO,CCAPT1)
C--SEE IF WE SOULD REJECT THIS REFLECTION
         IF (ICHECK.GE.0) THEN
            N6DEAD=N6DEAD+1
            GO TO 4850
         END IF
4750     CONTINUE
C -- CALCULATE RATIO OF (FO)**2 AND SIGMA((FO)**2),IF IT HAS NOT BEEN IN
         IF (IRATIO.LE.0) THEN
            IF (STORE(M6+12).LE.ZERO) THEN
               STORE(M6+20)=0.0
            ELSE
               STORE(M6+20)=MIN(STORE(JFO)/(2.*STORE(M6+12)),999.)
            END IF
         END IF
C
C----- WE HAVE FINISHED WITH 'CORRECTIONS' - SET TO UNITY
         STORE(M6+27)=1.0
C -- AND NOW STORE THE REFLECTION
         CALL XSLR (1)
C--ACCUMULATE THE REFLECTION TOTALS
         DO 4800 I=1,MD6
            CALL XACRT (I)
4800     CONTINUE
4850  CONTINUE
C--BRANCH ON THE TYPE OF INPUT
      GO TO (2950,2950,3300,3750,2950,2950,3300,3750,4900),ITYPE6
4900  CONTINUE
      WRITE (CMON,4950)
      CALL XPRVDU (NCVDU,1,0)
      WRITE (NCAWU,'(/A/)') CMON(1)(:)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(/A/)') CMON(1)(:)
4950  FORMAT (' Unsupported input data format')
      GO TO 5200
C
C--END OF THE REFLECTION INPUT  -  STORE THEM ON THE DISC
5000  CONTINUE
      N6D=N6W
C--NO ERRORS  -  CALCULATE THE REFLECTION DETAILS
      DO 5050 I=1,MD6
         CALL XCRD (I)
5050  CONTINUE
C--TERMINATE THE OUTPUT OF THE LIST
      CALL XERT (IULN)
      CALL XLINES
      WRITE (CMON,5100) N6W,N6DEAD
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
      WRITE (NCAWU,'(A)') CMON(1)(:)
5100  FORMAT (1X,I7,' reflections accepted',5X,I7,' reflections rejected
     1')
C----- IF ITYPE6 .NE. 'COPY'  OR 'TWIN' WE WERE PROBABLY READING RAW DATA
      IF ((ITYPE6.NE.1).AND.(ITYPE6.NE.5)) THEN
         IF (KHUNTR(30,0,IADDL,IADDR,IADDD,-1).LT.0) CALL XFAL30
C         IF (STORE(L30DR).LE.ZERO) STORE(L30DR)=FLOAT(N6W)
C         IF (STORE(L30DR+2).LE.ZERO) STORE(L30DR+2)=FLOAT(N6W)
         STORE(L30DR)=FLOAT(N6W)
         STORE(L30DR+2)=FLOAT(N6W)
C----- MIN AND MAX INDICES, FROM L6 DETAILS
         LIX=L6DTL
         STORE(L30IX)=STORE(LIX)
         STORE(L30IX+1)=STORE(LIX+1)
         LIX=LIX+MD6DTL
         STORE(L30IX+2)=STORE(LIX)
         STORE(L30IX+3)=STORE(LIX+1)
         LIX=LIX+MD6DTL
         STORE(L30IX+4)=STORE(LIX)
         STORE(L30IX+5)=STORE(LIX+1)
C---- THETA IS NOT AVAILABLE DURING READING REFLECTIONS
C        LIX = L6DTL + 16*MD6DTL
C        STORE(L30IX+6) = ASIN(SQRT(STORE(LIX))* WAVE)*RTD
C        STORE(L30IX+7) = ASIN(SQRT(STORE(LIX+1))*WAVE)*RTD
         CALL XWLSTD (30,ICOM30,IDIM30,-1,-1)
      END IF
C----- WRITE LIST 13 TO DISK IF TYPE IS TWIN
      IF ((ITYPE6.EQ.5).OR.(IFO.EQ.JFOT(1))) THEN
         WRITE (CMON,'(a)') 'Upating List 13 for twinned data'
         CALL XPRVDU (NCVDU,1,0)
         WRITE (NCAWU,'(a)') CMON(1)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
         ISTORE(L13CD+1)=0
         CALL XWLSTD (13,ICOM13,IDIM13,-1,-1)
      ELSE
         IF (ISTORE(L13CD+1) .EQ. 0 ) THEN
         WRITE (CMON,'(a)') 'Resetting List 13 for un-twinned data'
         CALL XPRVDU (NCVDU,1,0)
         WRITE (NCAWU,'(a)') CMON(1)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
         ISTORE(L13CD+1)=-1
         CALL XWLSTD (13,ICOM13,IDIM13,-1,-1)
         ENDIF
      END IF
C
C
C---- PRINT CORRECTION DETAILS
      I=MABS(1)
C--CHECK FOR ANY ERRORS
      IF (LEF) 5200,5150,5200
C--NO ERRORS  -  CHECK IF WE MUST OUTPUT TO DISC NOW
5150  CONTINUE
      CALL XSWP06 (IULN,MEDIUM)
C
C--END OF THE INPUT  -  RESTORE THE INPUT CARD IMAGE
      CALL XMOVE (YCARD2(1),YCARD1(1),NCARD)
      GO TO 5300
C--ERROR(S) DURING INPUT  -  RESTORE THE CURRENT CARD IMAGE
5200  CONTINUE
      CALL XMOVE (YCARD2(1),YCARD1(1),NCARD)
C--PRINT THE ERROR TERMINATION MESSAGE
5250  CONTINUE
      CALL XOPMSG (IOPLSI,IOPLSP,IULN)
      CALL XLSALT (IULN,0,0,ILSERF,ILSSET)
C--REWIND THE M/T BEFORE WE LEAVE
      REWIND MTA
      REWIND MTB
C--CHECK IF WE HAVE BEEN READING FROM THE MAIN INPUT FILE
5300  CONTINUE
      IF (IUNIT-NCRU) 5400,5350,5400
C--INPUT FROM THE MAIN CHANNEL  -  ALTER THE COUNTERS
5350  CONTINUE
      NI=NI+NCARDS
      MON=NI
C--AND NOW RETURN
5400  CONTINUE
      CALL XOPMSG (IOPLSI,IOPLSE,IULN)
      CALL XTIME2 (2)
      RETURN
C
5450  CONTINUE
C -- ERRORS
      GO TO 5200
C
      END
Cdjwnov99[
CODE FOR XSQRT
      SUBROUTINE XSQRT (FSQ,FSIGN,FABS,SIGSQ,SIG)
C----- RETURN THE SIGNED AND UNSIGNED SQUARE ROOT OF A STRUCTURE
C      AMPLITUDE AND THE CORRESPONDING SIGMA
C      FSQ  INPUT AMPLITUDE
C      FSIGN SIGNED MAGNITUDE
C      FABS  OUTPUT ABSOLUTE MAGNITUDE
C      INPUT SIGMA SQ
C      OUTPUT SIGMA
\XCONST
      FABS=SQRT(ABS(FSQ))
      FSIGN=SIGN(1.,FSQ)*FABS
Cdjwmar99[ compute sigma(f) from sigma(F**2)
      IF (SIGSQ.GT.ZERO) THEN
C----- WE HAVE SOME KIND OF SIGMA - TRY TO SCALE IT
         IF (FABS.GT.1.0) THEN
            SIG=SIGSQ/(2.*FABS)
         ELSE
            SIG=SIGSQ
         END IF
      ELSE
         SIG=SIGSQ
      END IF
Cdjwmar99]
      RETURN
      END
CODE FOR XSQRF
      SUBROUTINE XSQRF (FSQ,FSIGN,FABS,SIGSQ,SIG)
C----- RETURN THE SIGNED STRUCTURE AMPLITUDE AND THE CORRESPONDING SIGMA
C      FROM A SIGNED STRUCTURE FACTOR
C      FSQ  OUTPUT AMPLITUDE
C      FSIGN INPUT SIGNED MAGNITUDE
C      FABS  DUMMY
C      SIGSQ OUTPUT SIGMA SQ
C      INPUT SIGMA
\XCONST
      FSQ=FSIGN*ABS(FSIGN)
      IF (SIG.GT.ZERO) THEN
C----- WE HAVE SOME KIND OF SIGMA - TRY TO SCALE IT
         IF (ABS(FSIGN).GT.1.) THEN
            SIGSQ=SIG*(2.*ABS(FSIGN))
         ELSE
            SIGSQ=SIG
         END IF
      ELSE
         SIGSQ=SIG
      END IF
      RETURN
      END
Cdjwnov99]
CODE FOR MSCALE
      FUNCTION MSCALE (IPOINT)
C--CONTROL ROUTINE FOR INPUT GENERATED BY THE HILGER-WATTS DATA REDUCTIO
C  PROGRAM.
C
C  IPOINT  THE CALL CONTROL VALUE :
C
C          -1  INITIALISE.
C           0  PROCESS.
C
C--RETURN VALUES OF 'MSCALE' ARE :
C
C  -1  NO REFLECTION READ.
C   0  REFLECTION READ.
C
C--
\ISTORE
\ICOM30
C
      CHARACTER*24 CCAPT
C
\XCONST
\STORE
\XWORKA
\XLST06
\XLST6A
\XLST27
\XLST30
\XUNITS
\XSSVAL
C
\QSTORE
C
      EQUIVALENCE (JD,SCALE), (JE,GRAD), (IH,JF), (IK,JG)
\QLST30
C
      SAVE
C
C
      DATA CCAPT/'Correction is zero'/
C
C--ASSIGN THE RETURN VALUE
      MSCALE=0
C--CHECK THE CALL TYPE
      IF (IPOINT) 50,700,700
C--CHECK IF A LIST 27 IS PRESENT
50    CONTINUE
      SCALE=1.0
      IF (NSCALE) 150,150,100
C--SCALING IS INDICATED  -  CHECK FOR A LIST 27
100   CONTINUE
      IF (KEXIST(27)) 150,150,300
C--NO LIST 27 THAT CAN BE USED
150   CONTINUE
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,200)
      END IF
200   FORMAT (/,' No scales found')
      N27=-1
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,250) SCALE
      END IF
250   FORMAT (/,' A scale of',F10.5,'  has been assumed',/)
      GO TO 650
C--LOAD LIST 27 FROM THE DISC
300   CONTINUE
      CALL XFAL27
      IF (IERFLG.LT.0) GO TO 1250
C--SET THE POINTERS TO THE SECOND SCALE
      M27=L27+MD27
C--CHECK IF ANY SCALES ARE PRESENT TO USE
      IF (N27-2) 350,450,450
C--NO SCALES IN LIST 27
350   CONTINUE
      I=0
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,400) I,I
      END IF
400   FORMAT (/' Scales exhausted after',I6,'  reflection(s)',5X,'(At re
     1flection',I6,')')
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,250) SCALE
      END IF
      GO TO 650
C--CALCULATE A FEW CONSTANTS
450   CONTINUE
C----- LOAD DATA IF LIST 30 NOT ALREADY IN CORE
      IF (KHUNTR(30,0,IADDL,IADDR,IADDD,-1).LT.0) CALL XFAL30
      IF (IERFLG.LT.0) GO TO 550
      ATMP=-1000000.
      BTMP=1000000.
      M27TMP=L27+NSCALE
      DO 500 I=1,N27
         ATMP=MAX(ATMP,STORE(M27TMP))
         BTMP=MIN(BTMP,STORE(M27TMP))
         M27TMP=M27TMP+MD27
500   CONTINUE
      STORE(L30CD+8)=100.*(ATMP-BTMP)/ATMP
      CALL XWLSTD (30,ICOM30,IDIM30,-1,-1)
550   CONTINUE
C
      JA=NINT(STORE(L27+3))
      JB=NINT(STORE(M27+3))
      IH=L27+NSCALE
      IK=M27+NSCALE
      GRAD=0.0
C--CHECK THE SERIAL NUMBERS OF THE FIRST TWO SCALES
      IF (JB-JA) 650,650,600
C--COMPUTE THE INITIAL GRADIENT
600   CONTINUE
      GRAD=(STORE(IK)-STORE(IH))/(STORE(M27+3)-STORE(L27+3))
C--AND NOW RETURN AFTER THE INITIALISATION
650   CONTINUE
      RETURN
C
C--APPLY THE SCALE FACTORS IF NECESSARY
700   CONTINUE
      JC=NINT(STORE(M6+19))
C--CHECK IF THERE ARE SCALES WE CAN USE
      IF (N27) 1150,1150,750
750   CONTINUE
      IF (JA-JC) 850,800,900
800   CONTINUE
      IF (JB-JC) 1100,900,1100
850   CONTINUE
      IF (JB-JC) 900,900,1100
C--INCREMENT THE SCALE POSITION
900   CONTINUE
      L27=M27
      M27=L27+MD27
      N27=N27-1
C----- REMEMBER - M27 LOOKS ONE AHEAD
      IF (N27-1) 950,950,1000
950   CONTINUE
      I=NINT(STORE(M6+19))
      JA=N6W+N6DEAD+1
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,400) I,JA
      END IF
      IF (ISSPRT.EQ.0) THEN
         WRITE (NCWU,250) SCALE
      END IF
C--COMPUTE THE NEW CONSTANTS
      GO TO 1150
1000  CONTINUE
      JA=JB
      JB=NINT(STORE(M27+3))
      IH=L27+NSCALE
      IK=M27+NSCALE
      GRAD=0.0
      IF (JB-JA) 750,750,1050
1050  CONTINUE
      GRAD=(STORE(IK)-STORE(IH))/(STORE(M27+3)-STORE(L27+3))
      GO TO 750
C--COMPUTE THE SCALE AT THIS POINT
1100  CONTINUE
      SCALE=STORE(IH)+GRAD*(STORE(M6+19)-STORE(L27+3))
C--CALCULATE /FO/ AND THE OTHER TERMS
1150  CONTINUE
      STORE(M6+27)=SQRT(SCALE*WFACT(I))
C--CHECK THE MULTIPLIER
      IF (STORE(M6+27)-ZERO) 1200,1200,650
C--THIS MULTIPLIER IS NOT BIG ENOUGH
1200  CONTINUE
      CALL XL6RRP (N6DEAD,1000,IFO,CCAPT)
      MSCALE=-1
      GO TO 650
1250  CONTINUE
C -- ERRORS
      MSCALE=-1
      RETURN
      END
CODE FOR WFACT
      FUNCTION WFACT (IN)
C--COMPUTE THE OVERALL MULTIPLIER TO CONVERT I'S TO /FO/ **2'S
C
C  IN  DUMMY ARGUMENT
C
C--THE ADDRESSES OF THE COEFFICIENTS ARE GIVEN IN THE STACK
C  AT 'LFACT', AND THERE ARE 'MDFACT' OF THEM
C
C--
\ISTORE
C
\STORE
\XLST06
\XLST6A
C
\QSTORE
C
      IDWZAP=IN
C--SET THE INITIAL VALUE
      AFACT=1.
C--CHECK IF THERE ARE ANY COEEFICIENTS REQUIRED
      IF (MDFACT) 150,150,50
C--LOOP OVER THE REQUIRED COEFFICIENTS
50    CONTINUE
      MFACT=LFACT
      DO 100 J=1,MDFACT
         K=ISTORE(MFACT)+M6
         AFACT=AFACT*STORE(K)
         MFACT=MFACT+1
100   CONTINUE
150   CONTINUE
      WFACT=AFACT
      RETURN
      END
CODE FOR KRD06
      FUNCTION KRD06 (A,N,IEOFLG)
C--FREE FORMAT READ ROUTINE USED DURING THE INPUT OF LIST 6
C
C  A       THE ARRAY TO BE FILLED.
C  N       THE NUMBER OF NUMBERS TO BE READ.
C  IEOFLG  THE FLAG TO INDIATE HOW END OF FILE IS TO BE TREATED :
C
C          -1  END OF FILE IS ACCEPTABLE NOW AND CAN BE PROCESSED.
C           0  END OF FILE IS ILLEGAL HERE.
C
C--RETURN VALUES ARE :
C
C  -1  END OF FILE DETECTED BEFORE THE FIRST REFLECTION.
C   0  DATA READ OKAY.
C  +1  ERRORS HAVE OCCURRED, WHICH INCLUDE SPURIOUS CHARACTERS AND END O
C      IN THE MIDDLE OF THE DATA.
C
C--
C
      DIMENSION A(N)
C
\XUNITS
\XSSVAL
\XCARDS
\XCHARS
\XLISTI
\XLST6A
C
C--MARK THE RETURN VALUE AS OKAY ORIGINALLY
      KRD06=0
C--LOOP OVER EACH NUMBER TO BE READ
      DO 750 I=1,N
C--SEARCH FOR THE NEXT NON-BLANK CHARACTER
50       CONTINUE
         NC=KNEQUL(NC,IB)
C--CHECK FOR END OF CARD
         IF (NC) 100,100,200
C--END OF THE CARD  -  READ THE NEXT
100      CONTINUE
         READ (IUNIT,150,END=500) IMAGE
150      FORMAT (256A1)
         NCARDS=NCARDS+INCREM
         NC=1
         GO TO 50
C--READ THE NEXT NUMBER OFF THIS CARD
200      CONTINUE
         IF (KINPUT(A(I))) 250,750,250
C--SPURIOUS CHARACTER IN THE DATA
250      CONTINUE
         CALL XERHDR (0)
         WRITE (NCAWU,350) NCARDS,IMAGE,(IB,J=1,NC),IA
         WRITE (NCAWU,300)
         IF (ISSPRT.EQ.0) THEN
            WRITE (NCWU,350) NCARDS,IMAGE,(IB,J=1,NC),IA
            WRITE (NCWU,300)
         END IF
300      FORMAT (/,' Marked by an ''*''')
350      FORMAT (' Spurious character on record ',I5,'  : ',80A1/38X,
     1    81A1)
C--GENERAL ERROR RETURN FROM THIS ROUTINE
400      CONTINUE
         IF (ISSPRT.EQ.0) THEN
            WRITE (NCWU,450) LN,IUNIT
         END IF
         WRITE (NCAWU,450) LN,IUNIT
450      FORMAT (/,' Input of list ',I5,'  on unit ',I5,'  fails')
         KRD06=1
         GO TO 800
C--END OF FILE DETECTED  -  CHECK IF THIS IS THE NORMAL INPUT UNIT
500      CONTINUE
         KRD06=-1
         IF (IUNIT-NCRU) 600,550,600
C--NORMAL INPUT UNIT  -  FLAG END OF FILE
550      CONTINUE
         IEOF=-1
C--CHECK IF END OF FILE IS ALLOWED HERE
600      CONTINUE
         IF (IEOFLG) 800,650,650
C--ILLEGAL END OF FILE
650      CONTINUE
         CALL XERHDR (0)
         IF (ISSPRT.EQ.0) THEN
            WRITE (NCWU,700) NCARDS
         END IF
         WRITE (NCAWU,700) NCARDS
700      FORMAT (' End of file detected after ',I5,' records, in the mid
     1dle of a reflection'/'Check that all columns are separated by at l
     2east 1 space')
         GO TO 400
750   CONTINUE
C--AND NOW RETURN
800   CONTINUE
      RETURN
      END
