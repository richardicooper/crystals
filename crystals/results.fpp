C $Log: not supported by cvs2svn $
C Revision 1.56  2003/05/27 10:24:04  djw
C Line over-run fixed.
C
C Revision 1.55  2003/05/23 15:00:14  djw
C Full expression for weigting schemes 14&15
C
C Revision 1.54  2003/05/07 12:18:55  rich
C
C RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
C using only free compilers and libraries. Hurrah, but it isn't very stable
C yet (CRYSTALS, not the compilers...)
C
C Revision 1.53  2003/04/01 13:48:51  rich
C XTHLIM could go into an infinite loop in certain cases (certain cells?). Limit
C loops for optimising MAXH,K,L to 400 iterations.
C
C Revision 1.52  2003/03/25 14:02:35  rich
C Move DELRHOMIN/MAX back to their original locations in LIst 30.
C
C Revision 1.51  2003/02/20 16:05:21  rich
C Ridiculous number of changes - mainly additions apropos the HTML output.
C
C Revision 1.50  2003/02/19 13:35:25  djw
C Add Oxford Diffraction to list of known instruments for Jean Claude
C
C Revision 1.49  2003/02/17 13:28:43  djw
C Remove writes to .mon from FOURIER, save Rho and positions in LIST 30 CIFEXTRA (was in REFINEMENT), adjust output of 30
C
C Revision 1.48  2003/02/14 17:09:02  djw
C Extend codes to work wih list 6 and list 7.  Note that sfls, calc and
C recine have the parameter ityp06, which corresponds to the types
C pickedip for lists 6 and 7  from the command file
C
C Revision 1.47  2003/01/15 13:52:49  rich
C Remove all output to NCAWU.
C
C Fix return path for SPRT5P so that it doesn't try to print
C the overall parameters on the way out if there was an error.
C This occasionally crashed if you did a #PARAM without having
C an up-to-date LIST22.
C
C Revision 1.46  2003/01/14 10:20:49  rich
C Name clash in volume esd function fixed. (A).
C Escape backslashes in report of phi and omega scans.
C
C Revision 1.45  2002/12/03 13:55:48  rich
C Remove debugging statement.
C
C Revision 1.44  2002/11/07 17:35:13  rich
C THLIM upgraded so that it works. (With Friedel unmerged data and data
C that hasn't been SYSTEMATIC'd). It now also writes things to the listing
C file (missing reflection indices) and draws graphs.
C
C Revision 1.43  2002/11/06 12:58:22  rich
C If the theta_full value in L30 is negative, then the program will use its absolute
C value as theta_full and compute the completeness, rather than trying to find
C an optimum theta_full.
C
C Revision 1.42  2002/10/31 13:22:58  rich
C Some indenting to try to work out esd code.
C A DVF fix to fix compiler moan (consant passed as subroutine arg, then
C modified in subroutine).
C No calls to ZMORE allowed in DVF version.
C
C Revision 1.41  2002/10/07 11:03:06  rich
C EnCIFer compatibility.
C
C Revision 1.40  2002/08/30 14:36:15  richard
C Added pressure to L30. Only appears in CIF if non-zero.
C
C Revision 1.39  2002/07/22 14:37:31  Administrator
C Try to fix LIST 4 in cif
C
C Revision 1.38  2002/07/16 14:20:22  richard
C Fix format overflow when cell is bigger than 10,000 cubic Angstroms
C
C Revision 1.37  2002/07/15 13:14:29  richard
C For F000, use electron in cell count, as this is the SHELX standard, and while
C the CIF definition allows dispersive terms to be included, it only confuses
C referees.
C
C Revision 1.36  2002/07/15 12:04:36  richard
C Three things:
C F000 ignores F' and F'' if anomolous correction is off in L23 - awaiting confirmation
C from Ton about this.
C Call new code to work out completeness and theta_full.
C Put _chemical_absolute_configuration into the CIF during space group output.
C '.' for centro or 'unk' for non-centro. Leave it for the user to change if they
C think they've discovered something about the configuration.
C
C Revision 1.35  2002/06/07 16:01:59  richard
C Some things:
C
C (1) Tidied the CIF up, with spaces between groups of related items and that sort of thing.
C
C (2) Call XSFLSB at start to update L30 calc-R,Rw,sigma and number.
C
C (3) Calculate ZPRIME from L2 and L30 Z value, if L30 Z value is non-zero. Use this
C to give desired formula.
C
C (4) Quote three groups of R-factors: _ref, _all and _gt. The _gt threshold is the
C same as the L28 threshold if present, otherwise it is I>4u(I).
C
C Revision 1.34  2002/05/31 14:41:09  Administrator
C Update SHELX SPECIAL output
C
C Revision 1.33  2002/04/16 10:04:50  Administrator
C re-Fix atom types to be mixed case
C
C Revision 1.32  2002/04/12 13:52:02  Administrator
C Ensure refernce for absorption correction output
C
C Revision 1.31  2002/03/17 14:53:38  richard
C RIC: If refine_diff_density min or max are both within 0.000001 of 0.0, then
C replace with ? in the CIF file.
C
C Revision 1.30  2002/03/01 11:33:41  Administrator
C Correct and improve presntation of weighting scheme in .cif file
C
C Revision 1.29  2002/02/27 19:30:18  ckp2
C RIC: Increase lengths of lots of strings to 256 chars to allow much longer paths.
C RIC: Ensure consistent use of backslash after CRYSDIR:
C
C Revision 1.28  2002/01/14 12:11:45  Administrator
C Correct format of FLACK parameter output
C
C Revision 1.27  2001/12/14 16:56:53  ckp2
C Put cell volume su into CIF file. SU is based only on cell parameter esd's not full
C variance-covariance matrix but cifcheck can only use these too, so the results
C will tally.
C
C Revision 1.26  2001/09/26 11:36:50  Administrator
C No atom site type in summary file. CIF only.
C
C Revision 1.25  2001/09/11 11:19:16  ckp2
C In the Windows version, stop the CHAR(12) from printing in the PUNCH file.
C
C Revision 1.24  2001/09/07 14:24:54  ckp2
C CIF tidy.
C 1) Any writes directly to the CIF file (NCFPU1) are formatted so that
C the data lines up at column 35.
C 2) Any writes via the XPCIF subroutine are subject to the following rules:
C If there is a CIF dataname at the start of the line (an underscore) then any
C data following it is moved to column 35 provided that:
C a) There is some data there.
C b) This will not result in the data running past column 80.
C c) The CIF dataname is shorter than 35 characters.
C
C The CIF looks much easier to read as a result.
C
C Revision 1.23  2001/08/15 08:23:34  ckp2
C Two new scan types for LIST 30. Six new absorption correction types.
C (Currently these new types all store min+max in PSIMIN and PSIMAX).
C
C Revision 1.22  2001/08/09 07:29:40  ckp2
C It helps if _atom_site_type_symbol is uppercase for certain programs. (WinGX).
C
C Revision 1.21  2001/07/19 11:57:25  ckp2
C Add an _atom_site_type_symbol to CIF output.
C
C Make number format longer for torsion angle CIF output
C so that 3 digit negative numbers will not crash the program.
C
C Revision 1.20  2001/07/11 09:37:36  ckpgroup
C Move test for outputting absorption details
C
C Revision 1.19  2001/06/13 14:47:06  richard
C Tweak order of calculation so that List 5 always returns exactly the same
C molecular weight as List 29. (Number of multiplications reduced).
C
C Revision 1.18  2001/06/04 16:04:33  richard
C Fix display of su's in overall parameters in #PARA/END
C
C Revision 1.17  2001/04/11 15:27:18  CKP2
C Fix xsymop so that .CIF entries tally
C
C Revision 1.16  2001/03/28 12:46:13  CKP2
C DJW  Fix up site occupancies in LIST 5 part of cif output so that the
C effects of crystallogrpahic occupancy are explicitly removed. This is
C not explained in any CIFDIC, but is stated in current Notes for
C Authors.
C
C Revision 1.15  2001/03/09 10:29:24  richard
C Tweak to XPCIF to stop it crashing.
C
C Revision 1.14  2001/03/09 08:55:23  CKP2
C  Missed a call in XPCIF
C
C Revision 1.13  2001/03/05 17:29:01  CKP2
C Fix cif punching of character constants
C
C Revision 1.12  2001/03/02 17:04:34  CKP2
C More cif patches
C
C Revision 1.11  2001/02/27 18:15:52  CKP2
C DJW move call to PRC17 from PP5CO to calling routine because of clash
C with SELECT - probably due to incorrect use of STORE by something. List
C 2 in memeory was corrupt
C
C Revision 1.10  2001/02/26 09:49:59  richard
C Change log at top of file.
C
C
CODE FOR SPRT6P
      SUBROUTINE SPRT6P
C--MAIN ROUTINE FOR LIST 6P
C
C  NCOL   NUMBER OF COLUMNS PER PAGE
C  NLIN   NUMBER OF LINES PER PAGE
C  NSPAC  NUMBER OF SPACE AFTER EACH COLUMN
C  NSKIP  NUMBER OF CHARACTERS TO SKIP BEFORE THE FIRST COLUMN
C  SCALE5  THE SCALE FACTOR TO BE APPLIED TO /FC/.
C  IBAR    THE MAXIMUM NUMBER OF LINES PER PAGE.
C  LST    NUMBER OF CHARACTER PER COLUMN
C  LSTX   NUMBER OF CHARACTERS PER LINE
C  LW      THE NUMBER OF ENTRIES PER COLUMN.
C      L28SKP    USE (0) OR NOT USE (-1) LIST 28
C
C  Z       THE SCALE FACTOR FOR /FO/.
C  Y       THE CONVERSION FROM RADIANS TO DEGREES.
C
C  JA     START OF THE PAGE ASSEMBLY AREA
C  JB     ADDRESS OF THE LAST ENTRY IN THE PAGE ASSEMBLY AREA
C  JC     CURRENT ADDRESS IN THE PAGE ASSEMBLY AREA
C
C--FORMAT OF THE ASSEMBLY AREA :
C
C  0  TYPE OF ENTRY :
C      -1  BLANKS
C       0  NEW K,L PAIR
C       1  /FO/ENTRY
C  1  H  OR  K
C  2  /FO/ OR L
C  3  /FC/ OR NOT USED
C  4  PHASE OR NOT USED
C
C--
\TSSCHR
\ISTORE
C
\STORE
C
\XPTCS
C
\XOPVAL
\XWORK
\XWORKA
\XLISTI
\XCONST
\XUNITS
\XSSVAL
\XLST05
\XLST06
\XIOBUF
C
\XLST01
\QSTORE
C
C--READ THE CONTROL DIRECTIVES AND SET UP THE DEFAULT VALUES
      IN = 0
      IF(JDIR6P(ITYP06))1850,1000,1000
C--LOAD LIST 5 AND FIND THE SCALE FACTOR
1000  CONTINUE
C--FIND THE TYPE OF LISTS   IULN IS USUALY 6
      IULN=KTYP06(ITYP06)
      CALL XRSL
      CALL XCSAE
      CALL XFAL01
C-- CHECK IF THERE IS A LIST 5 TO LOAD
      IF(KEXIST(5) .GE. 1 ) THEN
C--THERE IS A LIST 5  -  LOAD IT
        CALL XFAL05
        IF ( IERFLG .LT. 0 ) GO TO 1850
C--SET THE SCALE FACTOR
        Z = SCALE5 / STORE(L5O)
      ELSE
        Z = SCALE5
      ENDIF
      Y=360./TWOPI
C--SET UP LIST 6 FOR PROCESSING
      CALL XFAL06(IULN, 0)
      IF ( IERFLG .LT. 0 ) GO TO 1850
C--SET UP THE PAGE ASSEMBLY AREA
      JA=NFL
      LN=6
      IREC=6001
      JB=KCHNFL(NCOL*NLIN*LW)-LW
C--START OF THE REFLECTION FETCHING LOOP
      IF (L28SKP .EQ. -1) THEN
      IF(KLDRNR(1))1850,1050,1050
C--SET UP THE CURRENT K,L PAIR FLAGS
      ELSE
      IF (KFNR(0)) 1850, 1050, 1050
      ENDIF
1050  CONTINUE
      A=STORE(M6+1)
      B=STORE(M6+2)
C--SET THE END OF REFLECTION FLAG OFF
      JZ=0
C--SET THE NEW K,L PAIR FLAG ON
      JY=1
C--SET ALL THE ASSEMBLY FLAGS TO INDICATE BLANKS
1100  CONTINUE
      JC=JA
      DO 1150 I=JA,JB,LW
      ISTORE(I)=-1
1150  CONTINUE
C--SET UP THE PAGE CONTROL FLAGS
      JD=NLIN
      JE=NCOL
C--OUTPUT ONE BLANK LINE AT THE TOP OF EACH COLUMN
1200  CONTINUE
      IN=JBLAS(IN)
C--CHECK IF THIS IS A NEW K,L PAIR
1250  CONTINUE
      IF(JY)1300,1300,1450
C--K,L PAIR HAS NOT CHANGED  -  CHECK IF THIS IS THE TOP OF THE PAGE
1300  CONTINUE
      IF(NLIN-JD-1)1350,1350,1400
C--OUTPUT ONE BLANK LINE IN THIS COLUMN
1350  CONTINUE
      IF(JBLAS(IN))1550,1400,1550
C--STORE THE CURRENT H, /FO/ ETC.
1400  CONTINUE
      IF(JHFFS(IN))1850,1250,1550
C--K,L PAIR HAS JUST CHANGED  -  OUTPUT A BLANK LINE
1450  CONTINUE
      IF(JBLAS(IN))1550,1500,1550
C--STORE THE NEW K,L PAIR INFORMATION
1500  CONTINUE
      IF(JKLS(IN))1550,1350,1550
C--END OF A COLUMN  -  CHECK IF THIS THE END OF THE REFLECTIONS
1550  CONTINUE
      IF(JZ)1600,1600,1650
C--ONLY THE END OF A COLUMN  -  CHANGE COLUMNS
1600  CONTINUE
      JE=JE-1
      JD=NLIN
C--CHECK IF THERE ARE ANY MORE COLUMNS ON THIS PAGE
      IF(JE)1650,1650,1200
C--END OF THE PAGE  -  PRINT THE RESULTS
1650  CONTINUE
      CALL SPRINT
C--CHECK FOR THE END OF THE REFLECTION FETCHING LOOP
      IF(JZ)1100,1100,1700
C--END OF THE REFLECTIONS  -  EXIT
1700  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTRF .GT. 0 ) WRITE ( NCWU,'(A)' ) CHAR(12)
      ENDIF
##GIDWXS      IF ( IPCHRF .GT. 0 ) WRITE ( NCPU ,'(A)' ) CHAR(12)
1720  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSE , 6 )
      CALL XTIME2(2)
      RETURN
C
C--ERROR ROUTINES
1850  CONTINUE
C
C -- ERRORS
      CALL XOPMSG ( IOPPPR , IOPLSP , 6 )
      GO TO 1720
      END
C
CODE FOR JDIR6P
      FUNCTION JDIR6P(ITYP06)
C--READ DIRECTIVES FOR PRINT LIST 6P
C
C--RETURN VALUES OF 'JDIR6P' ARE :
C
C  -1  ERRORS FOUND.
C   0  ALL OKAY.
C
C   ITYP06 CODE FOR LIST TYPE 
C      1== 6
C      2== 7
C--
C
      PARAMETER(IPROCS=10)
      DIMENSION PROCS(IPROCS)
C
C
\TSSCHR
\XPTCS
\XWORKA
\XUNITS
\XSSVAL
\XIOBUF
C
C
      EQUIVALENCE (PROCS(1),NCOL)
C
C--SET THE INITIAL RETURN VALUE
      JDIR6P=0
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ THE DIRECTIVES AND PARAMETERS
      IF (KRDDPV (PROCS, IPROCS) .LT. 0) GOTO 1150
C--DIRECTIVES INPUT OKAY  
C----- GET THE LIST TYPE
      ITYP06 =ILST
C  CALCULATE THE LINE LENGTH
      LST=18
      LW=5
      LSTX=NSKIP+NCOL*(LST+NSPAC)
C--SET UP THE MAXIMUM LINE LENGTH
      IBAR=IPAGE(3)
C--CHECK THE LINE LENGTH
      IF(IBAR-LSTX)1050,1200,1200
C--LINE LENGTH IS TOO LARGE
1050  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
      WRITE ( CMON,1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
1100  FORMAT(' More than',I5,'  characters on a line')
C--ERROR EXIT FOR THIS ROUTINE
1150  CONTINUE
      JDIR6P=-1
1200  CONTINUE
      RETURN
      END
C
CODE FOR JBLAS
      FUNCTION JBLAS(IN)
C--STORE BLANK SPACE FOR ONE LINE IN THE CURRENT COLUMN
C
C--RETURN VALUES ARE :
C
C  0  OKAY
C  1  END OF COLUMN
C
C--
C
\XPTCS
\XWORKA
C
      IDWZAP = IN
      JBLAS=0
C--MOVE THE POINTER TO THIS COLUMN
      JC=JC+LW
      JD=JD-1
C--CHECK FOR THE END OF THE COLUMN
      IF(JD)1000,1000,1050
C--SET THE END OF COLUMN FLAG
1000  CONTINUE
      JBLAS=1
1050  CONTINUE
      RETURN
      END
C
CODE FOR JKLS
      FUNCTION JKLS(IN)
C--STORE THE NEW K,L PAIR INFORMATION
C
C--RETURN VALUES ARE :
C
C  0  OKAY
C  1  END OF COLUMN
C
C--
\ISTORE
C
\STORE
C
\XPTCS
\XWORKA
\XLST06
C
\QSTORE
C
      IDWZAP = IN
      JKLS=0
C--CLEAR THE NEW K,L PAIR FLAG
      JY=0
C--STORE THE NEW INFORMATION
      ISTORE(JC)=0
      ISTORE(JC+1)=NINT(STORE(M6+1))
      ISTORE(JC+2)=NINT(STORE(M6+2))
      JC=JC+LW
      JD=JD-1
C--CHECK FOR THE END OF THIS COLUMN
      IF(JD)1000,1000,1050
1000  CONTINUE
      JKLS=1
1050  CONTINUE
      RETURN
      END
C
CODE FOR JHFFS
      FUNCTION JHFFS(IN)
C--STORE H INDEX, FO, FC AND PHASE
C
C--RETURN VALUES ARE :
C  0  OKAY
C  1  END OF REFLECTIONS, AND THUS END OF COLUMN
C
C--THIS ROUTINE IS RESPONSIBLE FOR FETCHING THE NEXT REFLECTION
C
C--
\TSSCHR
\ISTORE
C
\STORE
C
\XPTCS
\XWORK
\XWORKA
\XUNITS
\XSSVAL
\XLST05
\XLST06
\XCONST
\XERVAL
\XIOBUF
C
\QSTORE
C
C
      DATA IFO/'FO'/,IFC/'FC'/
C
      IDWZAP = IN
      JHFFS=0
      ISTORE(JC)=1
      ISTORE(JC+1)=NINT(STORE(M6))
      F=STORE(M6+3)*Z
C--CHECK THAT /FO/ IS NOT TOO LARGE
      IF(9999.-F)1500,1000,1000
1000  CONTINUE
      ISTORE(JC+2)=NINT(F)
      F=STORE(M6+5)*SCALE5
C--CHECK THAT /FC/ IS NOT TOO LARGE
      IF(9999.-F)1550,1050,1050
1050  CONTINUE
      ISTORE(JC+3)=NINT(F)
      F=STORE(M6+6)*Y
      IF(F)1100,1150,1150
1100  CONTINUE
      F=F+360.
1150  CONTINUE
      ISTORE(JC+4)=NINT(F)
      JC=JC+LW
      JD=JD-1
      IF(JD)1200,1200,1250
1200  CONTINUE
      JHFFS=1
1250  CONTINUE
C--FETCH NEXT REFLECTION
      IF (L28SKP .EQ. -1) THEN
      IF(KLDRNR(1))1300,1350,1350
C--SET THE END OF REFLECTION FLAG
      ELSE
      IF (KFNR(0)) 1300, 1350, 1350
      ENDIF
1300  CONTINUE
      JZ=1
      JHFFS=1
      GOTO 1700
C--CHECK IF K HAS CHANGED
1350  CONTINUE
      IF(ABS(A-STORE(M6+1))-0.5)1400,1450,1450
C--CHECK IF L HAS CHANGED
1400  CONTINUE
      IF(ABS(B-STORE(M6+2))-0.5)1700,1450,1450
C--NEW K,L PAIR  -  SET THE FLAGS AND RETURN
1450  CONTINUE
      JY=1
      A=STORE(M6+1)
      B=STORE(M6+2)
      GOTO 1700
C
C--ERROR BECAUSE /FO/ IS TOO LARGE TO PRINT
1500  CONTINUE
      IT=IFO
      GOTO 1600
C--ERROR BECAUSE /FC/ IS TOO LARGE
1550  CONTINUE
      IT=IFC
C--PRINT THE ERROR MESSAGE
1600  CONTINUE
      JHFFS=-1
      CALL XERHDR(0)
      IF (ISSPRT .EQ. 0)
     1 WRITE(NCWU,1650)IT,F,STORE(M6),STORE(M6+1),STORE(M6+2)
      WRITE ( CMON, 1650)IT,F,STORE(M6), STORE(M6+1), STORE(M6+2)
      CALL XPRVDU(NCVDU, 1,0)
1650  FORMAT(' **** /',A2,'/ Greater then 9999 :',F12.0,
     2 '  for the reflection ',3F5.0,' ****')
1700  CONTINUE
      RETURN
      END
C
CODE FOR SPRINT
      SUBROUTINE SPRINT
C--PRINT LIST 6P
C
C
\TSSCHR
\ISTORE
C
      DIMENSION LINEA(120)
C
\STORE
C
\XPTCS
\XWORKA
\XUNITS
\XSSVAL
\XCHARS
C
\QSTORE
C
      JC=JA-LW
      JF=LW*NLIN
      IF (ISSPRT .EQ. 0) THEN
      IF( ILSTRF .GT. 0) WRITE(NCWU, '(A)') CHAR(12)
      ENDIF
##GIDWXS      IF( IPCHRF .GT. 0) WRITE(NCPU, '(A)') CHAR(12)
C--CLEAR THE PRINT LINE TO BLANKS
      CALL XMVSPD(IB,LINEA(1),LSTX)
      JD=0
C
C--PRINT THE NEXT LINE
1050  CONTINUE
      JL=NSKIP+NSPAC
      JE=0
1150  CONTINUE
C--CLEAR THE TEMP. LINE AREA
      CALL XMVSPD(IB,LIN(1),LST)
C--CHECK IF THIS IS THE FIRST LINE
      IF(JD)1200,1200,1250
C--SET UP THE HEADING
1200  CONTINUE
      CALL STEST
      GOTO 1400
C--CHECK THE TYPE OF THE NEXT ARGUMENT
1250  CONTINUE
      JG=JC+JF*JE
      IF(ISTORE(JG))1400,1300,1350
C--CHANGE OF KL PAIR
1300  CONTINUE
      CALL SKL(JG)
      GOTO 1400
C--SET UP /FO/ ETC.
1350  CONTINUE
      CALL SHFF(JG)
C--TRANSFER FROM TEMP. PERMANENT STORAGE
1400  CONTINUE
      CALL XMOVE(LIN(1),LINEA(JL),LST)
C--CHECK IF WE HAVE ALL THE COLUMNS
      JL=JL+NSPAC+LST
      JE=JE+1
      IF(NCOL-JE)1450,1450,1150
C--PRINT THE LINE
1450  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTRF .GT. 0 ) WRITE(NCWU,1500) (LINEA(I),I=1,LSTX)
      ENDIF
      IF ( IPCHRF .GT. 0 ) WRITE(NCPU,1500) (LINEA(I),I=1,LSTX)
1500  FORMAT(1X,160A1)
C--CHECK IF WE HAVE FINISHED THE PAGE
      JC=JC+LW
      JD=JD+1
      IF(NLIN-JD)1550,1050,1050
1550  CONTINUE
      RETURN
      END
C
CODE FOR STEST
      SUBROUTINE STEST
C--FORM THE TEST PARTIAL LINE
C
C
      DIMENSION IH(7)
C
C
\XPTCS
C
C
      DATA IH(1)/'H'/
      DATA IH(2)/'F'/
      DATA IH(3)/'O'/
      DATA IH(4)/'C'/
      DATA IH(5)/'P'/
      DATA IH(6)/'/'/
      DATA IH(7)/'I'/
