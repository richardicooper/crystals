C $Log: not supported by cvs2svn $
C
CODE FOR XSORT
      SUBROUTINE XSORT
C--TREE SORT WITH PRUNING OF TOP BRANCHES
C
C--CONTROL VARIABLES IN THIS ROUTINE ARE :
C
C  IULN    THE LIST TYPE TO BE SORTED.
C  MEDIUM  THE OUTPUT MEDIUM REQUIRED.
C
C          -1  M/T
C           0  SAME AS BEFORE.
C          +1  DISC.
C
C--THIS ROUTINE ALWAYS OUTPUTS TO M/T INITIALLY, AND THEN REWRITES IF
C  NECESSARY.
C
C--
\ISTORE
\TYPE11
\ISORT
C
      CHARACTER*2 CPASS(2)
      DIMENSION PROCS(2)
C
\STORE
\XSTR11
\XSIZES
\XSORT
\XWORK
\XUNITS
\XSSVAL
\XLST06
\XTAPES
\XTAPED
\XERVAL
\XOPVAL
\XIOBUF
C
\QSORT
\QSTR11
\QSTORE
C
      EQUIVALENCE (PROCS(1),IULN),(PROCS(2),MEDIUM)
C
C
      DATA CPASS / '  ' , 'es' /
C
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ THE CONTROL DATA
      IF (  KRDDPV ( PROCS(1) , 2 )  .LT.  0  ) GO TO 9910
      IULN=KTYP06(IULN)
C--CLEAR THE STORE
      CALL XRSL
      CALL XCSAE
