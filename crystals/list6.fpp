CODE FOR XPRT6C
      SUBROUTINE XPRT6C(M1)
C--PRINT LIST 6 IN COMPRESSED FORMAT
C
C  M1  IF ZERO OR LESS THAN ZERO STRUCTURE FACTORS ARE PRINTED ON
C      ON THE SCALE OF /FO/, ELSE ON THE SCALE OF /FC/
C
C--
\XUNITS
\XSSVAL
C
      CALL XPRT6Q(6,M1,IPAGE(4)-9,3)
      RETURN
      END
C
CODE FOR XPRT6Q
      SUBROUTINE XPRT6Q(IULN,M1,NL,ICOL3)
C--PRINT LIST 6 IN COMPRESSED FORMAT
C
C  IULN    THE LIST TYPE TO BE PRINTED.
C  M1      IF ZERO OR LESS THAN ZERO STRUCTURE FACTORS ARE PRINTED ON
C          ON THE SCALE OF /FO/, ELSE ON THE SCALE OF /FC/
C  NL      THE NUMBER OF LINES PER PAGE
C  ICOL3   THE NUMBER OF COLUMNS PER PAGE (THIS IS CONSTRAINED
C          IN THE RANGE 1 TO 3).
C
C--
\ICOM06
\ISTORE
C
\STORE
\XCONST
\XLISTI
\XLST05
\XLST06
\XUNITS
\XSSVAL
\XLST50
\XCARDS
\XCHARS
\XIOBUF
C
\QSTORE
\QLST06
C
C--ENSURE THAT THE NUMBER OF COLUMNS/PAGE DOES NOT EXCEED 3
      ICOL=MIN0(ICOL3,3)
C--CHECK THAT THERE ARE SOME COLUMNS ON THE PAGE
      IF(ICOL)1000,1000,1050
C--INSERT THE DEFAULT NUMBER OF COLUMNS  -  3
1000  CONTINUE
      ICOL=3
C--CHECK IF LIST 6 IS AVAILABLE FOR PRINTING
1050  CONTINUE
      IF(KPRTLN(IULN,I))3400,1100,1100
C--ALL OKAY  -  LOAD LIST 50 AND THE RECORD FOR THE REQUIRED LIST TYPE
1100  CONTINUE
      CALL XFAL50
      CALL XLL50R(IULN+LSTOFF)
\IDIM06
C--SET THE POINTERS TO THE SECOND RECORD  -  CONTAINS THE KEYWORDS
      LN=IULN
      IREC=0
      CALL XDIRFL(4,ICOM06,IDIM06)
C--CLEAR THE CORE AGAIN
      CALL XRSL
      CALL XCSAE
C--FIND THE NUMBER AND ADDRESS OF THE KEYWORDS
      KC=ISTORE(LR62D+1)+LR62
      KD=ISTORE(LR62D+3)
C--ALLOCATE SPACE TO HOLD THE KEYWORDS
      KA=NFL
      KB=3
      I=KCHNFL(KB*KD)
C--FORM A4 CHARACTER STRINGS FROM THE KEYWORDS
      J=KA
      DO 1150 I=1,KD
      CALL XFA4CS(STORE(KC+1),STORE(J),KB*NWCHAR)
      KC=KC+ISTORE(LR62D+2)
      J=J+KB
1150  CONTINUE
C--SET UP THE SCALING POINTERS INITIALLY
      I=0
      A=1.
      C=1.
C--CHECK IF THIS IS A LIST 6
      IF(IULN-6)1400,1250,1400
C--CHECK IF THERE IS A LIST 5 STORED
1250  CONTINUE
      CALL XRLIND(5,I,J,K,L,M,STORE(NFL))
C--CHECK THE DISC ADDRESS
      IF(J)1400,1400,1300
C--THERE IS A LIST 5 STORED  -  LOAD IT INTO CORE
1300  CONTINUE
      CALL XFAL05
      IF ( IERFLG .LT. 0 ) GO TO 9900
      A=1.
      C=STORE(L5O)
C--CHECK THE OUTPUT SCALE REQUIRED
      IF(M1)1400,1400,1350
C--OUTPUT IS ON THE SCALE OF /FO/, NOT THE SCALE OF /FC/
1350  CONTINUE
      C=1.
      A=1./STORE(L5O)
C--SET UP THE PROCESSING OF LIST 6
1400  CONTINUE
      CALL XFLT06(IULN,0)
      CALL XFAL28
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--CHECK IF THERE IS A LIST ONE STORED
      IF(KEXIST(1))1500,1500,1450
C--LOAD LIST 1
1450  CONTINUE
      CALL XFAL01
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--PRINT THE DETAILS RECORD
1500  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1550)
      ENDIF
1550  FORMAT(' Quantity',12X,'Minimum',8X,'Maximum',7X,'Mean value',
     2 4X,'R.M.S. value',/)
C--LOOP OVER EACH DETAIL STORED
      M6DTL=L6DTL
      DO 1850 I=2,N6DTL
      KC=KA+KB-1
C--CHECK IF THIS DETAIL IS SET
      IF(STORE(M6DTL+3)-ZERO)1600,1700,1700
C--NOT SET  -  PRINT THE CAPTION AND IGNORE IT
1600  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1650)(ISTORE(J),J=KA,KC)
      ENDIF
1650  FORMAT(2X,3A4,4X,'No details available')
      GOTO 1800
C--PRINT THE DETAILS
1700  CONTINUE
      K=M6DTL+MD6DTL-1
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1750)(ISTORE(J),J=KA,KC),(STORE(J),J=M6DTL,K)
      ENDIF
1750  FORMAT(2X,3A4,2X,6E15.6)
C--UPDATE FOR THE NEXT PARAMETER
1800  CONTINUE
      M6DTL=M6DTL+MD6DTL
      KA=KA+KB
1850  CONTINUE
C--CHECK IF THIS LIST TYPE 6
      IF(IULN-6)2000,1900,2000
C--PRINT THE R VALUE ETC.
1900  CONTINUE
      J=NINT(STORE(L6P))
      M6P=L6P+2
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1950)J,(STORE(I+1),I=L6P,M6P)
      ENDIF
1950  FORMAT(/,' After ',I5,
     2 '  Structure factor/refinement calculation(s)',//,' R = ',F6.2,
     3 5X,'Weighted R = ',F6.2,5X,'Minimisation function = ',E15.6)