C
      LIN(4)=IH(1)
      LIN(6)=IH(6)
      LIN(7)=IH(2)
      LIN(8)=IH(3)
      LIN(9)=IH(6)
      LIN(11)=IH(6)
      LIN(12)=IH(2)
      LIN(13)=IH(4)
      LIN(14)=IH(6)
      LIN(16)=IH(5)
      LIN(17)=IH(1)
      LIN(18)=IH(7)
      RETURN
      END
C
CODE FOR SKL
      SUBROUTINE SKL(IN)
C--FORM THE K L PARTIAL LINE
C
\ISTORE
C
      DIMENSION IHKL(3)
C
\STORE
C
\XPTCS
\XCHARS
\XWORKA
C
\QSTORE
C
C
      DATA IHKL(1)/'K'/
      DATA IHKL(2)/'L'/
      DATA IHKL(3)/'='/
C
      LIN(1)=IA
      LIN(2)=IA
      LIN(4)=IHKL(1)
      LIN(5)=IHKL(3)
      IND=ISTORE(IN+1)
      J=8
      CALL SUBALF(J,IND,LIN)
      LIN(11)=IHKL(2)
      LIN(12)=IHKL(3)
      IND=ISTORE(IN+2)
      J=15
      CALL SUBALF(J,IND,LIN)
      LIN(17)=IA
      LIN(18)=IA
      RETURN
      END
C
CODE FOR SHFF
      SUBROUTINE SHFF(IN)
C--FORM THE H,FO,FC,PHASE PARTIAL LINE
C
\ISTORE
C
\STORE
C
\XPTCS
C
\QSTORE
C
      IND=ISTORE(IN+1)
      J=4
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+2)
      J=9
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+3)
      J=14
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+4)
      J=18
      CALL SUBALF(J,IND,LIN)
      RETURN
      END
C
CODE FOR SPRT5P
      SUBROUTINE SPRT5P
C--PRINT LIST 5P
C
C  IFIR    THE NUMBER OF BLANKS AT THE START OF EACH LINE.
C  MINX    THE FIRST LINE ON A PAGE TO BE USED TO PRINT COORDS.
C  MINU    THE FIRST LINE ON A PAGE TO BE USED TO PRINT U[IJ].
C  LINEX   THE LAST LINE PLUS ONE ON A PAGE USED TO PRINT COORDS.
C  LINEU   THE LAST LINE PLUS ONE ON A PAGE USED TO PRINT U[IJ].
C  NSTA    THE NUMBER OF CHARACTERS FOR THE TYPE AND SERIAL NUMBER.
C  NXF     NUMBER OF CHARACTERS FOR THE TOTAL COORD. FIELD.
C  NXD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT FOR COORDS.
C  NUF     NUMBER OF CHARACTERS FOR THE TOTAL U[IJ] FIELD.
C  NUD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT FOR U[IJ].
C  NOP     DECIMAL POINT INDICATOR :
C          0  PARAMETERS CONTAIN A DECIMAL POINT.
C          1  PARAMETERS DO NOT CONTAIN A DECIMAL POINT.
C
C  NAP     DOUBLE LINE SPACING INDCIATOR :
C
C          -1  SINGLE LINE SPACING.
C           0  DOUBLE LINE SPACING.
C
C  ICC     CHOOSE INDICATOR :
C
C           1  SYSTEM DOES NOT CHOOSE THE NUMBER OF SIGNIFICANT FIGURES.
C          -1  SYSTEM CHOOSES THE NUMBER OF SIGNIFICANT FIGURES TO PRINT
C
C  IBAR    THE LINE WIDTH.
C
C      ISELCO      SELECTION FUNCTION FOR COORDINATES :-
C
C            1      ALL
C            2      NONE
C            3      ONLY
C            4      EXCLUDE
C            5      SEPARATE
C
C      TYPECO      TYPE USED IN SELECTION OF COORDINATES. '    '
C                  INDICATES 'MATCH ALL'
C
C      ISELAN , TYPEAN      AS ABOVE BUT CONTROL SELECTION OF U'S
C
C      IDSPCO , IDSPAN      CONTROL WHETHER COORDS. / ANISO T.F.'S
C                           ARE DISPLAYED ON MONITOR CHANNEL
C
C      LSTAXS      CONTROL PRINTING BY 'XPRAXI'
C            0      NO PRINT
C            1      PRINT
C
C
C
C--
\TSSCHR
\ISTORE
C
C
\STORE
C
\XPTCL
\XWORKA
\XCONST
\XCHARS
\XLST01
\XLST05
\XLST11
\XLST12
\XLST23
\XUNITS
\XSSVAL
\XAPK
C
\XOPVAL
\QSTORE
C
      DATA IPPSEP / 5 / , IPPNBT / 1 /
C--READ THE INPUT DIRECTIVES
      IN = 0
      IF (  JDIR5P ( IN )  .LT.  0  ) GO TO 9910
C--INPUT WENT OKAY  -  CLEAR THE CORE AGAIN
      CALL XRSL
      CALL XCSAE
C--LOAD A FEW LISTS
      CALL XFAL01
      CALL XFAL05
      CALL XFAL23
cdjwfeb2001
        toler = store(l23sp+5)
        call xprc17 (0, 0, TOLER, -1)
cdjwfeb2001
C--FORM THE ABSOLUTE LIST 12
      JQ=0
      JS=1
      CALL XFAL12(JS,JQ,JR,JN)
      IF ( IERFLG .LT. 0 ) GO TO 2450
C--LINK LISTS 5 AND 12
      I=KSET52(0,-1)
      IF ( IERFLG .LT. 0 ) GO TO 2450
C--BRING DOWN THE MATRIX
      CALL XFAL11(1,1)
      IF (IERFLG .LT. 0) GOTO 2450
      AMULT=STORE(L11P+17)/STORE(L11P+16)
      IBASE=NFL
      JBASE = IBASE
      K = KCHNFL ( 4 * N5)
C----- WORK SPACE FOR SAPPLY - THAT CHECKS WE DONT RUN INTO LFL
      JS = NFL
C----- SET AUXILLIARY LIST 5 ADDRESSES
      L5A=L5
      N5A=N5
      MD5A=MD5
      M5A=L5
      CALL XPRAXI( 1, 1, JBASE, L5A, MD5A, N5A, LSTAXS, 0)
      IF ( IERFLG .LT. 0 ) GO TO 2450
C -- PRINT TYPE / SERIAL / X / Y / Z / U[ISO]
C
      IUIJ = 0
C -- DETERMINE WHICH SETS OF COORDS MUST BE PRINTED
      CALL XPPSEL ( ISELCO , TYPECO , ISEL , TYPE )
C -- CALL ROUTINE TO PRINT COORDS. TWO CALLS FOR 'SEPARATE'
      CALL XPP5CO ( ISEL , TYPE )
      IF ( ISELCO .EQ. IPPSEP ) CALL XPP5CO ( IPPNBT , TYPECO )
      IF ( IERFLG .LT. 0 ) GO TO 2450
C
      IF ( IUIJ .LE. 0 ) GO TO 2270
C
C -- PRINT TYPE / SERIAL / U'IJS
C
      CALL XPPSEL ( ISELAN , TYPEAN , ISEL , TYPE )
      CALL XPP5AN ( ISEL , TYPE )
      IF ( ISELAN .EQ. IPPSEP ) CALL XPP5AN ( IPPNBT , TYPEAN )
      IF ( IERFLG .LT. 0 ) GO TO 2450
2270  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
        IF(ILSTCO .GT. 0) WRITE(NCWU,'(A)')CHAR(12)
      ENDIF
###GILGIDWXS      IF(IPCHCO .EQ. 1) WRITE(NCPU,'(A)')CHAR(12)
C
C----- OUTPUT THE OVERALL PARAMETERS
      MCFUNC = 1
      CALL XPP5OV(MCFUNC)
CRIC0103 - Exit path - don't output parameters after errors - might be no L12.
2300  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSE , 5 )
      CALL XTIME2 ( 2 )
      RETURN
C
2450  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSP , 5 )
      GO TO 2300
9910  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPCMI , 0 )
      GO TO 2450
C
      END
C
CODE FOR JDIR5P
      FUNCTION JDIR5P(IN)
C--READ DIRECTIVES FOR PRINT LIST 5P
C
C--RETURN VALUES OF 'JDIR5P' ARE :
C
C  -1  ERRORS.
C   0  ALL OKAY.
C
C--
C
\TSSCHR
      PARAMETER (LPROCS = 26)
      DIMENSION PROCS(LPROCS)
C
C
\XPTCL
\XUNITS
\XSSVAL
\XWORKA
\XIOBUF
C
C
      EQUIVALENCE (PROCS(1),IFIR)
C
      IDWZAP = IN
C--SET THE INITIAL RETURN VALUE
      JDIR5P=0
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ THE DIRECTIVES
      IF (  KRDDPV ( PROCS , LPROCS )  .LT.  0  ) GO TO 1150
C--CHECK THE WIDTH OF A COORD. PAGE
      LSTX=NSTA+NXF*3+NUF
      IF(IBAR-LSTX-IFIR)1050,1200,1200
C--FIELD WIDTH IS WRONG
1050  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
      WRITE ( CMON, 1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
1100  FORMAT(' More than',I5,'  characters on a line')
C--GENERAL ERRORS
1150  CONTINUE
      JDIR5P=-1
      GOTO 1400
C--CHECK THE WIDTH OF AN ANISO PAGE
1200  CONTINUE
      LSTX=NSTA+NUF*6
      IF(IBAR-LSTX-IFIR)1050,1250,1250
C--SET UP THE NUMBER OF LINES PER PAGE
1250  CONTINUE
      LINEX=  NPLINE
      LINEU=  NPLINE
C--SET THE FLAG FOR THE FIRST COORD. LINE ON A PAGE
      MINX=5
C--SET THE FLAG FOR THE FIRST U[IJ] LINE, ASSUMING A4 ACROSS
      MINU=11
C--CHECK IF AN ANISO PAGE WILL FIT DOWN AN A4 PAGE
      IF(LSTX-68)1300,1300,1350
C--THIS WILL FIT DOWN AN A4 PAGE
1300  CONTINUE
      MINU=MINX
      LINEU=LINEX
C--SET THE FIELD WIDTH FLAGS
1350  CONTINUE
      NXD=ISIGN(NXD,ICC)
      NUD=ISIGN(NUD,ICC)
C----- IF COORDDS IN CIF FORMAT, SO ALSO ANISO
      IF (IPCHCO .EQ. 2)  IPCHAN = 2
1400  CONTINUE
      RETURN
      END
C
C
C
CODE FOR XPPSEL
      SUBROUTINE XPPSEL ( ISELCM , TYPECM , ISELRQ , TYPERQ )
C
C -- SELECT ON THE BASIS OF THE COMMAND GIVEN THE SELECTION
C    PARAMETERS. ISELCM AND TYPECM ARE THE VALUES DERIVED FROM THE
C    COMMAND PROCESSOR.
C    ISELRQ AND TYPERQ ARE THE VALUES THAT SHOULD BE PASSED TO XPP5CO
C
\XOPVAL
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#HOL      DATA IALATM / '    ' /
&HOL      DATA IALATM /4H     /
      DATA IPPNBT / 1 / , IPPABT / 2 /
C
      TYPERQ = TYPECM
C
      GO TO ( 1100 , 1200 , 1300 , 1400 , 1500 , 9910 ) , ISELCM
      GO TO 9910
C
1100  CONTINUE
C -- 'ALL'
      TYPERQ = ALLATM
      ISELRQ = IPPNBT
      GO TO 8000
1200  CONTINUE
C -- 'NONE'
      TYPERQ = ALLATM
      ISELRQ = IPPABT
      GO TO 8000
1300  CONTINUE
C -- 'ONLY'
      ISELRQ = IPPNBT
      GO TO 8000
1400  CONTINUE
C -- 'EXCLUDE'
      ISELRQ = IPPABT
      GO TO 8000
1500  CONTINUE
C -- 'SEPARATE'
      ISELRQ = IPPABT
      GO TO 8000
C
8000  CONTINUE
      RETURN
C
9910  CONTINUE
      CALL XOPMSG ( IOPCRY , IOPINT , 0 )
      RETURN
      END
C
C
C
CODE FOR XPP5CO
      SUBROUTINE XPP5CO ( IFUNC , TYPE )
C -- PUBLICATION PRINT OF COORDINATES SELECTED FROM LIST 5 ON THE BASIS
C    OF 'IFUNC' AND 'TYPE'
C
C      IFUNC : -
C      1      'NONE BUT'      ATOM MUST MATCH 'TYPE' TO BE PRINTED
C      2      'ALL BUT'       ATOM MUST NOT MATCH 'TYPE' TO BE PRINTED
C
C      'TYPE' IS THE TYPE OF ATOM TO BE PRINTED. THE VALUE '    ' WILL
C      MATCH EVERY ATOM ( I.E. ALL BUT , '    ' WOULD PRINT NOTHING )
C
C
C      IDSPHD      0      NO HEADING PRINTED ON MONITOR CHANNEL
C                  1      HAS BEEN PRINTED
C
C      NL                 NUMBER OF LINES PRINTED. INITIALLY SET AT
C                         END OF PAGE.
C
      CHARACTER CLINE *160, CTEM *4, CHTML*20
\TSSCHR
\ISTORE
C
\STORE
C
      DIMENSION LINEC(118), KDEV(4)
\XPTCL
\XWORKA
\XCONST
\XCHARS
\XLST01
\XLST05
\XLST11
\XLST12
\XLST23
\XUNITS
\XSSVAL
\XAPK
\XIOBUF
\UFILE
\XSSCHR
C
\QSTORE
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#HOL      DATA IALATM / '    ' /
&HOL      DATA IALATM /4H     /
C
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
C -- SET INITIAL VALUES.
cdjw feb2001
        iupdat = istore(l23sp+1)
        toler = store(l23sp+5)
C
      IDSPHD = 0
      M5=L5
      M12=L12
      M5A=L5+2
      NL=LINEX

C
C----- CAPTIONS FOR CIF FILE
      IF (IPCHCO .EQ. 2) THEN
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCFPU1, 890)
890       FORMAT(/'# Uequiv = arithmetic mean of Ui'/
     1    '# i.e. Ueqiv = (U1+U2+U3)/3')
        ELSE
          WRITE(NCFPU1, 891)
891       FORMAT(/'# Uequiv = geometric mean of Ui',
     1    ' i.e. Ueqiv = (U1*U2*U3)**1/3')
        ENDIF

        WRITE(NCFPU1,903)
903     FORMAT(/'# Replace trailing . with the number of unfound',
     1 /'# hydrogen atoms attaced to relavent atom')

        WRITE( NCFPU1, 900)
900     FORMAT ( /'loop_'/'_atom_site_label'/'_atom_site_type_symbol'/
     1 '_atom_site_fract_x'/
     1 '_atom_site_fract_y'/'_atom_site_fract_z')
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCFPU1, '(A)') '_atom_site_U_iso_or_equiv'
        ELSE
          WRITE(NCFPU1, '(A)') '_atom_site_U_equiv_geom_mean'
        ENDIF
        WRITE( NCFPU1, 902)
902     FORMAT ('_atom_site_occupancy'/
     1 '_atom_site_adp_type'  /
     2 '_atom_site_attached_hydrogens' )

      ELSE IF (IPCHCO .EQ. 3) THEN    !HEADERS FOR HTML TABLE

        WRITE (NCPU,'(''<H2>Parameters</H2>'')')
        WRITE( NCPU, 910)
910     FORMAT ('<TABLE BORDER="1"><TR>',
     1  '<TD align="center">Label</TD>',/,
     1  '<TD align="center"><em>x</em></TD>',/,
     2  '<TD align="center"><em>y</em></TD>',/,
     3  '<TD align="center"><em>z</em></TD>')
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCPU, '(A)')
     1     '<TD align="center">U<sub>iso/equiv</sub></TD>'
        ELSE
          WRITE(NCPU, '(A)') 
     1     '<TD align="center">U<sub>iso/equiv(geometric)</sub></TD>'
        ENDIF
        WRITE( NCPU, 911)
911     FORMAT ('<TD align="center">Occupancy</TD></TR>')
      ENDIF

      iuij = 0
C--LOOP OVER THE ATOMS
      DO K=1,N5
C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD
        MD5A=M5+NKA-1
        N5A=NKA-2
cdjw99[
c      U=STORE(M5+3)
C -- SET ANISO ATOMS FLAG IF APPROPRIATE
c      IF ( ABS(U) .LT. UISO ) IUIJ = 1
cdjw99]
C -- CHECK FOR MATCH
        MATCH = -1
        IF ( TYPE .EQ. STORE(M5) ) MATCH = 1
        IF ( TYPE .EQ. ALLATM ) MATCH = 1
        IF ( IFUNC .EQ. 2 ) MATCH = -MATCH
        IF ( MATCH .LE. 0 ) GO TO 1585
C
cdjw99[
C-C-C-USE OF ISOTROPIC T-FACTOR INSTEAD OF PURE FLAG
c        BUFF(2)=STORE(M5+7)
cdjw99]
C----- J IS DUMMY
        CALL SAPPLY (J)
C--CLEAR THE OUTPUT BUFFER
        CALL XMVSPD(IB,LINEA(1),118)
        J=IFIR
CDJW0402 CONVERT ATOM NAME TO MIXED CASE
        WRITE(CTEM,'(A4)') ISTORE(M5)
        CALL XCCLWC (CTEM(2:), CTEM(2:))
        READ (CTEM,'(A4)') ISTORE(M5)
        IF (IPCHCO .EQ. 3) THEN  
          WRITE(CHTML,'(A4,I6)') ISTORE(M5),NINT(STORE(M5+1))
          CALL XCCLWC (CHTML(2:), CHTML(2:))
          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,912)CHTML(1:NHTML)
912       FORMAT('<TR><TD>',A,'</TD>')
        END IF
C--OUTPUT THE TYPE AND SERIAL NUMBER
        CALL SA41(J,ISTORE(M5),LINEA)
        IND=NINT(STORE(M5+1))
        IBUFF=ISTORE(M5)
        JBUFF=IND
        CALL SUBZED(J,IND,LINEA,IPCHCO)
C-C-C-OUTPUT THE FLAG OF ATOM
cnov98      CALL SNUM(STORE(M5+3),0.0,1,0,10,LINEA)
C--UPDATE THE CURRENT POSITION FLAG
        J=IFIR+NSTA
C--RIC01 Add in atom_site_type_symbol
        IF (IPCHCO .EQ. 2) CALL SA41(J,ISTORE(M5),LINEA)
C--SET UP THE FLAGS FOR THE PASS OVER THE COORDS.
        MP=M5+4
        MPD=3
        IP=3
C--LOOP OVER THE COORDS.
        DO L=1,3
          LOJ = J+6
          J=J+NXF
          CALL SNUM(STORE(MP),BPD(MPD),NXD,NOP,J,LINEA)
          IF (IPCHCO .EQ. 3) THEN  
#WXS            WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
&WXS            WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
c            CALL XCRAS(CHTML,NHTML)
            WRITE(NCPU,913)CHTML(1:)
913         FORMAT('<TD>',A,'</TD>')
          END IF
          BUFF(IP)=STORE(MP)
          IP=IP+1
          MP=MP+1
          MPD=MPD+1
        END DO
cdjw99[
C--CHECK IF THIS ATOM IS ANISO OR ISO
        if (nint(store(m5+3)) .eq. 0) then
c----- aniso
C----- CALCULATE U[EQUIV]
          CTEM = 'Uani'
          BUFF(2)= STORE(JBASE)
C----- SET ESD=0.
          BPD(2)=0.
C----- INDICATE THAT THERE ARE SOME U[ANISO] TO PRINT
          IUIJ=1
1150      CONTINUE
        else
          CTEM = 'Uiso'
          BUFF(2)= STORE(m5+7)
          bpd(2) = bpd(6)
        endif
        JBASE = JBASE + 4
        LOJ = J+6
        J=J+NUF
C----- PRINT THE ISO OR EQUIV TEMPERATURE FACTOR
        CALL SNUM(BUFF(2),BPD(2),NUD,NOP,J,LINEA)
        IF (IPCHCO .EQ. 3) THEN  
#WXS          WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
&WXS          WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
c          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,913)CHTML(1:)
        END IF
cdjw99]
C----- GET THE OCCUPANCY
        LOJ = J+6
        J = J + NUF
        CALL XMOVE (LINEA, LINEC, 118)
cdjwmar2001 - Notes for Authors - dont include crystallographic
c             occupancy contribution - keep code for future
        if (iupdat .ge.0) then
c            w = store(m5+2)*store(m5+13)
            w = store(m5+2)
        else
            w = store(m5+2)/store(m5+13)
        endif
        CALL SNUM ( W, BPD(1), NUD, NOP, J, LINEC)
        IF (IPCHCO .EQ. 3) THEN  
#WXS          WRITE(CHTML,'(80A1)') LINEC(LOJ:J+4)
&WXS          WRITE(CHTML,'(80A1)') (LINEC(JR),JR=LOJ,J+4)
c          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,913)CHTML(1:)//'</TR>'
        END IF
C-C-C-SET OCC TO BE PRINTED ON SCREEN AFTER \PARAMETERS-COMMAND
C-C-C-(NOT IN CONTEXT WITH SPECIAL ATOMS, NEXT LINE MAY BE DELETED)
        BUFF(1)=W
        IF ( ABS (1.0 - W) .GT. ZERO) THEN
          CALL SNUM ( W, BPD(1), NUD, NOP, J, LINEA)
        ENDIF
C-C-C-OUTPUT THE FLAG OF ATOM
cdjwnov98      CALL SNUM(STORE(M5+3),0.0,1,0,(IFIR+9),LINEA)
C--CHECK FOR DOUBLE SPACING
1200    CONTINUE
        IF(NAP)1300,1250,1250
C--PRINT THE BLANK LINE
1250    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE ( NCWU , 1550 )
        ENDIF
        IF ( IPCHCO .GT. 0 ) WRITE ( NCPU , 1550 )
        NL=NL+1
C--CHECK FOR THE END OF A PAGE
1300    CONTINUE
        IF(NL-LINEX)1500,1350,1350
C--END OF THE PAGE  -  START A NEW PAGE
1350    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU , '(A)') CHAR(12)
        ENDIF
##GIDWXS      IF ( IPCHCO .EQ. 1 ) WRITE(NCPU, '(A)') CHAR(12)
        CALL STATX(LINEB)
        CALL STXYZ(LINEB)
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU ,1450) LINEB
        ENDIF
        IF (IPCHCO .EQ. 1) THEN
          CLINE = ' '
          WRITE(CLINE,'(160A1)' ) LINEB
          CALL XCTRIM (CLINE,NCHAR)
          WRITE(NCPU,'(//A/)') CLINE(1:NCHAR)
1450      FORMAT (2X,118A1)
        ENDIF
        NL=MINX
        GOTO 1200
C--PRINT THE CURRENT LINE
1500    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU ,1550) LINEA
        ENDIF
        CLINE = ' '
        IF (IPCHCO .EQ. 1) THEN
C----- ORDINARY PUNCH LISTING
            WRITE(CLINE,'(160A1)') LINEA
            IST = KCCNEQ (CLINE, 1, ' ')+1
            CALL XCCLWC (CLINE(IST:), CLINE(IST:))
            CALL XCTRIM (CLINE,NCHAR)
            WRITE(NCPU,'(A)') CLINE(1:NCHAR)
        ELSE IF (IPCHCO .EQ. 2) THEN
C----- CIF PUNCH LISTING
            WRITE(CLINE,'(160A1)') LINEC
C RIC01 Find second space in string:
            ISTRIC = MAX(1,KCCEQL(CLINE,1,' '))+1
            ISTRIC = MAX(1,KCCNEQ(CLINE,ISTRIC,' '))+1
            IST    = MAX(1,KCCEQL(CLINE,ISTRIC,' '))
C            IST = KCCNEQ (CLINE, 1, ' ')+1
            CALL XCCLWC (CLINE(IST:), CLINE(IST:))
            CALL XCTRIM (CLINE,NCHAR)
            CLINE(NCHAR+1:NCHAR+4) = CTEM
            CALL XCREMS( CLINE, CLINE, NCHAR)
            WRITE(NCFPU1,'(A,A)') CLINE(1:NCHAR), ' .'
        ENDIF
1550    FORMAT(2X,118A1)
        NL=NL+1
C -- DISPLAY ON MONITOR CHANNEL IF REQUIRED.
        IF ( IDSPCO .LE. 0 ) GO TO 1585
        IF ( IDSPHD .GT. 0 ) GO TO 1570
        WRITE ( CMON  , 1581 )
        CALL XPRVDU(NCVDU, 1,0)
        IDSPHD = 1
1570    CONTINUE
        WRITE ( CMON  , 1582 ) IBUFF , JBUFF , BUFF
        CALL XPRVDU(NCVDU, 1,0)