C--SET UP THE LIST 6 TRANSFER
      CALL XFLT06(IULN,0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--CHECK THE TYPE OF OUTPUT MEDIUM
      IF(MEDIUM)1150,1100,1150
C--SAME AS BEFORE  -  SET THE 'MEDIUM' FLAG
1100  CONTINUE
      MEDIUM=ISIGN(1,L6D)
C--SET UP THE OUTPUT PROCESSING
1150  CONTINUE
      CALL XSTR06(IULN,-1,0,1,0)
C--SET THE CONSTANTS
      NW=MD6R
      NN=N6R
C--PRESERVE THE READ FLAGS
      L6TEMP=L6R
      N6TEMP=N6R
C--SET A FEW SEARCH CONSTANTS
      MHD=0
      LRM=1000000
      MH=-1000000
      NR=0
C--SET THE CORE LIMITS
      N1 = 1
      N2 = ISIZ11
      IBASE=N1
      LA=N2
      NWR=NW+2
      IPASS=0
C--START PASSAGE THROUGH THE REFLECTIONS
1200  CONTINUE
      L6R=L6TEMP
      N6R=N6TEMP
C--CHECK FOR INPUT ON M/T
      IF(L6R)1250,1300,1300
C--RESET THE M/T DETAILS
1250  CONTINUE
      REWIND MTA
      MMTR=NMTR
C--SET UP THE LINKED SORT AREA
1300  CONTINUE
      IF ( MH .EQ. MHD ) GO TO 9920
      IPASS=IPASS+1
      MHD=MH
      MIH=1000000
      I=IBASE
      ISORT(I)=LRM
      ISORT(I+1)=I
      NRL=I+NWR
      I=NRL
1500  CONTINUE
      ISORT(I)=0
      J=I
      I=I+NWR
      IF(I-LA+NWR)1550,1550,1600
1550  CONTINUE
      ISORT(J+1)=I
      GOTO 1500
1600  CONTINUE
      ISORT(J+1)=IBASE
C--PICK UP THE NEXT REFLECTION
1650  CONTINUE
      IF(KLDRNR(I))2650,1700,1700
C--FIX THE INDICES
1700  CONTINUE
      IL=NINT(STORE(M6))
      IK=NINT(STORE(M6+1))
      IH=NINT(STORE(M6+2))
C--CHECK THIS INDEX AGAINST THE HIGHEST PROCESSED SO FAR
      IF(IH-MH)1650,1650,1800
C--BEGIN SHUFFLE THROUGH THE TREE, STARTING WITH H
1800  CONTINUE
      IF(IH-MIH)1850,1650,1650
C--START THE PASS THROUGH THE H STACK
1850  CONTINUE
      J=IBASE
      GOTO 1950
C--RECORD THE LAST H ADDRESS AND CHECK THIS VALUE
1900  CONTINUE
      J=I
1950  CONTINUE
      I=ISORT(J+1)
      IF(ISORT(I)-IH)1900,2000,2200
C--WE HAVE AN ENTRY FOR THIS H VALUE
2000  CONTINUE
      I=I+1
C--CHECK THE VALUE OF K
2050  CONTINUE
      J=I
      I=ISORT(I+1)
      IF(ISORT(I)-IK)2050,2100,2350
2100  CONTINUE
      I=I+1
C--CHECK THE VALUE OF L
2150  CONTINUE
      J=I
      I=ISORT(I+1)
      IF(ISORT(I)-IL)2150,2500,2500
C
C--INSERT A NEW VALUE OF H  -  CHECK IF THERE IS A FREE BLOCK
2200  CONTINUE
      IF(ISORT(NRL)-LRM)2300,2250,2300
C--FIND THE NEXT FREE BLOCK BY DELETING AN H BRANCH
2250  CONTINUE
      IF(KPRUNE(I))1650,2300,1650
C--TAKE THE NEXT FREE BLOCK AND INSERT THIS VALUE OF H
2300  CONTINUE
      I=ISORT(J+1)
      ISORT(J+1)=NRL
      J=NRL
      NRL=ISORT(J+1)
      ISORT(J)=IH
      ISORT(J+1)=I
      ISORT(J+2)=IBASE
      J=J+1
      I=IBASE
C--INSERT A NEW VALUE OF K  -  CHECK IF THERE IS FREE BLOCK
2350  CONTINUE
      IF(ISORT(NRL)-LRM)2450,2400,2450
C--FIND A FREE BLOCK BY DELETING AN H BRANCH
2400  CONTINUE
      IF(KPRUNE(I))1650,2450,1650
C--LINK IN THIS VALUE OF K
2450  CONTINUE
      ISORT(J+1)=NRL
      J=NRL
      NRL=ISORT(J+1)
      ISORT(J)=IK
      ISORT(J+1)=I
      ISORT(J+2)=IBASE
      J=J+1
      I=IBASE
C--INSERT A NEW VALUE OF L  -  CHECK IF THERE IS FREE BLOCK FOR THIS L
2500  CONTINUE
      IF(ISORT(NRL)-LRM)2600,2550,2600
C--FIND A BLOCK BY DELETING AN H BRANCH
2550  CONTINUE
      IF(KPRUNE(I))1650,2600,1650
C--INSERT THIS VALUE OF L
2600  CONTINUE
      ISORT(J+1)=NRL
      J=NRL
      NRL=ISORT(J+1)
      ISORT(J)=IL
      ISORT(J+1)=I
C--STORE THE INPUT INFORMATION FOR THIS REFLECTION
      CALL XMOVE(STORE(M6R),SORT(J+2),MD6R)
      GOTO 1650
C
C--SORT OUT THE TREE
C  I  CURRENT H ADDRESS
C  J  CURRENT K ADDRESS
C  K  CURRENT L ADDRESS
C--
2650  CONTINUE
      I=IBASE
      GOTO 3100
C--FETCH FIRST L FOR THIS K BRANCH
2700  CONTINUE
      K=ISORT(J+2)
      GOTO 2800
C--FETCH NEXT L FOR THIS BRANCH
2750  CONTINUE
      K=ISORT(K+1)
C--CHECK FOR THE END OF THIS L CHAIN
2800  CONTINUE
      IF(ISORT(K)-LRM)2850,2950,2850
2850  CONTINUE
      NR=NR+1
C--MOVE THE DATA TO THE OUTPUT M/T BUFFER
      CALL XMOVE(SORT(K+2),STORE(MMTW),MD6W)
      CALL XIMTWA(MTB)
      N6W=N6W+1
      GOTO 2750
C--FETCH FIRST K FOR THIS H BRANCH
2900  CONTINUE
      J=ISORT(I+2)
      GOTO 3000
C--FETCH THE NEXT K FOR THIS BRANCH
2950  CONTINUE
      J=ISORT(J+1)
3000  CONTINUE
      IF(ISORT(J)-LRM)2700,3050,2700
C--FIND THE NEXT H BRANCH
3050  CONTINUE
      MH=MAX0(MH,ISORT(I))
3100  CONTINUE
      I=ISORT(I+1)
      IF(ISORT(I)-LRM)2900,3150,2900
3150  CONTINUE
      I=MIN0(IPASS,2)
      IF (ISSPRT .EQ. 0)WRITE ( NCWU, 3200 ) IPASS, CPASS(I), NR
      WRITE ( CMON, 3200 ) IPASS , CPASS(I) , NR
      CALL XPRVDU(NCVDU, 1,0)
      WRITE ( NCAWU , 3200 ) IPASS , CPASS(I) , NR
3200  FORMAT ( 1X , 'After ' , I3 , ' pass' , A , I6 ,
     2 ' reflection(s) have been sorted' )
      IF(NR-NN)1200,3250,3250
C--END OF THE REFLECTION PROCESSING
3250  CONTINUE
      CALL XERT(IULN)
C--CHECK IF WE SHOULD WRITE THE DATA TO DISC
      CALL XSWP06(IULN,MEDIUM)
3270  CONTINUE
      CALL XOPMSG ( IOPSOR , IOPEND , 500 )
      CALL XTIME2(2)
      CALL XRSL
      CALL XCSAE
      RETURN
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPSOR , IOPABN , 0 )
      GO TO 3270
9910  CONTINUE
C -- INPUT ERRORS
      CALL XOPMSG ( IOPSOR , IOPCMI , 0 )
      GO TO 9900
9920  CONTINUE
C -- NOT ENOUGH SPACE
      I = NN - NR
      IF (ISSPRT .EQ. 0) THEN
      WRITE ( NCWU , 9925 ) I
      ENDIF
      WRITE ( NCAWU , 9925 ) I
      WRITE ( CMON, 9925 ) I
      CALL XPRVDU(NCVDU, 1,0)
9925  FORMAT ( 1X , I5 , ' reflections have been lost' )
      CALL XOPMSG ( IOPSOR , IOPSPC , 0 )
      GO TO 9900
      END
C
CODE FOR KPRUNE
      FUNCTION KPRUNE(IN)
C--THESE ROUTINES REMOVE 'H' BRANCHES FROM THE TREE WHEN MORE CORE
C  IS NEEDED
C
C--RETURNS EQUAL TO ZERO UNLESS THE PRESENT REFLECTION CANNOT BE
C  INCLUDED
C
C--
\ISTORE
\TYPE11
\ISORT
C
\STORE
\XSTR11
\XSIZES
\XSORT
C
\QSTORE
\QSTR11
\QSORT
C
      KPRUNE=0
      L=IBASE
      GOTO 1050
