CODE FOR XSMMRY 
      SUBROUTINE XSMMRY
C
C -- SUBROUTINE TO SUMMARISE DATA
C
C -- THIS ROUTINE IMPLEMENTS THE CRYSTALS 'SUMMARY' AND 'DISPLAY'
C    INSTRUCTIONS
C
C      VERSION
C      1.00      NOVEMBER 1984         PWB   INITIAL VERSION FOR LISTS
C                                            5 AND 6
C      1.01      DECEMBER 1984         PWB   ADD LISTS 1, 2, 3, 4, 13,
C                                            14, 23, 27, 28, 29
C      1.02      JANUARY 1985          PWB   ADD LISTS 12 AND 16
C      2.00      JANUARY 1985          PWB   REORGANISE TO USE 'KSUMLN'
C      2.01      JANUARY 1985          PWB   ADD 'EVERYTHING'
C
C
      PARAMETER ( NSMTYP = 50 )
      DIMENSION ISMTYP(NSMTYP)
C --
\ISTORE
C
\STORE
\XUNITS
\XSSVAL
\XERVAL
\XOPVAL
C
\QSTORE
C
C----- SEE ALSO KSUMLN - FOR THE SAME DATA - SHOULD IT BE IN BLOCK DATA?
      DATA ISMTYP /  1 ,  2 ,  3 ,  4 ,  5 ,     6 ,  0 ,  0 ,  0 , 10 ,
     2               0 , 12 , 13 , 14 ,  0 ,    16 , 17 ,  0 ,  0 ,  0 ,
     3               0 ,  0 , 23 ,  0 ,  0 ,     0 , 27 , 28 , 29 , 30 ,
     4               0 ,  0 ,  0 ,  0 ,  0 ,     0 ,  0 ,  0 ,  0 ,  0 ,
     5               0 ,  0 ,  0 ,  0 ,  0 ,     0 ,  0 ,  0 ,  0 ,  0 /
C
      DATA IVERSN / 201 /
C
      DATA ICOMSZ / 3 /
C
&PPCCS***
&PPC      CALL SETSTA( 'Summary ' )
&PPC      CALL NBACUR
&PPCCE***
C
C -- SET THE TIMING AND READ THE CONSTANTS
C
      CALL XTIME1 ( 2 )
      CALL XCSAE
C
C -- ALLOCATE SPACE TO HOLD RETURN VALUES FROM INPUT
CMAR98
      ICOMBF = KSTALL( ICOMSZ)
      CALL XZEROF (STORE(ICOMBF), ICOMSZ)
      I = KRDDPV ( ISTORE(ICOMBF) , ICOMSZ )
      IF ( I .LT. 0 ) GO TO 9910
C
C -- SET LIST TYPE AND LISTING LEVEL FLAG
C
        ITYPE = ISTORE(ICOMBF)
        LEVEL = ISTORE(ICOMBF+1)
C
C -- CHECK REQUEST
      IF ( ISTORE(ICOMBF+2) .LE. 0 ) THEN
C
C -- SPECIFIC LIST SUMMARY REQUIRED.
        ISTAT = KSUMLN ( ITYPE , LEVEL , 1 )
        IF ( ISTAT .LE. 0 ) GO TO 9900
      ELSE
C -- 'EVERYTHING'
        DO 2100 I = 1 , NSMTYP
          IF ( ISMTYP(I)  .GT. 0 ) THEN
            IF ( KEXIST(I) .GT. 0 ) THEN
              ISTAT = KSUMLN ( I , LEVEL , 1 )
            ENDIF
          ENDIF
2100    CONTINUE
      ENDIF
C
C
9000  CONTINUE
C -- FINAL MESSAGE
      CALL XOPMSG ( IOPDSP , IOPEND , IVERSN )
      CALL XTIME2 ( 2 )
C
      CALL XRSL
      CALL XCSAE
C
      RETURN
C
C
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPDSP , IOPABN , 0 )
      GO TO 9000
9910  CONTINUE
C -- INPUT ERRORS
      CALL XOPMSG ( IOPDSP , IOPCMI , 0 )
      GO TO 9900
C
C
      END
C
C
C
C
C
CODE FOR KSUMLN
      FUNCTION KSUMLN ( LSTYPE , LEVEL , LOADLN )
C
C -- SUBROUTINE PRODIVING LINK TO SUMMARY CODE
C
C -- INPUT
C      LSTYPE      LIST TYPE TO SUMMARISE
C      LEVEL       LEVEL OF SUMMARY ( ONLY FOR TYPE = 5 )
C      LOADLN      LOAD LIST BEFORE PRODUCING SUMMARY
C                    0 DO NOT LOAD LIST. A SUITABLE LIST HAS ALREADY
C                      BEEN LOADED
C                    1 LOAD LIST
C
C -- RETURN VALUE :-
C      -VE      ERROR PRODUCING SUMMARY. THE LIST CANNOT BE
C               SUMMARISED
C      +VE      SUCCESS
C
      PARAMETER ( NSMTYP = 50 )
      DIMENSION ISMTYP(NSMTYP)
C
      PARAMETER (NLTYPE = 31)
      CHARACTER*32 CLTYPE(NLTYPE)
      DIMENSION LLTYPE(NLTYPE)
C
\XLST01
\XLST02
\XLST03
\XLST04
\XLST05
\XLST06
\XLST13
\XLST14
\XLST23
\XLST27
\XLST28
\XLST29
\XLST30
\XUNITS
\XSSVAL
\XERVAL
\XIOBUF
C
C
C -- THE ARRAY 'ISMTYP' INDICATES WHETHER A SUMMARY IS AVAILABLE, AND
C    WHICH STRING FROM 'CLTYPE' SHOULD BE USED TO DESCRIBE THE DATA
C
C      1 - 9 , 10 - 19 , 20 - 29 , 30 - 39 , 40 - 49 , 50
C
C----- SEE ALSO KSUMLN - FOR THE SAME DATA - SHOULD IT BE IN BLOCK DATA?
      DATA ISMTYP /  1 ,  2 ,  3 ,  4 ,  5 ,     6 ,  0 ,  0 ,  0 , 10 ,
     2               0 , 12 , 13 , 14 ,  0 ,    16 , 17 ,  0 ,  0 ,  0 ,
     3               0 ,  0 , 23 ,  0 ,  0 ,     0 , 27 , 28 , 29 , 30 ,
     4               0 ,  0 ,  0 ,  0 ,  0 ,     0 ,  0 ,  0 ,  0 ,  0 ,
     5               0 ,  0 ,  0 ,  0 ,  0 ,     0 ,  0 ,  0 ,  0 ,  0 /
C
C
      DATA CLTYPE / 'Cell parameters', 'Symmetry',
     2 'Scattering factors', 'Weighting scheme', 'Parameters',
     3 'Reflection data', 3*'*', 'Peaks', '*', 'Refinement directives',
     4 'Diffraction conditions', 'Asymmetric section', '*',
     4 'Restraints', 'Special restraints', 5*'*',
     5 'S.F. modifications', 3*'*', 'Raw data scale factors',
     6 'Reflection selection conditions', 'Elemental properties',
     7 'General details', '*' /
C
      DATA LLTYPE / 15, 8,
     2 18, 16, 10,
     3 15, 1, 1, 1,  5, 1,  21,
     4 22, 18, 1,
     4 10, 18, 1, 1, 1, 1, 1,
     5 18, 1, 1, 1, 22,
     6 31, 20, 15,
     7 1 /
C
C
C
C -- CHECK TYPE NUMBER
C
      IF ( LSTYPE .LE. 0 ) GO TO 9910
      IF ( LSTYPE.GT. NSMTYP ) GO TO 9910
C
      INTLTP = ISMTYP(LSTYPE)
      IF ( INTLTP .LE. 0 ) GO TO 9920
C
C -- LOAD LIST IF REQUIRED
C
      IF ( LOADLN .GT. 0 ) THEN