C--ASSIGN THE NUMBER OF COEFFICIENTS TO BE PRINTED PER REFLECTION
2000  CONTINUE
      NW=6
      N=NW+NW+NW
      ASSIGN 2050 TO NRET
C--SET UP A PRINT BUFFER IN CORE
      JA=NFL
      LN=IULN
      IREC=1001
      M=KCHNFL(NW*NL*ICOL)
C--RESET THE CONSTANTS FOR THE BEGINNING OF A PAGE
2050  CONTINUE
      K=NL
      J=K+NL
      I=J+NL
      L=JA
      M=JA
C--FETCH THE NEXT REFLECTION
2100  CONTINUE
      IF(KFNR(0))2600,2150,2150
C--MOVE THE REFLECTION FROM THE INPUT BUFFER
2150  CONTINUE
      ISTORE(L)=NINT(STORE(M6))
      ISTORE(L+1)=NINT(STORE(M6+1))
      ISTORE(L+2)=NINT(STORE(M6+2))
      STORE(L+3)=STORE(M6+3)*A
      STORE(L+4)=STORE(M6+5)*C
      STORE(L+5)=STORE(M6+6)*RTD
      L=L+N
      I=I-1
      J=J-1
      K=K-1
C--CHECK IF THE COLUMN IS FULL
      IF(K)2300,2200,2100
C--END OF THE FIRST COLUMN  -  CHECK IF WE SHOULD ONLY PRINT ONE COLUMN
2200  CONTINUE
      IF(ICOL-1)2250,3150,2250
C--MORE THAN ONE COLUMN  -  RETURN FOR MORE REFLECTIONS
2250  CONTINUE
      M=M+NW
      L=M
      GOTO 2100
C--END OF THE SECOND OR THIRD COLUMNS  -  FIND WHICH
2300  CONTINUE
      IF(J)2400,2350,2100
C--END OF THE SECOND COLUMN  -  CHECK IF WE ARE ONLY PRINTING 2
2350  CONTINUE
      IF(ICOL-2)2250,2950,2250
C--MORE THAN TWO COLUMNS  -  CHECK FOR THE END OF A PAGE
2400  CONTINUE
      IF(I)2450,2450,2100
C--END OF A PAGE WITH THREE COLUMNS ON IT  -  PRINT THEM
2450  CONTINUE
      L=L-N
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2500)
2500  FORMAT('1',/,
     2 3(7X,'H',3X,'K',3X,'L',4X,'/FO/',4X,'/FC/',3X,'Phase'),/)
      WRITE(NCWU,2550)(ISTORE(NX),ISTORE(NX+1),ISTORE(NX+2),
     2 STORE(NX+3),STORE(NX+4),STORE(NX+5),NX=JA,L,NW)
      ENDIF
2550  FORMAT((3(4X,3I4,3F8.1)))
      GOTONRET,(2050,2700,3400,3050)
C
C--LAST REFLECTION MARKER FOUND
2600  CONTINUE
      M=NL-I
C--CHECK IF THERE ANY ROWS WITH THREE COLUMNS TO PRINT
      IF(M)2900,2900,2650
C--PRINT ROWS WITH THREE COLUMNS
2650  CONTINUE
      ASSIGN 2700 TO NRET
      GOTO 2450
C--RETURN AFTER PRINTING 3 COLUMNS  -  RESET TO PRINT 2
2700  CONTINUE
      ASSIGN 3400 TO NRET
      L=L+NW
C--CHECK IF THERE ARE ANY ROWS WITH TWO COLUMNS TO PRINT
2750  CONTINUE
      IF(I)2800,2800,2850
C--END OF 2 COLUMN PRINT - EXIT FOR 2 AND 3 COLUMNS, PRINT 1 FOR 1 AND 2
2800  CONTINUE
      GOTONRET,(2050,2700,3400,3050)
C--PRINT THE NEXT LINE OF TWO COLUMNS
2850  CONTINUE
      M=L+NW
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2550)(ISTORE(NX),ISTORE(NX+1),ISTORE(NX+2),
     2 STORE(NX+3),STORE(NX+4),STORE(NX+5),NX=L,M,NW)
      ENDIF
      I=I-1
      L=L+N
      GOTO 2750
C
C--NO ROWS WITH THREE COLUMNS
2900  CONTINUE
      ASSIGN 3050 TO NRET
C--COMPUTE THE NUMBER OF ROWS WITH TWO COLUMNS TO PRINT
2950  CONTINUE
      I=NL-J
C--CHECK IF THERE ANY ROWS WITH ONLY TWO COLUMNS
      IF(I)3100,3100,3000
C--NEW PAGE CAPTION REQUIRED BEFORE WE START
3000  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2500)
      ENDIF
      L=JA
      GOTO 2750
C--ASSIGN THE EXIT VARIABLE AFTER PRINTING THE 2 COLUMN ROWS
3050  CONTINUE
      ASSIGN 3400 TO NRET
      GOTO 3250
C
C--ONLY ROWS WITH ONE COLUMN TO PRINT
3100  CONTINUE
      ASSIGN 3400 TO NRET
C--COMPUTE THE NUMBER OF 1 COLUMN ROWS TO BE PRINTED
3150  CONTINUE
      J=NL-K
      IF(J)3400,3400,3200
C--CAPTION FOR THE NEW PAGE WITH ONLY ONE COLUMN ON IT
3200  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2500)
      ENDIF
      L=JA
C--CHECK FOR THE END OF THE PAGE
3250  CONTINUE
      IF(J)3300,3300,3350
C--END OF THE PAGE  -  EXIT NOW
3300  CONTINUE
      GOTONRET,(2050,2700,3400,3050)
C--PRINT THE NEXT LINE WITH ONE COLUMN ON IT
3350  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,2550)ISTORE(L),ISTORE(L+1),ISTORE(L+2),STORE(L+3),
     2 STORE(L+4),STORE(L+5)
      ENDIF
      L=L+N
      J=J-1
      GOTO 3250
C--A FEW SPARE LINES AT THE END
3400  CONTINUE
      CALL XLINES
      RETURN
C
9900  CONTINUE
C -- ERRORS
      IF (ISSPRT .EQ. 0) THEN
      WRITE ( NCWU , 9905 )
      ENDIF
      WRITE ( NCAWU , 9905 )
      WRITE ( CMON, 9905 )
      CALL XPRVDU(NCVDU, 1,0)
