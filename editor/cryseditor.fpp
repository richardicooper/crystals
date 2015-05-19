
C $Log: not supported by cvs2svn $
C Revision 1.8  2012/03/23 15:55:05  rich
C Support for intel compiler.
C
C Revision 1.7  2011/03/21 13:57:28  rich
C Update files to work with gfortran compiler.
C
C Revision 1.6  2011/03/04 06:04:24  rich
C Using new defines for compilers.
C
C Revision 1.5  2005/01/07 11:57:05  rich
C Add some blank lines between some #if and #endifs.
C
C Revision 1.4  2004/12/20 11:41:05  rich
C Added WXS support.
C
C Revision 1.3  2004/12/17 10:03:46  rich
C Oops - extra line. Removed executable.
C
C Revision 1.2  2004/12/17 10:01:02  rich
C MAC to ___MAC___ etc.
C
C Revision 1.1.1.1  2004/12/13 11:16:12  rich
C New CRYSTALS repository
C
C Revision 1.18  2003/05/12 14:07:18  rich
C Added ___GID___ EDITOR target to the EDITOR source code itself.
C
C Revision 1.17  2002/12/19 16:25:51  djw
C Increase number of MACROS
C
C Revision 1.16  2001/02/26 10:25:31  richard
C Added changelog to top of file
C
C
CODE FOR EDITOR
      PROGRAM EDITOR
C--MAIN CRYSTALS EDITING PROGRAM.
C
C--THIS VERSION READS A SET OF MACRO DEFINITIONS FROM CHANNEL 'NUMAC=3'
C  STORES THE INFORMATION AS FOLLOWS :
C
C--A MACRO IS INTRODUCED BY A CARD OF THE FORM :
C
C  #MACRONAME
C
C--THE 'MACRO NAME' MUST BE LESS THAN 7 CHARACTERS LONG.
C
C--FOLLOWING THIS CARD, THERE MAY BE ONE OR MORE MACRO DEFINITION CARDS,
C  OF WHICH MAY CONTAIN PARAMETERS FOR SUBSTITUTION. THESE PARAMETERS AR
C  IN THE FORM :
C
C  <N,M>
C
C--WHERE :
C
C  N  THE PARAMETER NUMBER. THIS MUST BE GREATER THAN 0 AND LESS THAN OR
C     TO THE MAXIMUM NUMBER OF PARAMETERS PROVIDED WHEN THE MACRO IS CAL
C     (UNDEFINED PARAMETERS ARE COMPILED AS MISSING OR BLANKS AT SUBSTIT
C      TIME IF THESE CONDITIONS ARE NOT FULFILLED).
C  M  THE NUMBER OF CHARACTERS THAT THE PARAMETER SHOULD OCCUPY. IF THIS
C     ARGUMENT AND ITS ',' ARE OMITTED, THE PARAMETER IS SUBSTITIUTED AS
C     GIVEN.
C
C--IN CORE, THE CARD IMAGES ARE SPLIT INTO TEXT AND PARAMETERS REQUIRING
C  SUBSTITUTION, EACH PART BEING LINKED BY A HEADER BLOCK AS FOLLOWS :
C
C  0  LINK TO THE NEXT PART OF THIS MACRO, ELSE -1.
C  1  TYPE OF THIS ARGUMENT :
C
C     -1  NEW CARD, NUMBER OF CHARACTERS TO PRINTED AT THE START GIVEN
C         BY WORD 2.
C      0  STRING OF CHARACTERS TO PRINT, LENGTH GIVEN IN WORD 2.
C     >0  NUMBER OF THE PARAMETER TO BE SUBSTITUTED. ITS LENGTH IS GIVEN
C         IN WORD 2.
C
C  2  THE TEXT OR PARAMETER LENGTH.
C
C--FOLLOWING EACH HEADER OF THIS TYPE ARE THE CHARACTERS, IF NECESSARY,
C  BE PRINTED.
C
C
C----- THIS VERSION ACCEPTS COMMENTS ON EDIT LINES
C     EDIT COMMENTS ARE INTRODUCED WITH '@'.
C     THE '@' AND ALL CHARACTERS IN COLUMNS UPTO
C     AND INCLUDING COLUMN 72 ARE REPLACED BY BLANKS
C     AS THE CARD IS READ IN.
C    THIS DOES NOT APPLY IN THE MIDDLE OF FORTRAN CHARACTER CONSTANTS
C--
C
C----- THIS VERSION (MAY,1982) HAS SELECTABLE EDIT LINES
C      THE MACHINE TYPE MUST BE DEFINED BY A 3 LETTER
C      CODE AT THE BEGINNING OF THE MACROFILE.
C      THE CODE 'UPD'
C      INDICATES AN UPDATE OF THE SOURCE WITHOUT MACRO SUBSTITUTION.
C      THE CODE 'ALL'
C      INDICATES THAT ALL # AND & LINES WILL BE TRANSFERED TO THE OUTPUT
C      AND MACRO SUBSTITUTION WILL OCCUR.
C      A FILE SO PRODUCED WILL NOT COMPILE WITHOUT MODIFICATION, BUT
C      DOES CONTAIN ALL INFORMATION FOR CURRENTLY SUPPORTED IMPLEMENTATI
C      THE IMPLEMENTER MUST EDIT THE # AND & LINES USING A SYSTEM EDITOR
C
C     EDITS INTRODUCED '&TYPE' WILL BE INCLUDED FOR THAT MACHINE
C     EDITS INTRODUCED '#TYPE' WILL BE INCLUDED FOR ALL MACHINES
C     NOT OF THAT TYPE.
C     '&' AND '#' LINES ARE CHANGED TO COMMENTS IF NOT APPLICABLE.
C
C -- DIMENSIONS OF ARRAYS INCREASED TO ALLOW FOR LARGER MACRO FILE
C    (SEPTEMBER 1982)
C
C
C      APRIL 1984      FORTRAN CHARACTER CONSTANTS MAY HAVE THE EDIT
C                      COMMENT CHARACTER INSIDE THEM
C
C
C      FEBRUARY 1997   ___DOS___ VERSION
      CHARACTER *128 DOSMAC
      CHARACTER *128 DOSSRC
      CHARACTER *128 DOSFOR
      CHARACTER *128 CMNAM
      CHARACTER *128 DOSCOD, DOSUCD
      CHARACTER *1 CC
C
C
      DIMENSION NU(2)

      PARAMETER ( LLEN = 160 )
C
      COMMON/SEGSN/ ISEG(3)
      COMMON/MACHIN/ MAC(4),IUPD(3),IALL(3)
      COMMON /XMACRO/ NMAC,NAMES(7,400),NHEAD,IADD,LAST,NTYP,MAXADD,
     2 MACROS(96000)
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
      LOGICAL LSTRIP
      COMMON /XSUBST/ IAND, INOT, ICOM, ICOM2, LSTRIP
C
      EXTERNAL EDTBLK