1581    FORMAT ( 1X , 'Type' , 4X , 'Serial' , 8X , 'Occ' , 5X ,
     2 'U(iso)' , 9X , 'Coordinates' )
1582    FORMAT ( 1X , A4 , 4X , I6 , 4X , 5 ( F8.4 , 2X ) )
C
1585    CONTINUE
C -- UPDATE THE ATOM INFORMATION FOR THE NEXT ATOM
        M12=ISTORE(M12)
        M5=M5+MD5
        M5A=M5A+MD5
      END DO
      IF ( IPCHCO .EQ. 3 ) WRITE(NCPU,'(''</TABLE>'')')

      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)

      RETURN
      END


CODE FOR XPP5AN
      SUBROUTINE XPP5AN ( IFUNC , TYPE )
C
C
C -- PUBLICATION PRINT OF U'IJS SELECTED FROM LIST 5 ON THE BASIS
C    OF 'IFUNC' AND 'TYPE'
C
C      IFUNC : -
C      1      'NONE BUT'      ATOM MUST MATCH 'TYPE' TO BE PRINTED
C      2      'ALL BUT'       ATOM MUST NOT MATCH 'TYPE' TO BE PRINTED
C
C      'TYPE' IS THE TYPE OF ATOM TO BE PRINTED. THE VALUE '    ' WILL
C      MATCH EVERY ATOM ( I.E. ALL BUT , '    ' WOULD PRINT NOTHING )
C
      DIMENSION KDEV(4)
      CHARACTER *160 CLINE
      CHARACTER *4 CTEM
      CHARACTER *20 CHTML
\TSSCHR
\ISTORE
C
\STORE
C
\XPTCL
\XWORKA
\XCONST
\XCHARS
\XLST01
\XLST05
\XLST11
\XLST12
\XUNITS
\XSSVAL
\XAPK
\XIOBUF
\UFILE
\XSSCHR
C
\QSTORE
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#HOL      DATA IALATM / '    ' /
&HOL      DATA IALATM /4H     /
C
1450  FORMAT ( // , 2X , 118A1 )
1460  FORMAT(15X,A6,6X,A4,8X,A5,7X,A5)
1550  FORMAT ( 2X , 118A1 )
C
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)

      M5=L5
      M12=L12
      M5A=L5+2
C--INDICATE THAT WE HAVE JUST OUTPUT A PAGE
      NL=LINEU
      IDSPHD = 0
C----- CAPTIONS FOR CIF FILE
      IF (IPCHAN .EQ. 2) THEN
        WRITE( NCFPU1, 900)
900     FORMAT ('loop_'/'_atom_site_aniso_label'/
     1 '_atom_site_aniso_U_11'/'_atom_site_aniso_U_22'/
     2 '_atom_site_aniso_U_33'/'_atom_site_aniso_U_23'/
     3 '_atom_site_aniso_U_13'/'_atom_site_aniso_U_12' )
      ELSE IF (IPCHAN .EQ. 3) THEN    !HEADERS FOR HTML TABLE

        WRITE (NCPU,'(''<H2>Thermal Parameters</H2>'')')
        WRITE( NCPU, 910)
910     FORMAT ('<TABLE BORDER="1"><TR>',
     1  '<TD align="center">Label</TD>',/,
     1  '<TD align="center">U<sub>11<sub></TD>',/,
     1  '<TD align="center">U<sub>22<sub></TD>',/,
     1  '<TD align="center">U<sub>33<sub></TD>',/,
     1  '<TD align="center">U<sub>23<sub></TD>',/,
     1  '<TD align="center">U<sub>13<sub></TD>',/,
     1  '<TD align="center">U<sub>12<sub></TD>')
      ENDIF
C
C--LOOP OVER THE ATOMS
C
      DO 2250 K=1,N5
      MD5A=M5+NKA-1
      N5A=NKA-2
C--CHECK IF THIS ATOM HAS AN ANISO TEMPERATURE FACTOR
C-C-C-CHECK IF THIS ATOM HAS AN ANISO T.F. OR A SPECIAL PARAMETER
      U=STORE(M5+3)
C      IF ( ABS(U) .GE. UISO ) GO TO 2200
      IF ( ABS(NINT(U)) .EQ. 1.0 ) GO TO 2200
C-C-C-THE LAST STATEMENT MIGHT CAUSE DIFFICULTIES WITH DATA OF OLD
C-C-C-FORMAT ! IN THIS CASE USE THE FOLLOWING:
C      IF ((ABS(U) .GE. UISO) .AND. (ABS(NINT(U)) .LT. 2.0)) GO TO 2200
C -- CHECK FOR MATCH
      MATCH = -1
      IF ( TYPE .EQ. STORE(M5) ) MATCH = 1
      IF ( TYPE .EQ. ALLATM ) MATCH = 1
      IF ( IFUNC .EQ. 2 ) MATCH = - MATCH
      IF ( MATCH .LE. 0 ) GO TO 2200
C
C--CALCULATE THE E.S.D.'S
C--CLEAR THE LINE BUFFER
C----- J IS DUMMY
      CALL SAPPLY (J)
      CALL XMVSPD(IB,LINEA(1),118)
C--OUTPUT THE ATOM TYPE AND SERIAL NUMBER
      J=IFIR
CDJW0402 CONVERT ATOM NAME TO MIXED CASE
      WRITE(CTEM,'(A4)') ISTORE(M5)
      CALL XCCLWC (CTEM(2:), CTEM(2:))
      READ (CTEM,'(A4)') ISTORE(M5)
C
      CALL SA41(J,ISTORE(M5),LINEA)
      IND=NINT(STORE(M5+1))
      CALL SUBZED(J,IND,LINEA, IPCHAN)
      J=IFIR+NSTA

      IF (IPCHCO .EQ. 3) THEN  
          WRITE(CHTML,'(A4,I6)') ISTORE(M5),NINT(STORE(M5+1))
          CALL XCCLWC (CHTML(2:), CHTML(2:))
          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,912)CHTML(1:NHTML)
912       FORMAT('<TR><TD>',A,'</TD>')
      END IF
C-C-C-OUTPUT THE FLAG OF ATOM
cnov98      CALL SNUM(STORE(M5+3),0.0,1,0,(IFIR+9),LINEA)
C--LOOP OVER THE PARAMETERS
      MP=M5+7
      MPD=6
      DO 1750 L=1,6
      LOJ = J + 6
      J=J+NUF
      CALL SNUM(STORE(MP),BPD(MPD),NUD,NOP,J,LINEA)

      IF (IPCHCO .EQ. 3) THEN  
#WXS          WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
&WXS          WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
          WRITE(NCPU,913)CHTML(1:)
913       FORMAT('<TD>',A,'</TD>')
      END IF

      MP=MP+1
      MPD=MPD+1
1750  CONTINUE
      IF ( IPCHAN .EQ. 3 ) WRITE(NCPU,'(''</TR>'')')
C--CHECK FOR DOUBLE SPACING
1800  CONTINUE
      IF(NAP)1900,1850,1850
C--WRITE THE BLANK LINE
1850  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,1550)
      ENDIF
      IF ( IPCHAN .GT. 0 ) WRITE(NCPU,1550)
      NL=NL+1
C--CHECK FOR THE END OF THE PAGE
1900  CONTINUE
      IF(NL-LINEU)2150,1950,1950
C--NEW PAGE
1950  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU , '(A)') CHAR(12)
      ENDIF
##GIDWXS      IF ( IPCHAN .EQ. 1 ) WRITE(NCPU, '(A)') CHAR(12)
      CALL STATX(LINEB)
      CALL STUIJ(LINEB)
      IF(MINX-MINU)2000,2100,2000