C--RECORD THE ADDRESS OF THE LAST TWO ELEMENTS IN THE STACK
1000  CONTINUE
      M=L
      L=K
C--CHECK FOR THE END OF THE H CHAIN
1050  CONTINUE
      K=ISORT(L+1)
      IF(ISORT(K)-LRM)1000,1100,1000
C--CHECK IF THE H VALUE WE WANT TO DELETE IS THE ONE WE WANT TO USE
1100  CONTINUE
      IF(IH-ISORT(L))1200,1150,1150
1150  CONTINUE
      KPRUNE=-1
C--REMOVE THE LAST H VALUE
1200  CONTINUE
      MIH=ISORT(L)
      NRL=L
      ISORT(M+1)=K
      M=ISORT(L+2)
      GOTO 1350
C--FORM THE L BRANCHES INTO A LINEAR ROW IN THE FREE BLOCK CHAIN
1250  CONTINUE
      L=K
1300  CONTINUE
      K=ISORT(L+1)
      IF(ISORT(K)-LRM)1250,1350,1250
C--CHECK IF THIS IS THE END OF THE K CHAIN
1350  CONTINUE
      IF(ISORT(M)-LRM)1400,1450,1400
C--PICK UP THE L CHAIN FOR THIS K VALUE
1400  CONTINUE
      ISORT(L+1)=M
      L=M
      M=ISORT(L+1)
      ISORT(L+1)=ISORT(L+2)
      GOTO 1300
1450  CONTINUE
      RETURN
      END
C
CODE FOR XREORD
      SUBROUTINE XREORD
C--REORDER THE REFLECTIONS IN LIST 6 FOR THE S.F.L.S ROUTINES
C
C--IF THE DATA ARE NOT TWINNED, REFLECTIONS WHICH COME FROM THE SAME
C  GROUP OF EQUIVALENT INDICES ARE BROUGHT TOGETHER IN LIST 6.
C
C--FOR TWINNED DATA LIST 25 IS USED, AND IN THIS CASE
C  OVERLAPPED REFLECTIONS WITH COMMON GROUPS OF INDICES ARE BROUGHT
C  TOGETHER TO SAVE TIME DURING S.F.L.S.
C
C--
\ISTORE
C
C
      DIMENSION PROCS(2)
C
\STORE
\XLISTI
\XCONST
\XUNITS
\XSSVAL
\XLST01
\XLST02
\XLST06
\XLST13
\XLST25
\XERVAL
\XOPVAL
\XIOBUF
C
\QSTORE
C
C
      EQUIVALENCE (PROCS(1),IULN),(PROCS(2),MEDIUM)
C
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ ANY NECESSARY DATA
      IF (  KRDDPV ( PROCS(1) , 2 )  .LT.  0  ) GO TO 9910
      IULN=KTYP06(IULN)
      CALL XRSL
      CALL XCSAE
C--LOAD LISTS ONE AND TWO
      CALL XFAL01
      CALL XFAL02
C--SET THE FRIEDEL LAW FLAG
      IFRIED=2
C--FIND THE TWIN FLAG
      CALL XFAL13
      ITWIN=ISTORE(L13CD+1)
C--SET UP DEFAULT VALUES FOR LIST 25
      L25=NOWT
      M25=NOWT
      MD25=0
      N25=0
C--CHECK IF WE SHOULD USE LIST 25  (TWINNED STRUCTURE)
      IF(ITWIN)1150,1100,1100
C--WE SHOULD USE LIST 25
1100  CONTINUE
      CALL XFAL25
C--SET UP LIST 6 FOR INPUT AND SUBSEQUENT OUTPUT
1150  CONTINUE
      CALL XFLT06(IULN,0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C----- CHECK IF THE DATA IS REALLY ON DISK
      IF (L6R .LE. 0) GOTO 9930
C--CHECK THE TYPE OF OUTPUT MEDIUM
      IF(MEDIUM)1250,1200,1250
C--SAME AS BEFORE  -  SET THE 'MEDIUM' FLAG
1200  CONTINUE
      MEDIUM=ISIGN(1,L6R)
C--SET UP THE OUTPUT PROCESSING
1250  CONTINUE
      CALL XSTR06(IULN,-1,0,1,0)
C--PRESERVE THE LIST 6 MARKERS
      KZ=L6R
      KY=N6R
C--SET UP THE CORE AREA FOR THE POINTERS TO 'KL' PAIRS
      M6DTLK=L6DTL+MD6DTL
      KA=NINT(STORE(M6DTLK))
      KB=(NINT(STORE(M6DTLK+1))-KA+1)*2
      M6DTLL=M6DTLK+MD6DTL
      KC=NINT(STORE(M6DTLL))
      KD=NINT(STORE(M6DTLL+1))-KC+1
      KE=NFL
      LN=6
      IREC=2001
      KF=KCHNFL(KB*KD)-2
C--INITIALISE THE 'KL' TABLE
      DO 1300 I=KE,KF,2
      ISTORE(I)=-1
      ISTORE(I+1)=0
1300  CONTINUE
      A=-550000.
      B=-550000.
C--SET THE FINISHED VALUE FLAG
      Y=2.*ZEROSQ
C
C--START OF THE LOOP TO FIND ALL THE 'KL' PAIRS
C
C--FETCH THE NEXT REFLECTION
1350  CONTINUE
      IF (N6R .LE. 0) GOTO 1900
      KH=L6R
C--CHECK IF THIS VALUE IS EQUAL TO 'Y'
      CALL XDOWNF(KH,STORE(NFL),1)
      IF(ABS(STORE(NFL)-Y)-ZEROSQ)1400,1500,1500
C--THIS VALUE IS NOT OKAY
1400  CONTINUE
      CALL XERHDR(0)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1450)Y
      ENDIF
      WRITE ( CMON,1450 ) Y
      CALL XPRVDU(NCEROR, 1,0)