C
C
C----- OPEN THE FILE READONLY/SHARED IF POSSIBLE
#if defined(___VAX___) 
      OPEN(UNIT=NCPU,CARRIAGECONTROL='LIST')
      OPEN(UNIT=NEFU, READONLY, SHARED, STATUS='OLD')
      OPEN(UNIT=NUMAC, READONLY, SHARED, STATUS = 'OLD')
      OPEN(UNIT=NCRU, READONLY, SHARED, STATUS = 'OLD')
#endif
      WRITE(6,*) ' Version Feb 99'

#if !defined(___VAX___) 
      DOSMAC = ' '
#endif
C----- DOS OPENS
#if defined(___GID___)||defined(___LIN___)||defined(___GIL___)||defined(___MAC___)||defined(___WXS___)||defined(___INW___)
      CALL GETARG(1,DOSSRC)
      CALL GETARG(2,DOSFOR)
      IGTRG = 3
#endif
#if defined(___DOS___) 
      DOSSRC=CMNAM()
      DOSFOR=CMNAM()
#endif

100   CONTINUE

#if defined(___GID___) || defined(___LIN___) || defined (___GIL___) || defined (___MAC___) || defined (___WXS___)||defined(___INW___)
      CALL GETARG(IGTRG,DOSCOD)
      IGTRG = IGTRG + 1
#endif
#if defined(___DOS___) 
      DOSCOD=CMNAM()
#endif

      CALL XCCUPC ( DOSCOD, DOSUCD )
      IF(DOSCOD(1:1).NE.' ') THEN
         IF(DOSUCD(1:4).EQ.'CODE') THEN
            READ(DOSUCD(6:8),1010) (MAC(I),I=1,3)
         ELSE IF (DOSUCD(1:4).EQ.'INCL') THEN
            READ(DOSCOD(6:6),'(A1)') IAND
         ELSE IF (DOSUCD(1:4).EQ.'EXCL') THEN
            READ(DOSCOD(6:6),'(A1)') INOT
         ELSE IF (DOSUCD(1:4).EQ.'COMM') THEN
            READ(DOSCOD(6:7),'(2A1)') ICOM, ICOM2
         ELSE IF (DOSUCD(1:4).EQ.'SUBS') THEN
            READ(DOSCOD(6:6),'(A1)') IH
         ELSE IF (DOSUCD(1:5).EQ.'MACRO') THEN
            READ(DOSCOD(7:),'(A)') DOSMAC
         ELSE IF (DOSUCD(1:5).EQ.'STRIP') THEN
            LSTRIP = .TRUE.
        ENDIF
      ELSE
         GOTO 200
      END IF
      GOTO 100

200   CONTINUE
      IF((DOSSRC.EQ.' ').OR.(DOSFOR.EQ.' ')) THEN
        WRITE(6,'(A)')'Usage: EDITOR <src> <output> ' //
     1   'code=<XXX> '//
     1   '[macro=macrofil.mac] [incl=&] [excl=#] '//

#if defined(___DOS___) || defined(_DIGITALF77_)

     2   '[comm=CC] [subs=\] [strip]'

#else

     2   '[comm=CC] [subs=\\] [strip]'

#endif

        STOP 'Error'
      ENDIF

      IF(DOSMAC.EQ.' ') DOSMAC='MACROFIL.MAC'

      ILEN=128

C---- THE SOURCE FILE
      WRITE(*,'(2A)') 'Source = ', DOSSRC(1:LEN_TRIM(DOSSRC))
      WRITE(*,'(A,3A1)') 'Comments = "', ICOM, ICOM2, '"'
      IF ( LSTRIP ) THEN
        WRITE(*,'(A)') 'Stripping comments'
      ELSE
        WRITE(*,'(A)') 'Leaving comments'
      END IF
#if defined(___LIN___) || defined (___GIL___) || defined (___MAC___) 
      OPEN(UNIT=NCRU, FILE=DOSSRC, STATUS = 'OLD')
#else
      CALL CONVER(DOSSRC,NCRU)
#endif
C---- THE MACRO FILE
#if !defined(__VAX__) 
      WRITE(*,'(2A)') 'macros = ', DOSMAC(1:LEN_TRIM(DOSMAC))
#endif

#if defined(__LIN__) || defined (__MAC__) || defined (__GIL__) 
      OPEN(UNIT=NUMAC, FILE=DOSMAC, STATUS = 'OLD', ERR=101)
101   CONTINUE
#else
      CALL CONVER(DOSMAC,NUMAC)
#endif

C--SET UP THE CONSTANTS TO READ THE MACRO FILE
      IADD=1
      LAST=1
      MACROS(LAST  )=-1
      MACROS(LAST+1)=0
      NCHAR=LLEN
      NCHARM=LLEN
      MACROS(LAST+2)=0
      NMAC=0
C----- SET FLAG FOR MACRO SUBSTITION
      MAC(4)=1
C----- READ THE FIRST CARD FROM  THE MACROSUBSTITUTION FILE.
C      THIS DEFINES THE TYPE OF MACHINE AS A 3 LETTER CODE.
C
#if defined(__VAX__) 
      READ (NUMAC,1010,END=1900) (MAC(I),I=1,3)
#endif
C----- FOR DOS VERSION, THIS IS ALREADY KNOWN FROM THE COMMAND LINE
1010  FORMAT (3A1)
      IF (MAC(1) .NE. IUPD(1)) GOTO 1015
      IF(MAC(2) .NE. IUPD(2)) GOTO 1000
      IF(MAC(3) .NE. IUPD(3)) GOTO 1000
C----- APPLY EDITS ONLY - NO NEED TO READ REST OF FILE
C      THE CODE 'UPD' CAUSES ALL EDITS TO BE APPLIEDBUT NO
C      SUBSTITUTION TO OCCUR.
#if !defined(__VAX__) 
      WRITE(*,'(2A)') 'Fortran = ', DOSFOR(1:LEN_TRIM(DOSFOR))
      OPEN(UNIT=NCPU, FILE=DOSFOR, STATUS='UNKNOWN')
#endif
      MAC(4)=-1
C----- SET MAXIMUM OP ECORD TO 72 CHARACTERS
       NCHAR=NCHARM
      GOTO 1900
1015  CONTINUE
C     THE CODE 'ALL' CAUSES MACRO SUBSTITUTION AND DIRECT COPYING
C     OF MACHINE SPECIFIC LINES.
C     CONSOLIDATED TEXT ('ALL' FLAG)
      IF(MAC(1).NE. IALL(1)) GOTO 1001
      IF(MAC(2).NE. IALL(2)) GOTO 1001
      IF(MAC(3).NE. IALL(3)) GOTO 1001
C----- COPY ALL MACHINE SPECIFIC ENTRIES TO OUTPUT
#if !defined(__VAX__) 
      WRITE(*,'(2a)') 'Fortran = ', DOSFOR(1:LEN_TRIM(DOSFOR))
      OPEN(UNIT=NCPU, FILE=DOSFOR, STATUS='UNKNOWN')