9905  FORMAT ( 1X , 'Printing of list 6 abandoned' )
      RETURN
      END
C
C----- L6W = -1 FOR M/T; +1 FOR DISK
CODE FOR XSWP06
      SUBROUTINE XSWP06(IULN,MEDIUM)
C--CHECK IF THE CURRENT OUTPUT MEDIUM IS WHAT IS REQUIRED FOR LIST 6
C
C  IULN    THE LIST TYPE BEING PROCESSED.
C  MEDIUM  THE NEW MEDIUM FLAG :
C
C          -1  M/T
C           0  AS BEFORE.
C          +1  DISC.
C
C--
\ISTORE
C
\STORE
\XUNITS
\XSSVAL
\XLST06
C
\QSTORE
C
C--CHECK WHAT IS REQUIRED NOW
      IF(MEDIUM)1000,1300,1050
C--M/T REQUIRED  -  CHECK WHERE WE ARE
1000  CONTINUE
      IF(L6W)1300,1100,1100
C--DISC REQUIRED  -  CHECK WHERE WE ARE NOW
1050  CONTINUE
      IF(L6W)1100,1300,1300
C--OUTPUT THE DATA TO THE NEW MEDIUM
1100  CONTINUE
      CALL XRSL
      CALL XCSAE
C--LOAD THE OLD LIST FOR READING
      CALL XFLT06(IULN,0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--SET UP THE NEW LIST FOR OUTPUT
      CALL XSTR06(IULN,MEDIUM,0,1,0)
C--LOAD THE NEXT REFLECTION
1150  CONTINUE
      IF(KLDRNR(I))1250,1200,1200
C--STORE THE NEXT REFLECTION
1200  CONTINUE
      CALL XSLR(1)
      GOTO 1150
C--TERMINATE THE TRANSFER
1250  CONTINUE
      CALL XERT(IULN)
C--AND NOW RETURN
1300  CONTINUE
C -- NORMAL AND ERROR RETURN
9900  CONTINUE
      RETURN
      END
C
CODE FOR XFAL06
      SUBROUTINE XFAL06(IOWF)
C--SET UP LIST 6 FOR READING FROM THE DISC, AND POSSIBLY FOR REWRITING
C
C  IOWF  THE WRITE/OVERWRITE FLAG :
C
C        -1  ATTEMPT AN OVERWRITE.
C         0  READ ONLY.
C        +1  CAREFUL UPDATE ONLY.
C
\XUNITS
\XSSVAL
C--
C
C--CALL THE MAIN LOADING ROUTINE
      CALL XFLT06(6,IOWF)
      IF ( IERFLG .LT. 0 ) RETURN
C
C--INITIALISE LIST 28 IF POSSIBLE
      CALL XFAL28
      RETURN
      END
C
CODE FOR XLDR06
      SUBROUTINE XLDR06(IOWF)
C--SET UP LIST 6 FOR READING FROM THE DISC, AND POSSIBLY FOR REWRITING.
C  THIS ROUTINE DOES NOT INITIALISE LIST 28, AND SO SUCH CHECKING
C  WILL BE PERFORMED.
C
C  IOWF  THE WRITE/OVERWRITE FLAG :
C
C        -1  ATTEMPT AN OVERWRITE.
C         0  READ ONLY.
C        +1  CAREFUL UPDATE ONLY.
C
C--
C
C--CALL THE MAIN LOADING ROUTINE
      CALL XFLT06(6,IOWF)
      RETURN
      END
C
CODE FOR XFLT06
      SUBROUTINE XFLT06(IULN,IOWF)
C--SET UP A LIST FOR PROCESSING AS A LIST 6.
C
C  IULN  THE LIST TYPE TO BE SET UP FOR PROCESSING.
C  IOWF  THE WRITE/OVERWRITE FLAG :
C
C        -1  ATTEMPT AN OVERWRITE.
C         0  READ ONLY.
C        +1  CAREFUL UPDATE ONLY.
C
C--
\ISTORE
\ICOM06
\ICOM28
C
\STORE
\XLST06
\XLISTI
\XLST28
\XPCK06
\XUSLST
\XUNITS
\XSSVAL
\XTAPES
\XTAPED
C
\QSTORE
\QLST06
\QLST28
C
\IDIM28
C--ZERO THE COMMON BLOCK FOR LIST 28
      CALL XZEROF(ICOM28(1),IDIM28)
\IDIM06
      LN6=IULN
C--LOAD THE DATA FROM THE DISC
      CALL XLDLST(IULN,ICOM06,IDIM06,IOWF)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--SET UP THE PACK COEFFICIENTS FOR THE INDICES
      IPACKR=KCOMP(1,I14,STORE(L6DMP),MD6DMP,N6DMP)
      IPACKW=IPACKR
C--SET UP THE PHASE/BATCH PACK COEFFICIENTS
      IPHSER=KCOMP(1,I15,STORE(L6DMP),MD6DMP,N6DMP)
      IPHSEW=IPHSER
C -- FIND IF THE RATIO AND JCODE HAVE BEEN PACKED
      JCDRAR = KCOMP ( 1 , I31 , STORE(L6DMP) , MD6DMP , N6DMP )
      JCDRAW = JCDRAR
C--SET THE POINTER TO THE CORE BUFFER
      M6=L6
C--CHECK IF THE INPUT IS FROM M/T
      IF(L6D)1000,1000,1050
C--INPUT IS FROM M/T  -  SET UP A BUFFER
1000  CONTINUE
      CALL XIMTR(MD6D)
C--REWIND THE INPUT TAPE
      REWINDMTA
C--SET THE POINTERS TO THE DISC INPUT BUFFER
1050  CONTINUE
      M6R=L6R
      L6R=L6D
      N6R=N6D
C--CONVERT THE DISC POINTERS TO ABSOLUTE VALUES
      CALL XABP06(1)
C--CHECK IF THIS OPERATION ALSO INVOLVES A WRITE TO THE DISC
      IF(IOWF)1100,1150,1100
C--OUTPUT IS TO BE GENERATED
1100  CONTINUE
      CALL XSTR06(IULN,0,IOWF,-1,0)
C--AND NOW RETURN
1150  CONTINUE
      CALL XZEROF(STORE(M6),MD6)
C -- NORMAL AND ERROR EXIT
9900  CONTINUE
      RETURN
      END
C
CODE FOR XEND06
      SUBROUTINE XEND06
C--TERMINATE THE TRANSFER OF LIST 6 REFLECTION DATA TO DISC
C
C--
C
C--CALL THE TERMINATION ROUTINE
      CALL XERT(6)
      RETURN
      END
C
CODE FOR XERT
      SUBROUTINE XERT(IULN)
C--TERMINATE THE OUTPUT OF LIST TYPE 6 TO THE DISC
C
C  IULN    THE TYPE OF LIST BEING OUTPUT AS A LIST 6.
C
C--
C
C
\XUNITS
\XSSVAL
\XLST06
\XLISTI
\XCHARS
\XTAPES
\XTAPED
\XIOBUF
C
C
C
C
C--SET THE LIST TYPE
      LN=IULN
      IREC=0
C--SET THE OUTPUT FLAG
      JTYPE=1
C--CHECK FOR OUTPUT TO M/T
      IF(L6W)1000,1000,1050
C--OUTPUT TO M/T  -  FINISH IT OFF
1000  CONTINUE
      CALL XTMTW(MTB)
      CALL XTMTR(MTA)
C--SWITCH UNITS
      I=MTA
      MTA=MTB
      MTB=I
      JTYPE=2
C--REWRITE THE LIST DETAILS TO DISC
1050  CONTINUE
      KA=L6W
      KB=N6W
      L6W=M6W
      N6W=1
C--MARK THE CURRENT LIST AS BEING UPDATED NOW
      CALL XMKOWF(IULN,1)
C--REWRITE THE DETAILS TO DISC
      CALL XSTR06(IULN,0,-1,-1,-1)
C--RESET THE POINTERS
      L6W=KA
      N6W=KB
C--ALTER THE WRITE/OVERWRITE FLAG
      CALL XMKOWF(IULN,0)
C--ALTER THE ERROR STATUS
      CALL XALTES(IULN,1)
C--CHECK FOR M/T OUTPUT
      IF(L6W .LE. 0 ) THEN
C--PRINT THE FILE NAME NOW CURRENT
1100  CONTINUE
      WRITE(NCAWU,1200)MTA
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1200)MTA
      ENDIF