C
        IF ( LSTYPE .EQ. 1 ) THEN
      IF (KHUNTR (1,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL01
        ELSE IF ( LSTYPE .EQ. 2 ) THEN
      IF (KHUNTR (2,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL02
        ELSE IF ( LSTYPE .EQ. 3 ) THEN
      IF (KHUNTR (3,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL03
        ELSE IF ( LSTYPE .EQ. 4 ) THEN
      IF (KHUNTR (4,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL04
        ELSE IF ( LSTYPE .EQ. 5 ) THEN
      IF (KHUNTR (5,0, IADDL,IADDR,IADDD, -1) .LT. 0)
     1  CALL XLDR05 ( LSTYPE )
        ELSE IF ( LSTYPE .EQ. 6 ) THEN
      IF (KHUNTR ( 1,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL01
      IF (KHUNTR ( 5,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL05
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL30
          CALL XFAL06 ( 0 )
        ELSE IF ( LSTYPE .EQ. 10 ) THEN
      IF (KHUNTR (10,0, IADDL,IADDR,IADDD, -1) .LT. 0)
     1  CALL XLDR05 ( LSTYPE )
        ELSE IF ( LSTYPE .EQ. 13 ) THEN
      IF (KHUNTR (13,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL13
        ELSE IF ( LSTYPE .EQ. 14 ) THEN
      IF (KHUNTR (14,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL14
        ELSE IF ( LSTYPE .EQ. 23 ) THEN
      IF (KHUNTR (23,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL23
        ELSE IF ( LSTYPE .EQ. 27 ) THEN
      IF (KHUNTR (27,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL27
        ELSE IF ( LSTYPE .EQ. 28 ) THEN
      IF (KHUNTR (28,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL28
        ELSE IF ( LSTYPE .EQ. 29 ) THEN
      IF (KHUNTR (29,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL29
        ELSE IF ( LSTYPE .EQ. 30 ) THEN
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL30
        ENDIF
C
        IF ( IERFLG .LT. 0 ) GO TO 9900
      ENDIF
C
C -- PRODUCE SUMMARY
C
      IF (ISSPRT .EQ. 0)
     1 WRITE ( NCWU , 1005 ) LSTYPE , CLTYPE(INTLTP)(1:LLTYPE(INTLTP))
      WRITE ( NCAWU , 1005 ) LSTYPE , CLTYPE(INTLTP)(1:LLTYPE(INTLTP))
      WRITE ( CMON , 1005 ) LSTYPE , CLTYPE(INTLTP)(1:LLTYPE(INTLTP))
      CALL XPRVDU(NCVDU, 1,0)
1005  FORMAT (' Summary of contents of list' , I3 ,
     2 ' - ' , A )
C
C
      IF ( LSTYPE .EQ. 1 ) THEN
        CALL XSUM01
      ELSE IF ( LSTYPE .EQ. 2 ) THEN
        CALL XSUM02
      ELSE IF ( LSTYPE .EQ. 3 ) THEN
        CALL XSUM03
      ELSE IF ( LSTYPE .EQ. 4 ) THEN
        CALL XSUM04
      ELSE IF ( LSTYPE .EQ. 5 ) THEN
        CALL XSUM05 ( LSTYPE , LEVEL )
      ELSE IF ( LSTYPE .EQ. 6 ) THEN
        CALL XSUM06
      ELSE IF ( LSTYPE .EQ. 10 ) THEN
        CALL XSUM05 ( LSTYPE , LEVEL )
      ELSE IF ( LSTYPE .EQ. 12 ) THEN
        CALL XPRTLX ( LSTYPE , -1 )
      ELSE IF ( LSTYPE .EQ. 13 ) THEN
        CALL XSUM13
      ELSE IF ( LSTYPE .EQ. 14 ) THEN
        CALL XSUM14
      ELSE IF ( LSTYPE .EQ. 16 ) THEN
        CALL XPRTLX ( LSTYPE , -1 )
      ELSE IF ( LSTYPE .EQ. 17 ) THEN
        CALL XPRTLX ( LSTYPE , -1 )
      ELSE IF ( LSTYPE .EQ. 23 ) THEN
        CALL XSUM23
      ELSE IF ( LSTYPE .EQ. 27 ) THEN
        CALL XSUM27
      ELSE IF ( LSTYPE .EQ. 28 ) THEN
        CALL XSUM28
      ELSE IF ( LSTYPE .EQ. 29 ) THEN
        CALL XSUM29
      ELSE IF ( LSTYPE .EQ. 30 ) THEN
        CALL XSUM30
      ENDIF
C
      IERFLG = 1
C
C
      KSUMLN = 1
      RETURN
C
C
9900  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9905 ) LSTYPE
      WRITE ( NCAWU , 9905 ) LSTYPE
      WRITE ( CMON , 9905 ) LSTYPE
      CALL XPRVDU(NCVDU, 1,0)
9905  FORMAT (' Summary of list type' , I3 , ' abandoned' )
      KSUMLN = -1
      RETURN
9910  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9915 ) LSTYPE
      WRITE ( NCAWU , 9915 ) LSTYPE
      WRITE ( CMON , 9915 ) LSTYPE
      CALL XPRVDU(NCVDU, 1,0)
9915  FORMAT (' Illegal list number for summary - ' , I12 )
      CALL XERHND ( IERWRN )
      GO TO 9900
9920  CONTINUE
C -- NO PROVISON FOR SUMMARY OF THIS LIST
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9925 ) LSTYPE
      WRITE ( NCAWU , 9925 ) LSTYPE
      WRITE ( CMON , 9925 ) LSTYPE
      CALL XPRVDU(NCVDU, 1,0)
9925  FORMAT (' No summary of list type ' , I5 , ' is available' )
      CALL XERHND ( IERWRN )
      GO TO 9900
C
      END
C
C
C
C
C
CODE FOR XSUM01
      SUBROUTINE XSUM01
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 1
C
\ISTORE
C
\STORE
\XLST01
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
C
C
C
C -- BEGIN OUTPUT
C
C -- CONVERT ANGLES TO DEGREES
C
      CALL XMULTR ( STORE(L1P1+3) , RTD , STORE(L1P1+3) , 3 )
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU,1015) ( STORE(J),J = L1P1,L1P1+6)
      WRITE ( NCAWU,1015) ( STORE(J),J = L1P1,L1P1+6)
      WRITE ( NCAWU,1015) ( STORE(J),J = L1P1,L1P1+6)
      WRITE ( CMON, 1015) ( STORE(J),J = L1P1,L1P1+6)
      CALL XPRVDU(NCVDU, 2,0)
1015  FORMAT (
     2 1X, 'a =     ',F9.4, '    b =    ',F9.4, '    c =     ',F9.4, /,
     3 1X, 'alpha = ',F9.4, '    beta = ',F9.4, '    gamma = ',F9.4,
     4 1x, 'Volume= ',F10.2)
C
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM02
      SUBROUTINE XSUM02
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 2
C
      CHARACTER*32 OPERAT
      CHARACTER*16 LATTIC(7)
      CHARACTER *5 CNOT
      CHARACTER *2 CNO
      CHARACTER *80 CLINE, CLOW
C
\ISTORE
C
\STORE
\XLST01
\XLST02
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      DATA LATTIC / 'primitive' , 'body centered' , 'rhombohedral' ,
     2 'face centered' , 'A centered' , 'B centered' , 'C centered' /
      DATA CNOT / ' non-' /, CNO / 'no' /
C
C
C----- FIND FLOATING ORIGINS - WE NEED LISTS 1 AND 5
      IORI = -1
      IF (KHUNTR ( 1,0, IADDL,IADDR,IADDD, -1) .LT. 0) THEN
       IF (KEXIST(1) .GT. 0) CALL XFAL01
      ENDIF
      IF (KHUNTR ( 5,0, IADDL,IADDR,IADDD, -1) .LT. 0)  THEN
       IF (KEXIST(5) .GT. 0) CALL XFAL05
      ENDIF
C----- NOW SEE IF THEY ARE LOADED
      IF ((KHUNTR ( 1,0, IADDL,IADDR,IADDD, -1) .GE. 0) .AND.
     1 (KHUNTR ( 5,0, IADDL,IADDR,IADDD, -1) .GE. 0)) THEN
            IORI = KSPINI( -1, .06)
            IF (IORI .GE. 0) CALL XFLORG( N2, 0, IORI)
      ENDIF
C -- BEGIN OUTPUT
C
C -- GET CENTRO AND LATTICE TYPE FLAGS
C
      ICENTR = NINT ( STORE(L2C) )
      LATTYP = NINT ( STORE(L2C+1) )
C
      CLOW = ' '
C----- DISPLAY SPACE GROUP SYMBOL
      J  = L2SG + MD2SG - 1
      WRITE(CLINE,2100) (ISTORE(I), I = L2SG, J)
2100  FORMAT('Space group symbol is ', 2X, 4(A4,1X))
      CALL XCREMS(CLINE, CLOW, ILAST)
C
C----- DISPLAY CRYSTAL CLASS
      WRITE(CLOW(40:),2200) (ISTORE(I), I = L2CC, L2CC+MD2CC-1)
2200  FORMAT('Crystal class is ', 1X, 4(A4))
      CALL XCTRIM (CLOW, ILAST)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2201) CLOW(1:ILAST)
      WRITE(NCAWU,2201) CLOW(1:ILAST)
      WRITE ( CMON, 2201) CLOW(1:ILAST)
      CALL XPRVDU(NCVDU, 1,0)
2201  FORMAT(1X,A)
C
      WRITE ( CLINE , 1025 ) LATTIC(LATTYP)
1025  FORMAT ('The lattice type is : ' , A )
      WRITE ( CLINE(40:) , 1035 ) N2
1035  FORMAT ('with ' , I3 , ' unique symmetry operators' )
      CALL XCTRIM (CLINE, ILAST)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2201) CLINE(1:ILAST)
      WRITE(NCAWU,2201) CLINE(1:ILAST)
      WRITE ( CMON, 2201) CLINE(1:ILAST)
      CALL XPRVDU(NCVDU, 1,0)
C
      LENCEN = 1
      IF ( ICENTR .LE. 0 ) LENCEN = 5
      WRITE ( CLINE , 1015 ) CNOT(1:LENCEN)
1015  FORMAT ('The space group is' , A , 'centrosymmetric' )
      CALL XCREMS(CLINE, CLOW, ILAST)
      IF (IORI .GE. 0)
     1 WRITE(CLOW(40:),'(A,I2,A)') 'with',IORI, ' floating origins'
      CALL XCTRIM (CLOW, ILAST)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,2201) CLOW(1:ILAST)
      WRITE(NCAWU,2201) CLOW(1:ILAST)
      WRITE ( CMON, 2201) CLOW(1:ILAST)
      CALL XPRVDU(NCVDU, 1,0)
C
C
C -- DISPLAY EACH SYMMETRY OPERATOR
C
      M2 = L2 + (N2-1) * MD2
      J = 1
      DO 2000 I = L2 , M2 , MD2
        CALL XSUMOP ( STORE(I) , STORE(L2P) , CLINE , LENGTH )
        CALL XCCLWC(CLINE(1:LENGTH), OPERAT(1:LENGTH))
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1105 ) OPERAT(1:LENGTH)
        WRITE ( NCAWU , 1105 ) OPERAT(1:LENGTH)
1105    FORMAT ( 1X , A )
        LENGTH = MIN(19,LENGTH)
        IF (J .GT. 80) THEN
            CALL XPRVDU(NCVDU, 1,0)
            J = 1
        ENDIF
        WRITE(CMON(1)(J:),1106) OPERAT(1:LENGTH)
1106    FORMAT ( A )
        J = J + 20
2000  CONTINUE
      IF (J .NE. 1) CALL XPRVDU(NCVDU, 1,0)
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM03
      SUBROUTINE XSUM03
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 3
C
\ISTORE
C
\STORE
\XLST03
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
C
C
C
C -- BEGIN OUTPUT
C
      IF ( N3 .GT. 0 ) THEN
        IF (ISSPRT .EQ. 0)WRITE ( NCWU , 1015 )
        WRITE ( NCAWU , 1015 )
        WRITE ( CMON  , 1015 )
        CALL XPRVDU(NCVDU, 1,0)
1015    FORMAT ( ' Scattering factors are known for :- ' )
C
        IF (ISSPRT .EQ. 0)
     1  WRITE ( NCWU , 1025 ) ( STORE(J) , J = L3 , M3 , MD3 )
        WRITE ( NCAWU , 1025 ) ( STORE(J) , J = L3 , M3 , MD3 )
        WRITE ( CMON  , 1025 ) ( STORE(J) , J = L3 , M3 , MD3 )
        CALL XPRVDU(NCVDU, 1,0)
1025    FORMAT ( 1X , 19A4 )
      ELSE
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1035 )
        WRITE ( NCAWU , 1035 )
        WRITE ( CMON , 1035 )
        CALL XPRVDU(NCVDU, 1,0)
1035    FORMAT (' No scattering factors stored in list 3' )
      ENDIF
C
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM04
      SUBROUTINE XSUM04
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 4
C
C -- THE EXPRESSIONS FOR THE WEIGHTS ARE CONSTRUCTED FROM THE
C    STRINGS CONTAINED IN 'CRESLT' AND 'CEXPRS' INDEXED BY
C    'IRESLT' AND 'IEXPRS'.
C
      PARAMETER ( MAXSCH = 16 )
      DIMENSION IEXPRS(2,MAXSCH)
      DIMENSION IRESLT(MAXSCH)
C
      CHARACTER*32 CSNAME(MAXSCH)
      DIMENSION    LNNAME(MAXSCH)
C
      CHARACTER*64 CFORMS(14)
      CHARACTER*8 CRESLT(2)
      CHARACTER*11 CEXPRS
C
\ISTORE
C
\STORE
\XLST04
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      DATA CFORMS /
     1 'FO/P(1), FO < P(1) or FO = P(1)' ,
     2 'P(1)/FO, FO > P(1)' ,
     3 '1.0 , FO < P(1) or FO = P(1)' ,
     4 'P(1)/FO, FO > P(1)' ,
     5 '1/(1 + [(FO - P(2))/P(1)]**2)' ,
     6 '1/[P(1) + FO + P(2)*FO**2 + . . + P(NP)*FO**NP]' ,
     7 '(Data with the key WEIGHT in list 6)' ,
     8 '1/(Data with the key SIGMA(/FO/) in list 6)' ,
     9 '1.0' ,
     + '1.0/[A[0]*T[0]''(X)+A[1]*T[1]''(X) ... +A[NP-1]*T[NP-1]''(X)]',
     1 '[SIN(theta)/lambda]^P(1)' ,
     2 '[weight] * exp[8*(p(1)/p(2))*(pi*s)^2]' ,
     3 '[weight] * [1-(deltaF/6*sigmaF)^2]^2 ' ,
     4 'q / [Sigma^2(F*)+(P(1)p)^2+P(2)p+P(4)+P(5)Sin(theta) ]' /
C
      DATA IEXPRS / 1 , 2 , 3 , 4 , 5 , 0 , 6 , 0 , 7 , 0 ,
     2 7 , 0 , 8 , 0 , 8 , 0 , 9 , 0 , 10 , 0 , 10 , 0 , 11 , 0 ,
     3 12, 0, 13, 0, 13, 0, 14, 0 /
C
C
      DATA CRESLT / 'W' , 'SQRT(W)' /
      DATA IRESLT / 2 , 2 , 1 , 1 , 1 , 2 , 1 , 2 , 1 , 1 ,
     2 1, 1, 1, 1, 1, 1 /
C
      DATA CSNAME / '( Modified Hughes )' , '( Hughes )' , ' ' ,
     2 '( Cruickshank )' , ' ' ,
     3 ' ' , ' ' , ' ' , '( Unit weights )' ,
     4 '( Chebychev polynomial )' , '( Chebychev polynomial )' ,
     5 ' ' , '( Dunitz and Seiler )', '( Tukey and Prince )',
     6 '( Tukey and Prince )', '( Modified Sheldrick )' /
      DATA LNNAME / 19 , 10 , 1 ,
     2 15 , 1 ,
     3 1 , 1 , 1 , 16 ,
     4 24 , 24 ,
     5 1, 21, 20, 20, 13 /
      DATA CEXPRS / 'expressions' /
      DATA LENEXP / 11 /
C
C
C
C
C -- BEGIN OUTPUT
C
      ITYPE = ISTORE(L4C)
      IFOTYP = ISTORE(L4C+1)
C
      IF (ISSPRT .EQ. 0)
     1 WRITE ( NCWU , 1015 ) ITYPE , CSNAME(ITYPE)(1:LNNAME(ITYPE))
      WRITE ( NCAWU , 1015 ) ITYPE , CSNAME(ITYPE)(1:LNNAME(ITYPE))
      WRITE ( CMON , 1015 ) ITYPE , CSNAME(ITYPE)(1:LNNAME(ITYPE))
      CALL XPRVDU(NCVDU, 1,0)
1015  FORMAT ( 1X , 'Weighting scheme type ' , I3 , 2X , A )
C
      LENGTH = LENEXP
      IF ( IEXPRS(2,ITYPE) .LE. 0 ) LENGTH = LENGTH - 1
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1016 ) CEXPRS(1:LENGTH)
      WRITE ( NCAWU , 1016 ) CEXPRS(1:LENGTH)
      WRITE ( CMON  , 1016 ) CEXPRS(1:LENGTH)
      CALL XPRVDU(NCVDU, 1,0)
1016  FORMAT ( 1X , 'Weights are calculated from ' ,
     2 'the following ' , A , ' :-' )
C
      DO 1018 I = 1 , 2
        ITEXT = IEXPRS(I,ITYPE)
        IF ( ITEXT .GT. 0 ) THEN
          IF (ISSPRT .EQ. 0)
     1    WRITE ( NCWU , 1017 ) CRESLT(IRESLT(ITYPE)) , CFORMS(ITEXT)
          WRITE ( NCAWU , 1017 ) CRESLT(IRESLT(ITYPE)) , CFORMS(ITEXT)
          WRITE ( CMON , 1017 ) CRESLT(IRESLT(ITYPE)) , CFORMS(ITEXT)
          CALL XPRVDU(NCVDU, 1,0)
1017      FORMAT ( 1X , A , ' = ' , A )
        ENDIF
1018  CONTINUE
C
      IF (MD4 .GT. 0) THEN
        M4 = L4 + MD4 -1
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1025 )
        WRITE ( NCAWU , 1025 )
        WRITE ( CMON , 1025 )
        CALL XPRVDU(NCVDU, 1,0)
1025    FORMAT ( 1X , 'Using parameters :- ')
        IF (ISSPRT .EQ. 0) WRITE (NCWU, 1035) (STORE(J), J = L4, M4 )
        WRITE ( NCAWU , 1035 ) ( STORE(J) , J = L4 , M4 )
        WRITE ( CMON , 1035 ) ( STORE(J) , J = L4 , M4 )
        CALL XPRVDU(NCVDU, 1,0)
1035    FORMAT ( 5X , 6G12.3 )
C
      ENDIF
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1045 ) STORE(L4F+1)
      WRITE ( NCAWU , 1045 ) STORE(L4F+1)
      WRITE ( CMON , 1045 ) STORE(L4F+1)
      CALL XPRVDU(NCVDU, 1,0)
1045  FORMAT ( 1X , 'The maximum weight is ' , G12.5 )
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM05
      SUBROUTINE XSUM05 ( ITYPE , LEVEL )
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 5 OR 10
C
\ISTORE
C
\STORE
\XLST05
\XUNITS
\XSSVAL
\XIOBUF
C
\QSTORE
C
C
      DATA ICNTSZ / 5 /
C
C
      JTYPE = ITYPE
C -- ALLOCATE MONITOR OUTPUT CONTROL AREA
      ICONTR = KSTALL ( ICNTSZ )
      CALL XZEROF ( ISTORE(ICONTR) , ICNTSZ )
C
C -- BEGIN OUTPUT
C
C     SUBROUTINE XMDMON ( ISTART , ISIZE , NDATA , IPOSIT , IPARTP ,
C    2 IFUNC , LEVEL , IMNLVL , IMNCNT , IFLAG , ICONTL )
C
C  ISTART  ADDRESS OF DATA IN 'STORE'
C  ISIZE   LENGTH OF EACH DATA ITEM
C  NDATA   NUMBER OF ITEMS
C  IPOSIT  POSITION OF FIRST ITEM IN ITS GROUP IN LIST 5, USED TO
C          CALCULATE NAMES OF SCALE FACTORS ETC.
C  IPARTP  PARAMETER TYPE
C            1  ATOMIC PARAMETERS
C            2  OVERALL PARAMETERS
C            3  LAYER SCALES
C            4  ELEMENT SCALES
C            5  BATCH SCALES
C            6  CELL PARAMETERS
C            7  PROFILE PARAMETERS
C            8  EXTINCTION PARAMETERS
C  IFUNC   REQUIRED HEADING
C  LEVEL   LEVEL OF LISTING
C  IMNLVL  ALTERNATIVE LEVEL OF LISTING
C            0  OFF     FORCE LIST LEVEL TO BE 0
C            1  LOW     FORCE LIST LEVEL TO BE < 2
C            2  MEDIUM  FORCE LIST LEVEL TO BE 'LEVEL'
C            3  HIGH    FORCE LIST LEVEL TO BE > 1
C  IMNCNT  MONITOR LEVEL CONTROL
C            0  USE SAVED LEVEL - USE WITH IFLAG = 1
C            1  USE 'LEVEL'
C            2  USE 'IMNLVL'
C  IFLAG   FORCE LISTING FLAG
C            0  LIST WHEN ON NEW VALUE OF IFUNC
C            1  FORCE LISTING NOW
C  ICONTL  CONTROL BLOCK ( ARRAY OF LENGTH 5 - SHOULD BE ZERO ON FIRST
C          CALL )
C            WORD 1  SAVED MONITOR LEVEL. THIS VALUE IS ACTUALLY USED
C                    TO CONTROL THE OUTPUT LEVEL
C                      0  NO LISTING
C                      1  LOW ATOMIC
C                      2  MEDIUM ATOMIC
C                      3  HIGH ATOMIC
C                      4  LOW OVERALL
C                      5  MEDIUM/HIGH OVERALL
C                      6  LOW LAYER/BATCH/ELEMENT
C                      7  MEDIUM/HIGH LAYER/BATCH/ELEMENT
C -- OUTPUT SCALE FACTORS OR A SUITABLE ALTERNATIVE MESSAGE IF THERE
C    ARE NONE
      IF ( ( MD5LS +MD5BS +MD5ES +MD5CL + MD5PR +MD5EX )
     1 .LE. 0 ) THEN
        WRITE ( CMON , 1065 )
        CALL XPRVDU(NCVDU, 2,0)
        WRITE(NCAWU, '(A)') (CMON(II)(:),II=1,2)
        IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') (CMON(II)(:),II=1,2)
1065    FORMAT ( 1X , 'There are no layer, element, or batch scales',/,
     1 1X, 'There are no special overall parameters' )
      ELSE
        CALL XMDMON (L5LS,1,MD5LS,1,3, 1,LEVEL,0,1,1,ISTORE(ICONTR))
        CALL XMDMON (L5ES,1,MD5ES,1,4, 1,LEVEL,0,1,1,ISTORE(ICONTR))
        CALL XMDMON (L5BS,1,MD5BS,1,5, 1,LEVEL,0,1,1,ISTORE(ICONTR))
        CALL XMDMON (L5CL,1,MD5CL,1,6, 1,LEVEL,0,1,1,ISTORE(ICONTR))
        CALL XMDMON (L5PR,1,MD5PR,1,7, 1,LEVEL,0,1,1,ISTORE(ICONTR))
        CALL XMDMON (L5EX,1,MD5EX,1,8, 1,LEVEL,0,1,1,ISTORE(ICONTR))
      ENDIF
C -- OUTPUT OVERALL PARAMETERS
CNOV98      CALL XMDMON ( L5O,1,MD5O,1,2, 1,LEVEL,0,1,1,ISTORE(ICONTR) )
      CALL XMDMON ( L5O,1,MD5O,1,2, 1, 2 ,0,1,1,ISTORE(ICONTR) )
C
C -- OUTPUT ATOMS PARAMETERS
      CALL XMDMON ( L5,MD5,N5,1,1, 1,LEVEL,0,1,1,ISTORE(ICONTR) )
C
C----- UPDATE GUIMODEL
C----- SET ILOOP TO A DUMMY, SAVE AUTOUPDTE FLAG
      ILOOP = 0
      ISAVE = ISSUPD
      ISSUPD = 1
&&&DVFGIDLIN            CALL XGDBUP('WRITE',L5,N5,MD5,ILOOP,.FALSE.,4)
      ISSUPD = ISAVE
      CALL XSTRLL ( ICONTR )
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM06
      SUBROUTINE XSUM06
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 6
C
      CHARACTER *8 CNAME(35)
\ICOM30
      DIMENSION KEY(35)
\ISTORE
C
\STORE
\XLST05
\XLST23
\XLST30
C
\XLST06
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
\QLST30
C
C
      DATA KEY/ 1, 2, 3, 4, 5, 6, 0, 0, 0, 0,
     1          0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     1          0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     1          0, 0, 0, 0, 0 /
C
      DATA CNAME/ 'H','K','L','Fo','Weight','Fc',6*' ',
     1 'Sigma',3*' ','Sth/L**2','Fo/Fc',17*' '/
C
C
      IF (KHUNTR ( 5,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL05
      IF (KHUNTR (23,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL23
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL30
C----- PRINT SOME OVER-ALL DETAILS
C--PRINT THE DETAILS RECORD
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1550)
      WRITE(NCAWU,1550)
      WRITE ( CMON ,1550)
      CALL XPRVDU(NCVDU, 1,0)
1550  FORMAT(' Quantity',12X,'Minimum',8X,'Maximum')
C--LOOP OVER EACH DETAIL STORED
      M6DTL=L6DTL
      DO 1850 I=2,N6DTL
      IF (KEY(I-1) .EQ. 0) GOTO 1800
C--CHECK IF THIS DETAIL IS SET
      IF(STORE(M6DTL+3)-ZERO)1600,1700,1700
C--NOT SET  -  PRINT THE CAPTION AND IGNORE IT
1600  CONTINUE
      IF (ISSPRT .EQ. 0)WRITE(NCWU,1650) CNAME(I-1)
      WRITE(NCAWU,1650) CNAME(I-1)
      WRITE ( CMON ,1650) CNAME(I-1)
      CALL XPRVDU(NCVDU, 1,0)
1650  FORMAT(6X,A8, 4X,'No details available')
      GOTO 1800
C--PRINT THE DETAILS
1700  CONTINUE
      K=M6DTL+MD6DTL-3
      IF (ISSPRT .EQ. 0)
     1 WRITE(NCWU,1750) CNAME(I-1), (STORE(J),J=M6DTL,K)
      WRITE(NCAWU,1750) CNAME(I-1), (STORE(J),J=M6DTL,K)
      WRITE ( CMON ,1750) CNAME(I-1), (STORE(J),J=M6DTL,K)
      CALL XPRVDU(NCVDU, 1,0)
1750  FORMAT(6X,A8,2X,6E15.6)
C--UPDATE FOR THE NEXT PARAMETER
1800  CONTINUE
      M6DTL=M6DTL+MD6DTL
1850  CONTINUE
C
C -- SCAN LIST 6 FOR ACCEPTED REFLECTIONS
C
      SCALE = STORE(L5O)
      TOP = 0.0
      BOTTOM = 0.0
      WTOP = 0.0
      WBOT = 0.0
      IFSQ = ISTORE(L23MN+1)
      N6ACC = 0
1100  CONTINUE
        ISTAT = KFNR ( 0 )
        IF ( ISTAT .LT. 0 ) GO TO 1200
        N6ACC = N6ACC + 1
        FO = STORE(M6+3)
        FC = SCALE * STORE(M6+5)
        WT = STORE(M6+4)
        TOP = TOP + ABS (ABS(FO) - FC)
        BOTTOM = BOTTOM + ABS(FO)
        IF (IFSQ .GE. 0) THEN
C - FSQ REFINENENT
            WDEL = WT* (FO * ABS(FO) - FC*FC)
            WFO = WT* (FO * ABS(FO))
        ELSE
            WDEL = WT * (FO - FC)
            WFO = WT * FO
        ENDIF
        WTOP = WTOP + WDEL*WDEL
        WBOT = WBOT + WFO*WFO
&PPCCS***
&PPC        IF ( MOD( N6ACC ,20) .EQ. 0 ) CALL nextcursor
&PPCCE***
        GO TO 1100
C
C
C -- BEGIN OUTPUT
C
1200  CONTINUE
C----- COMPUTE AND STORE R-VALUES
      RFACT = 100. * TOP / BOTTOM
      IF (WBOT .LE. 0.0) THEN
        WRFAC = 0.0
      ELSE
        WRFAC = 100. * SQRT (WTOP / WBOT)
      ENDIF
      STORE(L6P+1) = RFACT
      STORE(L6P+2) = WRFAC
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1215 ) N6D , N6ACC
      WRITE ( NCAWU , 1215 ) N6D, N6ACC
      WRITE ( CMON , 1215 ) N6D, N6ACC
      CALL XPRVDU(NCVDU, 1,0)
1215  FORMAT ( 1X , 'List 6 contains ' , I5 , ' reflections' ,
     1 ' of which ' , I5 , ' are accepted by LIST 28')
C
C
C -- PRINT THE R VALUE ETC.
      J = NINT(STORE(L6P))
      M6P = L6P+2
      IF (ISSPRT .EQ. 0)
     1 WRITE ( NCWU , 1235 ) J , ( STORE(I+1) , I=L6P,M6P )
      WRITE ( NCAWU , 1235 ) J , ( STORE(I+1) , I=L6P,M6P )
      WRITE ( CMON , 1235 ) J , ( STORE(I+1) , I=L6P,M6P )
      CALL XPRVDU(NCVDU, 2,0)
1235  FORMAT (1X , 'After ' , I5 ,
     2 ' structure factor/refinement calculations ' , / ,
     3 1X , 'R = ' , F6.2 , 5X , 'Weighted R = ' , F6.2 ,
     4 5X , 'Minimisation function = ' , E15.6 )
C
C
C----- UPDATE LIST 30
C----- DONT UPDATE LIST 30 -  THE USER MIGHT BE FIDDLING WITH LIST 28
C      STORE(L30RF) = RFACT
C      STORE(L30RF+1) = WRFAC
C      CALL XWLSTD ( 30, ICOM30, IDIM30, -1, -1)
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM13
      SUBROUTINE XSUM13
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 13
C
      PARAMETER ( NCRYST = 2 , NSPRED = 2 , NGEOMY = 10 , NRADTN = 2 )
      CHARACTER*30 CCRYST(NCRYST)
      CHARACTER*10 CSPRED(NSPRED)
      CHARACTER*10 CGEOMY(NGEOMY)
      CHARACTER*8 CRADTN(NRADTN)
C
\ISTORE
C
\STORE
\XLST13
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      DATA CCRYST / 'Friedel''s Law is used' ,
     2 'The crystal is twinned' /
      DATA CSPRED / 'Gaussian' , 'Lorentzian' /
      DATA CGEOMY /
     1 'NORMAL', 'EQUI', 'ANTI', 'PRECESSION', 'UNKNOWN',
     2 'CAD4', 'ROLLETT', 'Y290', 'KAPPA', 'AREA'
     3  /
      DATA CRADTN / 'X-rays' , 'neutrons' /
C
C -- BEGIN OUTPUT
C
      IND13 = L13CD
      DO 1100 I = 1 , NCRYST
        IF ( ISTORE(IND13) .GE. 0 ) THEN
          IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1025 ) CCRYST(I)
          WRITE ( NCAWU , 1025 ) CCRYST(I)
          WRITE ( CMON , 1025 ) CCRYST(I)
          CALL XPRVDU(NCVDU, 1,0)
1025      FORMAT ( 1X , A )
        ENDIF
        IND13 = IND13 + 1
1100  CONTINUE
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1105 ) CSPRED(ISTORE(L13CD+2))
      WRITE ( NCAWU , 1105 ) CSPRED(ISTORE(L13CD+2))
      WRITE ( CMON , 1105 ) CSPRED(ISTORE(L13CD+2))
      CALL XPRVDU(NCVDU, 1,0)
1105  FORMAT ( 1X , 'The mosaic spread is ' , A)
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1125 )
     1 CGEOMY(ISTORE(L13DT)), CRADTN(ISTORE(L13DT+1)+2)
      WRITE ( NCAWU , 1125 )
     1 CGEOMY(ISTORE(L13DT)), CRADTN(ISTORE(L13DT+1)+2)
      WRITE ( CMON , 1125 )
     1 CGEOMY(ISTORE(L13DT)), CRADTN(ISTORE(L13DT+1)+2)
      CALL XPRVDU(NCVDU, 2,0)
1125  FORMAT ( 1X , 'The diffraction geometry is ' , A /
     1 1X , 'Data was collected with ' , A )
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1145 ) STORE(L13DC)
      WRITE ( NCAWU , 1145 ) STORE(L13DC)
      WRITE ( CMON , 1145 ) STORE(L13DC)
      CALL XPRVDU(NCVDU, 1,0)
1145  FORMAT ( 1X , 'The wavelength is ' , F12.5 )
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM14
      SUBROUTINE XSUM14
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 14
C
      PARAMETER ( NAXIS = 3 , NDIVTP = 2 )
      CHARACTER*1 CAXIS(NAXIS)
      CHARACTER*7 CDIREC(NAXIS)
      CHARACTER*11 CDIVTP(NDIVTP)
C
\ISTORE
C
\STORE
\XLST14
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      DATA CAXIS / 'X' , 'Y' , 'Z' /
      DATA CDIREC / 'down' , 'across' , 'through' /
      DATA CDIVTP / 'Angstrom' , 'Division(s)' /
C
C
C
C -- BEGIN OUTPUT
C
C
      IF (ISSPRT .EQ. 0)
     1 WRITE ( NCWU , 1025 ) ( CDIREC(J) , CAXIS(ISTORE(L14O+J-1)) ,
     2                         J = 1 , NAXIS )
      WRITE ( NCAWU , 1025 ) ( CDIREC(J) , CAXIS(ISTORE(L14O+J-1)) ,
     2                         J = 1 , NAXIS )
      WRITE ( CMON , 1025 ) ( CDIREC(J) , CAXIS(ISTORE(L14O+J-1)) ,
     2                         J = 1 , NAXIS )
      CALL XPRVDU(NCVDU, 1,0)
1025  FORMAT ( 1X , 'Orientation of map is ',
     1 3 ( A , 1X , A , 2X ) )
C
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1035 ) STORE(L14SC)
      WRITE ( NCAWU , 1035 ) STORE(L14SC)
      WRITE ( CMON , 1035 ) STORE(L14SC)
      CALL XPRVDU(NCVDU, 1,0)
1035  FORMAT (1X , 'The map scale factor is ' , F10.5  )
C
      IND14 = L14
      DO 1400 I = 1 , N14
C
        IF ( ABS(STORE(IND14+3)) .LE. ZERO ) THEN
          IDIV = 1
        ELSE
          IDIV = 2
        ENDIF
C
      IF (ISSPRT .EQ. 0)
     1 WRITE ( NCWU , 1305 ) CAXIS(I), STORE(IND14), STORE(IND14+2),
     2                          STORE(IND14+1) , CDIVTP(IDIV)
        WRITE ( NCAWU , 1305 ) CAXIS(I), STORE(IND14), STORE(IND14+2),
     2                          STORE(IND14+1) , CDIVTP(IDIV)
      WRITE ( CMON , 1305 ) CAXIS(I), STORE(IND14), STORE(IND14+2),
     2                          STORE(IND14+1) , CDIVTP(IDIV)
      CALL XPRVDU(NCVDU, 1,0)
1305  FORMAT ( 1X , 'The ' , A , ' axis runs from ' , F7.2 ,
     2 ' to ' , F7.2 , ' in steps of ' , F8.4 , 1X , A )
C
        IF ( IDIV .EQ. 2 ) THEN
            IF (ISSPRT .EQ. 0)
     1      WRITE ( NCWU , 1315 ) CAXIS(I) , STORE(IND14+3)
          WRITE ( NCAWU , 1315 ) CAXIS(I) , STORE(IND14+3)
      WRITE ( CMON , 1315 ) CAXIS(I) , STORE(IND14+3)
      CALL XPRVDU(NCVDU, 1,0)
1315      FORMAT ( 11X , 'The ' , A , ' axis is divided into ' ,
     2             F8.4 , ' divisions' )
        ENDIF
C
        IND14 = IND14 + MD14
1400  CONTINUE
C
      END
C
C
CODE FOR XSUM23
      SUBROUTINE XSUM23
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 23
C
      PARAMETER (NMODFC = 7, NMODMN = 3, MMODSP = 5, NMODSP = 2)
      CHARACTER *34 CMODFC(NMODFC) , CMODMN(NMODMN)
      CHARACTER *13  CHARSP(MMODSP,NMODSP), CSP1(NMODSP)
C
      LOGICAL LHEADR
C
\ISTORE
C
\STORE
\XLST23
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      DATA CMODFC / 'Anomalous scattering' , 'Extinction parameter' ,
     2 'Layer scale factors' , 'Batch scales factors' ,
     3 'Uses stored partial contributions',
     3 'Updates stored contributions' , 'Enantiopole parameter' /
C
      DATA CMODMN(1) / 'Refinement against /F0/ **2' /
      DATA CMODMN(2) / 'Restraints applied' /
      DATA CMODMN(3) / 'Reflections used' /
C
      DATA CHARSP / 'Nothing', 'Warnings', 'Origin fixing',
     1 'Restraints ', 'Constraints ',
     2 'Nothing', 'Occupancies', 'Parameters',
     3 ' ', ' '/
      DATA CSP1 /' issued', ' updated'/
C
C
C
C -- BEGIN OUTPUT
C
      LHEADR = .FALSE.
C
      IND23 = L23M
      DO 1000 I = 1, NMODFC
        IF ( ISTORE(IND23) .GE. 0 ) THEN
          IF ( .NOT. LHEADR ) THEN
            IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1105 )
            WRITE ( NCAWU , 1105 )
            WRITE ( CMON , 1105 )
            CALL XPRVDU(NCVDU, 1,0)
1105        FORMAT ( 1X, 'Modifications applied to /FO/ and /FC/ :-')
            LHEADR = .TRUE.
          ENDIF
          IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1115 ) CMODFC(I)
          WRITE ( NCAWU , 1115 ) CMODFC(I)
          WRITE ( CMON , 1115 ) CMODFC(I)
          CALL XPRVDU(NCVDU, 1,0)
1115      FORMAT ( 2X , A )
        ENDIF
        IND23 = IND23 + 1
1000  CONTINUE
C
      IF ( LHEADR ) THEN
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1125 )
        WRITE ( NCAWU , 1125 )
1125    FORMAT ( 1X )
      ELSE
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1135 )
        WRITE ( NCAWU , 1135 )
        WRITE ( CMON , 1135 )
        CALL XPRVDU(NCVDU, 1,0)
1135    FORMAT ( 1X , 'No modifications to /FO/ and /FC/')
      ENDIF
C
      LHEADR = .FALSE.

      IF (ISSPRT .EQ. 0) WRITE(NCWU,2000) ISTORE(L23MN)
      WRITE(NCAWU,2000) ISTORE(L23MN)
      WRITE ( CMON ,2000) ISTORE(L23MN)
      CALL XPRVDU(NCVDU, 1,0)
2000  FORMAT(1X,'Refinement terminated if more than ',I4,
     1 ' singularities')
C
      IND23 = L23MN + 1
      DO 2100 I = 1 , NMODMN
        IF ( ISTORE(IND23) .GE. 0 ) THEN
          IF ( .NOT. LHEADR ) THEN
            IF (ISSPRT .EQ. 0) WRITE ( NCWU , 2005 )
            WRITE ( NCAWU , 2005 )
            WRITE ( CMON , 2005 )
            CALL XPRVDU(NCVDU, 1,0)
2005        FORMAT ( 1X, 'Conditions applied to minimisation ' ,
     2                    'function :-')
            LHEADR = .TRUE.
          ENDIF
          IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1115 ) CMODMN(I)
          WRITE ( NCAWU , 1115 ) CMODMN(I)
          WRITE ( CMON , 1115 ) CMODMN(I)
          CALL XPRVDU(NCVDU, 1,0)
        ENDIF
        IND23 = IND23 + 1
2100  CONTINUE
C
      IF ( LHEADR ) THEN
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 2105 )
        WRITE ( NCAWU , 2105 )
2105    FORMAT ( 1X )
      ELSE
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 2115 )
        WRITE ( NCAWU , 2115 )
        WRITE ( CMON , 2115 )
        CALL XPRVDU(NCVDU, 1,0)
2115    FORMAT ( 1X , 'No conditions on minimisation function')
      ENDIF
C
C
      I = KHUNTR( 23, 106, IADDL, IADDR, IADDD, -1)
      IF ( I .EQ. 0) THEN
C----- THIS IS A NEW FORMAT LIST 23
        LHEADR = .FALSE.
C
C
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 3105 )
        WRITE ( NCAWU , 3105 )
        WRITE ( CMON , 3105 )
        CALL XPRVDU(NCVDU, 1,0)
3105    FORMAT ( 1X, 'Treatment of atoms on SPECIAL positions:-')
C
        IND23 = L23SP
        DO 3000 I = 1, NMODSP
           J = ISTORE(IND23)+2
           IF (ISSPRT .EQ. 0) WRITE (NCWU, 3115 ) CHARSP(J,I), CSP1(I)
           WRITE ( NCAWU , 3115 ) CHARSP(J,I), CSP1(I)
           WRITE ( CMON , 3115 ) CHARSP(J,I), CSP1(I)
           CALL XPRVDU(NCVDU, 1,0)
3115       FORMAT ( 2X , A, A )
           IND23 = IND23+1
3000    CONTINUE
        IF (ISSPRT .EQ. 0) WRITE(NCWU,3116) STORE(L23SP+5)
        WRITE(NCAWU, 3116)  STORE(L23SP+5)
        WRITE ( CMON , 3116)  STORE(L23SP+5)
        CALL XPRVDU(NCVDU, 1,0)
3116  FORMAT(' Tolerance for coincidence = ', G10.5)
C
      ELSE
        IF (ISSPRT .EQ. 0) WRITE(NCWU,3120)
        WRITE(NCAWU,3120)
        WRITE ( CMON ,3120)
        CALL XPRVDU(NCVDU, 1,0)
3120    FORMAT(1X, 'This is an old format LIST 23 - Input a new one')
      ENDIF
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM27
      SUBROUTINE XSUM27
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 27
C
\ISTORE
C
\STORE
\XLST27
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
C
       WRITE ( CMON , 1015 ) N27
       CALL XPRVDU(NCVDU, 1,0)
1015  FORMAT ( 1X , I5 , ' scale factors are known' , / )
C
      IF (N27 .GT. 0) THEN
       M27 = L27 + (N27-1)*MD27
       J = 1
       DO 2000 I = L27 , M27 , MD27
         IF (J .GE. 80) THEN
             CALL XPRVDU(NCVDU, 1,0)
             J = 1
         ENDIF
         WRITE(CMON(1)(J:),1106) STORE(I+1)
1106    FORMAT ( F8.3 )
         J = J + 8
2000   CONTINUE
       IF (J .NE. 1) CALL XPRVDU(NCVDU, 1,0)
      ENDIF
C
C
      RETURN
      END
C
C
C
C
C
CODE FOR XSUM28
      SUBROUTINE XSUM28
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 28
C
      LOGICAL LHEADR
C
\ISTORE
C
\STORE
\XLST28
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
C
C
C -- BEGIN OUTPUT
      IF (MD28SK .GT. 1 ) THEN
        I = MD28SK-1
        IF (ISSPRT .EQ. 0) WRITE(NCWU,500) I, MD28SK
        WRITE(NCAWU,500) I, MD28SK
        WRITE ( CMON ,500) I, MD28SK
        CALL XPRVDU(NCVDU, 1,0)
500     FORMAT (1X,I4, ' out of ', I4,' reflections will be skipped')
      ENDIF
C
      LHEADR = (( N28MN + N28MX + N28RC + N28OM +N28CD) .NE. 0 )
C
      IF ( LHEADR ) THEN
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1015 )
        WRITE ( NCAWU , 1015 )
        WRITE ( CMON , 1015 )
        CALL XPRVDU(NCVDU, 1,0)