1450  FORMAT(' First word of a reflection is ',E15.10)
      CALL XERHND ( IERCAT )
C--LOAD THE COMPLETE REFLECTION
1500  CONTINUE
      IF(KLDRNR(1))1900,1550,1550
C--CHECK IF 'K' HAS CHANGED
1550  CONTINUE
      IF(ABS(STORE(M6+1)-A)-0.5)1600,1700,1700
C--CHECK IF 'L' HAS CHANGED
1600  CONTINUE
      IF(ABS(STORE(M6+2)-B)-0.5)1650,1700,1700
C--STILL THE SAME 'KL' PAIR  -  INCREMENT THE TOTAL
1650  CONTINUE
      ISTORE(KG+1)=ISTORE(KG+1)+1
      GOTO 1350
C--NEW 'KL' PAIR
1700  CONTINUE
      KG=(NINT(STORE(M6+2))-KC)*KB+(NINT(STORE(M6+1))-KA)*2+KE
C--CHECK IF WE HAVE MET THIS 'KL' PAIR BEFORE
      IF ( ISTORE(KG + 1) .NE. 0 ) GO TO 9920
      ISTORE(KG)=KH
      A=STORE(M6+1)
      B=STORE(M6+2)
      GOTO 1650
C--END OF THE SEARCH FOR 'KL' PAIRS
1900  CONTINUE
      L6R=KZ
      N6R=KY
C
C--START OF THE SORT LOOP
C
C--CHECK IF THIS REFLECTION HAS ALREADY BEEN USED
1950  CONTINUE
      IF (N6R .LE. 0) GOTO 3000
      CALL XDOWNF(L6R,STORE(NFL),1)
      IF(ABS(STORE(NFL)-Y)-ZEROSQ)2000,2050,2050
C--THIS REFLECTION HAS ALREADY BEEN USED  -  SKIP IT
2000  CONTINUE
      IF(KLDRNR(1))3000,1950,1950
C--FETCH THE NEXT REFLECTION
2050  CONTINUE
      KH=L6R
      IF(KLDRNR(1))3000,2100,2100
C--MARK THE REFLECTION AS USED
2100  CONTINUE
      STORE(NFL)=Y
      CALL XUPF(KH, ISTORE(NFL),1)
C--TRANSFER THE REFLECTION TO THE M/T BUFFER AND OUTPUT IT TO TAPE
      IN = 0
      CALL XSLR(IN)
C--PREPARE TO PASS THROUGH LIST 2 AND 25
      KS=N25
      A=STORE(M6)
      B=STORE(M6+1)
      C=STORE(M6+2)
C--CHECK IF THIS IS A TWINNED STRUCTURE
      IF(ITWIN)2350,2150,2150
C--FETCH THE ELEMENTS FOR THIS REFLECTION
2150  CONTINUE
      I=NINT(STORE(M6+11))
      J=I/10
C--CHECK IF THIS REFLECTION HAS ONLY ONE ELEMENT
      IF(J)1950,1950,2200
C--THIS REFLECTION HAS MORE THAN ONE ELEMENT
2200  CONTINUE
      I=J
      J=I/10
      IF(J)2250,2250,2200
C--'I' NOW HOLDS THE ELEMENT IN WHICH THE INDICES ARE GIVEN
2250  CONTINUE
      M25I=(I-1)*MD25I+L25I
C--CALCULATE THE INDICES IN THE STANDARD SETTING
      D=STORE(M25I)*STORE(M6)+STORE(M25I+1)*STORE(M6+1)+STORE(M25I+2)
     2 *STORE(M6+2)
      E=STORE(M25I+3)*STORE(M6)+STORE(M25I+4)*STORE(M6+1)+STORE(M25I+5)
     2 *STORE(M6+2)
      F=STORE(M25I+6)*STORE(M6)+STORE(M25I+7)*STORE(M6+1)+STORE(M25I+8)
     2 *STORE(M6+2)
C--PASS THROUGH THE VARIOUS TWIN TRANSFORMATION MATRICES
      M25=L25
C--COMPUTE THE TRANSFORMED INDICES
2300  CONTINUE
      A=STORE(M25)*D+STORE(M25+1)*E+STORE(M25+2)*F
      B=STORE(M25+3)*D+STORE(M25+4)*E+STORE(M25+5)*F
      C=STORE(M25+6)*D+STORE(M25+7)*E+STORE(M25+8)*F
C--PASS THROUGH THE SYMMETRY POSITIONS, GENERATING ALL THE EQUIVALENTS
2350  CONTINUE
      M2=L2
      DO 2950 KT=1,N2
      O=STORE(M2)*A+STORE(M2+3)*B+STORE(M2+6)*C
      P=STORE(M2+1)*A+STORE(M2+4)*B+STORE(M2+7)*C
      Q=STORE(M2+2)*A+STORE(M2+5)*B+STORE(M2+8)*C