1200  FORMAT (' The updated reflections are now on UNIT ', I2 )
C--AND NOW RETURN
      ELSE
            WRITE(NCAWU,
     1 '( '' Reflections on DISK updated '')')
      ENDIF
1250  CONTINUE
      RETURN
      END
C
CODE FOR XSTR06
      SUBROUTINE XSTR06(IULN,MTFLAG,IOWF,INEW,IMTBUF)
C--INITIATE OUTPUT FOR A LIST 6
C
C  IULN    THE TYPE OF LIST TO OUTPUT.
C  MTFLAG  M/T OUTPUT FLAG :
C
C          -1  OUTPUT IS TO M/T
C           0  OUTPUT IS AS DEFINED BY 'L6D'  -  I.E. SAME AS BEFORE.
C          +1  OUTPUT IS TO DISC.
C
C  IOWF    THE WRITE/OVERWRITE FLAG :
C
C          -1  OVERWRITE IF POSSIBLE.
C           0  OUTPUT A COMPLETELY NEW LIST.
C          +1  CAREFUL UPDATE.
C
C  INEW    THE NEW LIST FLAG :
C
C          -1  THIS IS NOT A NEW VERSION OF THIS LIST.
C           0  THIS IS A NEW LIST, WITH LINKS TO OTHER EXISTING LISTS.
C          +1  THIS IS A NEW LIST, WITH NO LINKS TO OTHER EXISTING
C              LISTS. THIS IS NORMALLY THE CASE WHEN THE LIST HAS JUST B
C              INPUT.
C
C  IMTBUF  THIS POINTER DETERMINES WHETHER AN M/T BUFFER IS SET IF REQUI
C
C          -1  DO NOT SET UP A BUFFER.
C           0  SET UP A BUFFER IF REQUIRED.
C
C
C--TO ALTER THE OUTPUT MEDIUM FROM THAT USED FOR INPUT, 'XFAL06' OR
C  'XFLT06' SHOULD BE CALLED WITH NO OUTPUT REQUESTED ('IOWF' SET TO 0),
C  AND THEN 'XSTR06' SHOULD BE CALLED TO NOMINATE THE OUTPUT MEDIUM.
C
C--
\HEADES
\ISTORE
\ICOM06
C
\STORE
\XLST06
\XLISTI
\XUSLST
\XTAPES
\XTAPED
C
\QSTORE
\QLST06
C
      LN6=IULN
C--ADJUST THE READ POINTERS DURING THIS OPERATION
      KA=L6R
      KB=M6R
      KC=N6R
C--INDICATE ONLY ONE READ RECORD
      L6R=M6R
      N6R=1
C--CHECK THE OUTPUT TYPE REQUIRED
      MTFLG=MTFLAG
      IF(MTFLG)1000,1050,1100
C--OUTPUT TO M/T
1000  CONTINUE
      KD=N6D
      N6D=0
      MTFLG=-1
      GOTO 1100
C--SAME AS BEFORE  -  CHECK THE PREVIOUS TYPE
1050  CONTINUE
      IF(L6D)1000,1000,1100
C--CONVERT ALL ADDRESSES IN THE MOVE BLOCK TO RELATIVE
1100  CONTINUE
      CALL XABP06(-1)
\IDIM06
C--INITIATE OUTPUT OF THE LIST
      CALL XWLSTD(IULN,ICOM06,IDIM06,IOWF,INEW)
C--RESET THE READ POINTERS
      L6R=KA
      M6R=KB
      N6R=KC
C--CHECK FOR OUTPUT TO M/T
      IF(MTFLG)1150,1250,1250
C--M/T OUTPUT  -  UPDATE THE CONTROL RECORD
1150  CONTINUE
      N6D=KD
      L6D=-1
C--FIND THE BLOCK ON DISC
      I=KFNDRI(IULN,-104,IADDR,IBUFF)
C--UPDATE THE NUMBER, LENGTH AND ADDRESS
      IBUFF(6)=N6D
      IBUFF(3)=MD0+IBUFF(5)*IBUFF(6)
      IBUFF(4)=-1
C--REWITE THE BLOCK
      CALL XUPF(IADDR,IBUFF(1),MD0)
C--UPDATE THE CORE POINTERS
      CALL XUDRH(IULN,-104,0,N6D)