1015    FORMAT ( 1X , 'Reflections are selected by the following ' ,
     2                  'conditions :-' )
C
        IF ( N28MN .GT. 0 ) THEN
          INDNAM = L28CN
          DO 1200 I = L28MN , M28MN , MD28MN
            IF (ISSPRT .EQ. 0) THEN
            WRITE ( NCWU , 1105 ) ( ISTORE(J) ,
     2      J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            ENDIF
            WRITE ( NCAWU , 1105 ) ( ISTORE(J) ,
     2      J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            WRITE ( CMON , 1105 ) ( ISTORE(J) ,
     2      J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            CALL XPRVDU(NCVDU, 1,0)
1105        FORMAT ( 2X , 'Minimum value of ' , 3A4 , ' is ' , F10.5 )
            INDNAM = INDNAM + MD28CN
1200      CONTINUE
        ENDIF
C
        IF ( N28MX .GT. 0 ) THEN
          INDNAM = L28CX
          DO 1400 I = L28MX , M28MX , MD28MX
            IF (ISSPRT .EQ. 0) THEN
             WRITE ( NCWU , 1305 ) ( ISTORE(J) ,
     2       J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            ENDIF
            WRITE ( NCAWU , 1305 ) ( ISTORE(J) ,
     2       J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            WRITE ( CMON , 1305 ) ( ISTORE(J) ,
     2       J = INDNAM , INDNAM + 2 ) , STORE(I+1)
            CALL XPRVDU(NCVDU, 1,0)
1305        FORMAT ( 2X , 'Maximum value of ' , 3A4 , ' is ' , F10.5 )
            INDNAM = INDNAM + MD28CX
1400      CONTINUE
        ENDIF
C
        IF ( N28RC .GT. 0 ) THEN
          DO 1600 I = L28RC , M28RC , MD28RC
            IF (ISSPRT .EQ. 0) THEN
            WRITE ( NCWU , 1505 ) ( STORE(J) , J = I , I + MD28RC - 1)
            ENDIF
            WRITE ( NCAWU , 1505 ) ( STORE(J) , J = I , I + MD28RC - 1)
            WRITE ( CMON , 1505 ) ( STORE(J) , J = I , I + MD28RC - 1)
            CALL XPRVDU(NCVDU, 1,0)
1505        FORMAT ( 2X , F6.2 , ' h + ' , F6.2 , ' k + ' ,
     2 F6.2 , ' l must lie in range ' , F6.2 , ' to ' , F6.2 )
1600      CONTINUE
        ENDIF
C
C
        IF ( N28CD .GT. 0 ) THEN
          DO 1850 I = L28CD , M28CD , MD28CD
          IF (ISSPRT .EQ. 0) THEN
            WRITE ( NCWU , 1855 ) ( STORE(J) , J = I , I + MD28CD - 1)
          ENDIF
            WRITE ( NCAWU , 1855 ) ( STORE(J) , J = I , I + MD28CD - 1)
            WRITE ( CMON , 1855 ) ( STORE(J) , J = I , I + MD28CD - 1)
            CALL XPRVDU(NCVDU, 1,0)
1855        FORMAT ( 2X , F6.2 , ' h + ' , F6.2 , ' k + ' ,
     2 F6.2 , ' l + ' , F6.2 , ' divided by ' , F6.2 ,
     3 ' must be integer')
1850      CONTINUE
        ENDIF
C
      IF ( N28OM .GT. 0 ) THEN
       WRITE(CMON,'(''Omitted Reflections'')')
       CALL XPRVDU(NCVDU, 1,0)
       M28OM = L28OM + (N28OM-1)*MD28OM
       J = 1
       INC = 14
       DO 2000 I = L28OM , M28OM , MD28OM
          IF (ISSPRT .EQ. 0) THEN
            WRITE ( NCWU , 1705 ) ( NINT(STORE(K)), K = I, I+MD28OM-1 )
          ENDIF
            WRITE ( NCAWU, 1705 ) ( NINT(STORE(K)), K = I, I+MD28OM-1 )
1705        FORMAT ( 11X , 'Reflection ' , 3I4 , '  omitted' )
         IF (J+INC .GE. 80) THEN
             CALL XPRVDU(NCVDU, 1,0)
             J = 1
         ENDIF
         WRITE(CMON(1)(J:),1106) (NINT(STORE(K)), K = I, I+MD28OM-1)
1106    FORMAT ( ':',3I4,':' )
         J = J + INC
2000   CONTINUE
       IF (J .NE. 1) CALL XPRVDU(NCVDU, 1,0)
      ENDIF
C
      ELSE
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 2005 )
        WRITE ( NCAWU , 2005 )
        WRITE ( CMON , 2005 )
        CALL XPRVDU(NCVDU, 1,0)
2005    FORMAT ( 1X , 'Reflections are not subject to restrictions' )
      ENDIF
C
C
      RETURN
      END
C
CODE FOR XSUM29
      SUBROUTINE XSUM29
C
C -- ROUTINE TO DISPLAY SUMMARY OF LIST 29
C
\ISTORE
C
\STORE
\XLST29
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      IF ( N29 .GT. 0 ) THEN
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1015 )
        WRITE ( NCAWU , 1015 )
        WRITE ( CMON , 1015 )
        CALL XPRVDU(NCVDU, 2,0)
1015    FORMAT ( ' Type              Radius              ' ,
     2 '  Number     Mu    Atomic Colour' /
     3         1X , '   Covalent  Van der Waals     Ionic  ' ,
     4 '                   weight' )
C
        DO 2000 I = L29 , M29 , MD29
        IF (ISSPRT .EQ. 0) THEN
          WRITE ( NCWU , 1105 ) ( STORE(J) , J = I , I + MD29 - 1 )
        ENDIF
          WRITE ( NCAWU , 1105 ) ( STORE(J) , J = I , I + MD29 - 1 )
          WRITE ( CMON , 1105 ) ( STORE(J) , J = I , I + MD29 - 1 )
          CALL XPRVDU(NCVDU, 1,0)
1105      FORMAT ( 1X , A4 ,  F7.4 , 2X , F13.4 , 2X , F8.4 , 2X ,
     2 F8.3 , F8.2 ,  F9.3,2X,A4 )
2000    CONTINUE
      ELSE
        IF (ISSPRT .EQ. 0) WRITE ( NCWU , 2005 )
        WRITE ( NCAWU , 2005 )
        WRITE ( CMON , 2005 )
        CALL XPRVDU(NCVDU, 1,0)
2005    FORMAT ( 1X , 'No element details stored in list 29' )
      ENDIF
C
      RETURN
      END
C
C
CODE FOR XSUM30
      SUBROUTINE XSUM30
C
C----- NUMBER OF RECORDS IN COMMON BLOCK
      PARAMETER (MAXBLK = 9)
C----- NUMBER (MAX) OF KEYS IN EACH BLOCK
      PARAMETER (MAXKEY = 19)
      CHARACTER *16 CTYPE(MAXBLK)
      CHARACTER *25  CKEY(MAXKEY,MAXBLK)
      CHARACTER *80 CLINE, CLOW
C
      CHARACTER *15 CINSTR, CDIR,  CPARAM, CVALUE, CDEF
C
      DIMENSION IPOINT(36)
C
C
\ISTORE
C
\STORE
\XLST30
\XUNITS
\XSSVAL
\XCONST
\XIOBUF
C
\QSTORE
C
      EQUIVALENCE (L30DR, IPOINT(1))
C
C
      DATA CTYPE /
     1 'OBSERVATIONS', 'CONDITIONS', 'REFINEMENT', 'INDICES',
     2 'ABSORPTION', 'GENERAL', 'COLOUR', 'SHAPE', 'CIF'/
C
      DATA (CKEY(I,1),I=1,MAXKEY)/
     1 'Total measured', '*', 'No. merged with Friedel',
     2 'R merged with Friedel',  'No. merged no Friedel',
     3 'R merged no Friedel', 13*'*'
     * /
      DATA (CKEY(I,2),I=1,MAXKEY)/
     1 'Smallest dimension', 'Medium dimension', 'Maximum Dimension',
     2 'No of orienting refs', 'Theta min orienting refs',
     3 'Theta max orienting refs', 'Temperature',
     4 'No of standards', 'Percent decay', '*','Interval', 'Count',
     5  7*'*'
     * /
      DATA (CKEY(I,3),I=1,MAXKEY)/
     1 'R', 'Rw', 'No. param last cycle', 'Sigma Cutoff', 'S',
     2 'Del rho min','Del rho max','max RMS shift','Reflections used',
     3 'Fo min function', 'Restraint min func', 'Total min func',
     4  7*'*'
     * /
      DATA (CKEY(I,4),I=1,MAXKEY)/
     1 'Hmin', 'Hmax', 'Kmin', 'Kmax', 'Lmin', 'Lmax', 'Theta min',
     2 'Theta max', 11*'*'
     * /
      DATA (CKEY(I,5),I=1,MAXKEY)/
     1 4*'*', 'empirical min', 'Empirical max', 'DIFABS min',
     2 'DIFABS max', 11*'*'
     * /
      DATA (CKEY(I,6),I=1,MAXKEY)/
     1 'Dobs', 'Dcalc', 'Fooo', 'Mu', 'M', 'Z', 'Flack',
     2 'Flack esd', 'Sigma cutoff',
     3 'No. Analyse', 'R Analyse', 'Rw Analyse',
     4 7*'*'
     * /
      DATA (CKEY(I,7),I=1,MAXKEY)/ 19*'*' /
      DATA (CKEY(I,8),I=1,MAXKEY)/ 19*'*' /
      DATA (CKEY(I,9),I=1,MAXKEY)/ 19*'*' /
C
C
C
1000    FORMAT ( 1X , 'No ', A16,  ' details stored in list 30' )
C
      CALL XPRTCN
C
      DO 5000 J = 1, MAXBLK
C----- THE ALL-TEXT ITEMS
        IF ((J .EQ. 7) .OR. (J .EQ. 8)) GOTO 5000
      I = 4 * (J-1) +1
      L30 = IPOINT(I)
      MD30 = IPOINT(I+2)
      IF ( MD30 .GT. 0 ) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, '(/A)') CTYPE(J)
         WRITE(NCAWU, '(/A)') CTYPE(J)
         WRITE ( CMON , '(/A)') CTYPE(J)
         CALL XPRVDU(NCVDU, 2,0)
         M = 0
         DO 3000 K = 1, MD30
          IF (CKEY(K,J) .NE. '*') THEN
           A = STORE(K-1+L30)
           NA = NINT(A)
           IF (ABS(A-NA) .LT. ZERO) THEN
              WRITE(CVALUE,'(I13)') NA
           ELSE
              WRITE(CVALUE,'(F13.5)') A
           ENDIF
          ELSE
            CVALUE = ' '
          ENDIF
          N = K - 2 *(K/2)
            IF (N .EQ. 1) THEN
C----- ODD ITEMS - IF '*' THEN LOOP
              CLINE(1:80) = ' '
              IF (CKEY(K,J) .EQ. '*') GOTO 3000
              WRITE ( CLINE( 1:40) , 1010 ) CKEY(K,J),CVALUE
              M = 1
1010          FORMAT (A,A)
            ELSE
C----- EVEN ITEMS - DONT SAVE '*', BUT PRINT FIRST PART
              IF (CKEY(K,J) .NE. '*') THEN
              WRITE ( CLINE( 41:80) , 1010 ) CKEY(K,J),CVALUE
                M = 1
              ENDIF
              IF ( M .EQ. 1) THEN
                IF (ISSPRT .EQ. 0) WRITE (NCWU, '(A)') CLINE
                WRITE (NCAWU, '(A)') CLINE
                WRITE ( CMON, '(A)') CLINE
                CALL XPRVDU(NCVDU, 1,0)
                M = 0
              ENDIF
            ENDIF
3000     CONTINUE
C----- FINISHED ON AN ODD ITEM, SO MUST PRINT
        IF ((N .EQ. 1) .AND. ( M .EQ. 1)) THEN
            IF (ISSPRT .EQ. 0) WRITE (NCWU, '(A)') CLINE
            WRITE (NCAWU, '(A)') CLINE
            WRITE ( CMON, '(A)') CLINE
            CALL XPRVDU(NCVDU, 1,0)
        ENDIF
3010    CONTINUE
C
        IF ( J .EQ. 1 ) THEN
C----- PARAMETER 13 ON DIRECTIVE 1 IS A CHARACTER STRING
          IPARAM  = 13
          IDIR = 1
          IVAL = ISTORE( L30 +IPARAM -1)
          GOTO 3020
        ELSE IF ( J .EQ. 2 ) THEN
C----- PARAMETER 10 ON DIRECTIVE 2 IS A CHARACTER STRING
          IPARAM  = 10
          IDIR = 2
          IVAL = ISTORE( L30 +10 -1)
          GOTO 3020
        ELSE IF ( J .EQ. 3 ) THEN
C----- PARAMETER 13 ON DIRECTIVE 3 IS A CHARACTER STRING
          IPARAM  = 13
          IDIR = 3
          IVAL = ISTORE( L30 +IPARAM -1)
          GOTO 3020
        ELSE IF ( J .EQ. 5 ) THEN
C----- PARAMETER 9 ON DIRECTIVE 5 IS A CHARACTER STRING
          IPARAM  = 9
          IDIR = 5
          IVAL = ISTORE( L30 +9 -1)
          GOTO 3020
        ELSE IF ( J .EQ. 6 ) THEN
C----- PARAMETER 13 ON DIRECTIVE 6 IS A CHARACTER STRING
          IPARAM  = 9
          IDIR = 13
          IVAL = ISTORE( L30 +IPARAM -1)
          GOTO 3020
        ENDIF
        GOTO 3040
3020    CONTINUE
        IZZZ= KGVAL(CINSTR, CDIR, CPARAM, CVALUE, CDEF,
     1                    33, IDIR, IPARAM, IVAL, JVAL, VAL, JTYPE)
        CLINE(1:80) = ' '
        WRITE(CLINE,1020) CPARAM, CVALUE
        CALL XCCLWC ( CLINE(2:), CLOW(2:))
        CLOW(1:1) = CLINE(1:1)
        IF (ISSPRT .EQ. 0) WRITE(NCWU,1021) CLOW
        WRITE(NCAWU, 1021) CLOW
        WRITE(CMON, 1021) CLOW
        CALL XPRVDU(NCVDU, 1,0)
1020    FORMAT ( A, 3X,A)
1021    FORMAT (  A)
3040    CONTINUE
      ELSE
          IF (ISSPRT .EQ. 0) WRITE ( NCWU , 1000 ) CTYPE(J)
          WRITE ( NCAWU , 1000 ) CTYPE(J)
          WRITE ( CMON , 1000 ) CTYPE(J)
          CALL XPRVDU(NCVDU, 1,0)
      ENDIF
5000  CONTINUE
C
C----- THERE REMAIN SOME PURE TEXT ITEMS
      DO 6000 J = 7,8
      I = 4 * (J-1) +1
      L30 = IPOINT(I)
      MD30 = IPOINT(I+2)
      IF ( MD30 .GT. 0 ) THEN
        CLINE(1:80) = ' '
        WRITE(CLINE,'(A,3X,8A4)') CTYPE(J),
     1 (ISTORE(K), K = L30, L30 + MD30 -1)
        CALL XCCLWC ( CLINE(2:), CLOW(2:))
        CLOW(1:1) = CLINE(1:1)
        IF (ISSPRT .EQ. 0) WRITE(NCWU,1021) CLOW
        WRITE(NCAWU, 1021) CLOW
        WRITE ( CMON , 1021) CLOW
        CALL XPRVDU(NCVDU, 1,0)
      ENDIF
6000  CONTINUE
      RETURN
      END
C
C
C
CODE FOR XSUMOP
      SUBROUTINE XSUMOP ( OPER , XLATT , TEXT , LENGTH )
C
C -- CONVERT MATRIX FORM OF SYMMETRY OPERATOR TO TEXT
C
C -- INPUT :-
C
C      OPER        SYMMETRY OPERATOR IN MATRIX FORM
C      XLATT       LATTICE TRANSLATION TO ADD. THIS CAN BE USED
C                  TO GENERATE ALL OPERATORS NEEDED IF THE LATTICE
C                  TYPE CANNOT BE USED TO DO THIS. ( I.E. SNOOPI
C                  DOES NOT UNDERSTAND LATTICE TYPES, SO OPERATORS
C                  EXPLICITLY INCLUDING THE EFFECT OF CENTERING MUST BE
C                  GENERATED )
C
C -- OUTPUT :-
C      TEXT        TEXT REPRESENTATION OF OPERATOR IN FORM
C                    X,Y,Z  OR  X,Y,Z+1/2  ETC.
C      LENGTH      USEABLE LENGTH OF TEXT
C
      DIMENSION OPER(3,4) , XLATT(3)
      CHARACTER*(*) TEXT
C
      CHARACTER*1 AXIS(3)
      CHARACTER *3 CTRANS
C
\XUNITS
\XCONST
C
      DATA AXIS / 'X' , 'Y' , 'Z' /
C
C
C
C
C -- CLEAR TEXT BUFFER
C
      TEXT = ' '
      LENGTH = 0
C
C -- SCAN EACH COMPONENT
C
      DO 2000 I = 1 , 3
        IF ( I .NE. 1 ) THEN
          LENGTH = LENGTH + 1
          TEXT(LENGTH:LENGTH) = ','
        ENDIF
C
C -- DETERMINE 'X' , 'Y' , 'Z' PART
C
      IFIRST = 1
C
        DO 1900 J = 1 , 3
          IOPER = NINT ( OPER(J,I) )
          IF ( IOPER .EQ. 0 ) GO TO 1900
          IF ( IOPER .LT. 0 ) THEN
            LENGTH = LENGTH + 1
            TEXT(LENGTH:LENGTH) = '-'
          ELSE IF ( IFIRST .LE. 0 ) THEN
            LENGTH = LENGTH + 1
            TEXT(LENGTH:LENGTH) = '+'
          ENDIF
          LENGTH = LENGTH + 1
          TEXT(LENGTH:LENGTH) = AXIS(J)
          IFIRST = 0
1900    CONTINUE
C
C -- DETERMINE TRANSLATIONAL PART, BUT ONLY FOR NON-INTEGRAL
C    TRANSLATIONS
C
        TRANS = OPER(I,4) + XLATT(I)
        IF ( ABS( TRANS - REAL(NINT(TRANS)) ) .LE. ZERO ) GO TO 2000
C
C -- CONVERT TRANSLATION TO RATIO OF TWO WHOLE NUMBERS
C
C----- NOTE TOLERANCE IS QUITE CRUDE INCASE VALUES LIKE 0.33 ARE USED
        FAC = 1.
        XTRANS = TRANS
1950    CONTINUE
        IF ( ABS ( TRANS - REAL ( NINT ( TRANS ) ) ) .GT. .01 ) THEN
          FAC = FAC + 1.0
          TRANS = XTRANS * FAC
          XMULT = FAC
          GO TO 1950
        ENDIF
C
C -- CONVERT RATIO FOUND TO PAIR OF INTEGERS, AND REMOVE COMMON FACTORS
C
        ITRANS = NINT ( TRANS )
        IMULT = NINT ( XMULT )
        IFAC = 2
1970    CONTINUE
        IF ( ( IFAC * ( ITRANS / IFAC ) .EQ. ITRANS  ) .AND.
     2       ( IFAC * ( IMULT / IFAC ) .EQ. IMULT )    ) THEN
          ITRANS = ITRANS / IFAC
          IMULT = IMULT / IFAC
          IFAC = IFAC + 1
          IF ( IFAC .LE. NINT ( FAC ) ) GO TO 1970
        ENDIF
C
C -- ADD TRANSLATIONAL COMPONENT TO OUTPUT STRING. ( NUMERATOR MUST
C    BE PRECEDED BY A PLUS OR MINUS SIGN, HENCE FORMAT 'SP' )
C
        WRITE ( CTRANS , '(SP,I3)' ) ITRANS
        DO 1980 J = 1 , 3
          IF ( CTRANS(J:J) .NE. ' ' ) THEN
            LENGTH = LENGTH + 1
            TEXT(LENGTH:LENGTH) = CTRANS(J:J)
          ENDIF
1980    CONTINUE
C
        LENGTH = LENGTH + 1
        TEXT(LENGTH:LENGTH) = '/'
C
        WRITE ( CTRANS , '(I3)' ) IMULT
        DO 1990 J = 1 , 3
          IF ( CTRANS(J:J) .NE. ' ' ) THEN
            LENGTH = LENGTH + 1
            TEXT(LENGTH:LENGTH) = CTRANS(J:J)
          ENDIF
1990    CONTINUE
C
C
2000  CONTINUE
C
C
      RETURN
      END