C--LOOP OVER THE FRIEDEL PAIRS
      DO 2900 KU=1,IFRIED
C--CHECK THE COMPUTED INDICES AGAINST THE LIMITS IN LIST 28
      IF(P-STORE(M6DTLK)+0.5)2850,2850,2400
2400  CONTINUE
      IF(P-STORE(M6DTLK+1)-0.5)2450,2850,2850
C--CHECK THE COMPUTED VALUE OF 'L'
2450  CONTINUE
      IF(Q-STORE(M6DTLL)+0.5)2850,2850,2500
2500  CONTINUE
      IF(Q-STORE(M6DTLL+1)-0.5)2550,2850,2850
C--COMPUTE THE LOOK UP ADDRESS
2550  CONTINUE
      KG=(NINT(Q)-KC)*KB+(NINT(P)-KA)*2+KE
      N=ISTORE(KG+1)
C--CHECK IF THERE ARE ANY REFLECTIONS TO COMPARE
      IF(N)2850,2850,2600
C--BEGIN COMPARING THE TRANSFORMED 'H' VALUES
2600  CONTINUE
      M=L6R
      L6R=ISTORE(KG)
      MM=N6R
      N6R=N+1
      DO 2800 KV=1,N
      IF (L6R .LE. 0) GOTO 2800
      K=L6R
C--FETCH THE NEXT REFLECTION WITH THIS VALUE OF 'K' AND 'L'
      IF(KLDRNR(1))2800,2650,2650
C--CHECK IF THIS REFLECTION HAS BEEN USED BEFORE
2650  CONTINUE
      CALL XDOWNF(K,STORE(NFL),1)
      IF(ABS(STORE(NFL)-Y)-ZEROSQ)2800,2700,2700
C--CHECK THE VALUE OF H
2700  CONTINUE
      IF(ABS(STORE(M6)-O)-0.5)2750,2800,2800
C--THE REQUIRED VALUE OF 'H' HAS BEEN FOUND
2750  CONTINUE
      IN = 0
      CALL XSLR(IN)
C--MARK THE REFLECTION AS USED
      STORE(NFL)=Y
      CALL XUPF(K, ISTORE(NFL),1)
2800  CONTINUE
C--RESET THE POINTER TO LIST 6 TO FETCH THE NEXT REFLECTION
      L6R=M
      N6R=MM
C--INVERT THE COMPUTED INDICES FOR FRIEDEL'S LAW
2850  CONTINUE
      O=-O
      P=-P
      Q=-Q
2900  CONTINUE
C--CHANGE SYMMETRY POSITIONS
      M2=M2+MD2
2950  CONTINUE
C--INCREMENT TO THE NEXT TRANSFORMATION MATRIX
      M25=M25+MD25
      KS=KS-1
C--CHECK IF WE SHOULD CHECK ANY MORE FOR THIS REFLECTION
      IF(KS)1950,1950,2300
C
C--END OF THE REFLECTION FETCHING LOOP
3000  CONTINUE
      CALL XERT(IULN)
C--COPY THE DATA TO THE OUTPUT MEDIUM IF NEC.
      CALL XSWP06(IULN,MEDIUM)
C--TERMINATION MESSGES
3020  CONTINUE
      CALL XOPMSG ( IOPREO , IOPEND , 200 )
      CALL XTIME2(2)
      CALL XRSL
      CALL XCSAE
      RETURN
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPREO , IOPABN , 0 )
      GO TO 3020
9910  CONTINUE
C -- INPUT ERRORS
      CALL XOPMSG ( IOPREO , IOPCMI , 0 )
      GO TO 9900
9920  CONTINUE
      WRITE(NCAWU,9925)
      WRITE ( CMON, 9925)
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU ,9925)
      ENDIF
9925  FORMAT ( 1X , 'The data need sorting' )
      CALL XERHND ( IERERR )
      GO TO 9900
9930  CONTINUE
      WRITE(NCAWU,9935)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU ,9935)
      WRITE ( CMON, 9935 )
      CALL XPRVDU(NCVDU, 3,0)
      ENDIF
9935  FORMAT ( 1X, 'The previous instruction should have left the data',
     1 / ' on the disc. Include a line STORE MEDIUM=DISK  or ', /
     2 ' a call to #LIST 6 with READ TYPE= COPY '  )
      CALL XERHND ( IERERR )
      GO TO 9900
      END
C
CODE FOR XSHELQ
      SUBROUTINE XSHELQ(STORE,NW,IPOS,NITEM,IDIMN,ABUFF)
C--IN CORE SHELL SORT ROUTINE, SORTING INTO ASCENDING ORDER.
C
C  STORE   THE ARRAY HOLDING THE DATA TO BE SORTED.
C  NW      THE NUMBER OF WORDS PER ITEM.
C  IPOS    THE POSITION OF THE ITEM TO BE SORTED (1 TO 'NW').
C  IDIMN    THE DIMENSION OF 'STORE'.
C  NITEM   THE NUMBER OF ITEMS TO BE SORTED.
C  ABUFF   A BUFFER OF LENGTH 'NW'.
C
C--
C
      DIMENSION STORE(IDIMN),ABUFF(NW)
C
C--COMPUTE THE INITIAL STEP LENGTH
      NSTEP=1
      DO 1050 I=1,NITEM
      J=3*NSTEP+1
      IF(J-NITEM)1050,1100,1100
1050  CONTINUE
C--ENSURE THAT THE STEP LENGTH IS NOT TOO LARGE
1100  CONTINUE
      NSTEP=MAX0(NSTEP,13)