C--CHECK IF THE OUTPUT AREA SHOULD BE CREATED
      IF(IMTBUF)1250,1200,1200
C--CREATE AN OUTPUT AREA
1200  CONTINUE
      CALL XIMTW(MD6D)
      REWINDMTB
C--SET THE POINTERS
1250  CONTINUE
      M6W=L6W
      L6W=L6D
      N6W=0
C--CONVERT THE POINTERS BACK TO ABSOLUTE
      CALL XABP06(1)
C--SET THE BUFFER TO ZERO INITIALLY
      CALL XZEROF(STORE(M6),MD6)
      RETURN
      END
C
CODE FOR KFNR
      FUNCTION KFNR(IN)
C--FETCH THE NEXT REFLECTION, CHECKING WITH LIST 28 THAT IT IS ALLOWED.
C
C----- IN   0 FOR READ-ONLY
C           1 FOR READ-WRITE
C
C--RETURN VALUES OF 'KFNR' ARE :
C
C  -1  END OF THE REFLCTIONS.
C   0  REFLCTION READ TO BE USED, STORED AT 'M6'.
C
C--
\XLST06
C
C--FETCH THE NEXT REFLECTION
1000  CONTINUE
      IF(KLDRNR(IN))1100,1050,1050
C--CHECK IF THE REFLECTION IS ALLOWED
1050  CONTINUE
      KFNR=0
      IF(KALLOW(IN)) 1060,1150,1150
1060  CONTINUE
      IF(IN) 1000,1000,1070
1070   CONTINUE
      CALL XSLR(IN)
      GO TO 1000
C--END OF THE REFLECTIONS FOUND
1100  CONTINUE
      KFNR=-1
C--AND NOW RETURN
1150  CONTINUE
      RETURN
      END
C
CODE FOR XSLR
      SUBROUTINE XSLR(IN)
C--STORE THE LAST REFLECTION
C
C  IN  A DUMMY ARGUMENT, IN PLACE FOR COMPATIBILITY.
C
C--
\ISTORE
C
\STORE
\XLST06
\XPCK06
\XTAPES
\XTAPED
\XCONST
C
\QSTORE
C
      IDWZAP = IN
C--CHECK IF THE INDICES SHOULD BE PACKED UP
      IF(IPACKW)1050,1000,1000
C--PACK THE INDICES
1000  CONTINUE
      STORE(M6+14)=STORE(M6)+STORE(M6+1)*256.+STORE(M6+2)*65536.
C--CHECK IF THE PHASE AND BATCH NUMBER NEED PACKING UP
1050  CONTINUE
      IF(IPHSEW)1150,1100,1100
C--PACK THE PHASE AND BATCH NUMBER
1100  CONTINUE
      STORE(M6+15)=STORE(M6+13)*20.+AMOD(STORE(M6+6),TWOPI)+10.
C -- CHECK IF WE MUST PACK UP THE RATIO AND JCODE
1150  CONTINUE
      IF ( JCDRAW .GE. 0 ) THEN
        STORE(M6+31) = STORE(M6+18) + 10.* ANINT ( 10. * STORE(M6+20) )
      ENDIF
C--MOVE THE DATA TO THE OUTPUT BUFFER
      J=M6W
C--CHECK FOR OUTPUT TO M/T
      IF(L6W)1300,1300,1350
C--OUTPUT TO M/T
1300  CONTINUE
      J=MMTW
C--TRANSFER THE DATA TO THE OUTPUT BUFFER
1350  CONTINUE
      DO 1400 I=L6DMP,M6DMP
      K=ISTORE(I)
      STORE(J)=STORE(K)
      J=J+1
1400  CONTINUE
C--CHECK FOR M/T OUTPUT
      IF(L6W)1450,1450,1500
C--M/T OUTPUT  -  UPDATE THE POINTERS
1450  CONTINUE
      CALL XIMTWA(MTB)
      GOTO 1550
C--OUTPUT THE DATA TO THE DISC
1500  CONTINUE
      CALL XUPF(L6W, ISTORE(M6W), MD6W)
C--UPDATE THE POINTERS
      L6W=L6W+KINCRF(MD6W)
C--UPDATE THE NUMBER OF REFLECTIONS OUTPUT
1550  CONTINUE
      N6W=N6W+1
      RETURN
      END
C
CODE FOR XABP06
      SUBROUTINE XABP06(IN)
C--ALTER THE DISC BUFFER POINTERS BY 'IN'*M6.
C
C  IN  INDICATES WHETHER TO SUBTRACT OR ADD 'M6' FROM THE STORED VALUES
C
C      -1  SUBTRACT 'M6'.
C      +1  ADD 'M6'.
C
C--
\ISTORE
C
\STORE
\XLST06
C
\QSTORE
C
C--SET THE INCREMENT/DECREMENT
      J=IN*M6
C--LOOP OVER THE AVAILABLE VALUES
      M6DMP=L6DMP+MD6DMP-1
      DO 1000 I=L6DMP,M6DMP
      ISTORE(I)=ISTORE(I)+J
1000  CONTINUE
      RETURN
      END
C
CODE FOR XFAL28
      SUBROUTINE XFAL28
C--SUBROUTINE TO LOAD LIST 28 FROM DISC, IF IT EXISTS
C
C--
\ICOM28
\ISTORE
C
\STORE
\XUNITS
\XSSVAL
\XCONST
\XLST01
\XLST06
\XLST28
C
\QSTORE
\QLST28
C
\IDIM28
C--ZERO THE LIST 28 COMMON BLOCK
      CALL XZEROF(ICOM28(1),IDIM28)
C--READ THE DETAILS FOR LIST 28
      CALL XRLIND(28,I,J,K,L,M,STORE(NFL))
C--CHECK IF SUCH A LIST EXISTS
      IF(J)1250,1250,1000