2000  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
C      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,2050) LINEB
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,2050) LINEB
        WRITE( NCWU ,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEB
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
        WRITE(NCPU,'(//A)') CLINE(1:NCHAR)
        WRITE(NCPU,1460) 'U(iso)','Size','D/100','A/100'
        write(ncpu,'(1x)')
      ENDIF
2050  FORMAT(2X,118A1)
      NL=MINU
      GOTO 1800
2100  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,1450) LINEB
        WRITE(NCWU,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEB
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
        WRITE(NCPU,'(A)') CLINE(1:NCHAR)
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,1450) LINEB
        WRITE(NCWU,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      NL=MINU
      GOTO 1800
C--PRINT THE CURRENT LINE
2150  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,1550) LINEA
      ENDIF
      IF ( IPCHAN .GE. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEA
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        WRITE(NCPU,'(A)') CLINE(1:NCHAR)
      ELSE IF (IPCHAN .EQ. 2) THEN
        CALL XCREMS( CLINE, CLINE, NCHAR)
        WRITE(NCFPU1,'(A)') CLINE(1:NCHAR)
      ENDIF
      NL=NL+1
C -- DISPLAY ON MONITOR CHANNEL IF REQUIRED.
      IF ( IDSPAN .LE. 0 ) GO TO 2200
      IF ( IDSPHD .GT. 0 ) GO TO 2170
      WRITE ( CMON , 2172 )
      CALL XPRVDU(NCVDU, 1,0)
      IDSPHD = 1
2170  CONTINUE
      JBUFF = NINT ( STORE(M5+1) )
      WRITE ( CMON , 2173 ) STORE(M5) , JBUFF ,
     2 ( STORE(J) , J =  M5+7 , M5+12 )
      CALL XPRVDU(NCVDU, 1,0)
2172  FORMAT ( 1X , 'Type' , 4X , 'Serial' , 16X , 'U(II)''s' , 24X ,
     2 'U(IJ)''s' )
2173  FORMAT ( 1X , A4 , 4X , I6 , 4X , 6 ( F8.4 , 2X ) )
C
2200  CONTINUE
      M12=ISTORE(M12)
      M5=M5+MD5
      M5A=M5A+MD5
C
2250  CONTINUE
      MD5A=MD5
      IF ( IPCHAN .EQ. 3 ) WRITE(NCPU,'(''</TABLE>'')')
C
      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
      RETURN
      END
C
C
CODE FOR XPP5OV
      SUBROUTINE XPP5OV ( IFUNC  )
C -- PUBLICATION PRINT OF OVERALL PARAM SELECTED FROM LIST 5
C    ON THE BASIS OF 'IFUNC'
C
C      IFUNC : -
C      1      OVERALL PARAMETERS
C      2      NOT YET USED
C
C
C
C      IDSPHD      0      NO HEADING PRINTED ON MONITOR CHANNEL
C                  1      HAS BEEN PRINTED
C
C      NL                 NUMBER OF LINES PRINTED. INITIALLY SET AT
C                         END OF PAGE.
C
      DIMENSION KDEV(4)
      CHARACTER *80 CLINE
      CHARACTER *80 CFORM, CBUF
      CHARACTER *10 COVER(6)
      CHARACTER *32 CCIF
\TSSCHR
C
\ISTORE
C
\STORE
C
\XPTCL
\XWORKA
\XCONST
\XCHARS
\XLST01
\XLST05
\XLST11
\XLST12
\XUNITS
\XSSVAL
\XOPK
\XIOBUF
\UFILE
\XSSCHR
C
\QSTORE
C
      DATA COVER / 'Scale  ', 'Du(iso) ', 'Ou(iso) ',
     2  'Polarity', 'Flack  ', 'Extinction'/
C
      DATA CCIF /
     3      '_refine_ls_extinction_coef' /
C
####LINGILGIDWXS      IFUNC = IFUNC
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
C -- SET INITIAL VALUES.
      NOD = -3
      NOF = 10
C
      M5 = L5O
      M5A = L5O
      M12 = L12O
      NL = LINEX
C
C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD
      MD5A = M5+NKO-1
      N5A = NKO
C
      JP = 1
      CALL XPESD ( 2, JP)
C
C--CLEAR THE OUTPUT BUFFER
      CALL XMVSPD(IB,LINEA(1),118)
      J=4
C--SET UP THE FLAGS FOR THE PASS OVER THE PARAMETERS
      MP=M5A
      MPD=1
      IP=1
C--LOOP OVER THE PARAMETERS
      DO 2050 L=1,N5A
      J = J + NOF
      CALL SNUM(STORE(MP), BPD(MPD), NOD, 0, J, LINEA)
      IP=IP+1
      MP=MP+1
      MPD=MPD+1
2050  CONTINUE
      WRITE (CLINE,2055) (LINEA(L), L=1,78)
2055  FORMAT(2X,78A1)
      CALL XCTRIM (CLINE, NLINE)
2300  CONTINUE
C----- BUILD UP A FORMAT STATEMENT
      WRITE (CFORM, 2410) NOF, NOF
2410  FORMAT( '(' ,I4, 'X, 6A',I4, ')' )
      IF (ISSPRT .EQ. 0) THEN
        IF ( ILSTCO .GT. 0 )  THEN
            WRITE( NCWU, CFORM) COVER
            WRITE( NCWU , '(A)') CLINE(1:NLINE)
        ENDIF
      ENDIF
      IF ( IPCHCO .EQ. 1 )  THEN
            WRITE(NCPU, CFORM) COVER
            WRITE( NCPU , '(A)') CLINE(1:NLINE)
      ELSE IF (IPCHCO .EQ. 2) THEN
C----- CIF OUTPUT OF EXTINCTION
            MP = L5O+5
C--       CLEAR THE OUTPUT BUFFER
            CALL XMVSPD(IB,LINEA(1),118)
            J = 15
C----- CHECK FOR ESD PRESENT, OR NON-INTEGER VALUE
            IF (((ABS(BPD(6)) .GT. ZERO)) .OR.
     1      (ABS(NINT(STORE(MP))-STORE(MP)) .GT. ZERO) ) THEN
             CALL SNUM(STORE(MP), BPD(6), NOD, 0, J, LINEA)
             WRITE(CBUF, '(2X,32A1)') (LINEA(J),J=1,32)
             CALL XCTRIM (CBUF, N)
             WRITE (CLINE, '(A,A)') CCIF, CBUF(1:N)
             CALL XCREMS ( CLINE, CLINE, N)
             WRITE(NCFPU1, '(A)') CLINE(1:N)
              WRITE(NCFPU1,2556)
2556        FORMAT ('_refine_ls_extinction_method ', /,4X,
     1      '''Larson 1970 Crystallographic Computing eq 22''')
            ELSE
              WRITE(NCFPU1,2557)
2557        FORMAT ('_refine_ls_extinction_method ', /,4X,'''None''')
            ENDIF
      ENDIF
C -- DISPLAY ON MONITOR CHANNEL
      WRITE ( CMON , 2560 )
      CALL XPRVDU(NCVDU, 1,0)
      WRITE ( CMON , CFORM) COVER
      CALL XPRVDU(NCVDU, 1,0)
      WRITE ( CMON , 2561 )( STORE(I), I = M5A, M5A+N5A-1),
     1 (BPD(I), I=1,6)
      CALL XPRVDU(NCVDU, 2,0)
2560  FORMAT (/,' Over-all Parameters')
2561  FORMAT ( 6X, 6F10.3)
C
      RETURN
9910  CONTINUE
      WRITE ( CMON, '(A)') 'ERROR in overall parameter print'
      CALL XPRVDU(NCVDU, 1,0)
      RETURN
      END
C
C
CODE FOR XPESD
      SUBROUTINE XPESD (ITYPE, ISTART)
C
C----- COMPUTE PARAMETER ESDS FOR A COMPLETE RECORD
C      ITYPE RECORD TYPE 1 = OVERALL
C                        2 = ATOM
C      ISTART             START ADDRESS IN RECORD FOR FIRST VARIABLE
C                        1 FOR OVERALL
C                       -1 FOR ATOMS (ITEMS -1 AND 0 ARE TYPE AND SERIAL
C
\TSSCHR
\ISTORE
C
\STORE
C
\XPTCL
\XWORKA
\XCONST
\XCHARS
\XLST01
\XLST05
\XLST11
\XLST12
\XUNITS
\XSSVAL
\XOPK
\XIOBUF
C
\QSTORE
C
      JP = ISTART
      CALL XZEROF (BPD, 11)
      L12A = ISTORE(M12+1)
      IF (L12A .GT. 0) THEN
        MD12A=ISTORE(L12A+1)
        JU=ISTORE(L12A+2)
        JV=ISTORE(L12A+3)
        JT=ISTORE(L12A+4)
C--SEARCH FOR THE CONTRIBUTIONS TO EACH PARAMETER IN TURN
        DO JW=JU,JV,MD12A
          IF(ISTORE(JW))1800,1800,1200
1200  CONTINUE
          JX=JW
          JY=L12A
          JR=JS
          JZ=0
C--CHECK IF THIS PART FOR THIS PARAMETER HAS BEEN REFINED
1250  CONTINUE
          IF(ISTORE(JX))1550,1550,1300
C--ADD THE CONTRIBUTIONS INTO THE STACK
1300  CONTINUE
          IF ( ( JR+4 )  .GE.   LFL ) GOTO 9910
          ISTORE(JR)=ISTORE(JX)
          ISTORE(JR+2)=KBLCK(ISTORE(JR))
          ISTORE(JR+1)=M12B
          STORE(JR+3)=1.
          IF(ISTORE(JY+1)-1)1450,1500,1450
1450  CONTINUE
          STORE(JR+3)=STORE(JX+1)
1500  CONTINUE
          JR=JR+4
          JZ=JZ+1
C--CARRY ONTO THE NEXT PART
1550  CONTINUE
          JY=ISTORE(JY)
          IF(JY)1700,1700,1600
C--MOVE ONTO THE NEXT PART
1600  CONTINUE
          JX=ISTORE(JY+2)+ISTORE(JY+1)*(JT-ISTORE(JY+4))
          IF(JX-ISTORE(JY+2))1550,1250,1650
1650  CONTINUE
          IF(ISTORE(JY+3)-JX)1550,1250,1250
1700  CONTINUE
          IF(JZ)1800,1800,1750
C--CALCULATE THE E.S.D.
1750  CONTINUE
          BPD(JP)=XVAR(JS,JZ,4,JR)
          IF ( IERFLG .LT. 0 ) GO TO 9900
          IF(BPD(JP) .LT. 0.0 ) THEN
            IF (ITYPE .EQ. 1 ) THEN
              IF (ISSPRT .EQ. 0)
     1        WRITE(NCWU,1770) STORE(M5), STORE(M5+1), BPD(JP)
              WRITE ( CMON, 1770) STORE(M5), STORE(M5+1), BPD(JP)
              CALL XPRVDU(NCVDU, 1,0)
1770  FORMAT(1X,' Negative e.s.d for atom ',A4,F6.0,F12.10)
            ELSE
              IF (ISSPRT .EQ. 0)
     1        WRITE(NCWU,1771) JP, BPD(JP)
              WRITE ( CMON, 1771) JP, BPD(JP)
              CALL XPRVDU(NCVDU, 1,0)
1771  FORMAT(1X,' Negative e.s.d for overall parameter ',
     1 I6, F12.10)
            ENDIF
            BPD(JP) = 0.0
          ENDIF
1790  CONTINUE
          BPD(JP)=SQRT(BPD(JP)*AMULT)
1800  CONTINUE
          JT=JT+1
          JP=JP+1
        END DO
      ENDIF
      GOTO 9999
9900  CONTINUE
9910  CONTINUE
      WRITE ( CMON,'(A)') ' Error computing parameter e.s.d '
      CALL XPRVDU(NCVDU, 1,0)
9999  CONTINUE
      RETURN
      END
C
C
C
CODE FOR XVAR
      FUNCTION XVAR(LS,NS,NW,LF)
C--CALCULATE THE VARIANCE FROM THE PARAMETERS IN THE GIVEN STACK
C
C  LS  ADDRESS OF THE FIRST WORD OF THE STACK
C  NS  NUMBER OF ENTRIES IN THE STACK
C  NW  NUMBER OF WORDS PER STACK ENTRY
C  LF  ADDRESS OF THE NEXT FREE LOCATION THAT MAY BE USED
C
C--FORMAT OF THE STACK :
C
C  0  LEAST SQUARES PARAMETER NUMBER
C  1  ADDRESS OF THE BLOCK INFORMATION FOR THIS PARAMETER
C  2  ADDRESS OF THE DIAGONAL ELEMENT FOR THIS PARAMETER
C  3  COEFFICIENT FOR THIS PARAMETER
C
C--THIS PATTERN IS REPEATED 'NS' TIMES STARTING FROM 'LS' EVERY 'NW' WOR
C  'LF' IS THE FIRST FREE LOCATION  -  USED FOR WORK SPACE
C  WORK SPACE IS NS*NS+2*NS
C
C--
\TYPE11
\ISTORE
C
\STORE
\XSTR11
\XERVAL
C
\QSTORE
\QSTR11
C
C--SET UP A FEW POINTERS
      N=LS
      IA=LF
      L=LF+NS*NS
C--CHECK THE CORE
      IF ( L + NS + NS - LFL )  1050 , 1050 , 9910
1050  CONTINUE
      IB=L
C--FORM THE VARIANCE-COVARIANCE MATRIX
      DO 1500 I=1,NS
      K=ISTORE(N+2)
C--STORE THE DIAGONAL ELEMENTS
      STORE(IA)=STR11(K)
      STORE(IB)=STORE(N+3)
      IB=IB+1
C--CHECK IF THIS IS THE LAST PARAMETER
      IF(I-NS)1100,1550,1550
1100  CONTINUE
      IC=IA+NS
      IA=IA+1
      ID=I+1
      M=N+NW
C--SET UP THE OFF-DIAGONAL TERMS
      DO 1450 J=ID,NS
C--CHECK IF THE TWO PARAMETERS ARE IN THE SAME BLOCK
      IF(ISTORE(N+1)-ISTORE(M+1))1150,1200,1150
C--SET UP ZERO COVARIANCES FOR PARAMETERS IN DIFFERENT BLOCKS
1150  CONTINUE
      STORE(IA)=0.0
      STORE(IC)=0.0
      GOTO 1400
C--COMPUTE THE ADDRESS OF THE OFF-DIAGONAL TERM IN THE L.S. MATRIX
1200  CONTINUE
      K=ISTORE(N)-ISTORE(M)
      IF(K)1250,1250,1300
1250  CONTINUE
      K=ISTORE(N+2)-K
      GOTO 1350
1300  CONTINUE
      K=ISTORE(M+2)+K
1350  CONTINUE
      STORE(IA)=STR11(K)
      STORE(IC)=STR11(K)
1400  CONTINUE
      M=M+NW
      IA=IA+1
      IC=IC+NS
1450  CONTINUE
      IA=IA+I
      N=N+NW
1500  CONTINUE
1550  CONTINUE
C--PERFORM THE CALCULATIONS
      I=L+NS
      CALL XMLTMM(STORE(LF),STORE(L),STORE(I),NS,NS,1)
      CALL XMLTTM(STORE(L),STORE(I),STORE(LF),1,NS,1)
      XVAR=STORE(LF)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      XVAR = 0
      RETURN
9910  CONTINUE
C -- CORE OVERFLOW
      CALL XICA
      CALL XERHND ( IERERR )
      GO TO 9900
C
      END
C
C
C
CODE FOR SA41
      SUBROUTINE SA41(J,IND,IVET)
C
C
      DIMENSION IVET(118)
C
C
\XCHARS
C
C
      CALL XARS(IND,IVET(J))
      DO 1000 I=1,4
      IF(IVET(J).EQ.IB)GOTO 1050
      J=J+1
1000  CONTINUE
1050  CONTINUE
      RETURN
      END
C
CODE FOR STATX
      SUBROUTINE STATX(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(8)
C
C
\XPTCL
\XCHARS
C
C
      DATA IK(1)/'A'/
      DATA IK(2)/'t'/
      DATA IK(3)/'o'/
      DATA IK(4)/'m'/
      DATA IK(5)/' '/
      DATA IK(6)/' '/
      DATA IK(7)/' '/
      DATA IK(8)/' '/
C
      CALL XMVSPD(IB,IVET(1),118)
      J=IFIR
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(3)
      IVET(J+3)=IK(4)
      IVET(J+3)=IK(4)
      IVET(J+7)=IK(5)
      IVET(J+8)=IK(6)
      IVET(J+9)=IK(7)
      IVET(J+10)=IK(8)
      RETURN
      END
C
CODE FOR STUIJ
      SUBROUTINE STUIJ(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(3)
C
C
\XPTCL
\XCHARS
C
C
      DATA IK(1)/'U'/
      DATA IK(2)/'('/
      DATA IK(3)/')'/
C
      J=NSTA-IABS(NUD)+1+IFIR
      DO 1000 I=1,6
      J=J+NUF
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+4)=IK(3)
1000  CONTINUE
      J=NSTA-IABS(NUD)+1+IFIR
      DO 1050 I=1,3
      J=J+NUF
      N=I+1
      IVET(J+2)=NUMB(N)
      IVET(J+3)=NUMB(N)
1050  CONTINUE
      J=J+NUF
      IVET(J+2)=NUMB(3)
      IVET(J+3)=NUMB(4)
      J=J+NUF
      IVET(J+2)=NUMB(2)
      IVET(J+3)=NUMB(4)
      J=J+NUF
      IVET(J+2)=NUMB(2)
      IVET(J+3)=NUMB(3)
      RETURN
      END
C
CODE FOR STXYZ
      SUBROUTINE STXYZ(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(16)
C
C
\XPTCL
C
C
      DATA IK(1)/'x'/
      DATA IK(2)/'/'/
      DATA IK(3)/'a'/
      DATA IK(4)/'y'/
      DATA IK(5)/'b'/
      DATA IK(6)/'z'/
      DATA IK(7)/'c'/
      DATA IK(8)/'U'/
      DATA IK(9)/'('/
      DATA IK(10)/'i'/
      DATA IK(11)/'s'/
      DATA IK(12)/'o'/
      DATA IK(13)/')'/
      DATA IK(14) /'O'/
      DATA IK(15) /'c'/
      DATA IK(16) /'c'/
C
      J=NSTA+NXF-IABS(NXD)+1+IFIR
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(3)
      J=J+NXF
      IVET(J)=IK(4)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(5)
      J=J+NXF
      IVET(J)=IK(6)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(7)
      J=J+NUF+IABS(NXD)-IABS(NUD)-1
      IVET(J)=IK(8)
      IVET(J+1)=IK(9)
      IVET(J+2)=IK(10)
      IVET(J+3)=IK(11)
      IVET(J+4)=IK(12)
      IVET(J+5)=IK(13)
      J = J + NUF
      IVET(J) = IK(14)
      IVET(J+1) = IK(15)
      IVET(J+2) = IK(16)
      RETURN
      END
C
C
CODE FOR SAPPLY
      SUBROUTINE SAPPLY (NPAR)
C----- NPAR = NUMBER OF REFINABLE PARAMETERS
C--COMPUTE THE E.S.D.'S OF THE ATOMIC PARAMETERS.
C
C  BPD    LOCATION OF THE E.S.D.'S
C
C--THE FOLLOWING VARIABLES ARE USED :
C
C  JO  SET ON ENTRY
C  JP
C
C  JR
C  JS  SET ON ENTRY FOR WORK SPACE
C  JT
C  JU
C  .
C  .
C  JZ
C
C--REQUIRES M12 SET ON ENTRY
C
C--
\TSSCHR
\ISTORE
C
\STORE
C
\XPTCL
\XWORKA
\XCONST
\XLST01
\XLST05
\XLST11
\XLST12
\XUNITS
\XSSVAL
\XERVAL
\XIOBUF
C
\QSTORE
C
      NPAR = 0
C--CLEAR THE TEMPORARY STORAGE
      DO 1000 JX=1,11
        BPD(JX)=0.0
1000  CONTINUE
C--CHECK IF ANY COORDINATES HAVE BEEN REFINED
      IF(ISTORE(M12+1))1100,1100,1050

1050  CONTINUE
      L12A=ISTORE(M12+1)
      IF(ISTORE(L12A+3))1100,1150,1150

1100  CONTINUE
      RETURN

1150  CONTINUE
      MD12A=ISTORE(L12A+1)
      NPAR = JV - JU
      JU=ISTORE(L12A+2)
      JV=ISTORE(L12A+3)
      JT=ISTORE(L12A+4)
      JP=JT-1

C--SEARCH FOR THE CONTRIBUTIONS TO EACH PARAMETER IN TURN
      DO JW=JU,JV,MD12A
        IF(ISTORE(JW).GT.0)THEN
          JX=JW
          JY=L12A
          JR=JS
          JZ=0
C--CHECK IF THIS PART FOR THIS PARAMETER HAS BEEN REFINED
1250      CONTINUE
          IF(ISTORE(JX))1550,1550,1300

1300      CONTINUE
C--ADD THE CONTRIBUTIONS INTO THE STACK
            IF ( ( JR+4 )  .GE.   LFL ) GO TO 9910
            ISTORE(JR)=ISTORE(JX)
            ISTORE(JR+2)=KBLCK(ISTORE(JR))
            ISTORE(JR+1)=M12B
            STORE(JR+3)=1.
            IF(ISTORE(JY+1)-1)1450,1500,1450
1450        CONTINUE
              STORE(JR+3)=STORE(JX+1)
1500        CONTINUE
            JR=JR+4
            JZ=JZ+1

1550      CONTINUE
C--CARRY ONTO THE NEXT PART
          JY=ISTORE(JY)
          IF(JY)1700,1700,1600

1600      CONTINUE
C--MOVE ONTO THE NEXT PART
            JX=ISTORE(JY+2)+ISTORE(JY+1)*(JT-ISTORE(JY+4))
            IF(JX-ISTORE(JY+2))1550,1250,1650
1650        CONTINUE
              IF(ISTORE(JY+3)-JX)1550,1250,1250

1700      CONTINUE
          IF(JZ.GT.0)THEN
C--CALCULATE THE E.S.D.
            BPD(JP)=XVAR(JS,JZ,4,JR)
            IF ( IERFLG .LT. 0 ) GO TO 9900
            IF(BPD(JP)) 1760,1790,1790
1760        CONTINUE
            WRITE ( CMON, 1770) STORE(M5), STORE(M5+1), BPD(JP)
            CALL XPRVDU(NCVDU, 1,0)
            IF (ISSPRT .EQ. 0) WRITE(NCWU,'(A)') CMON(1)
1770        FORMAT(1X,' Negative e.s.d for atom ',A4,F6.0,F12.10)
            BPD(JP) = 0.0
1790        CONTINUE
            BPD(JP)=SQRT(BPD(JP)*AMULT)
          END IF
        END IF

        JT=JT+1
        JP=JP+1
      END DO
      GOTO 1100
C
9900  CONTINUE
C -- ERRORS
      RETURN
9910  CONTINUE
      CALL XICA
      CALL XERHND ( IERERR )
      RETURN
C
      END
C
CODE FOR SNUM
      SUBROUTINE SNUM(COOR,ESD,ND,NP,J,IVET)
C--OUTPUT A COORDINATE AND ITS E.S.D.
C
C  COOR  COORDINATE TO INSERT
C  ESD   E.S.D. TO INSERT
C  ND    POWER OF 10 NUMBER MULTIPLIED BY
C  NP    0  WITH DECIMAL POINT
C        1  NO DECIMAL POINT
C  J     ADDRESS IN IVET OF RIGHTMOST CHARACTER IN FIELD
C  IVET  VECTOR FOR PRINTING
C
C--IF 'ND' IS NEGATIVE, THEN THE SUBROUTINE WILL CHOOSE
C  A VALUE FOR 'ND', UNLESS THAT VALUE IS LESS THAN 'ND' AND
C  THE NUMBER IS TO BE PRINTED AS AN INTEGER.
C
C--
C
C
      DIMENSION IVET(118)
C
\XCHARS
C
C
      J1=J
      A=COOR
      B=ESD
      N1=ND
C--CHECK IF WE ARE TO CHOOSE THE NUMBER OF DECIMAL PLACES
      IF(ND)1000,1000,1350
C--WE MUST CHOOSE THE NUMBER OF DECIMAL PLACES  -  UNPACK THE DEFAULT
1000  CONTINUE
      J2=IABS(ND)
      N1=1
      DO 1100 I=1,7
      IF(INT(B*(10.0**N1)+0.0501))1150,1050,1150
C--STILL TOO SMALL
1050  CONTINUE
      N1=N1+1
1100  CONTINUE
C--NO E.S.D. TO PRINT  -  INSERT THE DEFAULT
      N1=J2
      GOTO 1350
C--THE NUMBER OF PLACES FOR THE E.S.D. HAS BEEN FOUND
1150  CONTINUE
C----- 'RULE OF 19'
      IF ( (NINT(B*(10.0**(N1+1))) .LE. 19) .AND.
     1     (NINT(B*(10.0**(N1+1))) .GT. 10) ) N1 = N1+1
      J1=J+ND+N1
C--CHECK IF THE DECIMAL POINT IS TO BE PRINTED
      IF(NP)1450,1450,1200
C--NO DECIMAL POINT  -  CHECK THAT ENOUGH PLACES ARE GIVEN
1200  CONTINUE
      IF(J2-N1)1300,1250,1250
C--NOT ENOUGH PLACES  -  INSERT THE DEFAULT
1250  CONTINUE
      J1=J
      N1=J2
      GOTO 1400
C--CHANGE THIS TO A DECIMAL POINT PRINT OF A SPECIAL TYPE
1300  CONTINUE
      B=10.0**J2
      A=COOR*B
      B=ESD*B
      N1=N1-J2
      J1=J+N1+1
      GOTO 1450
C--NORMAL PRINT  -  CHECK IF THIS IS WITH DECIMAL POINT
1350  CONTINUE
      IF(NP)1450,1450,1400
C--PRINT WITHOUT DECIMAL POINT
1400  CONTINUE
      J3=J1+1
      CALL SI(A,N1,ID)
      CALL SUBALF(J1,ID,IVET)
      J2=J1
      GOTO 1500
C--PRINT WITH DECIMAL POINT
1450  CONTINUE
      J3=J1+1
      CALL SID(A,N1,IX,ID)
      J2=J1-N1+1
C--OUTPUT THE NUMBER AFTER THE DECIMAL POINT
      CALL SUBALF(J1,ID,IVET)
      CALL SET0(J2,J1,IVET)
      J2=J2-1
      IVET(J2)=IPOINT
      J2=J2-1
C--OUTPUT THE PART BEFORE THE DECIMAL POINT
      CALL SUBALF(J2,IX,IVET)
C--OUTPUT THE SIGH IF NECESSARY
1500  CONTINUE
      IF(A)1550,1600,1600
1550  CONTINUE
      IVET(J2)=MINUS
C--OUTPUT THE E.S.D.
1600  CONTINUE
      CALL SI(B,N1,ID)
      CALL SUBZED(J3,ID,IVET, 1)
      RETURN
      END
C
CODE FOR SUBALF
      SUBROUTINE SUBALF(J,IARG,IVET)
C--TRANSFORM INTEGER NUMBER TO ALPHANUMERIC CHARACHTERS
C
C  J     LAST ADDRESS IN IVET  -  RESET ON EXIT
C  IARG  INTEGER NUMBER
C  IVET  VECTOR FOR PRINTING
C
C--THIS ROUTINE INSERTS THE NUMBER 'IARG' IN THE ARRAY 'IVET'
C  STARTING AT THE POSITION 'J', WHICH IS AT THE RIGHT HAND END
C  OF THE NUMBER STRING.
C  ON EXIT 'J' IS SET TO THE NEXT WORD ON THE LEFT NOT USED.
C
C--
C
C
      DIMENSION IVET(118)
C
\XCHARS
C
C
      IAR=IABS(IARG)
C--FIND THE NEXT CHARACTER FOR THIS NUMBER
1000  CONTINUE
      I=IAR
      IAR=IAR/10
      I=I-IAR*10
      IVET(J)=NUMB(I+1)
      J=J-1
C--CHECK IF THE REMAINDER IS ZERO
      IF(IAR)1050,1050,1000
C--CHECK THE SIGN OF THE ORIGINAL ARGUMENT
1050  CONTINUE
      IF(IARG)1100,1150,1150
1100  CONTINUE
      IVET(J)=MINUS
      J=J-1
1150  CONTINUE
      RETURN
      END
C
CODE FOR SUBZED
      SUBROUTINE SUBZED(J,IARG,IVET, ICODE)
C--TRANSFORM INTEGER NUMBER TO ALPHANUMERIC CHARACTERS
C
C  J      FIRST ADDRESS IN IVET
C  IARG   INTEGER NUMBER
C  IVET   VECTOR FOR PRINTING
C  ICODE  IF .GE. 2, NO BRACKETS
C
C
C
      DIMENSION IVET(118)
C
\XCHARS
C
      IF(IARG)1000,1250,1000
1000  CONTINUE
      IVALUE=IARG
      M=0
      NMX=7
      IF (ICODE .LT. 2) THEN
        IVET(J)=ILB
        J=J+1
      ENDIF
      DO 1200 I=1,NMX
      I1=10**(NMX-I)
      I2=IVALUE/I1
      IF(I2)1050,1050,1100
1050  CONTINUE
      IF(M)1200,1200,1150
1100  CONTINUE
      M=1
1150  CONTINUE
      IVET(J)=NUMB(I2+1)
      J=J+1
      IVALUE=IVALUE-I2*I1
1200  CONTINUE
      IF (ICODE .LT. 2) THEN
        IVET(J)=IRB
        J=J+1
      ENDIF
1250  CONTINUE
      RETURN
      END
C
CODE FOR SET0
      SUBROUTINE SET0(J1,J2,IVET)
C
C
      DIMENSION IVET(118)
C
\XCHARS
C
C
      J=J1
1000  CONTINUE
      IF(J2-J)1100,1050,1050
1050  CONTINUE
      IVET(J)=NUMB(1)
      J=J+1
      GOTO 1000
1100  CONTINUE
      RETURN
      END
C
CODE FOR SID
      SUBROUTINE SID(A,N,IX,ID)
C--CONVERT THE NUMBER 'A' INTO INTEGER AND FRACTIONAL PARTS
C
C  A   NUMBER TO CONVERT
C  N   NUMBER OF DECIMAL PLACES REQUIRED
C  IX  THE INTEGER PART OF 'A'
C  ID  THE FRACTIONAL PART OF 'A'
C
C--
C
C
      AM = 10.0**IABS(N)
      X  = FLOAT( NINT(ABS(A)*AM)) / AM
      IX=INT(X)
      XD=X-FLOAT(IX)
      ID=NINT(XD*(10.0**IABS(N)))
      RETURN
      END
C
C
CODE FOR SI
      SUBROUTINE SI(A,N,ID)
C--EXPRESS THE NUMBER 'A' AS AN INTEGER
C
C  A   THE NUMBER TO CONVERT
C  N   THE NUMBER OF DECIMAL PLACES OF 'A' REQUIRED
C  ID  THE ANSWER
C
C--
C
C
      X=ABS(A)
      ID=NINT(X*(10.0**IABS(N)))
      RETURN
      END
C
C
C
C
C
CODE FOR KCPROP
      FUNCTION KCPROP (A)
C----- COMPUTE PROPERTIES OF CELL
C        A(1) = DENS
C        A(2) = F000
C        A(3) = ABSN
C        A(4) = WEIGHT
C
      DIMENSION A(10)
\TSSCHR
\ISTORE
\STORE
\XCONST
\XLST01
\XLST02
\XLST03
\XLST05
\XLST23
\XLST29
\XUNITS
\XSSVAL
\XIOBUF
C
\QSTORE
C
      KCPROP = 1
      CALL XZEROF (A, 8)
C----- LOAD DATA IF NOT ALREADY IN CORE
      IF (KHUNTR (1,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL01
      IF (KHUNTR (2,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL02
      IF (KHUNTR (3,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL03
      IF (KHUNTR (5,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL05
      IF (KHUNTR (23,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL23
      IF (KHUNTR (29,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL29
C-----  SET UP OCCUPANCIES
        WRITE ( CMON, '(A)') ' Recomputing density and Mu'
        CALL XPRVDU(NCVDU, 1,0)
cdjw feb2001
        iupdat = istore(l23sp+1)
        toler = store(l23sp+5)
c        inomo = ( istore(l23m) * -2 ) + 1 ! 1 for anom, 3 for no anom
        CALL XPRC17 (0, 0, toler, -1)
        IF (IERFLG .LE. 0) GOTO 1600
C----- CLEAR THE CELL PROPERTY DETAILS
        WEIGHT =0.
        ABSN=0.
        F000 = 0.
        FIMAG = 0.0
        FREAL = 0.0
        FELEC = 0.0
        ICHECK=N5
        JCHECK=0
        I29=L29 + (N29-1)*MD29
        I5 = L5 + (N5-1)*MD5
C
        DO 1521 M29= L29,I29,MD29
          CWGHT = 0.0
          CABSN = 0.0
          DO 1510 M5=L5,I5,MD5
            IF (ISTORE(M5) .EQ. ISTORE(M29)) THEN
C----- MATCH
              if (iupdat .ge.0) then
                w = store(m5+2)*store(m5+13)
              else
                w = store(m5+2)
              endif
              CWGHT = CWGHT + W
              CABSN = CABSN + W
              ICHECK = ICHECK - 1
            END IF
1510      CONTINUE
          WEIGHT = WEIGHT + CWGHT * STORE(M29+6)
          ABSN = ABSN + CABSN * STORE(M29+5)
1521    CONTINUE

        DO 1530 M5=L5,I5,MD5
C----- CHECK LIST 3
          DO M3 = L3, L3+(N3-1)*MD3, MD3
            IF (ISTORE(M5) .EQ. ISTORE(M3)) THEN
              F = 0.0
              DO I = 1, 11, 2
                F = F + STORE(M3+I)
              END DO
              FREAL = FREAL + STORE(M5+2) * STORE(M5+13) * F
              FIMAG=STORE(M5+2)*STORE(M5+13)*STORE(M3+2)
              F = 0.0
              DO I = 3, 11, 2
                F = F + STORE(M3+I)
              END DO
              F = REAL(NINT(F))
              FELEC = FELEC + STORE(M5+2) * STORE(M5+13) * F
              GOTO 1528
            ENDIF
          END DO
C----- NO MATCH -
          JCHECK= JCHECK + 1
          GOTO 1530
1528      CONTINUE
          F000 = SQRT( FREAL*FREAL + FIMAG*FIMAG )
1530    CONTINUE

C----- COMPUTE MU AND M
        IF (ICHECK .NE. 0 ) THEN
          WRITE ( CMON, 1545) ICHECK, 29
          CALL XPRVDU(NCVDU, 1,0)
          IF (ISSPRT .EQ. 0)  WRITE(NCWU,'(A)') CMON(1)(:)
1545    FORMAT(1X,I6,' atoms exists in LIST 5 without details',
     1    ' in LIST ', I3)
          KCPROP = -1
        ENDIF
C
        IF (JCHECK .GT. 0 ) THEN
          WRITE ( CMON, 1545) JCHECK, 3
          CALL XPRVDU(NCVDU, 1,0)
          IF (ISSPRT .EQ. 0)  WRITE(NCWU,'(A)') CMON(1)(:)
          KCPROP = -1
        ENDIF
CNOV97    CONTINUE INSPITE OF ERROR        RETURN
1550  CONTINUE
C----- NUMBER OF ASYMMETRIC UNITS
        ASYM = FLOAT (N2*N2P*(1+IC))
        RVOL = ASYM/ STORE(L1P1+6)
        ABSN = ABSN  * RVOL * 10.
        DENS = WEIGHT * RVOL / 0.60225
        I=5
        WRITE ( CMON, 1555)
        CALL XPRVDU(NCVDU, 1,0)
        WRITE ( CMON, 1560)
        CALL XPRVDU(NCVDU, 1,0)
        WRITE ( CMON, 1570) I,WEIGHT,DENS,ABSN
        CALL XPRVDU(NCVDU, 1,0)
        IF (ISSPRT .EQ. 0) THEN
          WRITE (NCWU,1555)
          WRITE (NCWU,1560)
          WRITE(NCWU,1570)I,WEIGHT,DENS,ABSN
1555      FORMAT(15X,'  molecular weight,',
     1    '  calculated density, absorption coefficient')
1560      FORMAT(40X, '(gm/cm**3)                (cm-1)')
1570      FORMAT(1X,' From LIST ',I4,3X,F12.3,7X,
     1    F12.3,10X,F12.3)
        ENDIF
        A(1) = DENS
        A(2) = F000 * ASYM
        A(3) = ABSN
        A(4) = WEIGHT
        A(5) = FELEC * ASYM
C
        WEIGHT=0.
        ABSN=0.

        DO 1580 M29=L29,I29,MD29
          WEIGHT = WEIGHT + STORE(M29+4)*STORE(M29+6)
          ABSN = ABSN + STORE(M29+4)*STORE(M29+5)
1580    CONTINUE

        ABSN = ABSN * RVOL * 10.
        DENS = WEIGHT * RVOL / 0.60225
        I = 29
        WRITE ( CMON, 1570) I,WEIGHT,DENS,ABSN
        CALL XPRVDU(NCVDU, 1,0)
        IF (ISSPRT .EQ. 0) WRITE(NCWU,'(A)') CMON(1)(:)
        A(6) = DENS
        A(7) = F000 * ASYM
        A(8) = ABSN
        A(9) = WEIGHT
        A(10) = FELEC * ASYM
1600    CONTINUE
      RETURN
      END
C
C
CODE FOR XPRTDA
      SUBROUTINE XPRTDA(KEY, IESD, NODEV)
C--PUBLICATION PRINT OF DISTANCES, ANGLES, TORSION ANGLES
C
C
C      KEY      1 = DIST
C               2 = ANGLES
C               3 = BOTH
C               4 = TORSION
C
C  NODEV    THE OUTPUT DEVICE
C
C  IFIR    THE NUMBER OF BLANKS AT THE START OF EACH LINE.
C  MINX    THE FIRST LINE ON A PAGE TO BE USED
C  LINEX   THE LAST LINE PLUS ONE ON A PAGE USED
C  NSTA    THE NUMBER OF CHARACTERS FOR THE TYPE AND SERIAL NUMBER.
C  NXF     NUMBER OF CHARACTERS FOR THE TOTAL VALUE FIELD.
C  NXD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT
C  NOP     DECIMAL POINT INDICATOR :
C          0  PARAMETERS CONTAIN A DECIMAL POINT.
C          1  PARAMETERS DO NOT CONTAIN A DECIMAL POINT.
C
C  NAP     DOUBLE LINE SPACING INDCIATOR :
C
C          -1  SINGLE LINE SPACING.
C           0  DOUBLE LINE SPACING.
C  ICC     CHOOSE INDICATOR :
C
C           1  SYSTEM DOES NOT CHOOSE THE NUMBER OF SIGNIFICANT FIGURES.
C          -1  SYSTEM CHOOSES THE NUMBER OF SIGNIFICANT FIGURES TO PRINT
C
C  IBAR    THE LINE WIDTH.
C
C
      CHARACTER *1 CODE, ANGLE, DIST
      CHARACTER *160 CLINE
C
      DIMENSION ITYPE(4) , SER(4) , ITEM(3)
      DIMENSION LINEA(118)
C--
\TSSCHR
\ISTORE
C
\STORE
\XCHARS
\XUNITS
\XSSVAL
\XTAPES
\XOPVAL
\XIOBUF
C
\QSTORE
C
C
      DATA DIST/'D'/, ANGLE/'A'/
      DATA ITEM(1)/2/, ITEM(2)/3/, ITEM(3)/4/
C----- MAXIMUM NO OF ATOMS
      DATA MITEM/4/
C
C**********************************************************************
      IF (KEY .GT. 20) THEN
            CALL XHTMPR(KEY, IESD, NODEV)
            GOTO 9930
      ELSE IF (KEY .GT. 10) THEN
            CALL XCIFPR(KEY, IESD, NODEV)
            GOTO 9930
      ENDIF
C---  CLEAR THE CORE
      CALL XRSL
      CALL XCSAE
C----- SET THE CONSTANTS
C----- BLANKS AT START OF LINE
      IFIR = 2
      NSTA = 8
      NFX = 8
      NXD = 2
      NOP = 0
      ICC = -1
      NAP = -1
      IBAR = 72
      LINE = IBAR
C----- PAGE BREAK EVERY 10 PAGES
      LINEX = 66*10
C----- SET MAXIMUM REQUESTED CHARACTERS PER LINE
      KLEN=MITEM*NSTA + 2*NFX + IFIR
C----- PREPARE AN ANGLE BUFFER
      ILEN=3*NSTA + 2*NFX
      JLEN=INT(ILEN+3)/4
      JFIR=INT(IFIR)/4
      IBUF=NFL
C--CHECK THE WIDTH OF A PAGE
      IF(IBAR-KLEN)1050,1200,1200
C--FIELD WIDTH IS WRONG
1050  CONTINUE
      WRITE ( CMON, 1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
1100  FORMAT(' More than',I5,'  characters on a line')
C-- ERROR
      GOTO 9920
1200  CONTINUE
C--SET THE FLAG FOR THE FIRST LINE ON A PAGE
      MINX=5
C--SET THE FIELD WIDTH FLAGS
      NXD=ISIGN(NXD,ICC)
C
      NL=LINEX
C
      REWIND (MTE)
C--LOOP OVER THE ENTRIES
C
2000  CONTINUE
      CLINE = ' '
      READ ( MTE,END=2700 ) CODE, TERM, ESD,
     1 (ITYPE(I),SER(I),(JUNK,J=1,5),I=1,4)
      IF (CODE .EQ. DIST)  THEN
            NUM = ITEM(1)
      ELSE  IF (CODE .EQ. ANGLE) THEN
            NUM = ITEM(2)
      ELSE
            NUM = ITEM(3)
      ENDIF
C
      IF (IESD .LT. 0) ESD=0.0
C
C--CLEAR THE OUTPUT BUFFER
      CALL XMVSPD(IB,LINEA(1),LINE)
      K=IFIR
      DO 2020 I=1,NUM
      J=K
C--OUTPUT THE TYPE
      CALL SA41 ( J , ITYPE(I) , LINEA )
      IND1=NINT(SER(I))
C----- OUTPUT  SERIAL NUMBER
      CALL SUBZED(J,IND1,LINEA,  1)
C--UPDATE THE CURRENT POSITION FLAG
      K=K+NSTA
      IF (I .LT. NUM) LINEA(K-2) = MINUS
2020  CONTINUE
      J=K + NFX
C----- OUTPUT VALUE AND ESD
      CALL SNUM(TERM, ESD, NXD, NOP,J,LINEA)
C--CHECK FOR DOUBLE SPACING
2200  CONTINUE
      IF(NAP)2300,2250,2250
C--PRINT THE BLANK LINE
2250  CONTINUE
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) WRITE(NODEV,2550)
      NL=NL+1
C--CHECK FOR THE END OF A PAGE
2300  CONTINUE
      IF(NL-LINEX)2500,2350,2350
C--END OF THE PAGE  -  START A NEW PAGE
2350  CONTINUE
      IF ( CODE  .NE. ANGLE  .AND.  KEY   .NE. 2    .AND.
     1     NODEV .NE. NCWU   .AND.  NODEV .NE. NCPU      )
     2  WRITE(NODEV, '(A)') CHAR(12)
C----- WRITE SOME LINETHROWS
C--CLEAR THE OUTPUT BUFFER
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) WRITE(NODEV,2450)
2450  FORMAT(//2X,118A1/)
      NL=MINX
      GOTO 2200
2500  CONTINUE
      IF (CODE .EQ. ANGLE .AND. KEY .GE. 1 ) THEN
C----- COMPRESS AND STORE CURRENT LINE
            JBUF=KSTALL(JLEN)
            CALL XFA4CS(LINEA(IFIR),STORE(JBUF),ILEN)
      ENDIF
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) THEN
C--PRINT THE DISTANCE OR TORSION  LINE
      CLINE = ' '
      WRITE(CLINE,2550) (LINEA(I),I = 1,KLEN)
      CALL XCTRIM (CLINE,NCHAR)
      WRITE(NODEV,'(A)') CLINE(1:NCHAR)
2550        FORMAT(2X,118A1)
            NL=NL+1
      ENDIF
C -- FETCH INFORMATION FOR THE NEXT ENTRY
C----- ANY MORE ?
      GOTO 2000
2700  CONTINUE
C
      REWIND (MTE)
C
      IF(IBUF .EQ. NFL) GOTO 9930
C------ WRITE OUT THE ANGLE BUFFER
      NL=LINEX
C
      DO 3500 I=IBUF,JBUF,JLEN
      IF (NL.GE.LINEX .AND. NODEV.NE.NCWU .AND. NODEV.NE.NCPU) THEN
            WRITE(NODEV, '(A)') CHAR(12)
            WRITE(NODEV,2450)
            NL=0
        ENDIF
      CLINE = ' '
      WRITE(CLINE,3100) (STORE(J),J=I,I+JLEN-1)
      CALL XCTRIM (CLINE,NCHAR)
      WRITE(NODEV,'(A)') CLINE(1:NCHAR)
        NL=NL+1
3100  FORMAT(2X,20A4)
3500  CONTINUE
C
      GOTO 9930
C
9920  CONTINUE
      CALL XOPMSG ( IOPDIS , IOPLSP , 5 )
9930  CONTINUE
      CALL XOPMSG ( IOPDIS , IOPLSE , 5 )
      CALL XTIME2 ( 2 )
C
      RETURN
      END
CODE FOR XHTMPR
      SUBROUTINE XHTMPR(KEY, IESD, NODEV)
C
C----- PRINT GEOMETRY INFORMATION IN HTML FORMAT
C
      DIMENSION IVEC(20), KDEV(4)
      CHARACTER *80 CLINE, CBUF
      CHARACTER *1 CODE
      CHARACTER *3 CKEY
      CHARACTER CGEOM(3)*8
\TSSCHR
\ISTORE
\STORE
\XUNITS
\XTAPES
\XCHARS
\XCONST
\XLST02
\QSTORE
\UFILE
\XSSCHR
      DATA CKEY /'DAT'/

      CALL XRSL  ! CLEAR THE STORE
      CALL XCSAE
      CALL XFAL02
      IF (STORE(L2C) .LE. ZERO) THEN
            JA = 1
      ELSE
            JA = 2
      ENDIF

      IPUB = KSTALL (28)

C----- WE NEED JKEY ETC BECAUSE MTE MAY CONTAIN BOTH DISTANCES AND ANGLE

      IF (KEY .EQ. 23) THEN
            JKEY = 0
            NCYC = 2
      ELSE IF (KEY .EQ. 24) THEN
            JKEY = 2
            NCYC = 1
      ELSE
            RETURN
      ENDIF
C
      DO 3000 ICYC = 1, NCYC
        KKEY = JKEY + ICYC

        SELECT CASE (KKEY)
        CASE (1)
          WRITE(NCPU, '(''<H2>Distances</H2>'')')
        CASE (2)
          WRITE(NCPU, '(''<H2>Angles</H2>'')')
        CASE (3)
          WRITE(NCPU, '(''<H2>Torsion</H2>'')')
        END SELECT
        WRITE(NCPU, '(''<TABLE BORDER="1">'')')

        REWIND (MTE)

1000    CONTINUE
          CALL XZEROF(STORE(IPUB), 28)
          READ (MTE, END=2500, ERR = 9000) CODE, TERM, ESD,
     1    (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2    JPUB=IPUB, IPUB+21, 7)
C
C-- GET ADDRESS OF LAST USEFUL ITEM - UP TO 4 (D, A or T)
          JPUB = INDEX (CKEY, CODE)
          IF (JPUB .NE. KKEY) GO TO 1000
          IF (JPUB .NE. 0) THEN
            KPUB = (JPUB * 7) + IPUB
          ELSE
            KPUB=0
          ENDIF
          CLINE = ' '
          WRITE(NCPU,'(''<TR>'')')
1         FORMAT ('<TD>',A,'</TD>')
          DO JPUB = IPUB, KPUB, 7
            WRITE (CLINE, '(A4,I4)') STORE(JPUB), NINT(STORE(JPUB+1))
            CALL XCRAS( CLINE, J)

C----- CHECK SYMMETRY INFORMATION
            IF (
     1       (ISTORE(JPUB+2)+ISTORE(JPUB+3)+ISTORE(JPUB+4)
     2       +ISTORE(JPUB+5)+ISTORE(JPUB+6) .EQ. 2) .AND.
     3      (ABS(ISTORE(JPUB+2))+ABS(ISTORE(JPUB+3))+ABS(ISTORE(JPUB+4))
     4      +ABS(ISTORE(JPUB+5))+ABS(ISTORE(JPUB+6)) .EQ. 2)) THEN
              WRITE(NCPU,1) CLINE(1:J)
            ELSE
              M = 1+
     1         (ABS(ISTORE(JPUB+2))-1) * N2P * JA +
     2         (ISTORE(JPUB+3)-1) * JA +
     3         (-SIGN(1,ISTORE(JPUB+2))+1)/2
              WRITE(CBUF, '(I4)') M
              CALL XCRAS (CBUF, N)
              CLINE(J+2:) = CBUF(1:N)//'_'
              J = J + N + 3
              WRITE(CLINE(J:J+2), '(3I1)') 5+ISTORE(JPUB+4),
     1        5+ISTORE(JPUB+5), 5+ISTORE(JPUB+6)
              WRITE(NCPU,1) CLINE(1:J+2)
            ENDIF
          END DO

C----- VALUE AND ESD
          CALL XFILL (IB, IVEC, 20)
          CALL SNUM ( TERM, ESD, -3, 0, 8, IVEC )
          WRITE( CBUF, '(20A1)') (IVEC(I), I=1, 20)
          CALL XCRAS ( CBUF, N)
          SELECT CASE (KKEY)
          CASE (1)
            WRITE(NCPU,1) CBUF(1:N)//'&Aring;'
          CASE (2,3)
            WRITE(NCPU,1) CBUF(1:N)//'&deg;'
          END SELECT
          WRITE(NCPU,'(''</TR>'')')
        GOTO 1000

2500    CONTINUE  ! END OF MTE

       WRITE(NCPU,'(''</TABLE>'')')

3000  CONTINUE

9000  CONTINUE
      RETURN
      END
CODE FOR XCIFPR
      SUBROUTINE XCIFPR(KEY, IESD, NODEV)
C
C----- PRINT GEOMETRY INFORMATION IN CIF FORMAT
C
      DIMENSION IVEC(20), KDEV(4)
      CHARACTER *80 CLINE, CBUF
      CHARACTER *3 CKEY
      CHARACTER *1 CODE
      CHARACTER CGEOM(3)*8
\TSSCHR
\ISTORE
\STORE
\XUNITS
\XTAPES
\XCHARS
\XCONST
\XLST02
\QSTORE
\UFILE
\XSSCHR
C
      DATA CGEOM /'_bond', '_angle', '_torsion' /
      DATA CKEY /'DAT'/
C
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
c
      IESD = IESD
      NODEV = NODEV
C      CLEAR THE STORE
      CALL XRSL
      CALL XCSAE
      CALL XFAL02
      IF (STORE(L2C) .LE. ZERO) THEN
            JA = 1
      ELSE
            JA = 2
      ENDIF
      IPUB = KSTALL (28)
C----- WE NEED JKEY ETC BECAUSE MTE MAY CONTAIN BOTH DISTANCES AND ANGLE
      IF (KEY .EQ. 13) THEN
            JKEY = 0
            NCYC = 2
      ELSE IF (KEY .EQ. 14) THEN
            JKEY = 2
            NCYC = 1
      ELSE
            CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
            RETURN
      ENDIF
C
      DO 3000 ICYC = 1, NCYC
      KKEY = JKEY + ICYC
      WRITE(NCFPU1, '(A)') 'loop_'
      DO 500 I = 1, KKEY+1
        WRITE( CLINE, 510) CGEOM(KKEY), I
510   FORMAT( '_geom', A, '_atom_site_label_', I1)
        CALL XCRAS ( CLINE, N)
        WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
       WRITE( CLINE, 520) CGEOM(KKEY), I
520   FORMAT ('_geom', A, '_site_symmetry_', I1)
        CALL XCRAS ( CLINE, N)
        WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
500   CONTINUE
      IF (KKEY .EQ. 1) THEN
      WRITE(CLINE, 530) CGEOM(KKEY), '_distance'
      ELSE
      WRITE(CLINE, 530) CGEOM(KKEY)
530   FORMAT ('_geom', A, A)
      ENDIF
      CALL XCRAS ( CLINE, N)
      WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
      WRITE(CLINE, 540) CGEOM(KKEY)
540   FORMAT ('_geom', A, '_publ_flag')
      CALL XCRAS ( CLINE, N)
      WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
C
      REWIND (MTE)
1000  CONTINUE
      CALL XZEROF(STORE(IPUB), 28)
      READ (MTE, END=2500, ERR = 9000) CODE, TERM, ESD,
     1 (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2  JPUB=IPUB, IPUB+21, 7)
C
C----- GET ADDRESS OF LAST USEFUL ITEM - UP TO 4
      JPUB = INDEX (CKEY, CODE)
      IF (JPUB .NE. KKEY) GO TO 1000
      IF (JPUB .NE. 0) THEN
        KPUB = (JPUB * 7) + IPUB
      ELSE
        KPUB=0
      ENDIF
C
      CLINE = ' '
      J = 1
C----- NO HYDROGEN YET
      NOH = 0
      DO 2000 JPUB = IPUB, KPUB, 7
C----- ATOM NAME
        WRITE (CBUF, '(A4)') STORE(JPUB)
        CALL XCTRIM (CBUF, N)
        CALL XCCLWC (CBUF(2:N), CBUF(2:N))
        NOH = MAX (NOH, INDEX(CBUF(1:2), 'H '))
C----- REMOVE TRAILING SPACE
        N = N-1
        CLINE(J:J+N-1) = CBUF(1:N)
        J = J + N
C----- ATOM NUMBER
        WRITE(CBUF, '(I4)') NINT(STORE(JPUB+1))
        CALL XCRAS( CBUF, N)
        CLINE(J:J+N-1) = CBUF(1:N)
        J = J+N+1
C
C----- SYMMETRY INFORMATION
      IF (
     1 (ISTORE(JPUB+2)+ISTORE(JPUB+3)+ISTORE(JPUB+4)
     2  +ISTORE(JPUB+5)+ISTORE(JPUB+6) .EQ. 2) .AND.
     3 (ABS(ISTORE(JPUB+2))+ABS(ISTORE(JPUB+3))+ABS(ISTORE(JPUB+4))
     4  +ABS(ISTORE(JPUB+5))+ABS(ISTORE(JPUB+6)) .EQ. 2)) THEN
C----- IDENTITY
            CLINE(J:J) = '.'
            J = J + 2
      ELSE
            M = 1+
     1         (ABS(ISTORE(JPUB+2))-1) * N2P * JA +
     2         (ISTORE(JPUB+3)-1) * JA +
     3         (-SIGN(1,ISTORE(JPUB+2))+1)/2
            WRITE(CBUF, '(I4)') M
            CALL XCRAS (CBUF, N)
            CLINE(J:J+N) = CBUF(1:N)//'_'
            J = J + N +1
            WRITE(CLINE(J:J+2), '(3I1)') 5+ISTORE(JPUB+4),
     1      5+ISTORE(JPUB+5), 5+ISTORE(JPUB+6)
            J = J+4
      ENDIF
2000  CONTINUE
C
C----- VALUE AND ESD
      CALL XFILL (IB, IVEC, 20)
      CALL SNUM ( TERM, ESD, -3, 0, 8, IVEC )
      WRITE( CBUF, '(20A1)') (IVEC(I), I=1, 20)
      CALL XCRAS ( CBUF, N)
      CLINE(J:J+N-1) = CBUF(1:N)
      J = J + N + 1
C
      N = INDEX (CLINE(1:J), 'H')
      IF (NOH .LE. 0) THEN
            WRITE(NCFPU1, '(A, 2X,A )') CLINE(1:J), 'yes'
      ELSE
            WRITE(NCFPU1, '(A, 2X,A )') CLINE(1:J), 'no'
      ENDIF
      GOTO 1000
C
2500  CONTINUE
3000  CONTINUE
C
9000  CONTINUE
      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
      RETURN
      END
CODE FOR XCIFX
      SUBROUTINE XCIFX
CDJWMAR99[      CIF OUTPUT DIRECTED TO NCFPU1, PERMITTING TEXT OUTPUT TO
C               BE SENT TO THE PUNCH UNIT AS A TABLE
C 
      PARAMETER (NCOL=2,NROW=49)
      PARAMETER (IDATA=15,IREF=23)
      CHARACTER*35 CPAGE(NROW,NCOL)
      CHARACTER*76 CREFMK
      PARAMETER (IDIFMX=8)
      DIMENSION IREFCD(3,IDIFMX)
      PARAMETER (ISOLMX=7)
      DIMENSION ISOLCD(ISOLMX)
      PARAMETER (IABSMX=13)
      DIMENSION IABSCD(IABSMX)

C 
CDJWMAR99 MANY CHANGES TO BRING UP TO DATE WITH NEW CIFDIC
      PARAMETER (NTERM=4)
      PARAMETER (NNAMES=30)
      DIMENSION A(10), JDEV(4), KDEV(4)
      PARAMETER (NLST=12)
      DIMENSION LSTNUM(NLST), JLOAD(NLST)
      DIMENSION IVEC(16), ESD(6)
      CHARACTER CCELL(3)*1,CANG(3)*5,CSIZE(3)*3,CINDEX(3)*2
      CHARACTER CBUF*80,CTEMP*80,CLINE*80, CHLINE*380
      character *80 ctext(4)
C
      CHARACTER*4 CTYPE
      CHARACTER*15 CINSTR,CDIR,CPARAM,CVALUE,CDEF
      CHARACTER*26 UPPER,LOWER
      CHARACTER*3 CSSUBS(11)
      CHARACTER*17 CWT 
      CHARACTER*22 CFM, CFMC ! 'F<sub>obs</sub>&sup2;'
      CHARACTER*35 CMOD
C                      
\TSSCHR                
\ICOM30
\ICOM31
\ISTORE
\STORE
\XCOMPD
\XUNITS
\UFILE
\XTAPES
\XCHARS
\XCONST
\XSSVAL
\XSSCHR
\XLISTI
\XLST01
\XLST02
\XLST03
\XLST04
\XLST05
\XLST06
\XLST13
\XLST23
\XLST28
\XLST29
\XLST30
\XLST31
\XIOBUF
C 
C 
\QLST30
\QLST31
\QSTORE

      V(CA,CB,CC,AL,BE,GA)=CA*CB*CC * SQRT(1-COS(AL)**2-COS(BE)**2-
     1   COS(GA)**2 + 2 * COS(AL) * COS(BE) * COS(GA))
C 
C------ REFERENCE CODES FOR THE DIFFRACTOMETERS
      DATA IREFCD /4,5,6, 13,24,13, 13,24,13, 25,17,17, 15,17,17,
     1 26,27,27, 20,19,20,  37,36,36 /
C------ REFERENCE CODES FOR DIRECT METHODS
      DATA ISOLCD /1,18,30,11,22,28,29/
C------ REFERENCE CODES FOR ABSORPTION METHOD
      DATA IABSCD /7,21,16,17,31,32,33,7,7,7,7,7,7/

C 
      DATA UPPER/'ABCDEFGHIJKLMNOPQRSTUVWXYZ'/
      DATA LOWER/'abcdefghijklmnopqrstuvwxyz'/
C                  1 2 3 4 5 6  7  8  9  10 11 12
      DATA LSTNUM/1,2,3,4,5,13,23,29,30,31,6,28/
      DATA CCELL/'a','b','c'/
      DATA CANG/'alpha','beta','gamma'/
      DATA CSIZE/'min','mid','max'/
      DATA CINDEX/'h_','k_','l_'/
      DATA ICARB/'C   '/
      DATA IHYD/'H   '/
CDJWMAR99      DATA JDEV /'H','K','L','I'/
      DATA CSSUBS /' 21',' 31',' 32',' 41',' 42',' 43',' 61',
     1            ' 62',' 63',' 64',' 65'/
 
1     FORMAT (A)
2     FORMAT ('<TR><TD>',A,'</TD><TD>',A,'</TD></TR>')
3     FORMAT ('<TR><TD>',A,'</TD><TD>',F5.2,'</TD></TR>')
4     FORMAT ('<TR><TD>',A,'</TD><TD>',I8,'</TD></TR>')
5     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.4,'</TD></TR>')
6     FORMAT ('<TR><TD>',A,'</TD><TD>',I8,A,'</TD></TR>')
7     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.2,A,'</TD></TR>')
8     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.3,'</TD></TR>')

CRICFEB03: Output one of 0=CIF, 1=PLAIN, 2=HTML
      CALL XCSAE
      I = KRDDPV ( IPUNCH , 1 )
      IF (I.LT.0) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, 51)
         WRITE ( CMON ,51)
         CALL XPRVDU(NCVDU, 1,0)
51       FORMAT(' Error in #CIFOUT directives. ')
         RETURN
      END IF

CDJWMAY99 - OPEN CIF OUTPUT ON FRN1
      IF ( IPUNCH .EQ. 0 ) THEN
         CALL XMOVEI (KEYFIL(1,23),KDEV,4)
         CALL XRDOPN (6,KDEV,CSSCIF,LSSCIF)
      END IF

CRICJUN02 - Last minute SFLS calc to get threshold cutoffs into 30.
      CALL XRSL
      CALL XCSAE

C----- SET REFLECTION LISTING TYPE
      ITYP06 = 1

      IF (KEXIST(33) .LE. 0) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, 1151)
         WRITE ( CMON ,1151)
         CALL XPRVDU(NCVDU, 1,0)
1151     FORMAT(' Calculation of R values cannot proceed ',
     2          'as no refinement has been carried out yet.')
      ELSE
         CALL XSFLSB(-1,ITYP06)
      ENDIF
 
      CALL XRSL
      CALL XCSAE

C----- CLEAR OUT THE PAGE BUFFER
      DO I=1,NROW
         CPAGE(I,1)=' '
         CPAGE(I,2)=' '
      END DO

      CALL XDATER (CBUF(1:8))

      IF ( IPUNCH .EQ. 0 ) THEN
        WRITE (NCFPU1,'(''data_CRYSTALS_cif '')')
        WRITE (NCFPU1,'(''_audit_creation_date  '',6X, 3(A2,A))')
     1         CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2)
        WRITE (NCFPU1,
     1   '(''_audit_creation_method CRYSTALS_ver_12-03-99'')')

C----- OUTPUT A TITLE, FIRST 60 CHARACTERS ONLY
        WRITE (NCFPU1,'(''#  '',15A4)') (KTITL(I),I=1,15)

      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        WRITE (CLINE,'(15A4,3(A2,A))') (KTITL(I),I=1,15),CBUF(7:8),'-',
     1  CBUF(4:5),'-',CBUF(1:2)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        K=MIN(35,NCHAR)
        WRITE (CPAGE(1,1)(:),'(A)') CLINE(1:K)
        IF (NCHAR.GE.36) THEN
          K=MIN(70,NCHAR)
          WRITE (CPAGE(1,2)(:),'(A)') CLINE(36:K)
        END IF

      ELSE IF ( IPUNCH .EQ. 2 ) THEN

        WRITE (NCPU,53)
53      FORMAT(
     1 '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" ',
     2 '"http://www.w3.org/TR/REC-html40/loose.dtd">',/,
     3 '<HTML><HEAD><TITLE>Crystal Structure Report</TITLE>',/,
     4 '<META NAME="Description" CONTENT="Structure Report generated',
     5 'by CRYSTALS.">',/,
     6 '<meta http-equiv="Content-Type" ',
     7 'content="text/html; charset=utf-8">',/,
     8 '</HEAD><BODY>')

        WRITE (NCPU,'(''<P align="right">'',3(A2,A),''</P>'')')
     1                      CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2)
        WRITE (CLINE,'(15A4)') (KTITL(I),I=1,15)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        WRITE (NCPU,'(''<P>'',A,''</P>'')') CLINE(1:NCHAR)
      END IF


      IF ( IPUNCH .EQ. 0 ) THEN
C----- COPY HEADER INFORMATION FROM .CIF FILE
        CALL XMOVEI (KEYFIL(1,2),JDEV,4)
###LINGILWXS      CALL XRDOPN(6,JDEV,'CRYSDIR:script\refcif.dat',25)
&&&LINGILWXS      CALL XRDOPN(6,JDEV,'CRYSDIR:script/refcif.dat',25)

        IF (IERFLG.GE.0) THEN
          CLINE=' '
100       CONTINUE
          READ (NCARU,'(A)',ERR=100,END=150) CLINE
          WRITE (NCFPU1,'(A)') CLINE
          GO TO 100
150       CONTINUE
C----- CLOSE THE FILE
###LINGILWXS       CALL XRDOPN(7,JDEV,'CRYSDIR:script\refcif.dat',25)
&&&LINGILWXS       CALL XRDOPN(7,JDEV,'CRYSDIR:script/refcif.dat',25)
        ELSE
          WRITE (CMON,'('' cif header file not available'')')
          CALL XPRVDU (NCVDU,1,0)
          IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
          IERFLG=0
        END IF
      END IF


C################################################################
 
C                      1 2 3 4 5 6  7  8  9  10 11 12
C FYI:    DATA LSTNUM /1,2,3,4,5,13,23,29,30,31, 6,28 /

      DO MLST=1,NLST
         JLOAD(MLST)=0                   !INDICATE LIST NOT LOADED
         LSTYPE=LSTNUM(MLST)
         IF (KEXIST(LSTYPE)) 400,300,500
300      CONTINUE
           WRITE (CMON,350) LSTYPE
           CALL XPRVDU (NCVDU,1,0)
350        FORMAT (1X,'List ',I2,' contains errors')
           CYCLE
400      CONTINUE
           WRITE (CMON,450) LSTYPE
450        FORMAT (1X,'List',I2,' does not exist')
           CALL XPRVDU (NCVDU,1,0)
           CYCLE
500      CONTINUE
 
         IF (LSTYPE.EQ.1) THEN
            CALL XFAL01
         ELSE IF (LSTYPE.EQ.2) THEN
            CALL XFAL02
         ELSE IF (LSTYPE.EQ.3) THEN
            CALL XFAL03
         ELSE IF (LSTYPE.EQ.4) THEN
            CALL XFAL04
         ELSE IF (LSTYPE.EQ.5) THEN
            CALL XLDR05 (LSTYPE)
         ELSE IF (LSTYPE.EQ.6) THEN
            IULN = 6
            CALL XFAL06 (IULN, 0)
         ELSE IF (LSTYPE.EQ.10) THEN
            CALL XLDR05 (LSTYPE)
         ELSE IF (LSTYPE.EQ.13) THEN
            CALL XFAL13
         ELSE IF (LSTYPE.EQ.14) THEN
            CALL XFAL14
         ELSE IF (LSTYPE.EQ.23) THEN
            CALL XFAL23
         ELSE IF (LSTYPE.EQ.27) THEN
            CALL XFAL27
         ELSE IF (LSTYPE.EQ.28) THEN
C----- LOADED BY XFAL06          CALL XFAL28
         ELSE IF (LSTYPE.EQ.29) THEN
            CALL XFAL29
         ELSE IF (LSTYPE.EQ.30) THEN
            CALL XFAL30
         ELSE IF (LSTYPE.EQ.31) THEN
\IDIM31
            CALL XLDLST (31,ICOM31,IDIM31,0)
         END IF
 
         IF (IERFLG.GE.0) JLOAD(MLST)=1
      END DO
 
C################################################################

      IF ( IPUNCH .EQ. 0 ) THEN
C-----  LOAD THE AVAILABLE REFERENCE TABLE

###LINGILWXS      CALL XRDOPN(6,JDEV,'CRYSDIR:script\reftab.dat',25)
&&&LINGILWXS      CALL XRDOPN(6,JDEV,'CRYSDIR:script/reftab.dat',25)
        IF (IERFLG.GE.0) THEN
          READ (NCARU,'(i4)') NREFS
          REWIND (NCARU)
          MDREFS=21
          LREFS=NFL
          I=KCHNFL(NREFS*MDREFS)
          CALL XZEROF (ISTORE(LREFS),MDREFS*NREFS)
C 
          I=0
          J=LREFS
200       CONTINUE
          READ (NCARU,'(a)',ERR=200,END=250) CTEMP
          IF (CTEMP(1:1).EQ.'#') THEN
            READ (CTEMP,'(1x,i3,19a4)') (ISTORE(K),K=J+1,J+MDREFS-1)
            J=J+MDREFS
            I=I+1
          END IF
          GO TO 200
250       CONTINUE
          REWIND (NCARU)
          IF (I.NE.NREFS) THEN
            WRITE (CMON,'(i6,a,i6,a)') I,'references found,',NREFS,' ref
     1erences expected'
            NREFS=I
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
          END IF
        ELSE
          NREFS = 0
          IERFLG=0
          WRITE (CMON,'('' Reference file not available'')')
          CALL XPRVDU (NCVDU,1,0)
          IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:)
        END IF
C-usage example 
c     ival =012
c     ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
c     call xrefpr (istore(lrefs),nrefs,mdrefs)

        IF (I.LE.0) THEN
          WRITE (CMON,'('' Reference '', i4, '' not available'')') IVAL
          CALL XPRVDU (NCVDU,1,0)
        END IF
      END IF
C
C################################################################
C
      IF ( IPUNCH .EQ. 0 ) THEN
         call xpcif('# General computing')
         call xpcif(
     1'#=============================================================')
         ival=22
         ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
         CALL XCTRIM (CTEMP,NCHAR)
         WRITE (CLINE,'(''_computing_structure_refinement'' )') 
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         WRITE (CLINE,'(A )') CTEMP(1:NCHAR)
         CALL XPCIF (CLINE)
         CALL XPCIF (';')

         WRITE (CLINE,'(''_computing_publication_material'' )') 
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         WRITE (CLINE,'(A )') CTEMP(1:NCHAR)
         CALL XPCIF (CLINE)
         CALL XPCIF (';')

         ival=23
         ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
         CALL XCTRIM (CTEMP,NCHAR)
         WRITE (CLINE,'(''_computing_molecular_graphics'' )') 
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         WRITE (CLINE,'(A )') CTEMP(1:NCHAR)
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         call xpcif(
     1'#=============================================================')
         CALL XPCIF (' ')
      END IF

C---- GET LIST 30 READY FOR UPDATING
      IF (JLOAD(9).LE.0) THEN
         WRITE (CMON,'(A)') 'List 30 not available - cif output abandone
     1d'
         CALL XPRVDU (NCVDU,1,0)
         GO TO 2600
      END IF
C 
C----- LIST 1 AND 31
      IF ( IPUNCH .EQ. 2 ) THEN
         WRITE (NCPU,'(''<H2>Crystal Data</H2>'')')
      END IF

C
      IF (JLOAD(1).GE.1) THEN
C --  CONVERT ANGLES TO DEGREES.

         CIFA = STORE(L1P1)
         CIFB = STORE(L1P1+1)
         CIFC = STORE(L1P1+2)
         CIFAL = STORE(L1P1+3)
         CIFBE = STORE(L1P1+4)
         CIFGA = STORE(L1P1+5)

         STORE(L1P1+3)=RTD*STORE(L1P1+3)
         STORE(L1P1+4)=RTD*STORE(L1P1+4)
         STORE(L1P1+5)=RTD*STORE(L1P1+5)
         CALL XZEROF (ESD,6)
         IF (JLOAD(10).GE.1) THEN
C----- SCALE DOWN THE ELEMENTS OF THE V/CV MATRIX
            SCALE=STORE(L31K)
            M31=L31
            ESD(1)=SQRT(STORE(M31)*SCALE)
            ESD(2)=SQRT(STORE(M31+6)*SCALE)
            ESD(3)=SQRT(STORE(M31+11)*SCALE)
            ESD(4)=SQRT(STORE(M31+15)*SCALE)*RTD
            ESD(5)=SQRT(STORE(M31+18)*SCALE)*RTD
            ESD(6)=SQRT(STORE(M31+20)*SCALE)*RTD
         END IF
         IF ( IPUNCH .EQ. 2 ) THEN
            WRITE (NCPU,'(''<TABLE>'')')
         END IF
         M1P1=L1P1
         DO 700 I=1,3
C----- VALUE AND ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(M1P1),ESD(I),-3,0,7,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (NCFPU1,600) CCELL(I)(1:1),CBUF(1:N)
600           FORMAT ('_cell_length_',A,T35,A)
            ELSE IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(3+I,1)(:),'(A,17X,A)')CCELL(I)(1:1),CBUF(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,601)     CCELL(I)(1:1), CBUF(1:N)
601           FORMAT('<TR><TD>',A,' =</TD><TD>',A,' &Aring;</TD>')
            END IF

            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(M1P1+3),ESD(I+3),-2,0,7,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            J=INDEX(CBUF(1:N),'.')
            IF (J.EQ.0) J=MAX(1,N)
            TEMP=STORE(M1P1+3)-INT(STORE(M1P1+3))
            IF (TEMP.LE.ZERO) N=MAX(1,J-1)
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (NCFPU1,650) CANG(I)(1:5),CBUF(1:N)
650           FORMAT ('_cell_angle_',A,T35,A)
            ELSE IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(3+I,2)(:),'(A,16X,A)') CANG(I)(1:5),CBUF(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,602)  CANG(I)(1:LEN_TRIM(CANG(I))),CBUF(1:N)
602           FORMAT('<TD>&',A,'; =</TD><TD>',A,'&deg;</TD></TR>')
            END IF
            M1P1=M1P1+1
700      CONTINUE

         VOL = V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA)

         CU=SQRT((VOL-V(CIFA+ESD(1),CIFB,CIFC,CIFAL,CIFBE,CIFGA))**2
     1        + (VOL-V(CIFA,CIFB+ESD(2),CIFC,CIFAL,CIFBE,CIFGA))**2
     2        + (VOL-V(CIFA,CIFB,CIFC+ESD(3),CIFAL,CIFBE,CIFGA))**2
     3        + (VOL-V(CIFA,CIFB,CIFC,CIFAL+ESD(4)*DTR,CIFBE,CIFGA))**2
     4        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE+ESD(5)*DTR,CIFGA))**2
     5        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA+ESD(6)*DTR))**2)

         CALL XFILL (IB,IVEC,16)
         CALL SNUM (VOL,CU,-2,0,8,IVEC)
         WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
         CALL XCRAS (CBUF,N)
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,750) CBUF(1:N)
750        FORMAT ('_cell_volume ',T35,A)
           CALL XPCIF (' ')
         ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(7,1)(:),'(A,10X,A)') 'Volume',CBUF(1:N)
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE>'')')
           WRITE (NCPU,'(''<TABLE>'')')
           WRITE (NCPU,2) 'Volume',CBUF(1:N)//' &Aring;&sup3;'
         END IF
      END IF