C--COMPUTE THE LAST USED ADDRESS
      LAST=(NITEM-1)*NW+IPOS
C--LOOP OVER EACH SEARCH VALUE
1150  CONTINUE
      NSTEPC=MAX0(1,NSTEP-1)
      NCW=NSTEPC*NW
      L=IPOS
      DO 1450 M=1,NSTEPC
      K=L
      GOTO 1250
1200  CONTINUE
      K=K+NCW
1250  CONTINUE
      I=K
      J=I+NCW
      IF(J-LAST)1300,1300,1400
1300  CONTINUE
      IF(STORE(J)-STORE(I))1350,1200,1200
C--INTER-CHANGE ENTRIES
1350  CONTINUE
      I0=I-IPOS
      J0=J-IPOS
      CALL XMOVE(STORE(I0+1),ABUFF(1),NW)
      CALL XMOVE(STORE(J0+1),STORE(I0+1),NW)
      CALL XMOVE(ABUFF(1),STORE(J0+1),NW)
      J=I
      I=I-NCW
      IF(I)1200,1200,1300
1400  CONTINUE
      L=L+NW
1450  CONTINUE
      NSTEP=(NSTEP-1)/3
      IF(NSTEP)1500,1500,1150
1500  CONTINUE
      RETURN
      END
C
CODE FOR XSHELR
      SUBROUTINE XSHELR(STORE,NW,IPOS,NITEM,IDIMN,ABUFF)
C--IN CORE SHELL SORT ROUTINE, SORTING INTO DESCENDING ORDER.
C
C  STORE   THE ARRAY HOLDING THE DATA TO BE SORTED.
C  NW      THE NUMBER OF WORDS PER ITEM.
C  IPOS    THE POSITION OF THE ITEM TO BE SORTED (1 TO 'NW').
C  IDIMN    THE DIMENSION OF 'STORE'.
C  NITEM   THE NUMBER OF ITEMS TO BE SORTED.
C  ABUFF   A BUFFER OF LENGTH 'NW'.
C
C--
C
      DIMENSION STORE(IDIMN),ABUFF(NW)
C
C--COMPUTE THE INITIAL STEP LENGTH
      NSTEP=1
      DO 1050 I=1,NITEM
      J=3*NSTEP+1
      IF(J-NITEM)1050,1100,1100
1050  CONTINUE
C--ENSURE THAT THE STEP LENGTH IS NOT TOO LARGE
1100  CONTINUE
      NSTEP=MAX0(NSTEP,13)
C--COMPUTE THE LAST USED ADDRESS
      LAST=(NITEM-1)*NW+IPOS
C--LOOP OVER EACH SEARCH VALUE
1150  CONTINUE
      NSTEPC=MAX0(1,NSTEP-1)
      NCW=NSTEPC*NW
      L=IPOS
      DO 1450 M=1,NSTEPC
      K=L
      GOTO 1250
1200  CONTINUE
      K=K+NCW
1250  CONTINUE
      I=K
      J=I+NCW
      IF(J-LAST)1300,1300,1400
1300  CONTINUE
      IF(STORE(I)-STORE(J))1350,1200,1200
C--INTER-CHANGE ENTRIES
1350  CONTINUE
      I0=I-IPOS
      J0=J-IPOS
      CALL XMOVE(STORE(I0+1),ABUFF(1),NW)
      CALL XMOVE(STORE(J0+1),STORE(I0+1),NW)
      CALL XMOVE(ABUFF(1),STORE(J0+1),NW)
      J=I
      I=I-NCW
      IF(I)1200,1200,1300
1400  CONTINUE
      L=L+NW
1450  CONTINUE
      NSTEP=(NSTEP-1)/3
      IF(NSTEP)1500,1500,1150
1500  CONTINUE
      RETURN
      END
C
CODE FOR XSHELI
      SUBROUTINE XSHELI(ISTORE,NW,IPOS,NITEM,IDIMN,IBUFF)
C--IN CORE SHELL SORT ROUTINE, SORTING INTO ASCENDING ORDER.
C
C  ISTORE  THE ARRAY HOLDING THE DATA TO BE SORTED.
C  NW      THE NUMBER OF WORDS PER ITEM.
C  IPOS    THE POSITION OF THE ITEM TO BE SORTED (1 TO 'NW').
C  IDIMN    THE DIMENSION OF 'ISTORE'.
C  NITEM   THE NUMBER OF ITEMS TO BE SORTED.
C  IBUFF   A BUFFER OF LENGTH 'NW'.
C
C--
C
      DIMENSION ISTORE(IDIMN),IBUFF(NW)
C
C--COMPUTE THE INITIAL STEP LENGTH
      NSTEP=1
      DO 1050 I=1,NITEM
      J=3*NSTEP+1
      IF(J-NITEM)1050,1100,1100
1050  CONTINUE
C--ENSURE THAT THE STEP LENGTH IS NOT TOO LARGE
1100  CONTINUE
      NSTEP=MAX0(NSTEP,13)
C--COMPUTE THE LAST USED ADDRESS
      LAST=(NITEM-1)*NW+IPOS
C--LOOP OVER EACH SEARCH VALUE
1150  CONTINUE
      NSTEPC=MAX0(1,NSTEP-1)
      NCW=NSTEPC*NW
      L=IPOS
      DO 1450 M=1,NSTEPC
      K=L
      GOTO 1250
1200  CONTINUE
      K=K+NCW