#endif
      MAC(4)=0
C----- DONT PUNCH CARD SEQUENCE FIELD
      NCHAR = NCHARM
      GOTO 1000
1001  CONTINUE
C--- NORMAL FORTRAN
#if !defined(__VAX__) 
      WRITE(*,'(2a)') 'Fortran = ', DOSFOR(1:Len_trim(DOSFOR))
      OPEN(UNIT=NCPU, FILE=DOSFOR, STATUS='UNKNOWN')
#endif
      GOTO 1000
C--READ THE NEXT CARD FROM THE MACRO FILE
1000  CONTINUE
      N=1
      NTYP=-1
      READ(NUMAC,1050,END=1900,ERR=1900)(ICARD(K),K=1,NCHARM)
1050  FORMAT(160A1)
C--CHECK FOR A '#' TO INDICATE THE START OF A NEW MACRO DEFINITION
      IF(ICARD(1).NE.IH) GOTO 1250
C--START OF A NEW MACRO  -  INCREMENT THE NUMBER OF MACROS READ
1100  CONTINUE
      NMAC=NMAC+1
      CALL XNEWBL(1)
C--SET THE POINTER TO THIS MACRO
      NAMES(1,NMAC)=LAST
C--STORE THE MACRO NAME
      DO 1150 K=1,6
C Check for Non-ASCII characters (EOL etc.)
#if !defined(__GIL__) && !defined(__LIN__) && !defined(__MAC__) 
       IF ( KISCHR(ICARD(K+1)) .LE. 0 ) ICARD(K+1)=32
#endif
      NAMES(K+1,NMAC)=ICARD(K+1)
1150  CONTINUE
      GOTO 1000
C--PROCESS THE NEXT CARD OF A MACRO  -  CHECK THE CORE
1250  CONTINUE
      CALL XNEWBL(-1)
C--CHECK THE INPUT CARD FOR A PARAMETER DELIMITER
      DO 1350 K=N,NCHARM
      M=K
      IF(ICARD(K).EQ.ILP) GOTO 1400
C--NOT A PARAMETER DELIMITER
1300  CONTINUE
      MACROS(IADD)=ICARD(K)
      IADD=IADD+1
      MACROS(LAST+2)=MACROS(LAST+2)+1
1350  CONTINUE
      GOTO 1000
C--MACRO DELIMITER FOUND  -  CHECK IF THERE ARE ANY CHARACTERS TO STORE
1400  CONTINUE
      N=M
C--CHECK IF THE LAST BLOCK INDICATES A NEW CARD OR PARAMETER
      IF(MACROS(LAST+1))1440,1430,1440
C--ONLY TEXT  -  CHECK IF THERE ARE ANY CHARACTERS
1430  CONTINUE
      IF(MACROS(LAST+2))1450,1450,1440
C--SET UP A NEW HEADER BLOCK FOR THIS PARAMETER
1440  CONTINUE
      CALL XNEWBL(-1)
C--A SUITABLE HEADER NOW EXISTS  -  READ THE PARAMETER NUMBER
1450  CONTINUE
      N=N+1
      IF(KNUMB(ICARD,N,MACROS(LAST+1)))1500,1500,1600
C--ILLEGAL PARAMETER NUMBER
1500  CONTINUE
      WRITE(NCWU,1550)(ICARD(K),K=1,NCHARM)
1550  FORMAT(/27H ILLEGAL MACRO PARAMETER : ,160A1)
      STOP 04
C--CHECK FOR THE TERMINATOR USED
1600  CONTINUE
      IF(ICARD(N).NE.IC) GOTO 1700
C--A ',' WAS USED AS TERMINATOR  -  READ THE FIELD WIDTH FOR THIS PARAME
1650  CONTINUE
      N=N+1
      IF(KNUMB(ICARD,N,MACROS(LAST+2)))1500,1500,1700
C--CHECK THAT THE TERMINATING CHARACTER IS THE OTHER PARAMETER DELIMITER
1700  CONTINUE
      IF(ICARD(N).NE.IRP) GOTO 1500
C--INCREMENT THE POINTER AND RETURN FOR MORE IF NECESSARY
1750  CONTINUE
      N=N+1
      IF(N-NCHARM)1250,1250,1000
C
C--INITIALIZE A FEW COMMON POINTERS
1900  CONTINUE
      CALL XNEWBL(1)
C      PAUSE
      I0=0
      J0=0
      ID=1
      JD=10
      I=I0
      J=J0
C--CHECK IF THERE IS AN EDIT FILE PRESENT
C      Ignore the edit file
#if !defined (__VAX__)
      GOTO 8000
#endif
      IF(KRDED(L))8000,2050,2050
C--READ THE NEXT EDIT INSTRUCTION
2000  CONTINUE
      IF(KRDED(L))5000,2050,2050
2050  CONTINUE
C--CHECK FOR AN '*'  -  START OF A NEW SEGMENT
      IF(NED(1).NE.IA) GOTO 2000
C--EDIT INSTRUCTION FOUND  -  SEARCH FOR THE SEGMENT, WITHOUT COPYING TH
2130  CONTINUE
      IF(KRDSOU(L))6000,2140,2140
C--CHECK FOR THE STRING 'CODE FOR '
2140  CONTINUE
      DO 2145 L=1,9
      IF(ICARD(L).NE.ICODE(L)) GOTO 2130
2145  CONTINUE
C--CHECK THE SEGMENT NAME
2150  CONTINUE
      DO 2170 L=1,6
      IF(ICARD(L+9).NE.NED(L+1)) GOTO 2130
2170  CONTINUE
      GOTO 2520
C
C--SEARCH THE INPUT DECK FOR A START OF SEGMENT FLAG  -  'CODE FOR ' IN
2200  CONTINUE
      IF(KRDSOU(L))6000,2250,2250
C--CHECK THE FIRST WORD
2250  CONTINUE
      DO 2350 L=1,9
      IF(ICARD(L).NE.ICODE(L)) GOTO 2400
2350  CONTINUE
      GOTO 2500
C--PUNCH THE CARD AND RETURN FOR MORE
2400  CONTINUE
      CALL XPCHNL(ICARD(1))
      GOTO 2200
C--CHECK IF THIS IS THE SEGMENT WE REQUIRE
2500  CONTINUE
      DO 2510 L=1,6
      IF(ICARD(L+9).NE.NED(L+1)) GOTO 2130
2510  CONTINUE
C
C--SET UP THE INITIAL FLAGS FOR A NEW SEGMENT
2520  CONTINUE
      I=I0
      J=J0
C----- STORE THE SEGMENT NAME
      ISEG(1)=ICARD(11)
      ISEG(2)=ICARD(12)
      ISEG(3)=ICARD(13)
C--READ THE NEXT EDIT INSTRUCTION
2530  CONTINUE
      IF(KRDED(L))5020,2550,2550
C--CHECK FOR AN '*' ON THE NEXT CONTROL CARD
2550  CONTINUE
      IF(NED(1).EQ.IA) GOTO 2400