C 
C----- LIST 2
C

      Z2 = 1
      IF (JLOAD(2).GE.1) THEN
         ICENTR=NINT(STORE(L2C))+1
         Z2 = STORE(L2C+3)
C----- CRYSTAL CLASS - FROM LIST 2
         J=L2CC+MD2CC-1
         WRITE (CTEMP,800) (ISTORE(I),I=L2CC,J)
800      FORMAT (4(A4))
         CBUF=' '
         CALL XCCLWC (CTEMP(2:),CBUF(2:))
         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         J = J - 1
         IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(3,1)(:),'(A,5X,A)') 'Crystal Class',CBUF(1:J)
         ELSE IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (CLINE,850) CBUF(1:J)
           CALL XPCIF (CLINE)
850        FORMAT ('_symmetry_cell_setting',T35,'''',A,'''')
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''<TR><TD>Crystal Class</TD><TD>'',
     1       A,''</TD></TR>'')') CBUF(1:J)
         END IF
C 
C ----- DISPLAY SPACE GROUP SYMBOL
         J=L2SG+MD2SG-1
         WRITE (CTEMP,900) (ISTORE(I),I=L2SG,J)
900      FORMAT (4(A4,1X))
         CBUF=' '
         CALL XCCLWC (CTEMP(2:),CBUF(2:))
         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         WRITE (CLINE,950) CBUF(1:J)