1250  CONTINUE
      I=K
      J=I+NCW
      IF(J-LAST)1300,1300,1400
1300  CONTINUE
      IF(ISTORE(J)-ISTORE(I))1350,1200,1200
C--INTER-CHANGE ENTRIES
1350  CONTINUE
      I0=I-IPOS
      J0=J-IPOS
      CALL XMOVE(ISTORE(I0+1),IBUFF(1),NW)
      CALL XMOVE(ISTORE(J0+1),ISTORE(I0+1),NW)
      CALL XMOVE(IBUFF(1),ISTORE(J0+1),NW)
      J=I
      I=I-NCW
      IF(I)1200,1200,1300
1400  CONTINUE
      L=L+NW
1450  CONTINUE
      NSTEP=(NSTEP-1)/3
      IF(NSTEP)1500,1500,1150
1500  CONTINUE
      RETURN
      END
C
CODE FOR XSHELJ
      SUBROUTINE XSHELJ(ISTORE,NW,IPOS,NITEM,IDIMN,IBUFF)
C--IN CORE SHELL SORT ROUTINE, SORTING INTO DESCENDING ORDER.
C
C  ISTORE  THE ARRAY HOLDING THE DATA TO BE SORTED.
C  NW      THE NUMBER OF WORDS PER ITEM.
C  IPOS    THE POSITION OF THE ITEM TO BE SORTED (1 TO 'NW').
C  IDIMN    THE DIMENSION OF 'ISTORE'.
C  NITEM   THE NUMBER OF ITEMS TO BE SORTED.
C  IBUFF   A BUFFER OF LENGTH 'NW'.
C
C--
C
      DIMENSION ISTORE(IDIMN),IBUFF(NW)
C
C--COMPUTE THE INITIAL STEP LENGTH
      NSTEP=1
      DO 1050 I=1,NITEM
      J=3*NSTEP+1
      IF(J-NITEM)1050,1100,1100
1050  CONTINUE
C--ENSURE THAT THE STEP LENGTH IS NOT TOO LARGE
1100  CONTINUE
      NSTEP=MAX0(NSTEP,13)
C--COMPUTE THE LAST USED ADDRESS
      LAST=(NITEM-1)*NW+IPOS
C--LOOP OVER EACH SEARCH VALUE
1150  CONTINUE
      NSTEPC=MAX0(1,NSTEP-1)
      NCW=NSTEPC*NW
      L=IPOS
      DO 1450 M=1,NSTEPC
      K=L
      GOTO 1250
1200  CONTINUE
      K=K+NCW
1250  CONTINUE
      I=K
      J=I+NCW
      IF(J-LAST)1300,1300,1400
1300  CONTINUE
      IF(ISTORE(I)-ISTORE(J))1350,1200,1200
C--INTER-CHANGE ENTRIES
1350  CONTINUE
      I0=I-IPOS
      J0=J-IPOS
      CALL XMOVE(ISTORE(I0+1),IBUFF(1),NW)
      CALL XMOVE(ISTORE(J0+1),ISTORE(I0+1),NW)
      CALL XMOVE(IBUFF(1),ISTORE(J0+1),NW)
      J=I
      I=I-NCW
      IF(I)1200,1200,1300
1400  CONTINUE
      L=L+NW
1450  CONTINUE
      NSTEP=(NSTEP-1)/3
      IF(NSTEP)1500,1500,1150
1500  CONTINUE
      RETURN
      END
CODE FOR SSORT
      SUBROUTINE SSORT(LIND,NUMB,IBLK,JUMP)
C--SORT THE DATA IN STORE
C
C  LIND  ADDRESS IN STORE
C  NUMB  NUMBER OF BLOCKS OF DATA TO BE SORTED
C  IBLK  BLOCK LENGHT OF THE DATA (I.E. NUMBER OF ITEMS PER BLOCK)
C  JUMP  < 0 SORT IN DECREASING ORDER
C  JUMP  > 0 SORT IN INCREASING ORDER
C  IABS(JUMP) = RELATIVE ADDRESS OF THE KEY OF SORT
C
\ISTORE
\STORE
\QSTORE
C
      JMP = JUMP
      JSIG=1
      IF (JMP.LT.0) THEN
                       JMP=IABS(JMP)
                       JSIG=-1
                     ENDIF
      IF (NUMB.LE.1) RETURN
      JMP=JMP-1
      JA=2
2010  CONTINUE
      JB=NUMB/JA
      IF(JB) 2020,2020,2030
2020  CONTINUE
      JB=1
2030  CONTINUE
      JC=NUMB-JB
2040  CONTINUE
      JD=0
      M=LIND
      DO 2070 I=1,JC
      MK=M+JB*IBLK
      IF ((STORE(M+JMP)-STORE(MK+JMP))*JSIG) 2060,2060,2050
 2050 CONTINUE
      MM=M
      MMK=MK
      DO 2055 JE=1,IBLK
      F=STORE(MM)
      STORE(MM)=STORE(MMK)
      STORE(MMK)=F
      MM=MM+1
      MMK=MMK+1
 2055 CONTINUE
      JD=1
 2060 CONTINUE
      M=M+IBLK
 2070 CONTINUE
      IF (JD) 2080,2080,2040
 2080 CONTINUE
      IF (JB-1) 2100,2100,2090
 2090 CONTINUE
      JA=JA*2
      GO TO 2010
 2100 CONTINUE
      RETURN
      END
C
CODE FOR SSORTI
      SUBROUTINE SSORTI(LIND,NUMB,IBLK,JUMP)