C--CHECK THE FIRST COLUMN FOR A '-'
2600  CONTINUE
      IF(NED(1).EQ.IM) GOTO 2660
C--FIRST EDIT CARD IS BLANK  -  PUNCH IT OUT BEFORE THE 'CODE FOR '
2630  CONTINUE
      CALL XPCHNL(NED(1))
      GOTO 2530
C--PUNCH THE 'CODE FOR ' CARD BEFORE WE ENTER THE PROCESSING LOOP
2660  CONTINUE
      CALL XPCHNL(ICARD(1))
C--READ THE EDIT LINES OFF THE CARD
2700  CONTINUE
      NU(2)=0
C--READ THE FIRST LINE NUMBER
      M=2
      IF(KNUMB(NED,M,NU(1)))2750,2850,2710
C--CHECK FOR A ',' AS THE TERMINATOR
2710  CONTINUE
      IF(NED(M).NE.IC) GOTO 2750
C--READ THE SECOND LINE NUMBER
2720  CONTINUE
      M=M+1
      IF(KNUMB(NED,M,NU(2)))2750,2850,2750
C--END OF THE LOOP  -  UNKNOWN CHARACTER
2750  CONTINUE
      WRITE(NCWU,2760)NED
2760  FORMAT(/28H ILLEGAL EDIT INSTRUCTION : ,160A1)
      STOP 01
2800  CONTINUE
C--CHECK THE CARD NUMBER AGAINST THE REQUESTED FIRST LINE NUMBER
2850  CONTINUE
      IF(NU(1)-I)3000,3070,3100
C--LINE SEQUENCE ERROR
3000  CONTINUE
      WRITE(NCWU,3050)NED
3050  FORMAT(/28H LINE NUMBER OUT OF ORDER : ,160A1)
      STOP 02
C--THE REQUEST CARD HAS BEEN PUNCHED  -  CHECK FOR AN INSERT ONLY
3070  CONTINUE
      IF(NU(2))3000,3510,3000
C--POSITION THE INPUT DECK
3100  CONTINUE
      IF(KRDSOU(L))6000,3150,3150
C--CHECK IF WE HAVE ARRIVED
3150  CONTINUE
      IF(NU(1)-I)3000,3300,3200
C--NO ARRIVED  -  OUTPUT THE CURRENT CARD
3200  CONTINUE
      CALL XPCHNL(ICARD(1))
      GOTO 3100
C--CHECK IF THIS A DELETION
3300  CONTINUE
      IF(NU(2))3400,3500,3400
C--DELETION  -  REMOVE THE CARDS
3400  CONTINUE
      IF(NU(2)-I)3000,3510,3410
3410  CONTINUE
      IF(KRDSOU(L))6000,3400,3400
C--OUTPUT THE CARD AFTER WHICH THE EDITS ARE TO COME
3500  CONTINUE
      CALL XPCHNL(ICARD(1))
C--RESET THE FLAGS AND OUTPUT THE INSERTIONS
3510  CONTINUE
      NU(1)=0
      NU(2)=0
C--READ THE NEXT EDIT INSTRUCTION
3520  CONTINUE
      IF(KRDED(L))5000,3525,3525
C--CHECK IF IT STARTS WITH AN '*'
3525  CONTINUE
      IF(NED(1).EQ.IA) GOTO 2200
C--CHECK IF IT STARTS WITH A '-'
3530  CONTINUE
      IF(NED(1).EQ.IM) GOTO 2700
3540  CONTINUE
      CALL XPCHNL(NED(1))
      GOTO 3520
C
C--END OF EDIT FILE
5000  CONTINUE
      IF(KRDSOU(L))7000,5010,5010
5010  CONTINUE
      DO 5015 L=1,9
      IF(ICARD(L).NE.ICODE(L)) GOTO 5020
5015  CONTINUE
      GOTO 7000
5020  CONTINUE
      CALL XPCHNL(ICARD(1))
      GOTO 5000
C
C--END OF SOURCE FILE
6000  CONTINUE
      WRITE(NCWU,6010)(NED(I),I=2,7)
6010  FORMAT(/19H MISSING SEGMENT : ,6A1)
      STOP 03
C
7000  CONTINUE
      GOTO 9999
c      STOP 00
C
C--NO EDIT FILE PRESENT  -  SIMPLY A MACRO EXPANSION OF THE TEXT
8000  CONTINUE
      IF(KRDSOU(L))7000,8100,8100
C--PUNCH THE CARD
8100  CONTINUE
      CALL XPCHNL(ICARD(1))
      GOTO 8000
9999  CONTINUE

      END
C
CODE FOR XNEWBL
      SUBROUTINE XNEWBL(IEND)
C--INSERT A NEW HEADER IN THE MACRO CHAIN SEQUENCE.
C
C--THIS ROUTINE ALSO CHECKS THE CORE LIMITS AND REMOVES TRAILING SPACES
C  FROM THE END OF PREVIOUS RECORDS.
C
C  IEND  DETERMINES WHETHER THE LAST BLOCK WAS THE END OF A CHAIN :
C
C        -1  NOT THE END OF A CHAIN
C        +1  END OF THE LAST CHAIN IS GIVEN BY 'LAST'.
C
C--
      PARAMETER ( LLEN = 160 )
      COMMON /XMACRO/ NMAC,NAMES(7,400),NHEAD,IADD,LAST,NTYP,MAXADD,
     2 MACROS(96000)
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
C
C--CHECK THAT THE CORE HAS NOT BEEN OVERWRITTEN
      IF(IADD-MAXADD)1260,1260,1160
C--NOT ENOUGH CORE AVAILABLE
1160  CONTINUE
      WRITE(NCWU,1170)
1170  FORMAT(/30H INSUFFICIENT SPACE FOR MACROS)
      STOP 05
C--CHECK IF THIS IS THE START OF A NEW CARD
1260  CONTINUE
      IF(NTYP)1270,1290,1290
C--START OF A NEW CARD  -  CHECK IF THE LAST BLOCK CONTAINED TEXT
1270  CONTINUE
      IF(MACROS(LAST+1))1275,1275,1290
C--LAST BLOCK COULD CONTAIN TEXT  -  CHECK THE LENGTH
1275  CONTINUE
      IF(MACROS(LAST+2))1290,1290,1280
C--CHECK IF THE LAST CHARACTER WAS A SPACE
1280  CONTINUE
      IF(MACROS(IADD-1).NE.IB) GOTO 1290
C--REMOVE THIS TRAILING SPACE
1285  CONTINUE
      MACROS(LAST+2)=MACROS(LAST+2)-1
      IADD=IADD-1
      GOTO 1275
C--LINK IN THE NEXT CONTROL BLOCK
1290  CONTINUE
      IF(IEND)1300,1310,1310
C--THIS BLOCK SHOULD BE LINKED  -  DO IT
1300  CONTINUE
      MACROS(LAST)=IADD