950      FORMAT ('_symmetry_space_group_name_H-M',T35,'''',A,'''')
CRicMay99 Changed 10X to 1X: CPAGE is only 35 chars wide so it is
C         easy to overflow with eg. 17 character spacegroup symbols.
C         This will spoil the formatting. Maybe it would be better
C         to compress whitespace.
         IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(3,2)(:),'(A,1X,A)') 'Space Group',CBUF(1:J)
         ELSE IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (CLINE)
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
C Subscript second number in screws: 21,31,32,41 etc.
           DO I=1,4     !Scan four times - more than enough.
             DO K=1,11
                J = KCCEQL(CBUF,1,CSSUBS(K))
                IF ( J .GT. 0 ) THEN
                  CBUF = CBUF(1:J)//CSSUBS(K)(2:2)//
     1             '<sub>'//CSSUBS(K)(3:3)//'</sub>'//CBUF(J+3:)
                END IF
             END DO
           END DO
           WRITE (NCPU,2) 'Space group', CBUF(1:LEN_TRIM(CBUF))
         END IF
 
         IF ( IPUNCH .EQ. 0 ) THEN
C DISPLAY EACH SYMMETRY OPERATOR
           WRITE (NCFPU1,1000)
1000       FORMAT ('loop_',/,' _symmetry_equiv_pos_as_xyz')
           DO I=L2,M2,MD2
             DO J=L2P,M2P,MD2P
               CALL XMOVE (STORE(I),STORE(NFL),12)
               DO K=1,ICENTR
C NEGATE IF REQUIRED
                  IF (K.EQ.2) CALL XNEGTR (STORE(I),STORE(NFL),9)
                  CALL XSUMOP (STORE(NFL),STORE(J),CTEMP,LENGTH,1)
                  CALL XCCLWC (CTEMP(1:LENGTH),CBUF(1:LENGTH))
                  WRITE (NCFPU1,1050) CBUF(1:LENGTH)
1050              FORMAT (1X,'''',A,'''')
               END DO
             END DO
           END DO
         END IF
C
         IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (' ')
           WRITE(CLINE,'(A)')'# choose from:  rm (reference molecule of'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')'# known chirality), ad (anomolous'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')'# dispersion - ie. Flack param), rmad '
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')'# (both rm and ad), syn (known from'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')'# synthetic pathway), unk (unknown)'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')'# or . (not applicable).'
           CALL XPCIF(CLINE)
           CALL XPCIF (' ')

           IF ( NINT ( STORE(L2C) ) .LE. 0 ) THEN
             WRITE (CLINE,1201) 'unk'
           ELSE
             WRITE (CLINE,1201) '.'
           END IF
1201       FORMAT ('_chemical_absolute_configuration',T35,'''',A,'''')
           CALL XPCIF(CLINE)
           CALL XPCIF (' ')
         END IF
      END IF

C 
C----- LIST 3
C 
      IF (JLOAD(3).GE.1) THEN
        IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,1250)
1250     FORMAT ('loop_'/'_atom_type_symbol'/'_atom_type_scat_dispersion
     1_real'/'_atom_type_scat_dispersion_imag'/'_atom_type_scat_Cromer_M
     2ann_a1'/'_atom_type_scat_Cromer_Mann_b1'/'_atom_type_scat_Cromer_M
     3ann_a2'/'_atom_type_scat_Cromer_Mann_b2'/'_atom_type_scat_Cromer_M
     4ann_a3'/'_atom_type_scat_Cromer_Mann_b3'/'_atom_type_scat_Cromer_M
     5ann_a4'/'_atom_type_scat_Cromer_Mann_b4'/'_atom_type_scat_Cromer_M
     6ann_c'/'_atom_type_scat_source  ')
           DO M3=L3,L3+(N3-1)*MD3,MD3
             WRITE (CTEMP,'(A4)') ISTORE(M3)
             CBUF=CTEMP(2:4)
             CALL XCCLWC (CBUF(1:3),CTEMP(2:4))
             WRITE (NCFPU1,1300) CTEMP(1:4),(STORE(M),M=M3+1,M3+11)
1300         FORMAT (1X,'''',A4,'''',4F10.4,/,7F10.4)
             WRITE (NCFPU1,1350)
1350         FORMAT ('''International_Tables','_Vol_IV_Table_2.2B''')
           END DO
        END IF
      END IF
C 
C----- COMPUTE PROPERTIES OF CELL
C 
      IF (JLOAD(1)*JLOAD(2)*JLOAD(3)*JLOAD(5)*JLOAD(8).NE.0) THEN
C 
         IEPROP=KCPROP(A)
C----- SAVE THE GOODIES IN LIST 30
         IF (JLOAD(9).GE.1) THEN
            STORE(L30GE+1)=A(1)
            STORE(L30GE+2)=A(5)
            STORE(L30GE+3)=A(3)
            STORE(L30GE+4)=A(4)
         END IF
      END IF
C 

C Sneaky early look at List 30 - need Z.

      Z30 = Z2
      IF ( JLOAD(9).EQ.1 ) THEN
         Z30=STORE(L30GE+5)
C Catch case where Z30 isn't set in L30 - assume = Z2.
         IF ( Z30 .LT. 0.00001 ) Z30 = Z2
      END IF

      NSUM=NINT(Z30)
      IF (AMOD(Z30,1.0).LE.ZERO) THEN
          WRITE (CTEMP,1600) NSUM
      ELSE
          WRITE (CTEMP,1650) Z30
      END IF
      CALL XCRAS (CTEMP,LENGTH)
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XPCIF (' ')
        CALL XPCIF (' ')
        WRITE (NCFPU1,'(''_cell_formula_units_Z '',T42, A)')
     1  CTEMP(1:LENGTH)
      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        WRITE (CPAGE(7,2)(:),'(A,19X,A)') 'Z ',CTEMP(1:LENGTH)
      ELSE IF ( IPUNCH .EQ. 2 ) THEN
        WRITE (NCPU,'(''<TR><TD>Z =</TD><TD>'',A,''</TD></TR>'')')
     1  CTEMP(1:LENGTH)
      END IF

      ZPRIME = Z30 / Z2

C----- CHECK IF LIST 5 LOADED
      IF (JLOAD(5).NE.1) GO TO 1750
C----- CHEMICAL FORMULA
CDJWMAR99[
      IBASE=KSTALL(NTERM*NNAMES)
      CALL XZEROF (STORE(IBASE),NTERM*NNAMES)
      ISTORE(IBASE)=ICARB
      STORE(IBASE+1)=0.0
      ISTORE(IBASE+NTERM)=IHYD
      STORE(IBASE+NTERM+1)=0.0
      NBASE=2
      DO 1500 M5=L5,L5+(N5-1)*MD5,MD5
C-----  GET THE CHARACTER FORM OF THE NAME, AS A UNIQUE CODE
         WRITE (CTYPE,'(A4)') ISTORE(M5)
         CALL XCRAS (CTYPE,NCHAR)
         ITEXT=100*INDEX(UPPER,CTYPE(1:1))+INDEX(UPPER,CTYPE(2:2))
C 
         DO J=IBASE,IBASE+(NBASE-1)*NTERM,NTERM
            IF (ISTORE(J).EQ.ISTORE(M5)) THEN
               STORE(J+1)=STORE(J+1)+STORE(M5+2)*STORE(M5+13)
               ISTORE(J+2)=J
               ISTORE(J+3)=ITEXT
               GO TO 1500
            END IF
         END DO
         J=IBASE+NBASE*NTERM
         ISTORE(J)=ISTORE(M5)
         STORE(J+1)=STORE(M5+2)*STORE(M5+13)
         ISTORE(J+2)=J
         ISTORE(J+3)=ITEXT
         NBASE=NBASE+1
1500  CONTINUE
C----- NOW SORT ON UNIQUE CODE, STARTTING AFTER (POSSIBLE) H
      I=IBASE+2*NTERM
      J=MAX(0,NBASE-2)
      K=NTERM
      L=4
      CALL SSORTI (I,J,K,L)
      J=1
      CLINE=' '
      JHTML=1
      CHLINE=' '
      DO 1700 I=IBASE,IBASE+(NBASE-1)*NTERM,NTERM
CDJWMAR99]
Cdjw NOV97
         IF (STORE(I+1).LE.ZERO) GO TO 1700
         ITYPE=ISTORE(I)
         WRITE (CTYPE,1550) ITYPE
1550     FORMAT (A4)
         CALL XCRAS (CTYPE,LENGTH)
         IF (LENGTH.GE.2) THEN
            CBUF=CTYPE(2:LENGTH)
            CALL XCCLWC (CBUF(1:LENGTH-1),CTYPE(2:LENGTH))
         END IF
         SUM=STORE(I+1) / ZPRIME
         NSUM=NINT(SUM)
         IF (AMOD(SUM,1.0).LE.ZERO) THEN
            WRITE (CTEMP,1600) NSUM
1600        FORMAT (I8)
         ELSE
            WRITE (CTEMP,1650) SUM
1650        FORMAT (F8.2)
         END IF
         CALL XCRAS (CTYPE,NCHAR)
         CALL XCRAS (CTEMP,LENGTH)
         CLINE(J:)=' '//CTYPE(1:NCHAR)//CTEMP(1:LENGTH)
         CHLINE(JHTML:)=' '//CTYPE(1:NCHAR)//'<sub>'//
     1                       CTEMP(1:LENGTH)//'</sub>'
         CALL XCREMS (CLINE,CLINE,J)
         CALL XCREMS (CHLINE,CHLINE,JHTML)
         CALL XCTRIM (CLINE,J)
         CALL XCTRIM (CHLINE,JHTML)
1700  CONTINUE
C

      IF ( IPUNCH .EQ. 0 ) THEN
        WRITE (NCFPU1,'(A,T35,A,A,A)') '_chemical_formula_sum','''',
     1  CLINE(1:J),''''
        WRITE (NCFPU1,'(A,T35,A,A,A)') '_chemical_formula_moiety','''',
     1  CLINE(1:J),''''
        WRITE (NCFPU1,'(''_chemical_compound_source'',                    
     1  /,'';''/''?''/'';'')')
      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        K=MIN(27,J)
        WRITE (CPAGE(2,1)(:),'(A,A)') 'Formula ',CLINE(1:K)
        IF (J.GE.28) THEN
          K=MIN(63,J)
          WRITE (CPAGE(2,2)(:),'(A)') CLINE(28:K)
        END IF
      ELSE IF ( IPUNCH .EQ. 2 ) THEN
        WRITE (NCPU,'(''<TR><TD>Formula</TD><TD>'',A,''</TD></TR>'')')
     1   CHLINE(1:JHTML)
      END IF
 
C----- LIST 30
1750  CONTINUE
 
      IF (JLOAD(9).GE.1) THEN
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (NCFPU1,'(''_chemical_formula_weight '',T35,F8.2)')
     1    STORE(L30GE+4) / ZPRIME
          CALL XPCIF (' ')
          CALL XPCIF (' ')
          CLINE(1:18)='_cell_measurement_'
          WRITE (NCFPU1,'(A18, ''reflns_used '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+3))
          WRITE (NCFPU1,'(A18, ''theta_min '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+4))
          WRITE (NCFPU1,'(A18, ''theta_max '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+5))
          WRITE (NCFPU1,'(A18, ''temperature '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+6))
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(9,2)(:),'(A,17X,F8.2)') 'Mr ',STORE(L30GE+4)
          WRITE (CPAGE(13,1)(:),'(A,5X,I6,A)') 'Cell from',
     1     NINT(STORE(L30CD+3)),' Reflections'
          WRITE (CPAGE(13,2)(:),'(A,9X,I3,'' to ''I3)') 'Theta range',
     1     NINT(STORE(L30CD+4)),NINT(STORE(L30CD+5))
          WRITE (CPAGE(10,2)(:),'(A,5X,I6)') 'Temperature (K)',
     1     NINT(STORE(L30CD+6))
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>M<sub>r</sub></TD><TD>'',
     1           F8.2,''</TD></TR>'')') STORE(L30GE+4)
          WRITE (NCPU,6) 'Cell determined from',NINT(STORE(L30CD+3)),
     1     ' reflections'
          WRITE (NCPU,'(''<TR><TD>Cell &theta; range =</TD><TD>'',
     1     I3,'' - '',I3,''&deg;</TD></TR>'')')
     2     NINT(STORE(L30CD+4)),NINT(STORE(L30CD+5))
          WRITE (NCPU,6) 'Temperature',NINT(STORE(L30CD+6)),'K'
          IF ( STORE(L30CF+12) .GT. 0.1 ) THEN
            WRITE (NCPU,6) 'Pressure ',NINT(STORE(L30CF+12)),' kPa'
          END IF
        END IF
 
 
        WRITE (CLINE,'(3X,8A4)') (ISTORE(K),K=L30SH,L30SH+MD30SH-1)
        CALL XCCLWC (CLINE(1:),CTEMP(1:))
        CALL XCTRIM (CTEMP,J)

        IF ( IPUNCH .EQ. 0 ) THEN
          CALL XPCIF (' ')
          CBUF(1:15)='_exptl_crystal_'
          WRITE (CLINE,'(A,''description '',T35,A,A,A)') CBUF(1:15),
     1     '''',CTEMP(1:J),''''
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(12,2)(:),'(A,2X,A)') 'Shape',CTEMP(1:J)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>Shape</TD><TD>'',A,''</TD></TR>'')')
     1    CTEMP(1:J)
        END IF
 
        WRITE (CLINE,'(3X,8A4)') (ISTORE(K),K=L30CL,L30CL+MD30CL-1)
        CALL XCCLWC (CLINE(1:),CTEMP(1:))
        CALL XCTRIM (CTEMP,J)
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (CLINE,'(A,''colour '',T35,A,A,A)') CBUF(1:15),'''',
     1     CTEMP(1:J),''''
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(12,1)(:),'(A,1X,A)') 'Colour',CTEMP(1:J)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>Colour</TD><TD>'',A,''</TD></TR>'')')
     1     CTEMP(1:J)
        END IF
 
        IF ( IPUNCH .EQ. 0 ) THEN
          DO I=1,3
            WRITE(CLINE,'(A,''size_'', A,T35,F5.2)')CBUF(1:15),CSIZE(I),
     1       STORE(L30CD+I-1)
            CALL XPCIF (CLINE)
          END DO
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(11,1)(:),'(A,13X,F5.2,''x'',F5.2,''x'',F5.2)')
     1     'Size',STORE(L30CD),STORE(L30CD+1),STORE(L30CD+2)
        ELSE IF ( IPUNCH .EQ.2 ) THEN
          WRITE (NCPU,'(''<TR><TD>Size</TD><TD>'',
     1   F5.2,'' &times; '',F5.2,'' &times; '',F5.2,'' mm</TD></TR>'')')
     1     STORE(L30CD),STORE(L30CD+1),STORE(L30CD+2)
        END IF

        IF ( IPUNCH .EQ. 0 ) THEN
          CALL XPCIF (' ')
          WRITE (CLINE,'(A,''density_diffrn'',T35,F6.3)') CBUF(1:15),
     1    STORE(L30GE+1)
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(9,1)(:),'(A,17X,F5.2)') 'Dx',STORE(L30GE+1)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>D<sub>x</sub></TD><TD>'',F5.2,
     1    '' Mg m<sup>-3</sup></TD></TR>'')') STORE(L30GE+1)
        END IF
 
        IF ( IPUNCH .EQ. 0 ) THEN
          IF (STORE(L30GE).GT.ZERO) THEN
            WRITE (CLINE,'(A,''density_meas'',T35,F6.3)') CBUF(1:15),
     1       STORE(L30GE)
          ELSE
            WRITE (CLINE,1850) CBUF(1:15),'density_meas','?'