C--SORT THE DATA IN ISTORE
C
C  LIND  ADDRESS IN ISTORE
C  NUMB  NUMBER OF BLOCKS OF DATA TO BE SORTED
C  IBLK  BLOCK LENGHT OF THE DATA (I.E. NUMBER OF ITEMS PER BLOCK)
C  JMP  < 0 SORT IN DECREASING ORDER
C  JMP  > 0 SORT IN INCREASING ORDER
C  IABS(JMP) = RELATIVE ADDRESS OF THE KEY OF SORT
C
\ISTORE
\STORE
\QSTORE
C
      JMP = JUMP
      JSIG=1
      IF (JMP.LT.0) THEN
                       JMP=IABS(JMP)
                       JSIG=-1
                     ENDIF
      IF (NUMB.LE.1) RETURN
      JMP=JMP-1
      JA=2
2010  CONTINUE
      JB=NUMB/JA
      IF(JB) 2020,2020,2030
2020  CONTINUE
      JB=1
2030  CONTINUE
      JC=NUMB-JB
2040  CONTINUE
      JD=0
      M=LIND
      DO 2070 I=1,JC
      MK=M+JB*IBLK
      IF ((istore(M+JMP)-istore(MK+JMP))*JSIG) 2060,2060,2050
 2050 CONTINUE
      MM=M
      MMK=MK
      DO 2055 JE=1,IBLK
      JF=istore(MM)
      istore(MM)=istore(MMK)
      istore(MMK)=JF
      MM=MM+1
      MMK=MMK+1
 2055 CONTINUE
      JD=1
 2060 CONTINUE
      M=M+IBLK
 2070 CONTINUE
      IF (JD) 2080,2080,2040
 2080 CONTINUE
      IF (JB-1) 2100,2100,2090
 2090 CONTINUE
      JA=JA*2
      GO TO 2010
 2100 CONTINUE
      RETURN
      END
C
CODE FOR SRTDWN
      SUBROUTINE SRTDWN (LSORT, MSORT, MDSORT, NSORT,
     1 IPOS, ITEM, VALUE, ITYPE, DEF)
C
C----- STORE THE OCCURENCES OF A RECORD CONTAINING THE LARGET OCCURENCES
C      OF AN ITEM
C
C      NSORT -  NUMBER OF RECORDS TO BE RETAINED
C      MDSORT - NUMBER OF ITEMS PER RECORD
C      LSORT -  STARTING ADDRESS IN STORE OF SAVED OCCURENCES (SET ON
C               INITIALISATION)
C      IPOS  -  ADDRESS IN STORE OF RECORD TO BE SORTED
C                  IF -VE, INITIALISATION
C      ITEM  -  OFFSET IN RECORD OF ITEM TO BE SORTED
C      VALUE -  SMALEST VALUE FOUND TO DATE - CAN BE USED BY CALLING
C                  ROUTINE TO CHECK IF CALL IS NECESSARY
C      ITYPE - -1 SMALLEST TO LARGEST
C               0 ABSOLUTE LARGEST TO SMALLEST
C               1 LARGEST TO SMALLEST
C
\ISTORE
\STORE
\QSTORE
C
      IF (IPOS .LT. 0) THEN
C----- INITIALISATION
cdjw take abs value
            IPOS = IABS(IPOS)
            LSORT = NFL
            NFL = KCHNFL(NSORT*MDSORT)
            call xzerof (store(lsort), nsort*mdsort)
              IF (ITYPE .LT. 0) THEN
                  DEF = 100000000.0
              ELSE IF (ITYPE .GT. 0) THEN
                  DEF = -100000000.0
              ELSE
                  DEF = 0.0
              ENDIF
cdjw            ITEMP = LSORT + IABS(IPOS) -1
            ITEMP = LSORT + IPOS -1
            DO 100 I = 1, NSORT
              STORE(ITEMP) = DEF
              ITEMP = ITEMP + MDSORT
100         CONTINUE
            VALUE = DEF
            RETURN
      ENDIF
C
C----- INSERTION
      IHIT = 0
      MSORT = LSORT
      DO 200 I = 1, NSORT
      IF (ITYPE .LT. 0) THEN
        IF (STORE(ITEM+IPOS) .LT. STORE(MSORT+IPOS)) IHIT = 1
      ELSE IF (ITYPE .GT. 0) THEN
        IF (STORE(ITEM+IPOS) .GT. STORE(MSORT+IPOS)) IHIT = 1
      ELSE
        IF (ABS(STORE(ITEM+IPOS)) .GT. ABS(STORE(MSORT+IPOS))) IHIT = 1
      ENDIF
        IF (IHIT .NE. 0) THEN
          IHIT = 0
C-----    SHUFFLE REMAINDER DOWN
            ITEMP = LSORT + (NSORT-2) * MDSORT
            DO 300 J = NSORT, I+1, -1
                  CALL XMOVE (STORE(ITEMP), STORE(ITEMP+MDSORT), MDSORT)
            ITEMP = ITEMP - MDSORT
300         CONTINUE
            CALL XMOVE (STORE(ITEM), STORE(MSORT), MDSORT)
            VALUE = STORE(LSORT + IPOS + (NSORT-1)*MDSORT)
            MSORT = I
            RETURN
        ENDIF
        MSORT = MSORT + MDSORT
200   CONTINUE
      VALUE = STORE(MSORT-MDSORT+IPOS)
      MSORT = NSORT
      RETURN
      END