C--UPDATE THE ADDRESS OF THE CURRENT HEADER
1310  CONTINUE
      LAST=IADD
C--SET UP THE CURRENT CONTROL BLOCK
      MACROS(LAST  )=-1
      MACROS(LAST+1)=NTYP
      MACROS(LAST+2)=0
C--UPDATE 'IADD' TO POINT TO THE STORAGE AREA
      IADD=IADD+NHEAD
C--SET THE TYPE FLAG TO CONTINUATION CARDS
      NTYP=0
      RETURN
      END
CODE FOR XPCHNL
      SUBROUTINE XPCHNL(LCARD)
C--PUNCH THE NEXT CARD OR GROUP OF CARDS
C
      PARAMETER ( LLEN = 160 )
      DIMENSION LCARD(LLEN)
C
      COMMON/XOUTBF/NPARAM,IPARAM(2,20),IBUF(160)
      COMMON /XMACRO/ NMAC,NAMES(7,400),NHEAD,IADD,LAST,NTYP,MAXADD,
     2 MACROS(96000)
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
      LOGICAL LSTRIP
      COMMON /XSUBST/ IAND, INOT, ICOM, ICOM2, LSTRIP
      CHARACTER CBUF*160
C
C--CHECK IF THIS INPUT CARD CONTAINS A MACRO CALL
900   FORMAT(160A1)
C -- CHECK FOR MACHINE DEPENDENT CODE
      CALL XCHMAC(LCARD(1))
      IF(LCARD(1).NE.IH) GO TO 5500
C--THIS IS A MACRO EXPANSION  -  CHECK IF THERE ARE ANY MACROS STORED
1000  CONTINUE
      IF(NMAC)5500,5500,1100
C--MACROS STORED  -  SEARCH FOR THIS MACRO
1100  CONTINUE


      DO L=2,7
#if !defined(__GIL__) && !defined(__LIN__) && !defined(__MAC__)
        IF(KISCHR(LCARD(L)) .LE. 0) LCARD(L) = 32
#endif
      ENDDO

c      WRITE(NCWU,'(A,6A1,6I8)') 'Searching:',
c     1 (LCARD(L),L=2,7),(LCARD(L),L=2,7)

      DO 1300 K=1,NMAC
      DO 1200 L=1,6
C--CHECK THE COMPONENTS OF THE MACRO NAME
      IF(LCARD(L+1).NE.NAMES(L+1,K)) GOTO 1300
C--SUCCESS
1200  CONTINUE
      LMAC=K
      GOTO 1500
1300  CONTINUE

c      DO K=1,NMAC
c      WRITE(NCWU,'(6A1,6I8)')
c     2 (NAMES(L,K),L=2,7),(NAMES(L,K),L=2,7)
c      ENDDO
      WRITE(NCWU,1400)(LCARD(K),K=1,7)
1400  FORMAT(/17H UNKNOWN MACRO : ,10A1)
      STOP 06
C--MACRO NAME FOUND  -  NOW LOOK FOR THE PARAMETERS
1500  CONTINUE
      N=8
      NPARAM=0
C--CHECK IF WE OFF THE CARD
1600  CONTINUE
      IF(N-NCHARM)1700,1700,3500
C--MORE TO PROCESS  -  CHECK FOR A BLANK
1700  CONTINUE
      IF(LCARD(N).NE.IB) GOTO 1900
C--THIS IS A BLANK  -  SKIP OVER IT
1800  CONTINUE
      N=N+1
      GOTO 1600
C--NOT A BLANK  -  MUST BE THE START OF A NEW PARAMETER
1900  CONTINUE
      NPARAM=NPARAM+1
      IPARAM(1,NPARAM)=N
C--CHECK IF THIS PARAMETER IS INTRODUCED BY '"'
      IF(LCARD(N).NE.IDQ) GOTO 2800
C--PARAMETER IS ENCLOSED IN '"'S  -  SEARCH FOR THE REST OF IT
2000  CONTINUE
      N=N+1
      IPARAM(1,NPARAM)=N
C--CHECK IF WE ARE OFF THE CARD
      IF(N-NCHARM)2300,2300,2100
C--PARAMETER FORMAT ERROR
2100  CONTINUE
      WRITE(NCWU,2200)(LCARD(K),K=1,NCHARM)
2200  FORMAT(/27H ILLEGAL MACRO PARAMETER : ,160A1)
      STOP 07
C--SEARCH FOR THE TERMINATING '"'
2300  CONTINUE
      L=N
      DO 2400 K=L,NCHARM
      N=K
      IF(LCARD(K).EQ.IDQ) GOTO 2500
2400  CONTINUE
      GOTO 2100
C--END OF THIS PARAMETER  -  SET THE SECOND FLAG
2500  CONTINUE
      IPARAM(2,NPARAM)=N-1
      N=N+1
C--CHECK FOR THE END OF THE CARD
      IF(N-NCHARM)2530,2530,3300
C--SEARCH FOR THE TERMINATING ','
2530  CONTINUE
      L=N
      DO 2700 K=L,NCHARM
      N=K
      IF(LCARD(K).EQ.IB) GOTO 2700
C--NOT A BLANK  -  CHECK FOR THE ',' NOW
2600  CONTINUE
      IF(LCARD(K).EQ.IC) GOTO 3300
      GOTO 2100
2700  CONTINUE
      GOTO 3300
C--NORMAL PARAMETER, NOT ENCLOSED BY '"'S
2800  CONTINUE
      L=N
      IPARAM(2,NPARAM)=IPARAM(1,NPARAM)-1
      DO 3100 K=L,NCHARM
      N=K
C--CHECK FOR A BLANK
      IF(LCARD(K).EQ.IB) GOTO 3100
C--NOT A BLANK  -  NOTE IT AND CHECK FOR THE PARAMETER TERMINATOR
2900  CONTINUE
      IF(LCARD(K).EQ.IC) GOTO 3300
C--NOT THE TERMINATOR  -  RECORD THE POSITION
3000  CONTINUE
      IPARAM(2,NPARAM)=N
3100  CONTINUE
C--UPDATE AND GO AND LOOK FOR THE NEXT PARAMETER
3300  CONTINUE
      N=N+1
      GOTO 1600
C
C--BEGIN TO OUTPUT THE RECORDS THAT HAVE BEEN STORED FOR THIS MACRO
3500  CONTINUE
      IADD=NAMES(1,LMAC)
      GOTO 3850
C--CHECK IF WE HAVE REACHED THE END OF THE CHAIN FOR THIS MACRO
3550  CONTINUE
      IF(MACROS(IADD))4900,4900,3600
C--MORE CHAIN LEFT  -  MOVE ONTO THE NEXT HEADER AND CHECK ITS TYPE
3600  CONTINUE
      IADD=MACROS(IADD)
      IF(MACROS(IADD+1))3700,4000,4300
C--START OF A NEW CARD  -  CHECK IF THERE IS ANYTHING TO OUTPUT
3700  CONTINUE
      IF(LOC)4000,4000,3800