C--THERE IS A LIST 28  -  LOAD IT FROM DISC
1000  CONTINUE
      CALL XLDLST(28,ICOM28,IDIM28,0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--FIND THE NUMBER OF ENTRIES IN LIST 28
      N=IDIM28/4
C--SET THE 'M' VARIABLES TO THE LAST ENTRY FOR EACH RECORD
      DO 1050 I=1,N
      J=(I-1)*4
      ICOM28(J+2)=ICOM28(J+1)+(ICOM28(J+4)-1)*ICOM28(J+3)
1050  CONTINUE
C--SET THE 'USE' POINTERS INTO LIST 6
      DO 1200 I=1,3,2
      K=(I-1)*4
C--CHECK IF THERE IS AN ENTRY FOR THIS RECORD
      IF(ICOM28(K+4))1200,1200,1100
C--COMPUTE THE ADDRESS POINTERS
1100  CONTINUE
      L=ICOM28(K+2)
      M=ICOM28(K+3)
      KK=ICOM28(K+1)
C--LOOP OVER EACH ENTRY
      DO 1150 J=KK,L,M
      ISTORE(J)=ISTORE(J)+M6
1150  CONTINUE
1200  CONTINUE
C----- FIX STEP AND STORE IT IN MD28SK
      MD28SK = MAX(1, NINT(STORE(L28SK)) )
C--CHECK IF LIST 1 IS IN CORE
1250  CONTINUE
      IF(KHUNTR(1,0,I,J,K,-1))1300,1350,1350
C--LIST 1 IS NOT IN CORE  -  FLAG ITS CONTROL VARIABLE
1300  CONTINUE
      L1S=NOWT
C--AND NOW RETURN
1350  CONTINUE
C -- NORMAL AND ERROR EXIT
9900  CONTINUE
      RETURN
      END
C
CODE FOR KALLOW
      FUNCTION KALLOW(IN)
C--THIS FUNCTION DETERMINES WHETHER A REFLECTION IS ACCEPTABLE TO LIST 2
C
C  IN  A DUMMY ARGUMENT.
C
C--THE RETURN VALUES OF 'KALLOW' ARE :
C
C  -1  NOT ACCEPTABLE.
C   0  THE REFLECTION IS OKAY.
C
C--THE REFLECTION IS TAKEN FROM THE CORE BUFFER AT 'M6', AND
C  SIN(THETA)/LAMBDA SQUARED AND FO/FC ARE COMPUTED BY THIS ROUTINE.
C
C--
\ISTORE
C
\STORE
\XCONST
\XLST06
\XLST28
C
\QSTORE
C
C----- DISALLOW THIS REFLECTION INITIALLY
      KALLOW = -1
C----- SHOULD WE SKIP IT (STEP STORED IN MD28SK IN XFAL28)
      IF (MOD (N6R, MAX(1, MD28SK) ) .NE. 0) GOTO 1650
C--COMPUTE THE SIN(THETA)/LAMBDA SQUARED
      STORE(M6+16)=SNTHL2(IN)
C--CHECK IF /FC/ IS ZERO
      IF(ABS(STORE(M6+5))-ZERO)1000,1050,1050
C--/FC/ IS ZERO  -  FO/FC DEFAULTS TO ZERO AS WELL
1000  CONTINUE
      STORE(M6+17)=ZERO
      GOTO 1100
C--COMPUTE FO/FC
1050  CONTINUE
      STORE(M6+17)=STORE(M6+3)/STORE(M6+5)
1100  CONTINUE
C--CHECK IF THERE ARE ANY MINIMA CONDITIONS
      IF(N28MN)1250,1250,1150
C--RUN THROUGH THE MINIMA CONDITIONS
1150  CONTINUE
      DO 1200 I=L28MN,M28MN,MD28MN
      J=ISTORE(I)
      IF(STORE(J)-STORE(I+1))1650,1200,1200
1200  CONTINUE
C--CHECK IF THERE ARE ANY MAXIMA CONDITIONS
1250  CONTINUE
      IF(N28MX)1400,1400,1300
C--RUN THROUGH THE MAXIMA CONDITIONS
1300  CONTINUE
      DO 1350 I=L28MX,M28MX,MD28MX
      J=ISTORE(I)
      IF(STORE(J)-STORE(I+1))1350,1350,1650
1350  CONTINUE
C--CHECK IF THERE ARE ANY SLICE CONDITIONS
1400  CONTINUE
      IF(N28RC)1600,1600,1450
C--PASS THROUGH THE SLICE CONDITIONS
1450  CONTINUE
      DO 1550 I=L28RC,M28RC,MD28RC
      A=STORE(M6)*STORE(I  )+STORE(M6+1)*STORE(I+1)+STORE(M6+2)
     2 *STORE(I+2)
C--CHECK THE MINIMUM
      IF(A-STORE(I+3))1520,1500,1500
C--CHECK THE MAXIMUM
1500  CONTINUE
      IF(A-STORE(I+4))1550,1550,1520
1520  CONTINUE
C----- REJECT OR ACCEPT?
      IF (ISTORE(I+5) .EQ. 0) GOTO 1650
1550  CONTINUE
1600  CONTINUE
      IF(N28CD)1800, 1800, 1700
C--PASS THROUGH THE REFLECTION CONDITIONS
1700  CONTINUE
      DO 1750 I = L28CD, M28CD, MD28CD
      A = STORE(M6)*STORE(I  )+STORE(M6+1)*STORE(I+1)+STORE(M6+2)
     2 *STORE(I+2) + STORE(I+3)
C--CHECK THE CONDITION
C----- REJECT OR ACCEPT?
      IF (ISTORE(I+5) .EQ. 0) THEN
        IF (MOD (ABS(A), STORE(I+4) ) .LE. ZERO) GOTO 1650
      ELSE
        IF (MOD (ABS(A), STORE(I+4) ) .GT. ZERO) GOTO 1650
      ENDIF
1750  CONTINUE
1800  CONTINUE
C
C -- CHECK FOR SPECIFIC OMISSIONS
      IF ( N28OM .LE. 0 ) GO TO 1640
      DO 1620 I = L28OM , M28OM , MD28OM
      A = 0.
      DO 1610 J = 1 , 3
      IND6 = M6 + J - 1
      IND28 = I + J - 1
      A = A + ABS ( STORE(IND6) - STORE(IND28) )
1610  CONTINUE
      IF ( A .LE.  ( 3 * ZERO )  ) GO TO 1650
1620  CONTINUE
C
1640  CONTINUE
C -- REFLECTION HAS PASSED ALL TESTS
      KALLOW=0
C--AND NOW RETURN
1650  CONTINUE
      RETURN
      END
C
CODE FOR SNTHL2
      FUNCTION SNTHL2(IN)
C--CALCULATE (SIN(THETA)/LAMBDA)**2
C
C  M6   LOCATION OF THE REFLECTION.
C  L1S  LOCATION OF THE R(IJ) TERMS.
C
C--
\STORE
\XLST01
\XLST06
C
      IDWZAP = IN
C--CHECK IF LIST 1 IS AVAILABLE
      SNTHL2=0.
      IF(L1S)1050,1050,1000
C--CALCULATE (SIN(THETA)/LAMBDA)**2
1000  CONTINUE
      SNTHL2=STORE(M6)*STORE(M6)*STORE(L1S)+STORE(M6+1)*STORE(M6+1)
     2 *STORE(L1S+1)+STORE(M6+2)*STORE(M6+2)*STORE(L1S+2)+STORE(M6+1)
     3 *STORE(M6+2)*STORE(L1S+3)+STORE(M6)*STORE(M6+2)*STORE(L1S+4)
     4 +STORE(M6)*STORE(M6+1)*STORE(L1S+5)
C--AND NOW RETURN
1050  CONTINUE
      RETURN
      END
C
CODE FOR KTYP06
      FUNCTION KTYP06(IULN)
C--SET THE TYPE OF LIST 6 TO BE USED.
C
C  IULN    THE NUMBER OF THE LIST 6, IN THE RANGE 1 TO N. THE FOLLOWING
C          TYPES ARE KNOWN AT PRESENT :
C
C          1  TYPE IS 6.
C
C--NO OTHER TYPES ARE SUPPORTED AND AN ERROR IS REPORTED FOR ANY OTHERS.
C
C--RETURN VALUES OF 'KTYP06' ARE :
C
C  >0  THE LIST TYPE TO BE USED.
C
C--
C
      DIMENSION ITYPE(2)
C
\XUNITS
\XSSVAL
\XERVAL
\XIOBUF
C
C
      DATA ITYPE(1)/6/
C
C--CHECK THE INPUT VALUE
      IF(IULN)1000,1000,1100
C--TYPE IS ILLEGAL
1000  CONTINUE
      CALL XERHDR(-1)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1050)IULN
      ENDIF
      WRITE(NCAWU,1050)IULN
      WRITE ( CMON, 1050) IULN
      CALL XPRVDU(NCVDU, 1,0)