1850        FORMAT (A,A,T35,A)
            CALL XPCIF (CLINE)
          END IF
C
          WRITE (CLINE,'(''# Non-dispersive F(000):'')')
          CALL XPCIF (CLINE)
          WRITE (CLINE,'(A,''F_000'',T35,F13.3)')CBUF(1:15),
     1           STORE(L30GE+2)
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>F000</TD><TD>'',F13.3,
     1                ''</TD></TR>'')')  STORE(L30GE+2)
        END IF
 
        CBUF(1:15)='_exptl_absorpt_'
 
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (CLINE,'(A,''coefficient_mu'',T35,F10.3)')CBUF(1:15),
     1     0.1*STORE(L30GE+3)
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(10,1)(:),'(A,13X,F9.3)') 'Mu',0.1*STORE(L30GE+3)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>&mu;</TD><TD>'',F9.3,
     1        '' mm<sup>-1</sup></TD></TR> '')') 0.1*STORE(L30GE+3)
        END IF

C      THE ABSORPTION DETAILS - ASSUME NO PATH ALONG AXIS!
        TMAX=EXP(-0.1*STORE(L30GE+3)*STORE(L30CD))
        TMIN=EXP(-0.1*STORE(L30GE+3)*STORE(L30CD+1))
        IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (CLINE,'(''# Sheldrick geometric definitions'',
     1     T35,2F8.2)')
     1     TMIN,TMAX
           CALL XPCIF (CLINE)
           CALL XPCIF (' ')
           CALL XPCIF (' ')
        END IF

        IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE>'')')
           WRITE (NCPU,'(''<H2>Data Collection</H2>'')')
           WRITE (NCPU,'(''<TABLE>'')')
        END IF

C----- PARAMETER 13 ON DIRECTIVE 2 IS A CHATACTER STRING: DIFFRACTOMETER MAKE
        IPARAM=13
        IDIR=2
        IVAL=ISTORE(L30CD+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)

C UNKNOWN CAD4 MACH3 KAPPACCD DIP SMART IPDS XCALIBUR
C    1     2       3     4    5     6    7   8
        IDIFNO = IVAL+1
        CALL XCREMS (CVALUE,CVALUE,NCHAR)
        CALL XCTRIM (CVALUE,NCHAR)
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA,1)(:),'(A,1X,A)') 'Diffractometer type',
     1     CVALUE(1:NCHAR)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''<TR><TD>Diffractometer</TD><TD>'',A,
     1       ''</TD></TR>'')')  CVALUE(1:NCHAR)
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           IF (IDIFNO .EQ. 1) THEN
C- UNKNOWN
             CTEMP='Unknown'
           ELSE IF (IDIFNO .EQ. 2) THEN
C- CAD4
             CTEMP='Enraf-Nonius CAD4'
           ELSE IF (IDIFNO .EQ. 3) THEN
C- MACH3
             CTEMP='Enraf-Nonius Mach3'
           ELSE IF (IDIFNO .EQ. 4) THEN
C- KAPPACCD
             CTEMP='Nonius Kappa CCD'
           ELSE IF (IDIFNO .EQ. 5) THEN
C- DIP
             CTEMP='Nonius DIP2000'
           ELSE IF (IDIFNO .EQ. 6) THEN
C- SMART
             CTEMP='Bruker SMART'
           ELSE IF (IDIFNO .EQ. 7) THEN
C- IPDS
             CTEMP='Stoe IPDS'
           ELSE IF (IDIFNO .EQ. 8) THEN
C- XCALIBUR
             CTEMP='Oxford Diffraction XCALIBUR'
           ELSE IF (IDIFNO .GT. IDIFMX) THEN
             WRITE(CMON,'(A)') 'Unknown Diffractometer type'
             CALL XPRVDU(NCVDU,1,0)
             CTEMP='Unknown'
             IDIFNO = 1
           ENDIF
           CALL XCTRIM (CTEMP,NCHAR)
C
           WRITE (CLINE,'(''_diffrn_measurement_device_type'' )') 
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
           WRITE (CLINE,'(A )') CTEMP(1:NCHAR)
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
C
           WRITE (CLINE,'(A)') 
     1     '_diffrn_radiation_monochromator      graphite'
           CALL XPCIF (CLINE)

        END IF
C
        IF ( IPUNCH .EQ. 0 ) THEN
           IVAL = IREFCD(1,IDIFNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_data_collection'' )')
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
           WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
        END IF
C
        IF ( IPUNCH .EQ. 0 ) THEN
           IVAL = IREFCD(2,IDIFNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_data_reduction'' )') 
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
           WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
        END IF
C
        IF ( IPUNCH .EQ. 0 ) THEN
           IVAL = IREFCD(3,IDIFNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_cell_refinement '' )') 
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
           WRITE (CLINE,'(A )') CTEMP(1:NCHAR)
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
        END IF
C
C----- DIRECT METHODS.
C----- PARAMETER 13 ON DIRECTIVE 6 IS A CHARACTER STRING
        IF ( IPUNCH .EQ. 0 ) THEN
           IPARAM=13
           IDIR=6
           IVAL=ISTORE(L30GE+IPARAM-1)
           IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1                  IVAL,JVAL,VAL,JTYPE)
           IVAL = ISOLCD(IVAL+1)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_structure_solution '' )') 
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
           WRITE (CLINE,'(A,A,A )') CTEMP(1:NCHAR)
           CALL XPCIF (CLINE)
           CALL XPCIF (';')
        END IF
C
C----- PARAMETER 10 ON DIRECTIVE 2 IS A CHARACTER STRING
C SCAN MODE DETAILS
        IPARAM=10
        IDIR=2
        IVAL=ISTORE(L30CD+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        CALL XCTRIM (CVALUE,NCHAR)
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA,2)(:),'(A,4X,A)') 'Scan type ',
     1      CVALUE(1:NCHAR)
C RIC2001 New scan types. Use IVAL, not char string.
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           IF ( IVAL .EQ. 1 ) THEN
&&DOSDVF            CVALUE = '\w/2\q'
&&GIDVAX            CVALUE = '\w/2\q'
&&LINGIL            CVALUE = '\\w/2\\q'
&WXS            CVALUE = '\\w/2\\q'
             CALL XCRAS (CVALUE,J)
           ELSE IF ( IVAL .EQ. 2 ) THEN
&&DOSVAX            CVALUE = '\w'
&&DVFGID            CVALUE = '\w'
&&LINGIL            CVALUE = '\\w'
&WXS            CVALUE = '\\w'
             CALL XCRAS (CVALUE,J)
           ELSE IF ( IVAL .EQ. 3 ) THEN
             CVALUE = '''\f scans'''
           ELSE IF ( IVAL .EQ. 4 ) THEN
&&DOSVAX             CVALUE = '''\f & \w scans'''
&&DVFGID             CVALUE = '''\f & \w scans'''
&&LINGIL             CVALUE = '''\\f & \\w scans'''
&WXS             CVALUE = '''\\f & \\w scans'''
           ELSE
             CVALUE = '?'
           END IF
           CLINE=' '
           WRITE (CLINE,'( ''_diffrn_measurement_method '',A)') CVALUE
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           IF ( IVAL .EQ. 1 ) THEN
              WRITE(NCPU,2)'Scan type','2&theta;/&omega; scans'
           ELSE IF ( IVAL .EQ. 2 ) THEN
              WRITE(NCPU,2)'Scan type','&omega; scans'
           ELSE IF ( IVAL .EQ. 3 ) THEN
              WRITE(NCPU,2)'Scan type','&phi; scans'
           ELSE IF ( IVAL .EQ. 4 ) THEN
              WRITE(NCPU,2)'Scan type','&phi; and &omega; scans'
           ELSE
              WRITE(NCPU,2)'Scan type','unknown'
           END IF
        END IF

C----- PARAMETER 9 ON DIRECTIVE 5 IS A CHARACTER STRING: ABSORPTION TYPE
        IPARAM=9
        IDIR=5
        IVAL=ISTORE(L30AB+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
C----- NOTE - WE CANNOT USE THE CRYSTALS CHARACTER STRING
        CMON(1) = ' '
        IF (TMIN.GT.3.0) THEN
            WRITE (CMON,'(A)') 'Analytical absorption correction mandato
     1ry for Acta C'
        ELSE IF (TMIN.GT.1.0) THEN
            WRITE (CMON,'(A,A)') 'A psi, empirical, multi-scan or analyt
     1ical absorption ','correction should be applied for Acta C'
        END IF
        IF (CMON(1)(1:1) .NE. ' ') THEN
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
            IF ( IPUNCH .EQ. 0 ) CALL XPCIF('# '//CMON(1)(:))
        ENDIF
        IVAL = MIN (IABSMX, IVAL + 1)
C NONE          1
C DIFABS        2
C EMPIRICAL     3
C MULTI-SCAN    4
C SADABS        5
C SORTAV        6
C SHELXA        7
C GAUSS         8
C ANALYT        9
C NUMER        10
C INTEGERATION 11
C SPHERICAL    12
C CYLINDRICAL  13
        IF (IVAL.EQ.1) THEN
            CVALUE='none'
            J=0
        ELSE IF ((IVAL.EQ.2).OR.(IVAL.EQ.7)) THEN
            CVALUE='refdelf'
            J=6
        ELSE IF (IVAL.EQ.3) THEN
            IF (L13DT.EQ.9) THEN
C           AREA DETECTOR
               CVALUE='multi-scan'
               J=2
            ELSE
               CVALUE='psi-scan'
               J=4
            END IF
        ELSE IF ((IVAL.GE.4).AND.(IVAL.LE.6)) THEN
C           AREA DETECTOR
            CVALUE='multi-scan'
            J=2
        ELSE IF (IVAL.EQ.8) THEN
            CVALUE='gaussian'
            J=0
        ELSE IF (IVAL.EQ.9) THEN
            CVALUE='analytical'
            J=0
        ELSE IF (IVAL.EQ.10) THEN
            CVALUE='numerical'
            J=0
        ELSE IF (IVAL.EQ.11) THEN
            CVALUE='integration'
            J=0
        ELSE IF (IVAL.EQ.12) THEN
            CVALUE='sphere'
            J=0
        ELSE IF (IVAL.EQ.13) THEN
            CVALUE='cylinder'
            J=0
        ELSE
            CVALUE='?'
            J=0
        END IF
        CLINE=' '
        WRITE (CLINE,'( A, ''correction_type '',A)') CBUF(1:15),CVALUE
        IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+1,1)(:),'(A,5X,A)') 'Absorption type',
     1      CVALUE
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,2) 'Absorption correction', CVALUE
        END IF
C 
C
        IF (J.GT.0) THEN
C-----   A FIX IN THE ABSENCE OF REAL INFO
            IF (STORE(L30AB+1+J) .LE. ZERO) THEN
              STORE(L30AB+1+J) = TMAX
              STORE(L30AB+J)  = TMIN
            ENDIF
            CLINE=' '
            WRITE (CLINE,'( A, ''process_details '')') CBUF(1:15)
            IF ( IPUNCH .EQ. 0 ) CALL XPCIF (CLINE)
            IVAL = IABSCD(IVAL)
            CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
            CALL XCTRIM (CTEMP,NCHAR)
            IF ( IPUNCH .EQ. 0 ) THEN
              CALL XPCIF (';')
              WRITE (CLINE,'(A,A,A )') CTEMP(1:NCHAR)
              CALL XPCIF (CLINE)
              CALL XPCIF (';')
            END IF
            DO I=1,3,2
              IF ( IPUNCH .EQ. 0 ) THEN
                WRITE (CLINE,'(A,''correction_T_'', A, F8.2)')
     1           CBUF(1:15),CSIZE(I),
     2           STORE(L30AB-1+J+(I+1)/2) / STORE(L30AB+1+J) * TMAX
                CALL XPCIF (CLINE)
              ELSE IF ( IPUNCH .EQ. 1 ) THEN
                WRITE (CPAGE(IDATA+1,2)(:),'(A,2X,2F5.2)')
     1           'Transmission range',
     2           STORE(L30AB-1+J+(1+1)/2)/STORE(L30AB+1+J)*TMAX,
     3           STORE(L30AB-1+J+(3+1)/2)/STORE(L30AB+1+J)*TMAX
              END IF
            END DO
        ELSE
           IF ( IPUNCH .EQ. 0 ) THEN
             WRITE (CLINE,'(A,''correction_T_'', A, F8.2)') CBUF(1:15),
     1        CSIZE(1),TMIN
             CALL XPCIF (CLINE)
             WRITE (CLINE,'(A,''correction_T_'', A, F8.2)') CBUF(1:15),
     1        CSIZE(3),TMAX
             CALL XPCIF (CLINE)
           ELSE IF ( IPUNCH .EQ. 1 ) THEN
             WRITE (CPAGE(IDATA+1,2)(:),'(A,2X,2F5.2)')
     1        'Transmission range',TMIN,TMAX
           ELSE IF ( IPUNCH .EQ. 2 ) THEN
             WRITE (NCPU,3)'T<sub>min</sub>',TMIN
             WRITE (NCPU,3)'T<sub>max</sub>',TMAX
           END IF
        END IF
C 
        IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (' ')
           CBUF(1:18)='_diffrn_standards_'
C 
           WRITE (CLINE,'(A, ''interval_time '',I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+10))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''interval_count '',I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+11))
           CALL XPCIF (CLINE)
C 
           WRITE (CLINE,'(A, ''number '', I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+7))
           CALL XPCIF (CLINE)
C 
           WRITE (CLINE,'(A, ''decay_% '', F6.2)') CBUF(1:18),
     1      STORE(L30CD+8)
           CALL XPCIF (CLINE)
           CALL XPCIF (' ')
C 
           WRITE (NCFPU1,'(''_diffrn_ambient_temperature '',I10)')
     1      NINT(STORE(L30CD+6))

           IF ( STORE(L30CF+12) .GT. 0.1 ) THEN
             WRITE (NCFPU1,'(''_diffrn_ambient_pressure '',I10)')
     1       NINT(STORE(L30CF+12))
           END IF
C 
           CBUF(1:15)='_diffrn_reflns_'
C 
           CLINE=' '
           WRITE (CLINE,'(A, ''number '', I10)') CBUF(1:15),
     1      NINT(STORE(L30DR))
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+2,1)(:),'(''Reflections measured '', I8)')
     1      NINT(STORE(L30DR))
           WRITE (CPAGE(14,1)(:),'(''Standard Interval '',I8)')
     1      NINT(STORE(L30CD+11))
           WRITE (CPAGE(14,2)(:),'(''Standard Count '',3X, I8)')
     1      NINT(STORE(L30CD+7))
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
            WRITE (NCPU,4) 'Reflections measured', NINT(STORE(L30DR))
        END IF
 
        IF (STORE(L30DR+4).LE.ZERO) THEN
C----- FRIEDELS LAW USED
           I=2
        ELSE
           I=4
        END IF
        J=MIN(NINT(STORE(L30DR+I)),NINT(STORE(L30DR)))
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+2,2)(:),
     1      '(''Independent reflections'',I7)') J
           WRITE (CPAGE(IDATA+3,1)(:),'(''Rint '', 14X,F10.4)')
     1      STORE(L30DR+1+I)*.01
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,4) 'Independent reflections', J
           WRITE (NCPU,5) 'Rint ', STORE(L30DR+1+I)*.01
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           CLINE=' '
           WRITE (CLINE,'(''_reflns_number_total '')')
           CTEMP(1:)=CLINE(1:15)
           WRITE (CLINE(22:),'(I10)') J
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''av_R_equivalents '', F10.2)')
     1      CBUF(1:15), STORE(L30DR+1+I)
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,I6)')
     1      '# Number of reflections with Friedels Law is ',
     2      NINT(STORE(L30DR+2))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,I6)')
     1      '# Number of reflections without Friedels Law is ',
     2      NINT(STORE(L30DR+4))
           CALL XPCIF (CLINE)
C----- TRY FOR A FRIEDEL MERGE ESTIMATE
           IF (STORE(L30DR+2).GT.ZERO) I=2
           IF (JLOAD(2)*JLOAD(1).GE.1) THEN
             TMP= 8. * ( (PI*STORE(L1P1+6)) / (6.*(3-(I/2))*N2P*N2)
     1       *((2. * SIN(DTR*STORE(L30IX+7)))/STORE(L13DC))**3)
             IF (TMP.GT.ZERO) THEN
               WRITE (CLINE,'(A,I6)')
     1          '# Theoretical number of reflections is about',NINT(TMP)
               CALL XPCIF (CLINE)
             END IF
           END IF
           CALL XPCIF (' ')
           CALL XPCIF (' ')
        END IF

        INRIC = 0

        CALL XTHLIM (THMIN,  THMAX,THMCMP,  THBEST,THBCMP, INRIC, IULN)

        IF ( IPUNCH .EQ. 0 ) THEN
           CBUF(1:21)='_diffrn_reflns_theta_'
           WRITE (CLINE,'(A,''min '', F10.3)') CBUF(1:21), THMIN
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,''max '', F10.3)') CBUF(1:21), THMAX
           CALL XPCIF (CLINE)
           CBUF(9:32)='measured_fraction_theta_'
           WRITE (CLINE,'(A,''max '',F10.3)') CBUF(1:32), THMCMP
           CALL XPCIF (CLINE)

           CALL XPCIF (' ')

           CBUF(9:21)='reflns_theta_'
           WRITE (CLINE,'(A,''full '', F10.3)') CBUF(1:21), ABS(THBEST)
           CALL XPCIF (CLINE)
           CBUF(9:32)='measured_fraction_theta_'
           WRITE (CLINE,'(A,''full '',F10.3)') CBUF(1:32), THBCMP
           CALL XPCIF (CLINE)

           CALL XPCIF (' ')
           CALL XPCIF (' ')
           CBUF(1:15)='_diffrn_reflns_'
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+3,2)(:),'(''Theta max '', 10X,              
     1     f10.2)') STORE(L30IX+7)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,5) '&theta;<sub>max</sub>', STORE(L30IX+7)
        END IF
 
C----- RELECTION LIMITS IN DATA COLLECTION
        K=0
        DO I=1,3
           DO J=1,3,2
             IF ( IPUNCH .EQ. 0 ) THEN
               WRITE (CLINE,'(A, ''limit_'',A,A, I10)') CBUF(1:15),
     1          CINDEX(I),CSIZE(J),NINT(STORE(L30IX+K))
               CALL XPCIF (CLINE)
             END IF
             K=K+1
           END DO
           IF ( IPUNCH .EQ. 1 ) THEN
             WRITE (CPAGE(IDATA+I+3,1)(22:),'(2I6)')
     1        NINT(STORE(L30IX+K-2)),NINT(STORE(L30IX+K-1))
           ELSE IF ( IPUNCH .EQ. 2 ) THEN
610      FORMAT ('<TR><TD>',A,'</TD><TD>',I4,' &rarr; ',I4,'</TD></TR>')
             WRITE (NCPU,610) CINDEX(I)(1:1)//' = ',
     1       NINT(STORE(L30IX+K-2)),NINT(STORE(L30IX+K-1))
           END IF
        END DO

 
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+4,1)(1:15),'(A)') 'Hmin, Hmax'
           WRITE (CPAGE(IDATA+5,1)(1:15),'(A)') 'Kmin, Kmax'
           WRITE (CPAGE(IDATA+6,1)(1:15),'(A)') 'Lmin, Lmax'
        END IF


        IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE>'')')
           WRITE (NCPU,'(''<H2>Refinement</H2>'')')
           WRITE (NCPU,'(''<TABLE>'')')
        END IF

        IF ( IPUNCH .EQ. 0 ) THEN
           IF (JLOAD(12).GE.1) THEN  !REFLECTION LIMITS IN COMPUTATIONS
             JLOAD(11)=1
             M6DTL=L6DTL
             IF (N6DTL.GE.4) THEN
               DO I=1,3    !LOOP OVER EACH INDEX
                  IF (STORE(M6DTL+3)-ZERO) 2250,2150,2150 !CHECK DETAIL SET
2150              CONTINUE   ! PRINT THE DETAILS
                  K=0
                  DO J=1,3,2
                     WRITE (CLINE,'(''_reflns_limit_'',A,A, I10)')
     1                CINDEX(I),CSIZE(J),NINT(STORE(K+M6DTL))
                     K=K+1
                     CALL XPCIF (CLINE)
                  END DO
2250              CONTINUE
                  M6DTL=M6DTL+MD6DTL  !UPDATE FOR THE NEXT PARAMETER
               END DO
             END IF
           END IF
        END IF

        IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (' ')
           CALL XPCIF (' ')

           CBUF(1:21)='_refine_diff_density_'
           J=1
           IF( ( ABS(STORE(L30RF+5)) .LT. 0.000001 ) .AND.
     1       ( ABS(STORE(L30RF+5)) .LT. 0.000001 ) ) THEN
             DO K=1,2
               WRITE (CLINE,'(A, A,1X,A)') CBUF(1:21),CSIZE(J), '?'
               CALL XPCIF (CLINE)
               J=J+2
             END DO
           ELSE
             DO K=1,2
               WRITE (CLINE,'(A, A, F10.2)') CBUF(1:21),CSIZE(J),
     1         (STORE(L30RF+4+K))
               CALL XPCIF (CLINE)
               J=J+2
             END DO
           END IF
           CALL XPCIF (' ')
           CALL XPCIF (' ')

           IF ( STORE(L30RF+3) .LT. -9.9 ) THEN
             LCUTUS = 0
           ELSE
             LCUTUS = 1
           END IF


           CBUF(1:11)='_refine_ls_'
C 
           WRITE (CLINE,'(A, ''number_reflns '', I10)') CBUF(1:11),
     1      NINT(STORE(L30RF+8))
           CALL XPCIF (CLINE)

           WRITE (CLINE,'(A, ''number_restraints '', I10)') CBUF(1:11),
     1      NINT(STORE(L30CF+13))
           CALL XPCIF (CLINE)
C 
           WRITE (CLINE,'(A, ''number_parameters '', I10)') CBUF(1:11),
     1      NINT(STORE(L30RF+2))
           CALL XPCIF (CLINE)
C
           CALL XPCIF (' ')
           WRITE (CLINE,'(''#'',A,''R_factor_ref '',F10.4)') CBUF(1:11),
     1              STORE(L30RF+0)*0.01
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(A, ''wR_factor_ref '', F10.4)') CBUF(1:11),
     1              STORE(L30RF+1)*0.01
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(A, ''goodness_of_fit_ref '', F10.4)')
     1      CBUF(1:11),STORE(L30RF+4)
           CALL XPCIF (CLINE)
C
           CALL XPCIF (' ')
           WRITE (CLINE,'(''#_reflns_number_all '', I10)')
     1      NINT(STORE(L30CF+5))
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(''_refine_ls_R_factor_all '', F10.4)')
     1      STORE(L30CF+6)*0.01
           CALL XPCIF (CLINE)
C 
           WRITE (CLINE,'(''_refine_ls_wR_factor_all '', F10.4)')
     1      STORE(L30CF+7)*0.01
           CALL XPCIF (CLINE)
C
           CALL XPCIF (' ')
           IF ( LCUTUS .EQ. 0 ) THEN
             WRITE (NCFPU1,1)
     1       '# No actual I/u(I) cutoff was used for refinement. The'
             WRITE (NCFPU1,1)
     1       '# threshold below is used for "_gt" information ONLY:'
           ELSE
             WRITE (NCFPU1,
     1    '(''# The I/u(I) cutoff below was used for refinement as '')')
             WRITE (NCFPU1,
     1      '(''# well as the _gt R-factors:'')')
           END IF
C
           WRITE(CBUF, '(''I>'',F6.2,''u(I)'')') STORE(L30CF+0)
           CALL XCRAS (CBUF,NCHAR)
           WRITE (NCFPU1,'(''_reflns_threshold_expression '',T35,A)')
     1     CBUF(1:NCHAR)