C--DATA REMAINING TO OUTPUT  -  PUNCH THE CARD
3800  CONTINUE
C -- CHECK FOR MACHINE DEPENDENT CODE
      CALL XCHMAC(IBUF(1))
      IF((.NOT.LSTRIP).OR.((IBUF(1).NE.ICOM)
     1                 .OR.(IBUF(2).NE.ICOM2))) THEN
        WRITE(CBUF,900)(IBUF(ITEMP),ITEMP=1,NCHAR)
        WRITE(NCPU,'(A)') TRIM(CBUF)
      END IF
C--PREPARE THE OUTPUT BUFFER FOR THE NEXT RECORD
3850  CONTINUE
      LOC=0
      DO 3900 K=1,NCHAR
      IBUF(K)=IB
3900  CONTINUE
C--OUTPUT THE MACRO NAME IN THE SEQUENCE FIELD
      DO 3950 K=1,6
      IBUF(K+73)=NAMES(K+1,LMAC)
3950  CONTINUE
C--CHECK IF THERE IS ANY TEXT TO OUTPUT FROM THIS HEADER
4000  CONTINUE
      IF(MACROS(IADD+2))3550,3550,4100
C--TEXT TO OUTPUT  -  MOVE IT ACROSS
4100  CONTINUE
      L=MACROS(IADD+2)
      M=IADD+NHEAD
      DO 4200 K=1,L
      LOC=LOC+1
      IBUF(LOC)=MACROS(M)
      M=M+1
4200  CONTINUE
      GOTO 3550
C--MACRO PARAMETER TO SUBSTITUTE
4300  CONTINUE
      IF(MACROS(IADD+1)-NPARAM)4600,4600,4400
C--PARAMETER NOT GIVEN
4400  CONTINUE
      LOC=LOC+MAX0(0,MACROS(IADD+2))
      GOTO 3550
C--CHECK IF THIS PARAMETER CONTAINS ANY TEXT
4600  CONTINUE
      L=MACROS(IADD+1)
      IF(IPARAM(1,L)-IPARAM(2,L))4700,4700,4400
C--SUBSTITUTE THIS PARAMETER AT THIS POINT
4700  CONTINUE
      M=IPARAM(2,L)
      L=IPARAM(1,L)
      N=LOC
      DO 4800 K=L,M
      N=N+1
      IBUF(N)=LCARD(K)
4800  CONTINUE
      LOC=MAX0(N,LOC+MACROS(IADD+2))
      GOTO 3550
C--END OF THE MACRO SUBSTITUTION
4900  CONTINUE
      IF(LOC)6000,6000,5000
C--DATA WATING TO BE OUTPUT
5000  CONTINUE
C -- CHECK FOR MACHINE DEPENDENT CODE
      CALL XCHMAC(IBUF(1))
      IF((.NOT.LSTRIP).OR.((IBUF(1).NE.ICOM).OR.
     1 (IBUF(2).NE.ICOM2))) THEN
		 WRITE(CBUF,900)(IBUF(ITEMP),ITEMP=1,NCHAR)
		 WRITE(NCPU,'(A)') TRIM(CBUF)
	  END IF
      GOTO 6000
C
C--NOT A MACRO  -  OUTPUT THE RECORD
5500  CONTINUE
      IF((.NOT.LSTRIP).OR.((LCARD(1).NE.ICOM).OR.
     1  (LCARD(2).NE.ICOM2)))THEN
        WRITE(CBUF,900)(LCARD(ITEMP),ITEMP=1,NCHAR)
        WRITE(NCPU,'(A)') TRIM(CBUF)
      END IF
6000  CONTINUE
      RETURN
      END
CODE FOR XCHMAC
      SUBROUTINE XCHMAC(LCARD)
C -- CHECK FOR MACHINE TYPE
C
      PARAMETER ( LLEN = 160 )

      DIMENSION LCARD(LLEN)
      DIMENSION HOL(3)
      INTEGER HOL
C
      COMMON /MACHIN/MAC(4),IUPD(3),IALL(3)
C
      COMMON /XCHARS/ NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON /XCARDS/ NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
C --
      LOGICAL LSTRIP
      COMMON /XSUBST/ IAND, INOT, ICOM, ICOM2, LSTRIP
#if defined (_HOL_)
      DATA HOL(1)/1HH/, HOL(2)/1HO/, HOL(3)/1HL/
#else
      DATA HOL(1)/'H'/, HOL(2)/'O'/, HOL(3)/'L'/
#endif
C
      DATA MMAC /3/, MNMAC /4/
C----- CHECK IF UPDATING OR CONSOLIDATING ONLY
      IF(MAC(4))8000,8000,1000
C----- DO MACHINE SPECIFIC SUBSTITUTION
C
1000  CONTINUE
1100  CONTINUE
      IONE = LCARD(1)
      IF (IONE.EQ.IB) GO TO 9000
C --
1200  CONTINUE
C -- CHECK FOR MACHINE SWITCHES
      ISW=0
      IF (IONE.EQ.IAND) ISW=1
      IF (IONE.EQ.INOT) ISW=-1
C -- CHECK HOW MANY MACHINE SWITCHES (MAXIMUM == MNMAC)
C -- ALLOW THINGS LIKE &&DOSWIN or &&&DOSWINDEC
      INMAC=1
      DO 1202 II=2,MNMAC
         IF (LCARD(II).EQ.IONE) INMAC=INMAC+1
1202  CONTINUE
C
C----- LOOK FOR HOLLERITH SUBSTITUTION
      IMAC=-1
      DO 1220 II=1,MMAC
      IF (LCARD(II+1).NE.HOL(II)) IMAC=1
1220  CONTINUE
      IF (IMAC .EQ. -1) GOTO 1230
C
C----- IDENTIFY MACHINE
C----- IMAC will be 1 if the MAChine is listed.
C----- IMAC will be -1 if it is not.
      DO 1251 KK=0,INMAC-1
        IMAC=1
        DO 1250 II=1,MMAC
          IF (LCARD(INMAC+KK*MMAC+II).NE.MAC(II)) IMAC=-1
1250    CONTINUE
        IF (IMAC.EQ.1) GOTO 1230
1251  CONTINUE
1230  CONTINUE
      INCL=ISW*IMAC
      IF (INCL) 1400,9000,1600
1400  CONTINUE
C -- CONVERT CARD TO COMMENT
      DO 1420 II=NCHARM,1,-1
      LCARD(II+2) =  LCARD(II)
1420  CONTINUE
      LCARD(1)=ICOM
      LCARD(2)=ICOM2
      RETURN
1600  CONTINUE
C -- INCLUDE THIS CARD C--NB NOT SURE ABOUT THESE MATHS: (JJ=68?)
C      JJ=NCHAR-MMAC-9
C This seems better:
      JJ=NCHARM-(MMAC+1)*INMAC
C -- REMOVE CHARACTERS AT BEGINNING OF CARD AND FILL END WITH BLANKS
      DO 1620 II=1,JJ
      K=II+(MMAC+1)*INMAC
      LCARD(II)=LCARD(K)