1050  FORMAT(' Illegal list 6 type selector ',I5)
      CALL XERHND ( IERPRG )
C--CHECK THE MAXIMUM
1100  CONTINUE
      IF(IULN-2)1150,1000,1000
C--FIND THE TYPE
1150  CONTINUE
      KTYP06=ITYPE(IULN)
      RETURN
      END
CODE FOR XIRTAC
      SUBROUTINE XIRTAC(IPOSN)
C--INITIATE THE ACCUMULATION OF DETAILS FOR THE REFLECTIONS. THIS
C  ROUTINE SETS UP ONE SLOT IN THE RECORD STARTING AT 'STORE(L6DTL)'.
C
C  IPOSN   THE NUMBER OF THE SLOT TO INITIATE, IN THE RANGE 1 TO MD6.
C
C--
\STORE
\XLST06
C
C--COMPUTE THE ADDRESS IN THE DETAILS RECORD.
      I=L6DTL+(IPOSN-1)*MD6DTL
C--SET THE MAXIMUM AND MINIMUM FLAGS
      STORE(I)=1E20
      STORE(I+1)=-1E20
C--SET THE SLOTS FOR THE MEAN AND R.M.S.
      STORE(I+2)=0.
      STORE(I+3)=0.
      RETURN
      END
C
CODE FOR XACRT
      SUBROUTINE XACRT(IPOSN)
C--ADD IN THE TOTAL FOR A REFLECTION TO A GIVEN SLOT IN THE DETAILS
C  RECORD.
C
C  IPOSN   THE POSITION IN THE DETAILS RECORD TO BE UPDATED, IN THE RANG
C          1 TO MD6.
C
C--
\STORE
\XLST06
C
C--FIND THE POSITION IN THE DETAILS AND CORE BUFFER
      I=IPOSN-1
      J=L6DTL+I*MD6DTL
      I=M6+I
C--FIND THE NEW MAXIMUM AND MINIMUM
      STORE(J)=AMIN1(STORE(J),STORE(I))
      STORE(J+1)=AMAX1(STORE(J+1),STORE(I))
C--ADD IN FOR THE MEAN AND R.M.S.
      STORE(J+2)=STORE(J+2)+STORE(I)
      STORE(J+3)=STORE(J+3)+STORE(I)*STORE(I)
      RETURN
      END
C
CODE FOR XCRD
      SUBROUTINE XCRD(IPOSN)
C--COMPUTE THE REFLECTIONS DETAILS AT THE POSITION INDICATED.
C
C  IPOSN   THE POSITION IN THE DETAILS RECORD TO BE COMPUTED, IN THE
C          RANGE 1 TO MD6.
C
C--
\STORE
\XLST06
C
C--CHECK IF ANY REFLECTIONS HAVE BEEN OUTPUT
      A=0.
      IF(N6W)1050,1050,1000
C--COMPUTE THE RECIPROCAL OF THE NUMBER OF REFLECTIONS OUTPUT
1000  CONTINUE
      A=1./FLOAT(N6W)
C--COMPUTE THE POSITION IN THE DETAILS RECORD
1050  CONTINUE
      I=L6DTL+(IPOSN-1)*MD6DTL
C--COMPUTE THE MEAN
      STORE(I+2)=STORE(I+2)*A
C--COMPUTE THE R.M.S. VALUE
      STORE(I+3)=SQRT(STORE(I+3)*A)
      RETURN
      END
C
CODE FOR XWRDTD
      SUBROUTINE XWRDTD(IULN)
C--WRITE THE REFLECTION DETAILS RECORD TO DISC
C
C  IULN    THE LIST THAT IS BEING OUTPUT AS A LIST TYPE 6.
C
C--
\HEADES
C
\ISTORE
\STORE
\XLST06
\XLISTI
\QSTORE
C
C--SET THE LIST TYPE
      LN=IULN
C--FIND THE RECORD ON DISC
      I=KFNDRI(IULN,107,J,IBUFF)
C--WRITE THE NEW DETAILS TO DISC
      CALL XUPF(IBUFF(4), ISTORE(L6DTL), IBUFF(3)-MD0)
C--FIND THE RECORD ON DISC
      I=KFNDRI(IULN,106,J,IBUFF)
C--WRITE THE NEW DETAILS TO DISC
      CALL XUPF(IBUFF(4),STORE(L6P),IBUFF(3)-MD0)
      RETURN
      END