C
           WRITE (CLINE,'(''_reflns_number_gt '', I10)')
     1     NINT(STORE(L30CF+1))
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(''_refine_ls_R_factor_gt '', F10.4)')
     1     STORE(L30CF+2)*0.01
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(''_refine_ls_wR_factor_gt '', F10.4)')
     1     STORE(L30CF+3)*0.01
           CALL XPCIF (CLINE)
C
C
           CBUF(1:11)='_refine_ls_'
C
           CALL XPCIF (' ')
           CALL XPCIF (' ')
           WRITE (CLINE,'(A, ''shift/su_max '', F10.6)') CBUF(1:11),
     1      STORE(L30RF+7)
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
C 
           WRITE (CPAGE(IREF+3,1)(:),'(A,6X,F10.2)') 'Delta Rho min',
     1      STORE(L30RF+5)
           WRITE (CPAGE(IREF+3,2)(:),'(A,7XF10.2)') 'Delta Rho max',
     1      STORE(L30RF+6)
           WRITE (CPAGE(IREF+4,1)(:),'(A,3X,I10)') 'Reflections used',
     1      NINT(STORE(L30RF+8))
           WRITE (CPAGE(IREF+4,2)(:),'(A,6X,F10.2)') 'sigma(I) limit',
     1      STORE(L30RF+3)
           WRITE (CPAGE(IREF+5,1)(:),'(A,I9)') 'Number of parameters',
     1      NINT(STORE(L30RF+2))
           WRITE (CPAGE(IREF+5,2)(:),'(A,5X,F10.3)') 'Goodness of fit',
     1      STORE(L30RF+4)
           WRITE (CPAGE(IREF+1,1)(:),'(A,11X,F10.3)') 'R-factor',
     1      STORE(L30RF)*0.01
           WRITE (CPAGE(IREF+1,2)(:),'(A,3X,F10.3)')'Weighted R-factor',
     1      STORE(L30RF+1)*0.01
           WRITE (CPAGE(IREF+2,2)(:),'(A,8X,F10.4)') 'Max shift/su',
     1      STORE(L30RF+7)

        ELSE IF ( IPUNCH .EQ. 2 ) THEN
 
           WRITE (NCPU,7) '&Delta;&rho;<sub>min</sub> =',
     1      STORE(L30RF+5), ' e &Aring;<sup>-3</sup>'
           WRITE (NCPU,7) '&Delta;&rho;<sub>max</sub> =',
     1      STORE(L30RF+6), ' e &Aring;<sup>-3</sup>'
           WRITE (NCPU,4) 'Reflections used',NINT(STORE(L30RF+8))
           WRITE (NCPU,7) 'Cutoff: I > ', STORE(L30RF+3), '&sigma;(I)'
           WRITE (NCPU,4) 'Parameters refined',NINT(STORE(L30RF+2))
           WRITE (NCPU,7) 'S = ', STORE(L30RF+4), ''
           WRITE (NCPU,8) 'R-factor', STORE(L30RF)*0.01
           WRITE (NCPU,8) 'weighted R-factor', STORE(L30RF+1)*0.01
           WRITE (NCPU,5) '&Delta;/&sigma;<sub>max</sub>',STORE(L30RF+7)
        END IF
C 
        IF (STORE(L30GE+7).GT.ZERO) THEN
            IF (STORE(L30GE+6).GT.0.5+ZERO) THEN
               WRITE (CMON,2400)
2400           FORMAT ('The Flack parameter is greater than 0.5','The st
     1ructure may need inverting')
               CALL XPRVDU (NCVDU,1,0)
            END IF
C----- PACK UP THE FLACK PARAMETER AND ITS ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(L30GE+6),STORE(L30GE+7),-0,0,7,IVEC)
            WRITE (CTEMP,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CTEMP,N)
              
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (CLINE,'(A, ''abs_structure_Flack  '', 4X, A )')
     2         CBUF(1:11),CTEMP(1:N)
              CALL XPCIF (CLINE)
            ELSE IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(IREF+7,1)(:),'(A,A)') 'Flack parameter',
     1         CTEMP(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,2) 'Flack parameter',
     1         CTEMP(1:N)
            END IF
 
            WRITE (CTEMP,'(I12)') MAX(0,NINT(STORE(L30DR+4)-STORE(L30DR+
     1       2)))
            CALL XCRAS (CTEMP,N)
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (CLINE,'(A, ''abs_structure_details  '', 4X,          
     1        ''''''Flack, '',                                            
     2        A, '' Friedel-pairs'''''')') CBUF(1:11),CTEMP(1:N)
              CALL XPCIF (CLINE)
            END IF
        END IF
C 
C      THE REFINEMENT DETAILS
C----- PARAMETER 13 ON DIRECTIVE 3 IS A CHARACTER STRING
        IPARAM=13
        IDIR=3
        IVAL=ISTORE(L30RF+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        IF (IVAL.EQ.1) THEN
            CTYPE='F'
        ELSE
            CTYPE='Fsqd'
        END IF
        CLINE=' '
        IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (CLINE,'( A, ''structure_factor_coef '',A)')
     1      CBUF(1:11), CTYPE
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IREF,1)(:),'(A,A)') 'Refinement on ',CTYPE
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           JFCOEF = IVAL
           IF ( JFCOEF .EQ. 1 ) THEN
             WRITE(NCPU,2)'Refinement on','F'
           ELSE
             WRITE(NCPU,2)'Refinement on','F&sup2;'
           END IF
        END IF
C 
C----- WEIGHTING SCHEME - LIST 4
C 
        IF (JLOAD(4).GT.0) THEN
            ITYPE=ISTORE(L4C)

            IF ( IPUNCH .EQ. 2 ) THEN

              call xsum04(0,ctext)

603   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,A,F10.3,'</TD></TR>')
604   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,'</TD></TR>')
605   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,A,F10.3,A,'</TD></TR>')
606   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,A,6(F10.3,A),'</TD></TR>')
607   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 A,A,F10.3,A,'</TD></TR>')

              JTYPE = ICON41
              IF (JTYPE .EQ. 3) THEN 
                IF (ISTORE(L23MN+1) .GE. 0) THEN 
                  IF (  (ITYPE .EQ. 10) .OR. (ITYPE .EQ. 11) .OR.
     1                  (ITYPE .EQ. 14) .OR. (ITYPE .EQ. 15) .OR.
     1                  (ITYPE .EQ. 17) .OR. (ITYPE .EQ. 16) ) THEN
                    JTYPE = 2
                  ELSE
                    JTYPE = 1
                    
                  ENDIF
                ELSE
                  JTYPE = 0
                ENDIF
              ENDIF

              CMOD = ' '
              IF ( JTYPE .EQ. 1 )
     1              CMOD = '(1/4F<sub>obs</sub>&sup2;) &times; '

              CFM  = 'F<sub>obs</sub>'
              CFMC = 'F<sub>calc</sub>'
              IF ( JTYPE .EQ. 2 ) THEN
                   CFM  = 'F<sub>obs</sub>&sup2;'
                   CFMC = 'F<sub>calc</sub>&sup2;'
              END IF

              CWT = 'w = '
              IF ( IROBUS .EQ. 1 ) THEN
                 CWT = 'w&prime; ='
                 CMOD = ' '
              END IF

              IF ( IDUNIT .EQ. 1 ) THEN
                 CWT = 'w&prime; ='
                 CMOD = ' '
              END IF

              LMOD = MAX(1,LEN_TRIM(CMOD))
              LFM  = MAX(1,LEN_TRIM(CFM))

              SELECT CASE (ITYPE)

              CASE (1)
                 WRITE(NCPU,603) CWT,CMOD(1:LMOD),
     1           '('//CFM(1:LFM)//'/',STORE(L4),
     1           ')&sup2;, if '//CFM(1:LFM)//' <= ',STORE(L4)
                 WRITE(NCPU,603) CWT,CMOD(1:LMOD),
     1           '(',STORE(L4),
     1           '/'//CFM(1:LFM)//')&sup2;, if '//CFM(1:LFM)//' > ',
     1           STORE(L4)
              CASE (2)  
                 WRITE(NCPU,604) CWT, CMOD(1:LMOD),
     1           '1 if '//CFM(1:LFM)//' <= ',STORE(L4)
                 WRITE(NCPU,603) CWT, CMOD(1:LMOD),
     1           '(',STORE(L4),
     2           '/'//CFM(1:LFM)//')&sup2;, if '//CFM(1:LFM)//' > ',
     3           STORE(L4)
              CASE (3)
                 WRITE(NCPU,605) CWT, CMOD(1:LMOD),
     1            '(1+[('//CFM(1:LFM)//' - ',
     2            STORE(L4+1), ')/', STORE(L4),
     3           ']&sup2;)<sup>-1</sup>'
              CASE (4)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '[P<sub>1</sub>&times;'//CFM(1:LFM)//') + '//
     2           'P<sub>2</sub>&times;'//CFM(1:LFM)//'&sup2; + ...'//
     3           ' + P<sub>n</sub>&times;'//CFM(1:LFM)//'<sup>n</sup>]'
     4           //'<sup>-1</sup>'
                 WRITE(NCPU,2) 'P<sub>1</sub> - P<sub>n</sub> = ',
     1           CTEXT(4)
              CASE (5,6)
                 WRITE(NCPU,2) 'w = ',
     1            'user supplied weights - please elaborate.'
              CASE (7)
                 WRITE(NCPU,2) CWT,
     1            CMOD(1:LMOD)//'1/&sigma;('//CFM(1:LFM)//')'
              CASE (8)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '1/&sigma;&sup2;('//CFM(1:LFM)//')'
              CASE (9)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//'1'
              CASE (11)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '[P<sub>0</sub>T<sub>0</sub>&prime;(x) + '//
     2           'P<sub>1</sub>T<sub>1</sub>&prime;(x) + ...'//
     3           'P<sub>n-1</sub>T<sub>n-1</sub>&prime;(x)]'//
     4           '<sup>-1</sup>,<br>where P<sub>i</sub> are the '//
     5           'coefficients of a Chebychev series in '//
     6           't<sub>i</sub>(x), and x = '//CFM(1:LFM)//'/'//
     7           CFM(1:LFM)//'<sub>max</sub>.'
                 WRITE(NCPU,2) 'P<sub>0</sub> - P<sub>n-1</sub> = ',
     1           CTEXT(4)
              CASE (12)
                 WRITE(NCPU,607) CWT,CMOD(1:LMOD),
     1            '[sin&theta;/&lambda;]<sup>',
     2           STORE(L4),'</sup>'
              CASE (13)
                 WRITE(NCPU,605) 'w =',CMOD(1:LMOD),
     1            '[old-weight] &times; '//
     2            'e<sup>[8&times;(',STORE(L4),'/',STORE(L4+1),
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
              CASE (15)
                 WRITE(NCPU,2) 'w =',CMOD(1:LMOD)//
     1           'w&prime; &times; [1 - (&Delta;F<sub>obs</sub> / '//
     2           '6 &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w&prime; =',
     1           '[P<sub>0</sub>T<sub>0</sub>&prime;(x) + '//
     2           'P<sub>1</sub>T<sub>1</sub>&prime;(x) + ...'//
     3           'P<sub>n-1</sub>T<sub>n-1</sub>&prime;(x)]'//
     4           '<sup>-1</sup>,<br>where P<sub>i</sub> are the '//
     5           'coefficients of a Chebychev series in '//
     6           't<sub>i</sub>(x), and x = '//CFMC(1:LFM+1)//'/'//
     7           CFMC(1:LFM+1)//'<sub>max</sub>.'
                 WRITE(NCPU,2) 'P<sub>0</sub> - P<sub>n-1</sub> = ',
     1           CTEXT(4)
              CASE (16)
                 IF ( ABS(STORE(L4+2)).LT.ZERO ) THEN
                    CBUF = '1/'
                 ELSE IF (STORE(L4+2).GT.0) THEN
                    WRITE (CBUF,'(A,F10.4,A)') 'e<sup>',STORE(L4+2),
     1              ' &times; (sin(&theta;)/&lambda;)&sup2;</sup>'
                 ELSE
                    WRITE (CBUF,'(A,F10.4,A)') '1 - e<sup>',STORE(L4+2),
     1              ' &times; (sin(&theta;)/&lambda;)&sup2;</sup>'
                 END IF
                 WRITE(NCPU,606) CWT,CMOD(1:LMOD),
     1            CBUF(1:LEN_TRIM(CBUF)),
     1          '[&sigma;&sup2;('//CFM(1:LFM)//') + (',
     2          STORE(L4),' &times; P)&sup2; + ',STORE(L4+1),
     3          ' &times; P + ', STORE(L4+3), ' + ', STORE(L4+4),
     4          ' &times; sin&theta;],<br>P = ',STORE(L4+5),
     5          ' &times; max('//CFM(1:LFM)//',0) + ', 1-STORE(L4+5),
     6          ' &times; '//CFMC(1:LFM+1)
              END SELECT

              CMOD = ' '
              IF ( JTYPE .EQ. 1 )
     1              CMOD = '(1/4F<sub>obs</sub>&sup2;) &times; '
              LMOD = MAX(1,LEN_TRIM(CMOD))

              IF ( ( IROBUS .EQ. 1 ) .AND. ( IDUNIT. EQ. 1 ) ) THEN
                 WRITE(NCPU,605) 'w&prime;&prime; = ',
     1            ' ',
     2            'e<sup>[8&times;(',DUN01,'/',DUN02,
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
                 WRITE(NCPU,607) 'w&prime;&prime;&prime; =',
     1           '[1 - ','(&Delta;F<sub>obs</sub> / ',
     2           ROBTOL,
     3           ' &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime; &times; '//
     2           'w&prime;&prime;&prime;'
              ELSE IF ( IROBUS .EQ. 1 ) THEN
                 WRITE(NCPU,607) 'w&prime;&prime; =',
     1           '[1 - ','(&Delta;F<sub>obs</sub> / ',
     2           ROBTOL,' &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime;'
              ELSE IF ( IDUNIT .EQ. 1 ) THEN
                 WRITE(NCPU,605) 'w&prime;&prime; = ',
     1            '',
     2            'e<sup>[8&times;(',DUN01,'/',DUN02,
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime;'
              END IF
              WRITE (NCPU,'(''</TABLE>'')')
            END IF



            IF (ITYPE.EQ.9) THEN
C------ UNIT WEIGHTS
              IF ( IPUNCH .EQ. 0 ) THEN
                WRITE (CLINE,'(A)') 
     1 '# WARNING. The IUCr will not accept Unit Weights'
                CALL XPCIF (CLINE)
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme calc'')')CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ELSE IF ((ITYPE.EQ.5).OR.(ITYPE.EQ.6).OR.(ITYPE.EQ.7).OR.
     1       (ITYPE.EQ.8)) THEN
C------ SIGMA WEIGHTS
              IF ( IPUNCH .EQ. 0 ) THEN
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme sigma'')')
     1           CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ELSE 
              IF ( IPUNCH .EQ. 0 ) THEN
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme calc'')')CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ENDIF
            IF ( IPUNCH .EQ. 0 ) THEN
              CLINE=' '
              WRITE (CLINE,'(A, ''weighting_details '')') CBUF(1:11)
              CALL XPCIF (CLINE)
              WRITE (NCFPU1,'('';'')')
              call xsum04(0,ctext)
              ival = 0
              if ((itype .eq. 10) .or.  (itype .eq. 11)) then
                ival = 12
              else if ((itype .eq. 14) .or. (itype .eq. 15)) then
                ival = 35
                ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
                call xctrim (ctemp,nchar)
                write (cline,'(a,a )') 'Method, part 1, ', 
     1          ctemp(1:nchar)
                call xpcif (cline)
                write(cline,'(a,a)')  
     1 '[weight] = 1.0/[A~0~*T~0~(x)+A~1~*T~1~(x)',
     2 ' ... +A~n-1~]*T~n-1~(x)]'
                call xpcif (cline)
                write (cline,'(a,a)') 
     1 'where A~i~ are the Chebychev coefficients listed below',
     2 ' and x = Fcalc/Fmax'
                call xpcif (cline)
               ival = 38
             else if ((itype .eq. 16) .or.  (itype .eq. 17)) then
                ival = 34
              endif
              if (ival .ne. 0 ) then     
                ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
                call xctrim (ctemp,nchar)
                write (cline,'(a,a )') 'Method = ', ctemp(1:nchar)
                call xpcif (cline)
              else
                call xpcif(ctext(1))
              endif
              call xpcif(ctext(2))
              call xpcif(ctext(3))
              call xpcif(ctext(4))
              write (ncfpu1,'('';'')')
            END IF
        END IF
      END IF
C 
      IF (JLOAD(6).GE.1) THEN
         CBUF(1:5)=''' ? '''
         IF (NINT(10.*STORE(L13DC)).EQ.7) THEN
###LINGILWXS            CBUF(1:8) = '''Mo K\a'''
&&&LINGILWXS            CBUF(1:8) = '''Mo K\\a'''
         ELSE IF (NINT(10.*STORE(L13DC)).EQ.15) THEN
###LINGILWXS            CBUF(1:8) = '''Cu K\a'''
&&&LINGILWXS            CBUF(1:8) = '''Cu K\\a'''
         END IF
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,'(''_diffrn_radiation_type       '', T35, A)')
     1      CBUF(1:8)
           WRITE (NCFPU1,'(''_diffrn_radiation_wavelength '', T35,
     1      F12.5)') STORE(L13DC)
         ELSE  IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(8,1)(:),'(A,4X,A)') 'Radiation type',CBUF(2:7)
           WRITE (CPAGE(8,2)(:),'(A,5X,F10.6)')'Wavelength',STORE(L13DC)
         END IF
      END IF

      IF ( IPUNCH .EQ. 0 ) THEN
         CALL XPCIF (' ')
         CALL XPCIF (' ')
C - NOW LIST THE REFERENCES
         WRITE (CLINE,'( A)') 
     1 '## -------------------REFERENCES ----------------------##'
         CALL XPCIF (CLINE)
         WRITE (CLINE,'( A)') 
     1 '## Insert your own references - in alphabetic order'
         CALL XPCIF (CLINE)
         WRITE (CLINE,'( A)') 
     1 '_publ_section_references '
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         CALL XREFPR (ISTORE(LREFS),NREFS,MDREFS)
         CALL XPCIF (';')
      END IF
 
 
2550  CONTINUE

      IF ( IPUNCH .EQ. 1 ) THEN
##GIDWXS      WRITE (NCPU,'(A)') CHAR(12)
        WRITE (NCPU,'(5X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=1,NROW)
C----- ONLY 29 LINES USED IN PAGE  - CMON IS CURRENLTY 24
        WRITE (CMON,'(X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=1,24)
        CALL XPRVDU (NCVDU,24,1)
        WRITE (CMON,'(X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=25,29)
        CALL XPRVDU (NCVDU,5,1)
      END IF

C      WRITE LIST 30 BACK TO DISK (after THLIM calc)
      IF (JLOAD(9).GE.1) CALL XWLSTD (30,ICOM30,IDIM30,-1,-1)

      GO TO 2650
C----- ERROR EXIT
2600  CONTINUE
C 
2650  CONTINUE
      IF (IEPROP.NE.1) THEN
         WRITE (CMON,2700)
2700     FORMAT (' Error in computing molecular properties',/' Re-input 
     1expected composition - #SCRIPT INCOMP')
         CALL XPRVDU (NCVDU,2,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A,A)') CMON(1),CMON(2)
      END IF
C----- CLOSE THE 'CIF' OUTPUT FILE
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XRDOPN (7,KDEV,CSSCIF,LSSCIF)
C      CLOSE THE REFERENCES FILE
###LINGILWXS       CALL XRDOPN(7,JDEV,'CRYSDIR:script\reftab.dat', 25)
&&&LINGILWXS       CALL XRDOPN(7,JDEV,'CRYSDIR:script/reftab.dat', 25)
      END IF
      RETURN
      END

CODE FOR XPCIF
      SUBROUTINE XPCIF(CLINE)
C----- COMPRESS AND PUNCH THE STRING CLINE
      CHARACTER *(*) CLINE
      CHARACTER *80 CTEMP, CTEMP2
\XUNITS
      CTEMP = ''
      CTEMP2 = ''

      CALL XCREMS (CLINE, CTEMP, NCHAR)
      K = KHKIBM(CTEMP)
      CALL XCTRIM (CTEMP, NCHAR)

C If line starts with _ try to line up data in col 35. (if present).
      IF (CTEMP (1:1) .EQ. '_') THEN
           IDNM = KCCEQL(CLINE,1,' ')
C Check that data will fit into 80 chars if tabbed to col 35.
           IF ( ( NCHAR - IDNM .GT. 45 ) .OR. ( IDNM .GT. 34 ) ) THEN
C It won't:
             WRITE(CTEMP2,'(A)') CTEMP
           ELSE IF ( NCHAR - IDNM .LE. 0 ) THEN
C There is no extra data:
             WRITE(CTEMP2,'(A)') CTEMP
           ELSE
C It will:
             WRITE(CTEMP2,'(A,T35,A)') CTEMP(1:IDNM),CTEMP(IDNM+1:NCHAR)
           ENDIF
      ELSE
           WRITE (CTEMP2,'(A)') CTEMP
      END IF

      CALL XCTRIM (CTEMP2, NCHAR)
      WRITE(NCFPU1, '(A)') CTEMP2(1:NCHAR)
      RETURN
      END

CODE FOR CREFMK
      CHARACTER *(*) FUNCTION CREFMK(ITAB, NTAB, MDTAB, IVAL)
C----- MARK A REFERENCE AS BEING USED
C      RETURNS WITH BRIEF REFERENCE
C      ITAB - TABLE IF IDENTIFIERS AND BRIEF NAMES
C      NTAB AND MDTAB NUMBER OF IDENTIFIERS, LENGTH OF EACH
C      IVAL IDENTIFIER TO BE MARKED AS USED
      DIMENSION ITAB(MDTAB*NTAB)
      CHARACTER *80 CTEMP
\XUNITS
\XSSVAL
\XIOBUF
      CREFMK = ' '      
      IF (NTAB.LE. 0) GOTO 980
      DO 100 I = 1, 1+(NTAB-1)*MDTAB,MDTAB
       IF (ITAB(I+1) .EQ. IVAL) THEN
            ITAB(I) = 1
             WRITE(CTEMP,'(19A4)') (ITAB(J),J=I+2,I+MDTAB-1) 
             CREFMK = CTEMP
            GOTO 980
       ENDIF
100   CONTINUE
      WRITE(CMON,'('' Reference '', i4, '' not found'')')IVAL
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ.0) WRITE(NCWU,'(A)') CMON(1)(:)
980   CONTINUE
      RETURN
      END
C
CODE FOR XREFPR
      SUBROUTINE XREFPR(ITAB, NTAB, MDTAB)
C----- PRINT OUT THE USED-REFERENCES
      DIMENSION ITAB(MDTAB*NTAB)
      CHARACTER *80 CBUF
\XUNITS
\XSSVAL
\XIOBUF
      REWIND (NCARU)
      IF (NTAB.LE. 0) GOTO 900
      DO 100 I = 1, 1+(NTAB-1)*MDTAB,MDTAB
c      write(cbuf,'(2i4)') istore(i), istore(I+1)
c      call zmore(cbuf,0)
      IF (ITAB(I) .EQ. 1) THEN
50     CONTINUE
       READ(NCARU,'(A)',END=900,ERR=900) CBUF
       IF (CBUF(1:1) .EQ. '#') THEN
            READ (CBUF,'(1X,I3)') J
            IF (J .EQ. ITAB(I+1)) THEN
               CALL XPCIF(' ')
C               WRITE(CMON,'(1X)') 
C               CALL XPRVDU(NCVDU,1,0)
               WRITE(CBUF,'(19A4)') (ITAB(K),K=I+2,I+MDTAB-1)
C               CALL XPCIF(CBUF)
C               WRITE(CMON,'(A)') CBUF
C               CALL XPRVDU(NCVDU,1,0)
               CALL XPCIF(' ')
60             CONTINUE
               READ(NCARU,'(A)',END=900,ERR=900) CBUF
               IF ((CBUF(1:1) .EQ. ' ') .OR. (CBUF(1:1) .EQ. '#'))
     1         GOTO 90
               CALL XPCIF(CBUF)
C                WRITE(CMON,'(A)') CBUF
C                CALL XPRVDU(NCVDU,1,0)
               GOTO 60 
            ENDIF
        ENDIF
        GOTO 50
      ENDIF
90    CONTINUE
100   CONTINUE
      RETURN
900   CONTINUE
&&&GIDGILWXS      CALL ZMORE ('Premature end',0)
      RETURN
      END