1620  CONTINUE
      JJ=JJ+1
      K = NCHAR
      DO 1630 II=JJ,K
      LCARD(II)=IB
1630  CONTINUE
C      LCARD(LLEN) = ICOM
C --
C -- CONTINUE PROCESSING THIS CARD
      GO TO 1000
8000   CONTINUE
C---- UPDATING ONLY
9000  CONTINUE
C -- THIS CARD COMPLETED
      RETURN
      END
C
C --
C
CODE FOR KNUMB
      FUNCTION KNUMB(IARRAY,N,IRES)
C--READ A NUMBER FROM THE ARRAY 'IARRAY', STARTING AT CHARACTER 'N'.
C
C  IARRAY  THE ARRAY CONTAINING THE CHARACTERS.
C  N       THE FIRST CHARACTER TO USE.
C  IRES    THE NUMBER FOUND.
C
C--RETURN VALUES ARE :
C
C  -1  NO NUMBER FOUND, I.E. INCORRECT OR BLANK CHARACTER.
C   0  NUMBER TERMINATED BY A BLANK.
C  +1  NUMBER TERMINATED BY ANY OTHER CHARACTER.
C
C--'N' ALWAYS POINTS TO THE TERMINATING CHARACTER.
C
C--
      PARAMETER ( LLEN = 160 )
      DIMENSION IARRAY(LLEN)
C
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
C
C--SET UP THE INITIAL CONSTANTS
      M=N
      IRES=0
C--CHECK IF WE ARE OFF THE CARD
1000  CONTINUE
      IF(N-NCHAR)1100,1100,1400
C--COMPARE THE NEXT CHARACTER
1100  CONTINUE
      DO 1300 L=1,10
      IF(IARRAY(N).NE.NUM(L)) GOTO 1300
C--SUCCESS  -  INCREMENT THE RESULT
1200  CONTINUE
      IRES=IRES*10+L-1
      N=N+1
      GOTO 1000
1300  CONTINUE
C--END OF A NUMBER  -  CHECK IF THERE REALLY WAS A NUMBER
1400  CONTINUE
      IF(M-N)1500,1800,1800
C--A NUMBER HAS BEEN READ  -  CHECK THE TERMINATOR
1500  CONTINUE
      IF(IARRAY(N).EQ.IB) GOTO 1700
C--NOT A BLANK AS TERMINATOR
1600  CONTINUE
      KNUMB=1
      GOTO 1900
C--BLANK AS TERMINATOR
1700  CONTINUE
      KNUMB=0
      GOTO 1900
C--NOT A NUMBER AT ALL
1800  CONTINUE
      KNUMB=-1
1900  CONTINUE
      RETURN
      END
C
CODE FOR KRDSOU
      FUNCTION KRDSOU(IN)
C--READ SOURCE CARDS
C
C  IN  DUMMY ARGUMENT
C
C--RETURN VALUES ARE :
C
C  -1  E.O.F.
C   0  O.K.
C
C--
      PARAMETER ( LLEN = 160 )
      COMMON/SEGSN/ ISEG(3)
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
C
      READ(NCRU,1000,END=2000)(ICARD(ITEMP),ITEMP=1,NCHAR)
1000  FORMAT(160A1)
      I=I+ID
      J=J+JD
#if !defined(__VAX__)
      GOTO 1030
#endif
      IF(ICARD(1) .EQ.IH) GOTO 1030
      N=J
C      DO 1020 L=1,5
C      K=N
C      N=N/10
C      K=K-N*10
C      ICARD(81-L)= NUM(K+1)
C1020  CONTINUE
C      ICARD(73)=ISEG(1)
C      ICARD(74)=ISEG(2)
C      ICARD(75)=ISEG(3)
1030  CONTINUE
      KRDSOU=0
C Check for Non-ASCII characters (EOL etc.)
      DO K=1,NCHAR
#if !defined(__GIL__) && !defined(__LIN__) && !defined(__MAC__)
      IF ( KISCHR(ICARD(K)) .LE. 0 ) ICARD(K)=32
#endif
      END DO
1040  CONTINUE
      RETURN
C
2000  CONTINUE
      KRDSOU=-1
      GOTO 1040
      END
C
CODE FOR KRDED
      FUNCTION KRDED(IN)
C--READ EDIT CARDS
C
C  IN  DUMMY ARGUMENT
C
C--RETURN VALUES ARE :
C
C  -1  E.O.F.
C   0  O.K.
C
C
C      'ICHSTR' IS USED IN THIS ROUTINE TO INDICATE WHETHER OR NOT WE
C      ARE CURRENTLY PROCESSING A CHARACTER STRING. THIS MEANS THAT
C      CHARACTERS WHICH NORMALLY INDICATE AN EDIT COMMENT ARE NOT
C      TREATED AS SUCH WHEN THEY APPEAR IN A FORTRAN CHARACTER CONSTANT
C
C
C--
      PARAMETER ( LLEN = 160 )
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
C
#if defined (_HOL_)
      DATA IAT/1H@/
      DATA ICHR / 1H' /