CODE FOR KLDRNR
      FUNCTION KLDRNR(IN)
C--LOAD THE NEXT REFLECTION FROM THE DISC
C
C  IN  A DUMMY ARGUMENT.
C
C--RETURN VALUES ARE :
C
C  -1  END OF DATA  -  ALL SUBSEQUENT ACCESSES WILL RETURN THIS VALUE
C   0  REFLECTION TRANSFERRED TO THE CORE BUFFER.
C
C      IDISPL      FLAG CONTROLLING LIST 6 DISPLAY
C                    -1      NO DISPLAY
C                    +1      DISPLAY
C
      LOGICAL DISPL6
      PARAMETER (NINTER = 50)
C--
\ISTORE
C
\XDRIVE
\STORE
\XLST06
\XPCK06
\XTAPES
\XTAPED
\XUNITS
\XIOBUF
\XSSVAL
\XCHARS
\XCONST
C
      SAVE DISPL6 , IDISPL , NXTLVL , NSTAR
C
\QSTORE
C
      DATA IDISPL / 1 /
C
C
C--CHECK FOR END OF FILE
      KLDRNR=-1
      IF(N6R)1550,1550,1000
C--READ DOWN THE NEXT REFLECTION
1000  CONTINUE
      KLDRNR=0
      CALL XZEROF(STORE(M6),MD6)
C--CHECK FOR INPUT FROM M/T
      IF(L6R)1050,1050,1100
C--INPUT FROM TAPE  -  FETCH THE NEXT REFLECTION
1050  CONTINUE
      CALL XIMTRA(MTA)
      M6R=MMTR
      GOTO 1150
C--INPUT FROM DISC
1100  CONTINUE
      CALL XDOWNF(L6R,STORE(M6R),MD6R)
C--UPDATE THE POINTERS FOR THE DISC
      L6R=L6R+KINCRF(MD6R)
C--UPDATE THE NUMBER OF REFLECTIONS LEFT TO READ
1150  CONTINUE
      N6R=N6R-1
C--TRANSFER THE DATA TO THE CORE BUFFER
      J=M6R
      DO 1200 I=L6DMP,M6DMP
      K=ISTORE(I)
      STORE(K)=STORE(J)
      J=J+1
1200  CONTINUE
C--CHECK IF THE INDICES SHOULD BE UNPACKED
      IF(IPACKR)1300,1250,1250
C--UNPACK THE REFLECTIONS
1250  CONTINUE
      A=FLOAT(NINT(STORE(M6+14)/256.))
      STORE(M6)=STORE(M6+14)-A*256.
      STORE(M6+2)=FLOAT(NINT(A/256.))
      STORE(M6+1)=A-STORE(M6+2)*256.
C--CHECK IF THE PHASE AND BATCH NUMBER SHOULD BE UNPACKED
1300  CONTINUE
      IF(IPHSER)1400,1350,1350
C--UNPACK THE PHASE AND BATCH NUMBER
1350  CONTINUE
      STORE(M6+13)=AINT(STORE(M6+15)*0.05)
      STORE(M6+6)=STORE(M6+15)-STORE(M6+13)*20.-10.
C -- CHECK IF THE RATIO AND JCODE SHOULD BE UNPACKED
1400  CONTINUE
      IF ( JCDRAR .GE. 0 ) THEN
        STORE(M6+20) = AINT(STORE(M6+31)*0.1+0.005) * 0.1
        STORE(M6+18) = STORE(M6+31) - ( 100. * STORE(M6+20) )
      ENDIF
      STORE(M6+13) = AMAX1 ( STORE(M6+13) , 1.0 )
C
C -- MAKE SURE 'SIGMA' AND 'CORRECTIONS' HAVE REASONABLE VALUES
      IF ( STORE(M6+12) .LT. ZERO ) STORE(M6+12) = ZERO
      IF ( STORE(M6+27) .LT. ZERO ) STORE(M6+27) = 1.0
C
C -- PRODUCE DISPLAY IF REQUIRED
      DISPL6 = ( IDISPL .GT. 0 ) .AND. ( IQUN .EQ. JQUN ) .AND.
     2     ( ISSSPD .GT. 1 ) .AND. ( N6D .GT. 0 )
C
      IF ( DISPL6 ) THEN
        IF ( N6R .GE. (N6D-1) ) THEN
CNOV98WIN32          WRITE ( CMON,1505)
CNOV98WIN32          CALL XPRVDU(NCVDU, 1, 0)
          WRITE(NCVDU,1505)
1505      FORMAT ( 15X , '0', 12X, 'Processing reflections ',
     2    11X , '100%')
          IF (ISSTML .EQ. 3 ) CALL VGACOL ( 'BOL', 'YEL', 'BLA' )
          WRITE(NCVDU,'(15X,''^'',$)')
          NSTAR = 1
          NXTLVL = ( NSTAR * N6D ) / NINTER
        ELSE IF ( (N6D-N6R) .GE. NXTLVL ) THEN
          IPERCN = MIN0 ( 100 , ( 100 * NSTAR ) / NINTER )
          CALL SLIDER (NSTAR, NINTER)
C
C -- CALCULATE WHERE NEXT PRINT IS DUE
C
          NPREV = NXTLVL + 1
1520      CONTINUE
          NSTAR = NSTAR + 1
          NXTLVL = ( NSTAR * N6D ) / NINTER
          IF ( ( NXTLVL .LE. NPREV ) .AND.
     2         ( NSTAR .LE. NINTER ) ) GO TO 1520
C
1530      CONTINUE
          NSTAR = NSTAR + 1
          NEWLVL = ( NSTAR * N6D ) / NINTER
          IF ( ( NEWLVL .LE. NXTLVL ) .AND.
     2         ( NSTAR .LE. NINTER ) ) GO TO 1530
C
          NSTAR = MIN0 ( NSTAR - 1 , NINTER )
C
        ENDIF
      ENDIF
      RETURN
C
1550  CONTINUE
      IF ( ISSTML .EQ. 3)  CALL VGACOL ( 'BOL', 'WHI', 'BLU' )
C------ SWITCH ON LINE FEEDS FOR DOS
          JNL77 = 1
      WRITE(NCAWU,1560)
C      WRITE(CMON,1560)
C      CALL XPRVDU(NCVDU, 2,0)
1560  FORMAT(' ')
      RETURN
      END
C