#else
      DATA IAT/'@'/
      DATA ICHR / '''' /
#endif
C
C
C
      ICHSTR = -1
C
      READ(NEFU,1000,END=2000)(NED(ITEMP),ITEMP=1,NCHAR)
1000  FORMAT(160A1)
C -- IF THE CHARACTER IS AN AT SIGN, THE REST OF THE LINE IS A COMMENT
      IF ( NED(1) .EQ. IAT ) GO TO 1060
      DO 1030 K=1,72
C -- IF THE NEXT CHARACTER IS THE CHARACTER STRING DELIMITER, CHANGE
C    THE CHARACTER STRING INDICATOR
      IF ( NED(K) .EQ. ICHR ) ICHSTR = 0 - ICHSTR
C -- IF WE ARE IN THE MIDDLE OF A STRING, THE CHARACTERS ARE TAKEN
C    LITERALLY ( NO EDIT COMMENTS ETC. HERE )
      IF ( ICHSTR .GT. 0 ) GO TO 1030
1030  CONTINUE
1031  CONTINUE
      KRDED=0
1050  CONTINUE
      RETURN
C
1060  CONTINUE
      DO 1070 ITEMP =K,72
      NED(ITEMP) =IB
1070  CONTINUE
      GOTO  1031
C
2000  CONTINUE
      KRDED=-1
      GOTO 1050
      END
C
CODE FOR EDTBLK
      BLOCK DATA EDTBLK
      PARAMETER ( LLEN = 160 )
      COMMON/XCARDS/NCHAR,NCHARM,NED(LLEN),ICARD(LLEN),I,J,ID,JD
      COMMON/MACHIN/ MAC(4),IUPD(3),IALL(3)
      COMMON /XMACRO/ NMAC,NAMES(7,400),NHEAD,IADD,LAST,NTYP,MAXADD,
     2 MACROS(96000)
      COMMON/XCHARS/NUM(10),ICODE(9),IA,IB,IC,IM,ILP,IRP,IH,IDQ
      COMMON/XUNITS/NCRU,NEFU,NCWU,NCPU,NUMAC
      COMMON /SEGSN/ ISEG(3)
      LOGICAL LSTRIP
      COMMON /XSUBST/ IAND, INOT, ICOM, ICOM2, LSTRIP
C
      DATA MAXADD/95920/,NHEAD/3/
#if defined (_HOL_)
      DATA NUM(1)/1H0/,NUM(2)/1H1/,NUM(3)/1H2/,NUM(4)/1H3/,NUM(5)/1H4/
      DATA NUM(6)/1H5/,NUM(7)/1H6/,NUM(8)/1H7/,NUM(9)/1H8/,NUM(10)/1H9/
      DATA ICODE(1)/1HC/,ICODE(2)/1HO/,ICODE(3)/1HD/,ICODE(4)/1HE/
      DATA ICODE(5)/1H /,ICODE(6)/1HF/,ICODE(7)/1HO/,ICODE(8)/1HR/
      DATA ICODE(9)/1H /
#else
      DATA NUM(1)/'0'/,NUM(2)/'1'/,NUM(3)/'2'/,NUM(4)/'3'/,NUM(5)/'4'/
      DATA NUM(6)/'5'/,NUM(7)/'6'/,NUM(8)/'7'/,NUM(9)/'8'/,NUM(10)/'9'/
      DATA ICODE(1)/'C'/,ICODE(2)/'O'/,ICODE(3)/'D'/,ICODE(4)/'E'/
      DATA ICODE(5)/' '/,ICODE(6)/'F'/,ICODE(7)/'O'/,ICODE(8)/'R'/
      DATA ICODE(9)/' '/
#endif
      DATA NCRU/5/,NEFU/1/,NCWU/6/,NCPU/7/,NUMAC/3/

#if defined (_HOL_)
      DATA IA/1H*/,IM/1H-/,IB/1H /,IC/1H,/
#else
      DATA IA/'*'/,IM/'-'/,IB/' '/,IC/','/
#endif

#if defined(__LIN__)  || defined (__MAC__) || defined (__GIL__)
#if defined (_HOL_)
      DATA ILP/1H</,IRP/1H>/,IH/1H\/,IDQ/1H"/
#else
      DATA ILP/'<'/,IRP/'>'/,IH/'\\'/,IDQ/'"'/
#endif
#else
      DATA ILP/'<'/,IRP/'>'/,IH/'\'/,IDQ/'"'/
#endif

#if defined (_HOL_)
      DATA ISEG(1) /1H / , ISEG(2) /1H / , ISEG(3) /1H /
      DATA IUPD(1)/1HU/,IUPD(2)/1HP/,IUPD(3)/1HD/
      DATA IALL(1)/1HA/,IALL(2)/1HL/,IALL(3)/1HL/

      DATA IAND/1H&/,INOT/1H#/,ICOM/1HC/,ICOM2/1H /
#else
      DATA IUPD(1)/'U'/,IUPD(2)/'P'/,IUPD(3)/'D'/
      DATA IALL(1)/'A'/,IALL(2)/'L'/,IALL(3)/'L'/

      DATA IAND/'&'/,INOT/'#'/,ICOM/'C'/,ICOM2/' '/
      DATA ISEG(1) /' '/ , ISEG(2) /' '/ , ISEG(3) /' '/
#endif
C
      DATA LSTRIP /.FALSE./
C
      END
CODE FOR XCRAS
      SUBROUTINE XCRAS ( CSOURC, LENNAM )
C
C----- REMOVE ALL SPACES BY LEFT ADJUSTING STRING
C
C      CSOURC      SOURCE STRING TO BE CONVERTED
C      LENNAM      USEFUL LENGTH
C
C
      CHARACTER *(*) CSOURC
      CHARACTER *1  CBUF
C
      LENFIL=  LEN(CSOURC)
      K = 1
      DO 100 I = 1 , LENFIL
       CBUF = CSOURC(I:I)
       IF (CBUF .NE. ' ') THEN
           CSOURC(K:K) = CBUF
         K = K + 1
       ENDIF
100   CONTINUE
      LENNAM = MAX (1, K-1)
      IF (LENNAM .LT. LENFIL) CSOURC(LENNAM+1:LENFIL) = ' '
      RETURN
      END
C
C
#if defined(__DOS__) || defined(_DIGITALF77_) ||defined (__INW__)
      SUBROUTINE CONVER ( CFILE , NUNIT )



      CHARACTER*128 CFILE

      INTEGER NUNIT

      OPEN(NUNIT,FILE=CFILE,STATUS='OLD',ERR=101)
101   CONTINUE


      RETURN

      END


#endif
CODE FOR XCCUPC
      SUBROUTINE XCCUPC ( CLOWER , CUPPER )
C
C -- CONVERT STRING TO UPPERCASE
C
C      CLOWER      SOURCE STRING TO BE CONVERTED
C      CUPPER      RESULTANT STRING
C
C
      CHARACTER*(*) CLOWER , CUPPER
C
      CHARACTER*26 CALPHA , CEQUIV
C
      DATA CALPHA / 'abcdefghijklmnopqrstuvwxyz' /
      DATA CEQUIV / 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' /
C
C
C -- MOVE WHOLE STRING.
C-ASSIGNING LOWER TO UPPER IS FORMALLY INVALID
C      CUPPER = CLOWER
      READ(CLOWER,'(A)') CUPPER
C
      LENGTH = MIN0 ( LEN ( CLOWER ) , LEN ( CUPPER ) )
C
C -- SEARCH FOR LOWERCASE CHARACTERS AND CONVERT TO UPPERCASE
      DO 2000 I = 1 , LENGTH
        IPOS = INDEX ( CALPHA , CLOWER(I:I) )
        IF ( IPOS .GT. 0 ) CUPPER(I:I) = CEQUIV(IPOS:IPOS)
2000  CONTINUE
C
C
      RETURN
      END

#if !defined(__GIL__) && !defined(__LIN__) && !defined(__MAC__) 
CODE FOR KISCHR
      FUNCTION KISCHR ( ICHAR )
C Return 0 if CCHAR is not a character.
      CHARACTER*96 CALPHA
      CHARACTER*1  CCHAR
C23456789012345678901234567890123456789012345678901234567890123456789012
      DATA CALPHA / 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY
#if defined(__DOS__) || defined(_DIGITALF77_) || defined(_INTELF77_)
     1Z1234567890!"�$%^&*()_+-={}[]@~''#<>?,./|\:;` ' /
#else
     1Z1234567890!"�$%^&*()_+-={}[]@~''#<>?,./|\\:;` ' /
#endif
C Note ' is escaped with '
C On UNIX \ is escaped with \

      WRITE(CCHAR,'(A1)')ICHAR
      KISCHR = INDEX ( CALPHA , CCHAR )
      RETURN
      END
#endif
