C $Log: not supported by cvs2svn $
C Revision 1.39  2004/11/24 11:28:20  stefan
C 1. Removed a cpu_time and print statment for measuring the time it takes to run sflsc.
C
C Revision 1.38  2004/11/18 16:48:51  stefan
C 1. Added code to create a paramlist from the bonded atoms.
C 2. Added code to using the param list to accumerlat the paramlist
C 3. Added some code to time sflsc
C
C Revision 1.37  2004/10/11 10:37:10  djw
C Output enantiomer & high GOF info to listinf file
C
C Revision 1.36  2004/10/01 08:25:39  rich
C Fixed syntax errors (AlOl).
C
C Revision 1.35  2004/09/30 15:52:57  rich
C Uh-oh. SFLS reorganised quite a lot.
C
C Revision 1.34  2004/06/17 10:31:25  rich
C Add computation and plotting of Prince t^2/(1+Pii) values to the SFLS
C routine. (Only called if REFINE LEV=n where n>0 is specified).
C
C Revision 1.33  2004/05/13 15:26:21  rich
C Make SFLS do a leverage plot if correct incantation is specified.
C
C Revision 1.32  2004/04/16 09:42:28  rich
C Added code to compute leverages of individual reflections, instead of accummulating
C a new normal matrix. (Requires matching inverted normal matrix from a previous cycle).
C
C Revision 1.31  2004/03/24 15:03:39  rich
C Fixed: U[iso] too small message was never output due to linefeed in FORMAT statement.
C (Symptom: lots of blank lines output, followed by 'n temperature factors too small' message).
C
C Revision 1.30  2003/02/14 17:09:02  djw
C Extend codes to work wih list 6 and list 7.  Note that sfls, calc and
C recine have the parameter ityp06, which corresponds to the types
C pickedip for lists 6 and 7  from the command file
C
C Revision 1.29  2003/01/15 15:26:39  rich
C Removal of NCAWU calls throught the standard SFLS refinement instruction. If
C anywhere will benefit from less IO, it's here.
C
C Revision 1.28  2003/01/15 13:50:35  rich
C Remove all output to NCAWU as part of an ongoing project.
C
C Revision 1.27  2002/12/04 14:31:11  rich
C Reformat output during refinement.
C
C Allow punching to MATLAB files, including restraints.
C
C Tidy some routines.
C
C Revision 1.26  2002/10/31 13:27:53  rich
C
C Two changes: Default I/u(I) cutoff is now 2.0 when called from RESULTS.
C The calculation of R_gt and R_all now respect all L28 cutoffs EXCEPT
C the I/u(I) minimum value. This is more like the IUCr definition (which
C states that these values should respect the theta limits.) The IUCr don't
C mention OMITted reflections, but it's unlikely anyone wants these in
C the R_gt and R_all values.
C
C Revision 1.25  2002/09/27 14:43:46  rich
C Overwrite L5 when updating SCALE factor only.
C Some placeholder comments for Flack's unplaced e- density stuff.
C
C Revision 1.24  2002/07/15 11:58:14  richard
C Update L30 R and Rw for refinement when doing a CALC. (A calc is done during
C CIF production which ensures that these values are truly uptodate.)
C
C Revision 1.23  2002/06/07 16:06:06  richard
C New MODE parameter for SFLSB, set to -1, when called from the CIF code, it
C recalculates R-factors at either the L28 cutoff sigma value, or if there is no
C cutoff in L28, the at I>4u(I). These R-factors are store in L30 (CALC-R, etc).
C
C Also indented and simplified some of the code a bit.
C
C Revision 1.22  2002/03/18 10:01:22  richard
C Minor bug in CALC THRESHOLD fixed.
C
C Revision 1.21  2002/03/12 18:03:55  ckp2
C Only print "unwise" warning when twinned data, if user actually attempts extinction
C calculation.
C
C Revision 1.20  2002/03/11 12:06:11  Administrator
C enable axtinction and twinning, hightlight warning about inadvisability
C
C Revision 1.19  2002/03/06 15:35:53  Administrator
C Fix a format statement, enable Extinction and TWINS to be refined together
C
C Revision 1.18  2002/02/12 12:54:49  Administrator
C Allow filtering of reflections in SFLS/CALC
C
C Revision 1.17  2002/02/01 14:41:30  Administrator
C Enable CALC to get additional R factors and display them in SUMMARY
C
C Revision 1.16  2001/10/08 12:25:59  ckp2
C
C All program sub-units now RETURN to the main CRYSTL() function inbetween commands.
C The changes made are: in every sub-program the GOTO's that used to loop back for
C the next KNXTOP command have been changed to RETURN's. In the main program KNXTOP is now
C called at the top of the loop, but first the current ProgramName (KPRGNM) array is cleared
C to ensure the KNXTOP knows that it is not in the correct sub-program already. (This
C is the way KNXTOP worked on the very first call within CRYSTALS).
C
C We now have one location (CRYSTL()) where the program flow returns between every command. I will
C put this to good use soon.
C
C Revision 1.15  2001/08/14 10:47:06  ckp2
C FLOAT(NINT()) all indices transformed by L25 twinning matrices just in case
C the twin law doesn't quite bring them onto an integer. (The user had better
C know what they are doing).
C
C Revision 1.14  2001/07/11 10:18:51  ckpgroup
C Enable -ve Flack Parameter
C
C Revision 1.13  2001/06/08 15:03:37  richard
C Fix: Store F/F2 state from L23 into the correct slot in L30.
C
C Revision 1.12  2001/03/18 10:34:47  richard
C Sfls was updating wrong parameter in L30, overwriting structure soln with Rw.
C
C Revision 1.11  2001/03/16 16:54:55  CKP2
C Update list 30
C
C Revision 1.10  2001/03/02 17:03:46  CKP2
C djw put common block \xsfwk inti macrifile, and extend for (more!) cif
C items
C
C Revision 1.9  2001/02/26 10:29:08  richard
C Added changelog to top of file
C
C
CODE FOR XSFLSB
      SUBROUTINE XSFLSB (MODE, ITYP06)
C--MAIN CONTROL ROUTINE FOR THE S.F.L.S. ROUTINES
C
C--
C      IF MODE EQ -1, DON'T READ DATA STREAM, USE I/u(I)>2 if no value
C                                             in L28.
C      IF MODE EQ 0,  DON'T READ DATA STREAM, USE EXISTING L33 THRESHOLD
C      IF MODE EQ 1, READ DATA STREAM
C
C      ITYP06 - LIST TYPE INDICATOR. 1=6, 2=7
C
\TYPE11
\ISTORE
\ICOM30
\ICOM33
      CHARACTER *12 CTEMP
C
C
C
C
      DIMENSION IWORKA(17)
C
\STORE
\XCONST
\XLISTI
\XUNITS
\XSSVAL
\XUSLST
\XLST01
\XLST02
\XLST03
\XLST05
\XLST06
\XLST11
\XSTR11
\XLST12
\XLST13
\XLST22
\XLST23
\XLST28
\XLST25
\XLST30
\XLST33
\XERVAL
\XOPVAL
C
C
      DIMENSION JFRN(4,2)
C
C
\XSFWK
\XMTLAB
\XWORKB
\XSFLSW
\XIOBUF
\QSTORE
\QLST33
\QSTR11
\QLST30
C
C
C
      EQUIVALENCE (IWORKA(1),JI)
C----- V 810 INCLUDES THE SPECIAL SHAPES
      DATA JFRN /'F', 'R', 'N', '1',
     1           'F', 'R', 'N', '2'/
      DATA IVERSN /811/
      INTEGER PARAM_LIST_MAKE

C----- ACCEPT -VE FLACK PARAMETER
C----- USES DIFABS CORRECTION TO FC
C----- THE CODE HAS BEEN REORGANISED SO THAT FOR NONTWINNED REFINEMENT
C      THE CODE IS ALMOST CONTINUOUS. F**2 REFINEMENT HAS ALSO BEEN
C      LINEARISED.
C
      CALL XTIME1(1)
      ILEV = 0
      IF (MODE .LE. 0) THEN
C----- WE WONT READ ANY DATA, BUT WILL SET TYPE TO 'CALC'
            NUM = 3
      ELSE
C--LOAD THE NEXT '#INSTRUCTION'
            NUM=KNXTOP(LSTOP,LSTNO,ICLASS)
C--CHECK IF WE SHOULD RETURN
            IF(NUM.LE.0) RETURN
C--BRANCH ON THE TYPE OF OPERATION
            I=KRDDPV(ISTORE(NFL),1)
C--READ THE NEXT DIRECTIVE CARD
100         CONTINUE
            LAST=IDIR
            IDIR=KRDNDC(ISTORE(NFL),1)
C--CHECK THE REPLY
            IF(IDIR .GE. 0) THEN
C--ERROR CONDITION
            GOTO 9950
            ENDIF
C--END OF THE DIRECTIVES  -  CHECK FOR ANY ERRORS
250         CONTINUE
            IF ( LEF .NE. 0 ) GO TO 9950
C--SAVE THE LIST TYPE INDICATOR
            ITYP06=ISTORE(NFL)
      ENDIF


1105  CONTINUE
      CALL XZEROF(IWORKA(1),17)
      GOTO(1200,1250,1300,1350,4550,4600,1150),NUM
1150  CALL GUEXIT(54)

C--'#REFINE' HAS BEEN GIVEN
1200  CONTINUE
      SFLS_TYPE = SFLS_REFINE
      GOTO 1400
C
C--'#SCALE' HAS BEEN REQUESTED
1250  CONTINUE

      SFLS_TYPE = SFLS_SCALE
      GOTO 1400
C
C--'#CALCULATE' HAS BEEN GIVEN
1300  CONTINUE

      SFLS_TYPE = SFLS_CALC
      CALL XZEROF(RALL(1),12)
      RALL(1)=STORE(L33CD+5)
      GOTO 1400
C
C--'#CYCLENDS' INSTRUCTION
1350  CONTINUE
      CALL XCYCLE
      RETURN
C
C--SET THE VALUES FOR A S.F.L.S. CALCULATION
1400  CONTINUE
&PPCCS***
&PPC      CALL SETSTA( 'S.F.L.S.' )
&PPC      CALL nextcursor
&PPCCE***
      CALL XDUMP
C--CLEAR THE CORE
      CALL XRSL
C--LOAD LIST 13  -  THE EXPERIMENTAL CONDITIONS LIST
      CALL XFAL13
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--SET THE TWINNED/NON-TWINNED FLAG
      TWINNED = .FALSE.
      IF(ISTORE(L13CD+1).GE.0) TWINNED = .TRUE.
C--FIND THE TYPE OF RADIATION
      NU=ISTORE(L13DT+1)
C--FETCH THE POLARISATION CONSTANTS
      WAVE=STORE(L13DC)
      THETA1=STORE(L13DC+1)
      THETA2=STORE(L13DC+2)
C--LOAD LIST 23  -  DEFINES CONDITIONS FOR S.F.L.S. CALCULATIONS
      CALL XFAL23
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--SET THE ANOMALOUS DISPERSION FLAG
C SET TO -1 FOR NO ANOMALOUS DISPERSION, ELSE 0 Replaced by ANOMAL      
      ANOMAL = .FALSE.
      IF ( ISTORE(L23M) .EQ. 0 ) ANOMAL = .TRUE.
C--SET THE EXTINCTION FLAG
      EXTINCT = .FALSE.
      IF(ISTORE(L23M+1).GE.0) EXTINCT = .TRUE.
C--SET THE LAYER SCALES APPLICATION FLAG
      LAYERED=.FALSE.
      IF(ISTORE(L23M+2).GE.0) LAYERED = .TRUE.
C--SET THE BATCH SCALES APPLICATION FLAG
      BATCHED=.FALSE.
      IF (ISTORE(L23M+3).GE.0) BATCHED = .TRUE.
C--SET THE PARTIAL CONTRIBUTIONS FLAG
      PARTIALS = .FALSE.
      IF(ISTORE(L23M+4).GE.0) PARTIALS = .TRUE.
C--SET THE UPDATE PARTIAL CONTRIBUTIONS FLAG
      ND=ISTORE(L23M+5)
C----- SET THE ENANTIOPOLE REFINEMENT FLAG
      ENANTIO = .FALSE.
      IF ( ISTORE(L23M+6) .EQ. 0 ) ENANTIO = .TRUE.
C--SET THE FLAG FOR REFINEMENT AGAINST /FO/ OR /FO/ **2
      NV=ISTORE(L23MN+1)
C----- CHECK IF WE  NEED REFLECTIONS (-1 IF NOT)
      IREFLS = ISTORE(L23MN+3)
C--FIND THE MINIMUM ALLOWED TEMPERATURE FACTOR
      UMIN=STORE(L23AC+8)
C----- SAVE THE TOLERANCE AND UPDATE VALUES
      STOLER = STORE(L23SP+5)
      IUPDAT = ISTORE(L23SP+1)
C--CLEAR THE CORE OUT AGAIN
      CALL XRSL
      CALL XCSAE
C----- SAVE SOME SPACE FOR THE U AXES
      IADDU = KCHLFL (4)
C--LOAD LIST 33  -  THE CONDITIONS FOR THIS S.F.L.S. CALCULATION
      CALL XFAL33
      IF ( IERFLG .LT. 0 ) GO TO 9900
      IF ( SFLS_TYPE .EQ. SFLS_CALC ) THEN
         RALL(1)=STORE(L33CD+5)
      END IF

C If outputting design matrix and deltaF's then open files now.
       IF ( SFLS_TYPE .eq. SFLS_REFINE ) THEN     
       MATLAB = 0
       IF (ISTORE(L33CD+5).EQ.1) THEN
        MATLAB = 1
        CALL XRDOPN (5,JFRN(1,1),'design.m',8)
        WRITE (NCFPU1, '(''A=['')')
        CALL XRDOPN (5,JFRN(1,2),'wdf.m',5)
        WRITE (NCFPU2, '(''DF=['')')
       END IF

       ILEV = ISTORE(L33CD+12)
      END IF

      NF=-1
      REFPRINT = .FALSE.
C----- READ DOWN SOME LISTS
      CALL XFAL01
      CALL XFAL02
      CALL XFAL05
      CALL XFAL30
      IF (IERFLG .LT. 0) GOTO 9900
C
C--CHECK THAT ALL THE TEMPERATURE FACTORS ARE REASONABLE
C-C-C-CHECK THAT ALL T.F. AND SPECIAL PARAMETERS ARE REASONABLE
C-C-C-SIMILAR CHECKS ALSO IN XSFLSG (NO CHANGE OF LIST 5 BY XSFLSB)
      M5=L5
C--CHECK THAT THERE IS AT LEAST ONE ATOM IN LIST 5
      IF(N5 .LE. 0) GOTO 9940
C--LOOP OVER EACH ATOM
      A=0.0
      N=0
      DO I=1,N5   ! Safety checks
C-C-C-CHECK WHETHER ATOM IS ANISOTROPIC
        IF (ABS(STORE(M5+3)) .LE. UISO) THEN
C-C-C-CHECK ANISOTROPIC ATOMS
C--CHECK THE SMALLEST U AXIS
          CALL XEQUIV ( 1, M5, MD5, IADDU )
          IF (STORE(IADDU+1) .LT. UMIN) THEN
C--THIS ANISOTROPIC TEMPERATURE FACTOR IS NOT ALLOWED
            IF (ISSPRT .EQ. 0)
     1 WRITE(NCWU, 3110) STORE(M5),NINT(STORE(M5+1)),STORE(IADDU+1)
3110  FORMAT(' Atom ', A4, I5, ' has U-min too small, ', F8.4)
      WRITE ( CMON, 3110) STORE(M5),NINT(STORE(M5+1)),STORE(IADDU+1)
            CALL XPRVDU(NCVDU, 1,0)
            A=AMIN1(A,STORE(IADDU+1))
            N=N+1
            U = UMIN+ZERO
            STORE(M5+7) = AMAX1(U,STORE(M5+7))
            STORE(M5+8) = AMAX1(U,STORE(M5+8))
            STORE(M5+9) = AMAX1(U,STORE(M5+9))
            STORE(M5+10) = AMAX1(0.01*U,STORE(M5+10))*STORE(L1C)
            STORE(M5+11) = AMAX1(0.01*U,STORE(M5+11))*STORE(L1C+1)
            STORE(M5+12) = AMAX1(0.01*U,STORE(M5+12))*STORE(L1C+2)
          ENDIF
        ELSE
C-C-C-CHECK ISOTROPIC ATOM OR SPECIAL FIGURE
C--CHECK THE ISOTROPIC TEMPERATURE FACTOR
          IF(STORE(M5+7) .LE. UMIN) THEN
C--THIS U[ISO] VALUE IS OUT OF RANGE
            WRITE ( CMON, 3120)STORE(M5),NINT(STORE(M5+1)),STORE(M5+7)
            CALL XPRVDU(NCVDU, 1,0)
            IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1)(:)
3120        FORMAT( ' Atom ', A4, I5, ' has U-iso too small, ', F8.4)
            A=AMIN1(A,STORE(M5+7))
            N=N+1
            STORE(M5+7) = UMIN + ZERO
          ENDIF
C-C-C-CHECK OF SPECIAL FIGURE SPECIFIC PARAMETERS
          IF (NINT(STORE(M5+3)) .GE. 2) THEN
C-C-C-CHECK OF SIZE FOR ALL SPECIAL FIGURES
            IF (STORE(M5+8) .LT. 0.0005) THEN
              IF (ISSPRT .EQ. 0) THEN
                WRITE(NCWU,3130)STORE(M5),NINT(STORE(M5+1)),STORE(M5+8)
              ENDIF
3130          FORMAT(/,' Spec.Fig. ',A4,I5,' has SIZE too small:',F8.4,
     2           /,31X,'Reset to:  0.001',/,
     3           21X,'(in LIST 5 only in case of refinement !)')
              STORE(M5+8)=0.001
            ENDIF
C-C-C-CHECK OF DECLINAT AND AZIMUTH FOR LINE AND RING
            IF (NINT(STORE(M5+3)) .GE. 3) THEN
C-C-C-CHECK WHETHER DECLINAT MIGHT BE GIVEN IN DEGREES
C-C-C-(SUPPOSED IF ANGLES BIGGER THAN 5.0)
C-C-C-(THIS BLOCK CAN BE REMOVED WHEN IT IS MADE SURE THAT THE VALUE
C-C-C-OF ANGLES IS ALWAYS IN UNITS OF 100 DEGREES.)
              IF ((STORE(M5+9) .GE. 5.0).OR.(STORE(M5+9) .LE. -5.0))THEN
                IF (ISSPRT .EQ. 0) THEN
                 WRITE(NCWU,3140)STORE(M5),NINT(STORE(M5+1)),STORE(M5+9)
                ENDIF
3140            FORMAT(/,' Line/Ring ',A4,I5,' has DECLINAT probably',
     2          ' given in degrees: ', F8.4,/,
     3       21X,'Value devided by 100 to get units of 100 degrees',/,
     4       21X,'(in LIST 5 only in case of refinement !)')
                STORE(M5+9)=STORE(M5+9)/100
              ENDIF
C-C-C-BRING DECLINAT INTO PRACTICAL RANGE IF TOO FAR AWAY FROM IT
              IF ((STORE(M5+9).GT.3.6).OR.(STORE(M5+9).LT.-3.6)) THEN
                STORE(M5+9)=MOD(STORE(M5+9),3.6)
              ENDIF
              IF (STORE(M5+9) .GT. 1.8) THEN
                STORE(M5+9)=STORE(M5+9)-3.6
              ELSE IF (STORE(M5+9) .LT. -1.8) THEN
                STORE(M5+9)=STORE(M5+9)+3.6
              ENDIF
C-C-C-CHECK WHETHER DECLINAT IS CLOSE TO 0.0 OR +/-1.8
              IF ((ABS(STORE(M5+9)+1.8) .LT. 0.001) .OR.
     2            (ABS(STORE(M5+9)-1.8) .LT. 0.001) .OR.
     3            (ABS(STORE(M5+9)) .LT. 0.001)) THEN
C-C-C-PRINT WARNING, GIVE AZIMUTH ARBITRARY VALUE
                IF (ISSPRT .EQ. 0) THEN
                  WRITE(NCWU, 3145) STORE(M5),NINT(STORE(M5+1))
                ENDIF
3145       FORMAT(/,' Line/Ring ',A4,I5,' has DECLINAT = n*180.0 deg.',
     2            /,21X,'==> AZIMUTH is not defined !!!',
     3            /,    ' It is reset to an arbitrary value (0.0)',
     4                  ' and should not be refined !',
     5            /,' (change in LIST 5 only in case of refinement !)')
C-C-C-PERHAPS IT'S REASONABLE TO REMOVE THE AUTOMATICAL CHANGE
                STORE(M5+10) = 0.0
              ELSE
C-C-C-CHECK WHETHER AZIMUTH MIGHT BE GIVEN IN DEGREES
C-C-C-(SUPPOSED IF ANGLES BIGGER THAN 5.0)
C-C-C-(THIS BLOCK CAN BE REMOVED WHEN IT IS MADE SURE THAT THE VALUE
C-C-C-OF ANGLES IS ALWAYS IN UNITS OF 100 DEGREES.)
                IF ((STORE(M5+10).GE.5.0).OR.(STORE(M5+10).LE.-5.0))THEN
                  IF (ISSPRT .EQ. 0) THEN
                    WRITE(NCWU,3150)STORE(M5),NINT(STORE(M5+1)),
     1                                             STORE(M5+10)
                  ENDIF
3150              FORMAT(/,' Line/Ring ',A4,I5,' has AZIMUTH  probably',
     2                     ' given in degrees: ', F8.4,/,
     3        21X,'Value devided by 100 to get units of 100 degrees',/,
     4        21X,'(in LIST 5 only in case of refinement !)')
                  STORE(M5+10)=STORE(M5+10)/100
                ENDIF
C-C-C-BRING AZIMUTH INTO PRACTICAL RANGE IF TOO FAR AWAY FROM IT
                IF ((STORE(M5+10).GT.3.6).OR.(STORE(M5+10).LT.-3.6))THEN
                  STORE(M5+10)=MOD(STORE(M5+10),3.6)
                ENDIF
                IF (STORE(M5+10) .GT. 1.8) THEN
                  STORE(M5+10)=STORE(M5+10)-3.6
                ELSE IF (STORE(M5+10) .LT. -1.8) THEN
                  STORE(M5+10)=STORE(M5+10)+3.6
                ENDIF
              ENDIF
            ENDIF
          ENDIF
        ENDIF
        M5 = M5 + MD5
      END DO
C--CHECK IF THE T.F.'S ARE ALL OKAY
      IF (N .NE. 0) THEN
C -- INVALID TEMPERATURE FACTOR
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9935 ) N , UMIN , A
9935  FORMAT ( 1X , I6 , ' temperature factors less ' ,
     1 'than the lowest allowed value of ' , F10.5 ,
     2 /1X,' The minimum value  was ', F10.5)
      WRITE ( CMON, 9935) N, UMIN, A
      CALL XPRVDU(NCVDU, 2,0)
      ENDIF
      IF ((STORE(L5O+4) .GT. 1.) .OR. (STORE(L5O+4) .LT. 0.)) THEN
        WRITE ( CMON, 3320) STORE(L5O+4)
        CALL XPRVDU(NCVDU, 1,0)
        IF (ISSPRT .EQ. 0)  WRITE(NCWU, '(A)') CMON(1)(:)
3320    FORMAT(1X,'Enantiopole parameter out of range. (',F6.3,' ) ')
      END IF

      IF (STORE(L5O+5) .LT. -ZERO) THEN
        WRITE ( CMON, 3345) STORE(L5O+5)
        CALL XPRVDU(NCVDU, 1,0)
        WRITE(NCWU, '(A)') CMON(1)(:)
3345    FORMAT(1X,'Extinction parameter out of range. (',F6.3,' ) ')
        STORE(L5O+5) = -ZERO
      ENDIF

      IF (IUPDAT .GE. 0)  I = KSPINI( -1, STOLER) ! SET THE OCCUPANCIES
      NUPDAT = 0  
      J =NFL
      I = KCHNFL(40)  ! SAVE SOME WORK SPACE
      M5 = L5
      DO I = 1, N5   ! Set occupancies
        IF (IUPDAT .GE. 0) THEN
          IGSTAT =KSPGET ( STORE(J), STORE(J+10), ISTORE(J+20),
     2      STORE(J+30), MGM, M5, IUPDAT, NUPDAT)
        ELSE
          STORE(M5+13) = 1.0
        ENDIF
        M5 = M5 + MD5
      END DO
      NFL= J

      SCALE = STORE(L5O) 
      IF (SCALE .LE. 0.000001) THEN  ! CHECK THAT THE SCALE FACTOR GIVEN IS NOT ZERO
        IF (ISSPRT .EQ. 0) WRITE(NCWU,1420)
        WRITE ( CMON, 1420)
        CALL XPRVDU(NCVDU, 1,0)
1420    FORMAT(10X,' The overall scale factor has been set to 1.0' )
        SCALE = 1.   ! SCALE FACTOR IS UNREASONABLE  -  RESET IT TO 1.0
        STORE(L5O)=1.
        CALL XSTR05(5,-1,-1)
      ENDIF

      NEWLHS = .FALSE.  ! CHECK ON THE TYPE OF MATRIX TO USE
      IF ( ISTORE( M33CD + 6) .EQ. -1 ) NEWLHS = .TRUE.
      ISTAT2 = ISTORE (M33CD+3)  ! SET THE STORE MAP LEVEL

      IF ( IREFLS .GE. 0 ) THEN            ! Not Restraints only

         IF ( ISTORE(M33CD+2) .GT. 0 ) THEN  ! CHECK ON THE TYPE OF LISTING REQUIRED
           NF=0   ! COMPLETE LISTING, INCLUDING ELEMENT CONTRIBUTIONS FOR A TWIN
           REFPRINT = .TRUE.   ! LISTING OF EACH STRUCTURE FACTOR AS IT IS CALCULATED
         ELSE IF ( ISTORE(M33CD+2) .EQ. 0 ) THEN
           REFPRINT = .TRUE.   ! LISTING OF EACH STRUCTURE FACTOR AS IT IS CALCULATED
         END IF
         IF (TWINNED) THEN  ! CHECK IF THIS STRUCTURE IS TWINNED
            SCALED_FOT = .FALSE.
            IF(ISTORE(M33CD+4).GE.0) SCALED_FOT = .TRUE.   ! SCALED /FOT/ IS REQUIRED
         END IF

         CALL XFAL03    ! READ DOWN SOME LISTS
         IULN = KTYP06(ITYP06)  ! FIND THE REFELCTIONLIST TYPE
         CALL XFAL06(IULN,1)

         S6SIG = -10.0   ! SIGMA THRESHOLD
         IF ( MODE.EQ.-1 ) RALL(1) = 2.0
         IF ( N28MN .GT. 0 ) THEN
            INDNAM = L28CN
            DO I = L28MN , M28MN , MD28MN
               WRITE ( CTEMP , '(3A4)') (ISTORE(J), J = INDNAM,INDNAM+2)
               IF (INDEX(CTEMP,'RATIO') .GT. 0) THEN
                  S6SIG = STORE(I+1)
                  IF ( MODE.EQ.-1 ) RALL(1) = STORE(I+1)
               ENDIF
               INDNAM = INDNAM + MD28CN
            END DO
         END IF
         IF ( IERFLG .LT. 0 ) GO TO 9900

         CALL XIRTAC(6)   ! INITIALISE THE COLLECTION OF THE DETAILS FOR /FC/ AND PHASE
         CALL XIRTAC(7)
         CALL XIRTAC(16)

         N12=0  ! SET UP DEFAULT VALUES FOR THE REFLECTION HOLDING STACK
         N25=1


         IF ( .NOT. TWINNED ) THEN        ! THIS IS NOT A TWINNED REFINEMENT
           NF=-1
           IF(ND.GE.0) THEN  ! CHECK IF WE ARE UPDATING THE PARTIAL DERIVATIVES
             CALL XIRTAC(8)
             CALL XIRTAC(9)
           END IF

         ELSE                         ! THIS IS A TWINNED REFINEMENT

           IF ( EXTINCT ) THEN
             CALL OUTCOL(9)
             WRITE(CMON,'(6X,A)') 
     1       'It is unwise to refine extinction for twinned data'
             CALL XPRVDU(NCVDU, 1,0)
             IF (ISSPRT .EQ. 0) WRITE(NCWU,'(A)') CMON(1)
             CALL OUTCOL(1)
cdjw0302 - allow twin with extparam:  NA=-1
           END IF
           PARTIALS = .FALSE. ! SUPPRESS PARTIAL CONTRIBUTIONS
           ND=-1
           ENANTIO = .FALSE.  ! SUPPRESS ENANTIOPOLE REFINEMENT
           CALL XIRTAC(4)     ! INITIALISE THE DETAILS FOR /FO/

           IF(.NOT. REFPRINT) NF = -1          ! SUPPRESS ELEMENT PRINTING

           IF ( IERFLG .LT. 0 ) GO TO 9900
           CALL XFAL25                  ! LOAD THE TWIN OPERATORS

           IF ( MD5ES .NE. N25 ) GO TO 9910 ! CHECK THAT THE NUMBER OF OPERATORS EQUALS THE NUMBER OF ELEMENTS

           LN=LN5
           IREC=1001
           M5ES=NFL
           I=KCHNFL(MD5ES)
           J=M5ES
           K=L5ES
           DO I=1,MD5ES   ! FORM THE SQUARE ROOT OF THE ELEMENT SCALES
             IF (STORE(K) .LT. 0) THEN
               IF (ISSPRT .EQ. 0) WRITE(NCWU,2301) I, STORE(K)
               WRITE ( CMON, 2301)  I, STORE(K)
               CALL XPRVDU(NCVDU, 1,0)
2301           FORMAT(' Twin element error, Scale',I3,' = ',F8.4)
               STORE(K) = 0.0
             ENDIF
             STORE(J)=SQRT(STORE(K))
             J=J+1
             K=K+1
           END DO
         END IF
      END IF

      JQ=0

       IF ( SFLS_TYPE .NE. SFLS_REFINE ) THEN  ! NO REFINEMENT
        ISO_ONLY = .TRUE.
        JO = 1 ! Dummy space for derivatives
        JP = 1 ! Dummy space for derivatives

        IF(KSET52(-1,0).GE.0)THEN      ! SET THE T.F. VALUES IN LIST 5
          IF ( IERFLG .LT. 0 ) GO TO 9900
          ISO_ONLY = .FALSE.
        END IF
      ELSE                             ! REFINEMENT

        JQ=(2-IC)  ! SET UP THE STORAGE LOCATIONS FOR THE PARTIAL DERIVATIVES
        IF ( ANOMAL ) JQ = JQ * 2
        JQ=MAX0(JQ,2)
        LJS=-1

        CALL XFAL12(LJS,JQ,JR,JN)  ! LOAD LIST 12
        IF ( IERFLG .LT. 0 ) GO TO 9900
        ISO_ONLY = .TRUE. ! SET THE INITIAL DETAILS FOR LINKING LISTS 12 AND 5
        IF(KSET52(0,0).GE.0)THEN    ! LINK LIST 12 AND LIST 5
          IF ( IERFLG .LT. 0 ) GO TO 9900
          ISO_ONLY = .FALSE.  ! ! ANISO T.F.'S ARE STORED
        END IF
        IF ( IERFLG .LT. 0 ) GO TO 9900

        IF ( N12 .LE. 0 ) GO TO 9920  ! CHECK THERE ARE PARAMETERS TO REFINE
        JO=JR       ! SET UP THE STACK FOR THE COMPLETE PARTIAL DERIVATIVES
        JP=JO+N12-1

        IF ( ILEV .NE. 0 ) THEN  ! CHECK IF WE NEED THE L.H.S.
          CALL XSET11(0,1,1)  ! Need old matrices for working out leverage.
          IF ( IERFLG .LT. 0 ) GO TO 9900
        ELSE
          IF(NEWLHS) THEN           ! SET UP A NEW MATRIX   MATRIX=NEW (default)
            CALL XSET11(-1,1,1)
            IF ( IERFLG .LT. 0 ) GO TO 9900
            if (ISTORE(L33CD+13) .EQ. 0) then ! See if sparse is set to bond
               if (n12b .gt. 1) then ! if there is more than 1 block
                  write (cmon, 2350) 
 2350             format ('Sparse set to bond does not work',
     1             'with multipule blocks of data')
                  call XERHND(IERERR)
                  goto 9900
               endif
               iresults = nfl
               i = KCHNFL(N11)
               NRESULTS = param_list_make(istore(IRESULTS), n11, JR, 
     1              JQ)
            END IF
          ELSE                       ! WE ONLY NEED THE R.H.S. MATRIX=OLD (Old LHS will be loaded later)
            CALL XSET11(0,0,1)
            IF ( IERFLG .LT. 0 ) GO TO 9900
            M11R=L11R+N11R-1  
            DO I=L11R,M11R  ! CLEAR THE R.H.S. OF THE OLD NUMBERS
              STR11(I)=0.
            END DO
          END IF
        END IF
        
C--CHECK THAT THERE IS ROOM TO OUTPUT THE MATRIX
        CALL XCL11(11)
CC--INITIALISE THE MATRIX ACCUMULATION ROUTINES
Cc        CALL XSETMT

      END IF

C--LINK LIST 5 AND 3
C----- CHECK FOR RESTRAINTS ONLY
      IF (IREFLS .GE. 0) THEN
        N3=KSET53(0)+1
        IF ( IERFLG .LT. 0 ) GO TO 9900
      ENDIF
C
C----- CHECK IF REFLECTIONS SHOULD BE USED
      IF (IREFLS .LE. -1) THEN
            NT    = 0
            R     = 0.
            RW    = 0.
            WDFT  = 0.
            AMINF = 0.
            CYCNO = STORE(M33V) + 1
      ELSE
C--SET UP THE REFLECTION HOLDING STACK
        NR=4
        NY=20
        JREF_STACK_START=NFL
C--SET THE LIST AND RECORD TYPE
        LN=25
        IREC=1001

C N25 is the number of twin elements
C N12 is the number of parameters being refined
C JQ is the number of words needed to hold each derivative
C NY is 20
C NR is 4 = H,K,L,PSHIFT for each reflections
C N2I is the number of symmetry operators

        JREF_STACK_PTR = KCHNFL(N25*(N12*(JQ+1)+NY+NR*N2I)+1)
C--PREPARE TO INITIALISE THE STACK
        JREF_STACK_PTR = JREF_STACK_START+1
        NI = JREF_STACK_START
        NJ = (N2T-1)*NR

        DO I=1,N25      ! SET UP THE STACK
          ISTORE(NI)    = JREF_STACK_PTR   ! Ptr to next block
          NI            = JREF_STACK_PTR   ! Update ptr
          ISTORE(NI)    = NOWT             ! Indicate last block
          ISTORE(NI+1)  = JREF_STACK_PTR+NY   ! Ptr to start of derivs
          ISTORE(NI+2)  = ISTORE(NI+1)+N12-1  ! Ptr to end of derivs
          ISTORE(NI+18) = ISTORE(NI+2)+1      ! Ptr to start of ?
          ISTORE(NI+19) = ISTORE(NI+18)+N12*JQ-1  ! Ptr to end of ?
          ISTORE(NI+9)  = ISTORE(NI+19)+1
          ISTORE(NI+10) = ISTORE(NI+9)+NJ
          JREF_STACK_PTR= ISTORE(NI+10)+NR
          NL=ISTORE(NI+9) ! INSERT DUMMY INITIAL INDICES
          NM=ISTORE(NI+10)
          DO NN=NL,NM,NR
            STORE(NN)=-1000000.
            STORE(NN+1)=-1000000.
            STORE(NN+2)=-1000000.
            STORE(NN+3) = 0.0
          END DO
        END DO

        CALL XPRTCN               ! OUTPUT AN INITIAL CAPTION
        STORE(L6P)=STORE(L6P)+1.  ! FIND THE NUMBER OF CYCLES CALCULATED
        JI=NINT(STORE(L6P))
        CYCNO = STORE(L6P)

        IF (ISSPRT .EQ. 0) WRITE(NCWU,3600)JI  ! PRINT THE TITLE HEADING
3600  FORMAT(' Structure factor least squares',5X,
     2 ' calculation number',I6)

        IF(ISTAT2 .NE. 0) THEN   ! PRINT THE ALLOCATED CORE STORE IF NECESSARY
          CALL XPCM(1)
C--CHECK IF WE SHOULD DUMP ANY OTHER GOODIES
          IF(ISTAT2.GE.1) THEN 
            IF (ISSPRT .EQ. 0) WRITE(NCWU,3750)IWORKA
3750        FORMAT('IWK:',13I9)
            M2=L2+MD2*N2-1
            IF (ISSPRT .EQ. 0) WRITE(NCWU,3800)(STORE(I),I=L2,M2)
3800        FORMAT(1X,12F10.5)
            M2I=L2I+MD2I*N2I-1
            IF (ISSPRT .EQ. 0) WRITE(NCWU,3800)(STORE(I),I=L2I,M2I)
            M3=L3+MD3*N3-1
            IF (ISSPRT .EQ. 0) WRITE(NCWU,3850)(STORE(I),I=L3,M3)
3850        FORMAT(1X,A4,11F10.5)
            M5=L5+MD5*(N5-1)
            DO I=L5,M5,MD5
              L=I+2
              M=I+MD5-1
              IF (ISSPRT .EQ. 0) 
     1      WRITE(NCWU,3900)ISTORE(I),ISTORE(I+1),(STORE(K),K=L,M)
3900          FORMAT(1X,2I4,11F9.5)
            END DO

            IF(SFLS_TYPE .EQ. SFLS_REFINE) THEN
              CALL XPRINT(L22,L22+(MD22*N22)-1)
            END IF
          END IF
        END IF
        
        CALL XSFLSC ( STORE(JO), JP-JO+1, istore(iresults), nresults) ! CALL THE CALCULATION LINK
      ENDIF

      IF ( IERFLG .LT. 0 ) GO TO 9900
C--CHECK FOR L.S. REFINEMENT
      IF( SFLS_TYPE .EQ. SFLS_REFINE ) THEN  !STORE THE MATRIX
        STORE(L11P+23)=FLOAT(N12)      ! STORE THE NUMBER OF PARAMETERS
        STORE(L11P+24)=FLOAT(NT)       ! NUMBER OF REFLECTIONS THAT HAVE BEEN USED
        STORE(L11P+25)=WDFT            ! STORE THE SUM OF W*DF**2
        IF (ABS (RW) .LE. ZERO) THEN
            A =1.
        ELSE
            A = 100. / RW
        ENDIF
        STORE(L11P+26)=WDFT*A*A        ! STORE THE SUM OF W* /FO/ **2
        STORE(L11P+16)=STORE(L11P+24)-STORE(L11P+23)  ! NUMBER OF DEGREES OF FREEDOM
        STORE(L11P+17)=AMINF           ! STORE THE MINIMISATION FUNCTION
        CALL XCL11(11)                 ! OUTPUT LIST 11
        CALL XMKOWF(11,0)
        CALL XALTES(11,1)
      END IF
C--TERMINATE THE OUTPUT OF LIST 6  -  STORE THE R-VALUE

      IF (IREFLS .GE. 0) THEN
        STORE(L6P+1)=R
C--STORE THE WEIGHTED R-VALUE
        STORE(L6P+2)=RW
C--STORE THE MINIMISATION FUNCTION
        STORE(L6P+3)=AMINF
C--COMPUTE THE REFLECTION TOTALS FOR /FC/ AND PHASE
        CALL XCRD(6)
        CALL XCRD(7)
        CALL XCRD(16)
C--
        IF(TWINNED) CALL XCRD(4)  ! CHECK FOR A TWINNED REFINEMENT
      
        IF(ND.GE.0) THEN   ! CHECK IF WE HAVE UPDATED THE A AND B PARTS
          CALL XCRD(8)
          CALL XCRD(9) ! UPDATE THEIR DETAILS
        END IF

        CALL XMONTR(-1)  ! WRITE THE LIST TO THE DISC
        CALL XERT(IULN)
      END IF

      STORE(M33V) = CYCNO      ! UPDATE THE DETAILS FOR LIST 33
      STORE(M33V+1)=R
      STORE(M33V+2)=RW
      STORE(M33V+3)=0.
      STORE(M33V+4)=AMINF
\IDIM33

      CALL XWLSTD(33,ICOM33,IDIM33,-1,-1)   ! OUTPUT THE NEW LIST 33 TO DISC
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL30
      IF (KHUNTR (11,0, IADDL,IADDR,IADDD, -1) .EQ. 0) THEN
        STORE(L30RF +0 ) = R   ! 'REFINE' 
        STORE(L30GE +10 ) = R  ! UPDATE LIST 30
        STORE(L30RF +1 ) = RW
        STORE(L30GE +11 ) = RW
        IF(STORE(L11P+23) .GT.ZERO) STORE(L30RF +2 ) = STORE(L11P+23)
        IF (STORE(L11P+16) .GT. ZERO) THEN
          STORE(L30RF +4 ) = SQRT(AMINF / STORE(L11P+16))
        ENDIF

        STORE(L30RF +8 ) = STORE(L11P+24)  ! NUMBER OF REFLECTIONS USED
        STORE(L30GE +9 ) = STORE(L11P+24)

        IF ( SFLS_TYPE .NE. SFLS_REFINE )  THEN
            STORE(L30RF+3) = S6SIG  ! SIGMA THRESHOLD FOR REFINEMENT
            STORE(L30GE+8) = S6SIG
        ENDIF

        STORE(L30IX+6) = RTD*ASIN(WAVE*SMIN)  ! STORE THETA LIMITS
        STORE(L30IX+7) = RTD*ASIN(WAVE*SMAX)

        ISTORE(L30RF +12 ) = NV + 2   ! REFINEMENT TYPE

      ENDIF

      IF( SFLS_TYPE .EQ. SFLS_CALC ) THEN  ! 'CALC' ONLY

          STORE(L30RF +0 ) = R
          STORE(L30GE +10 ) = R
          STORE(L30RF +1 ) = RW
          STORE(L30GE +11 ) = RW

          STORE(L30CF)=RALL(1)
          STORE(L30CF+1)=RALL(2)

          STORE(L30CF+4)=-10.
          STORE(L30CF+5)=RALL(7)

          IF (RALL(4) .GT. ZERO) THEN
            STORE(L30CF+2) =100.* RALL(3)/RALL(4)
          ENDIF
          IF (RALL(6) .GT. ZERO) THEN
            STORE(L30CF+3) = 100.*SQRT(RALL(5)/RALL(6))
          ENDIF

          IF (RALL(9) .GT. ZERO) THEN
            STORE(L30CF+6) =100.* RALL(8)/RALL(9)
          ENDIF
          IF (RALL(11) .GT. ZERO) THEN
            STORE(L30CF+7) = 100.*SQRT(RALL(10)/RALL(11))
          ENDIF

6260      FORMAT (/
     1       ' With Sigma(I) cutoff= ',F6.2, 
     1       ', there are', I9, ' reflections',/
     1       , ' R-value=',F7.3, 34X, ' Rw=', F7.3)
6262      FORMAT (2X,I7,' reflections   R ',F5.2,
     1    '% Rw ',F5.2,'% with I/u(I) from List 28')
6261      FORMAT (2X,I7,' reflections   R ',F5.2,
     1    '% Rw ',F5.2,'% with I/u(I) >',F6.1)

            CALL OUTCOL(6)
            WRITE ( CMON, 6262) 
     1       NT, MIN(99.99,STORE(L30RF)),MIN(99.99,STORE(L30RF+1))
            CALL XPRVDU(NCVDU, 1, 0)

            WRITE ( CMON, 6261)
     1       NINT(RALL(7)), MIN(99.99,STORE(L30CF+6)),
     2                      MIN(99.99,STORE(L30CF+7)), -10.0
            IF (ISSPRT .EQ. 0) WRITE(NCWU,6260) 
     1       -10., NINT(RALL(7)), STORE(L30CF+6), STORE(L30CF+7)
            CALL XPRVDU(NCVDU, 1, 0)

            WRITE ( CMON, 6261)  
     1       NINT(RALL(2)), MIN(99.99,STORE(L30CF+2)),
     2                      MIN(99.99,STORE(L30CF+3)), RALL(1)
            IF (ISSPRT .EQ. 0) WRITE(NCWU,6260)
     1       RALL(1), NINT(RALL(2)), STORE(L30CF+2), STORE(L30CF+3) 
            CALL XPRVDU(NCVDU, 1, 0)
            CALL OUTCOL(1)
      ENDIF
      CALL XWLSTD ( 30, ICOM30, IDIM30, -1, -1)

      CALL XRSL     ! CLEAR THE CORE
      CALL XCSAE

      IF( SFLS_TYPE .EQ. SFLS_SCALE ) THEN   ! THE SCALE FACTOR HAS BEEN REFINED
        CALL XFAL05
        IF ( IERFLG .LT. 0 ) GO TO 9900
        STORE(L5O)=SCALE
        J =NFL            ! SAVE SOME WORK SPACE
        I = KCHNFL(40)
        M5 = L5
        DO I = 1, N5  ! Set occupancies
          IF (IUPDAT .GE. 0)
     1      IGSTAT =KSPGET ( STORE(J), STORE(J+10), ISTORE(J+20),
     2      STORE(J+30), MGM, M5, IUPDAT, NUPDAT)
          M5 = M5 + MD5
        END DO
        NFL= J
        CALL XSTR05(LN5,-1,-1)
        CALL XRSL
        CALL XCSAE
      END IF

C--PRINT THE TERMINATION MESSAGES
      CALL XOPMSG(IOPSFS, IOPEND, IVERSN)
      CALL XTIME2(1)
      IF (MODE .LE. 0)  RETURN
      RETURN

C--'#END' INSTRUCTION
4550  CONTINUE
      CALL XEND
      RETURN

C--'#TITLE' INSTRUCTION
4600  CONTINUE
      CALL XRCN
      RETURN

9900  CONTINUE
C -- ERRORS
      IF (MODE .LE. 0)  RETURN
      RETURN
9910  CONTINUE
C -- NUMBERS DON'T MATCH
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9915 )
      WRITE ( CMON, 9915 )
      CALL XPRVDU(NCVDU, 1,0)
9915  FORMAT ( 1X , 'The number of elements in lists 5 and 25 is' ,
     1 ' different' )
      CALL XERHND ( IERERR )
      GO TO 9900
9920  CONTINUE
C -- NOTHING TO REFINE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9925 )
      WRITE ( CMON, 9925 )
      CALL XPRVDU(NCVDU, 1,0)
9925  FORMAT ( 1X , 'List 12 indicates that no parameters ' ,
     1 'are to be refined' )
      CALL XERHND ( IERERR )
      GO TO 9900
9940  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9945 )
      WRITE ( CMON, 9945 )
      CALL XPRVDU(NCVDU, 1,0)
9945  FORMAT(1X ,'LIST 5 contains no atoms')
      GOTO 9900
9950  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 9955 )
      WRITE ( NCAWU , 9955 )
      WRITE ( CMON, 9955 )
      CALL XPRVDU(NCVDU, 1,0)
9955  FORMAT(1X ,'No additional arguments permitted')
      GOTO 9900
      END
C
CODE FOR XSFLSC
      SUBROUTINE XSFLSC ( DERIVS, NDERIV, IRESULTS, NRESULTS)
      DIMENSION DERIVS(NDERIV)
      DIMENSION IRESULTS(NRESULTS)
C--MAIN STRUCTURE FACTOR CALCULATION ROUTINE
C
C--USEAGE OF CONTROL VARIABLES :
C
C  JA      SET TO 1 FOR ISO ATOMS ONLY, ELSE N2                         Changed to ISO_ONLY
C  JB      SET TO -1 FOR NO REFINEMENT, ELSE 0 .                        Replaced by SFLS_TYPE
C  JC      SET TO -1 FOR ONLY CALCULATE COS, ELSE 0                     REplaced by COS_ONLY
C  JD      SET TO -1 FOR CENTRO, ELSE 0                                 Replaced by CENTRO
C  JE      SET TO -1 FOR NO ANOMALOUS DISPERSION, ELSE 0                Replaced by ANOMAL
C  JF      CURRENT VALUE OF JB, SET FOR EACH ATOM IF JB=0               Replaced by ATOM_REFINE
C  JG      SET TO -1 FOR NO PRINT, ELSE THE NUMBER OF LINES BEFORE PAGE Replaced by REFPRINT
C  JH      SET TO -1 IF THE SCALE FACTOR IS NOT TO BE REFINED, ELSE 0   Replaced by SFLS_TYPE

C  JJ      SET TO -1 IF ONLY ISO-TERMS REQUIRED, ELSE 0 (SIMILAR TO JA) Removed (use ISO_ONLY)
C  JK      SET TO -1 IF BOTH LEFT AND RIGHT HAND SIDES ARE NEEDED       Replaced by NEWLHS
C  JL      SET TO -1 IF ENANTIOPOLE PARAMETER NOT USED, ELSE 0          Replaced by ENANTIO

C  JI      CYCLE NUMBER

C  JN      DUMMY LOCATION FOR NON-REFINED PARAMETERS
C  JO      ADDRESS COMPLETE PARTIAL DERIVATIVES
C  JP      LAST ADDRESS COMPLETE PARTIAL DERIVATIVES
C  JQ      NUMBER OF PARTIAL DERIVATIVES PER REFLECTION (0,1,2 OR 4)
C  JR      ADDRESS PARTIAL DERIVATIVES BEFORE THEY ARE ADDED TOGETHER
C  LJS      WORK VARIABLE
C  JT      WORK VARIABLES USED DURING ACCUMULATION OF PARTIAL DERIVATIVE  Replaced by LJT
C  JU                                                                     Replaced by LJU
C  JV                                                                     Replaced by LJV
C  JW                                                                     Replaced by LJW
C  JX      LOOP VARIABLE FOR EQUIVALENT POSITIONS                         Replaced by LJX
C  JY      LOOP VARIABLE FOR ATOMS                                        Replaced by LJY
C  JZ                                                                     Replaced by LJZ
C
C  NA      SET TO -1 FOR NO EXTINCTION CORRECTION TO /FC/, ELSE 0   Replaced by EXTINCT
C  NB      SET TO -1 FOR NO TWINNED DATA, ELSE TO 0 OR 1.           Replaced by TWINNED and SCALED_FOT
C          (0 MEANS PUT /FOT/ ETC. IN /FO/, WHILE 1 OR GREATER
C           MEANS PUT THE /FO/ AND /FC/ ETC. COMPUTED FOR THE
C           ELEMENT FOR WHICH THE INDICES ARE GIVEN).
C  NC      IF GREATER THAN -1, THEN THE GIVEN PARTIAL CONTRIBUTIONS
C          ARE TO BE USED, ELSE NOT.                                Replaced by PARTIALS
C  ND      IF SET TO -1, THEN NO NEW PARTIAL CONTRIBUTIONS ARE
C          OUTPUT. IF GREATER THAN -1, THE NEW /FC/ ETC. ARE STORED
C          AS THE PARTIAL CONTRIBUTIONS.
C  NE      IF GREATER THAN -1, THEN THE LAYER SCALES ARE APPLIED TO /FO/
C          ELSE NOT.   Replaced by LAYERED
C  NF      IF GREATER THAN -1, THE CONTRIBUTORS TO EACH TWINNED REFLECTI
C          ARE PRINTED.
C  JREF_STACK_START      ADDRESS OF THE WORD THAT HOLDS THE ADDRESS OF THE FIRST
C          BLOCK OF THE REFLECTION HOLDING STACK
C  JREF_STACK_PTR  USED TO PASS THROUGH THE REFLECTION HOLDING STACK
C  NI      SIMILAR TO NH.
C  NJ      THE VALUE OF THE VARIABLE 'ELEMENTS' FOR EACH REFLECTION.
C  NK      CURRENT VALUE OF 'NJ' FOR EACH REFLECTION .
C  NL      THE ELEMENT OF THE CURRENT REFLECTION
C  NM      THE NUMBER OF REFLECTIONS IN THE STACK USED SO FAR
C  NN      SET TO 0 IF NO NEW REFLECTIONS HAVE BEEN INTRODUCED,
C          ELSE THE NUMBER OF NEW REFLECTIONS FOUND
C  NO      DUMP OF 'JO'
C  NP      DUMP OF 'JP'
C  NQ      COUNTER WHEN THE TWIN COMPONENTS ARE BEING COMBINED
C  NR      NUMBER OF WORDS PER SYMMETRY RELATED REFLECTION IN THE
C          REFLECTION HOLDING STACK.
C          THE FORMAT OF THE SYMMETRY RELATED REFLECTION ENTRIES IS :
C
C          0  H TRANSFORMED
C          1  K TRANSFORMED
C          2  L TRANSFORMED
C          3  THE PHASE SHIFT FOR THIS GROUP OF INDICES
C
C  NT      THE NUMBER OF REFLECTIONS THAT HAVE BEEN USED
C  NU      -1 FOR XRAYS, AND 0 FOR NEUTRONS  -  ONLY USED FOR EXTINCTION
C  NV      -1 FOR REFINEMENT ON /FO/, ELSE REFINEMENT ON /FO/ **2
C  NW      -1 FOR NO BATCH SCALE APPLICATION, ELSE 0.       Replaced by BATCHED
C
C--THE FORMAT OF THE REFLECTION HOLDING STACK WHICH STARTS AT
C      'ISTORE(NG)' IS :
C
C   0  LINK TO NEXT REFLECTION OR -1000000
C   1  ADDRESS OF THE FIRST WORD OF THE DERIVATIVES W.R.T. /FC/
C   2  ADDRESS OF THE LAST WORD OF THE DERIVATIVES W.R.T. /FC/
C   3  H FOR THE CURRENT REFLECTION
C   4  K FOR THE CURRENT REFLECTION
C   5  L FOR THE CURRENT REFLECTION (ALL IN FLOATING POINT).
C   6  /FC/ FOR THE CURRENT REFLECTION
C   7  PHASE FOR THE CURRENT REFLECTION
C   8  ELEMENT NUMBER WHICH THIS REFLECTION CURRENTLY REPRESENTS.
C   9  ADDRESS OF THE FIRST WORD OF THE FIRST GROUP OF
C      EQUIVALENT INDICES FOR  THIS BLOCK. (THE REFLECTIONS ARE
C      ARE EQUIVALENT TO THOSE INDICES GIVEN IN WORDS 3 TO 5).
C  10  ADDRESS OF THE LAST GROUP OF EQUIVALENT INDICES FOR THIS
C      REFLECTION BLOCK.
C      (EACH EQUIVALENT SET OF INDICES IS 'NR' WORDS LONG).
C  11  PHASE SHIFT NECESSARY FOR THE REFLECTION CURRENTLY USING THIS BLO
C  12  1.0 IF FRIEDEL'S LAW HAS NOT BEEN USED FOR THE CURRENT REFLECTION
C  13  REAL PART OF A FOR THE ORIGINAL REFLECTION
C  14  IMAGINARY PART OF A FOR THE ORIGINAL REFLECTION
C  15  REAL PART OF B FOR THE ORIGINAL REFLECTION
C  16  IMAGINARY PART OF B FOR THE ORIGINAL REFLECTION
C  17  NOT USED
C  18  ADDRESS OF THE FIRST WORD OF THE DERIVATIVES W.R.T. A, B ETC.
C  19  ADDRESS OF THE LAST WORD OF THE DERIVATIVES W.R.T. TO A, B ETC.
C
C--THE DERIVATIVES FOLLOW THIS INFORMATION.
C
C--NORMALLY, WHEN EACH REFLECTION IS READ FROM THE DISC,
C  IT IS CHECKED AGAINST THOSE ALREADY IN THE STACK TO SEE IF ITS
C  A AND B PARTS TOGETHER WITH THEIR DERIVATIVES ARE PRESENT.
C  IF THEY ARE NOT PRESENT, THEN THESE VALUES ARE CALCULATED
C  AND THE INFORMATION SET UP IN THE BLOCK AT THE TOP OF THE STACK.
C  THIS CORRESPONDS TO THE ORIGINAL VALUES IN WORDS 13-16 AND IN THE
C  DERIVATIVES STORED FOR THE A AND B PARTS.
C  ONCE THE VALUES REQUIRED FOR THE CURRENT REFLECTION ARE PRESENT,
C  /FC/ AND ITS DERIVATIVES ARE CALCULATED.
C  (AT THIS STAGE, THE CURRENT REFLECTION MAY CORRESPOND TO THE ORIGINAL
C   REFLECTION OR MAY BE ONE OF ITS EQUIVALENTS FROM THE STACK).
C  THE DERIVATIVES ARE THEN ADDED TO THE NORMAL EQUATIONS, AFTER
C  MODIFICATION FOR EXTINCTION AND REFINEMENT AGAINST /FO/ **2 IF
C  NECESSARY.
C
C--DURING THE PROCESSING OF ONE NOMINAL REFLECTION FOR A TWIN, THE STACK
C  IS SEARCHED FOR EACH ELEMENT IN TURN. IF THE ELEMENT HAS
C  ALREADY BEEN CALCULATED, THE BLOCK IS MOVED TO THE TOP OF THE STACK
C  AND CONTROL PASSES TO THE NEXT COMPONENT. IF THE ELEMENT OR
C  COMPONENT IS NOT IN THE STACK, THE LAST BLOCK IS SWITCHED TO
C  THE TOP OF THE STACK, AND THEN ITS A AND B PARTS WITH THEIR DERIVATIV
C  COMPUTED. AT THE END, THE ELEMENT FOR WHICH THE INDICES ARE GIVEN
C  IS LEFT AT THE TOP OF THE STACK AS THIS IS ALWAYS THE LAST
C  ELEMENT PROCESSED.
C  WHEN THE A AND B PARTS HAVE BEEN  FOUND FOR ALL THE ELEMENTS, /FC/
C  AND ITS DERIVATIVES ARE CALCULATED FOR EACH ELEMENT.
C  FOLLOWING THIS, /FCT/ AND ITS DERIVATIVES ARE CALCULATED, AND THEN AD
C  TO THE NORMAL EQUATIONS.
C
C      PARTIAL DERIVATIVE STACK
C                  FLACK SYMBOL
C      0   F.COS(HX)      A      AC
C      1   F.SIN(HX)      B      BC
C      2  -F".SIN(HX)    -D      ACI
C      3   F".COS(HX)     C      BCI
C
C      FC = (A-D) + I.(B+C)
C
C
C--THE FORMAT OF THE LIST 6 BUFFER AT 'M6' IS :
C
C   0  H
C   1  K
C   2  L (ALL IN FLOATING POINT).
C   3  /FO/
C   4  WEIGHT  -  REALLY THE SQUARE ROOT OF THE WEIGHT
C   5  /FC/
C   6  PHASE
C   7  PARTIAL CONTRIBUTION FOR A.
C   8  PARTIAL CONTRIBUTION FOR B.
C   9  T-BAR  -  EXTINCTION TERM FOR THIS REFLECTION.
C  10  /FOT/  -  TOTAL /FO/ FOR A TWINNED STRUCTURE
C  11  THE ELEMENTS OF A TWINNED STRUCTURE.
C
C--USEAGE OF GENERAL VARIABLES
C
C  TC     COEFFICIENT FOR THE ISO-TEMPERATURE FACTORS
C  SST    SIN(THETA)/LAMBDA SQUARED
C  ST     SIN(THETA)/LAMBDA
C  SMAX, SMIN      MAX AND MIN VALUES OF SINTETA/LAMBDA
C  AC     TOTAL REAL A PART FOR THE REFLECTION
C  BC     TOTAL REAL B PART FOR THE REFLECTION
C  ACI    TOTAL IMAGINARY A PART FOR THE REFLECTION
C  BCI    TOTAL IMAGINARY B PART FOR THE REFLECTION
C  ACT    TOTAL A PART FOR THE RELFECTION
C  BCT    TOTAL B PART FOR THE REFLECTION
C  ACD    PARTIAL DERIVATIVE WITH RESPECT TO POLARITY PARAMETER
C  BCD    PARTIAL DERIVATIVE WRTO POLARITY PARAMETER
C  ACF    TOTAL PARTIAL DERIV WRTO POLARITY
C  ACN    TOTAL A PART FOR INVERSE STRUCTURE - USED IN ENANTIOPOLE REFIN
C  BCN    TOTAL B PART FOR INVERSE STRUCTURE - USED IN ENANTIOPOLE REFIN
C  ACE    PARTIAL DERIVATIVE FOR ENANTIOPOLE
C  ENANT  ENANTIOPOLE PARAMETER
C  ALPD    PARTIAL DERIVATIVES FOR  EACH ATOM WITH RESPECT TO A
C  BLPD    PARTIAL DERIVATIVES FOR  EACH ATOM WITH RESPECT TO B
C  FO     SCALED FO
C  FC     FC ON ABSOLUTE SCALE
C  P      PHASE ANGLE IN RADIANS
C  W      SQUARE ROOT OF THE WEIGHT FOR THIS RELFECTION
C  DF     DIFFERENCE BETWEEN FO AND FC
C  WDF    WEIGHTED DIFFERENCE BETWEEN FO AND FC
C  FOT    SUM OF FO
C  FCT    SUM OF FC
C  DFT    SUM OF MOD(DF)
C  AMINF  MINIMIZATION FUNCTION - SUM WEIGHTED DIFFERENCE SQUARED
C  WDFT   MINIMISATION FUNCTION BASED ONLY ON /FO/.
C  RW     HAMILTON WEIGHTED R VALUE
C  R      NORMAL WEIGHTED R VALUE
C  COSP   COSINE OF THE PHASE ANGLE
C  SINP   SINE OF THE PHASE ANGLE
C  EXT    EXTINCTION PARAMETER (R*)  -  SEE LARSON IN C.C. 1970.
C  LAYER  THE INDEX OF THE CURRENT LAYER AS REQUIRED BY THE LAYER SCALES
C  IBATCH  THE BATCH OF THE CURRENT REFLECTION MINUS ONE.
C  FCEXT  FC CORRECTED FOR EXTINCTION EFFECTS.
C  FCEXS  FCEXT CORRECTED FOR THE SCALE FACTOR
C  EXT1   (1 + 2*(R*)* /FC/ **2*DELTA)
C  EXT2   (1 + (R*)* /FC/ **2*DELTA)
C  EXT3   EXT1/EXT2
C  WAVE   THE WAVELENGTH OF THE RADIATION USED TO COLLECT THE DATA
C  THETA1 THE MONOCHROMATOR BRAGG ANGLE
C  THETA2 THE ANGLE BETWEEN THE MONOCHROMATOR AND THE DIFFRACTING PLANES
C  POL1   FIRST PART OF THE POLARISATION CORRECTION
C  POL2   THE SECOND PART OF THE POLARISATION CORRECTION
C  DEL    THE FIXED PART OF DELTA
C  DELTA  THE EXTINCTION MULTILPLIER  -  SEE LARSON.
C
C  PH, PK AND PL ARE A DUMP OF THE NOMINAL INDICES FOR A TWIN.
C
C  SH, SK AND SL ARE THE INDICES OF A TWINNED REFLECTION IN THE
C        STANDARD SETTING.
C
C--THE VARIOUS SCALE FACTORS USED ARE :
C
C  SCALEO  THE OVERALL SCALE FACTOR FROM LIST 5.
C          'SCALEO' IS ASSUMED NOT TO BE ZERO.
C  SCALEL  THE LAYER SCALE FACTOR FOR THE CURRENT LAYER  -  THIS
C          SCALE MAY BE ZERO IF REQUIRED.
C  SCALEB  THE BATCH SCALE FACTOR FOR THE CURRENT REFLECTION  -  THIS
C          SCALE MAY BE ZERO IF REQUIRED.
C  SCALES  THE SCALE FACTOR TO BE USED WHEN STORING /FC/.
C          THIS EQUALS SCALEL*SCALEB, SINCE 'SCALEO' IS NOT APPLIED TO /
C  SCALEG  THE COMBINED /FC/ SCALE FACTOR (=SCALEO*SCALEL*SCALEB).
C          'SCALEG' WILL BE ZERO IF 'SCALEL' OR 'SCALEB' IS ZERO.
C  SCALEK  THE OVERALL /FO/ SCALE FACTOR (=1.0/SCALEG, UNLESS
C          'SCALEG' IS ZERO, WHEN 'SCALEK' IS SET TO 1.0).
C  SCALEW  SCALEG*W
C
C--IF 'SCALEL' IS ZERO, ITS DERIVATIVE IS CALCULATED CORRECTLY,
C  BUT ALL OTHER DERIVATIVES FOR THAT REFLECTION WILL BE ZERO.
C
C
C--ALL DERIVATIVES ARE INTIALLY COMPUTED ON THE SCALE OF /FC/, AND THEN
C  ON THE CORRECT SCALE (THAT OF /FO/) WHEN THE A AND B PARTS ARE ADDED
C  TOGETHER AND THE WEIGHTS APPLIED.
C
C--THE DERIVATIVES FOR THE OVERALL SCALE FACTORS ARE COMPUTED SEPARATELY
C  OTHER OVERALL PARAMETERS.
C
C----- PARTIAL DERIVATIVE RELATIONSHIPS
C
C      FTSQ  = (1-X)*FP**2 + X*FN**2
C      where FPSQ is for the given index, and FNSQ for its Friedel inver
C
C      dFTSQ = 2*FP*(1-X)*dFP + 2*FN*X*dFN
C
C      dFT   = (FP/FT)*(1-X)*dFP   +    (FN/FT)*dFN
C
C            COSA := (1-X)*FP/FT,       SINA := X*FN/FT
C
C      FPSQ  = Q**2 + S**2,             FNSQ = QN**2 + SN**2
C
C      dFP   = (Q/FP)*dQ + (S/FP)*dS,   dFN   = (QN/FN)*dQN + (SN/FN)*dS
C
C           COSP := Q/FP, SINP := S/FP, COSPN := QN/FN, SINPN := SN/FN
C
C            Q = A-D, S = B+C,          QN = A+D, SN = -B+C
C
C            AC := A, ACI := -D, BC := B, BCI = C
C
C            ACT := Q, BCT := S,        ACN := QN, BCN := SN
C
C      dQ/dp = dA/dp - dD/dp,           dQN/dp =  dA/dp + dD/dp
C      dS/dp = dB/dp + dC/dp,           dSN/dp = -dB/dp + dC/dp


\TYPE11
\ISTORE
\STORE
\XSTR11
\XSFWK
\XWORKB
\XSFLSW
\XCONST
\XUNITS
\XSSVAL
\XLST01
\XLST02
\XLST03
\XLST05
\XLST06
\XLST11
\XLST12
\XLST25
\XLST28
\XLST33
\XERVAL
\XIOBUF
\QSTORE
\QSTR11

C-C-C-AGREEMENT OF CONSTANTS AND VARIABLES
C-C-C-...FOR FLAG TO DECIDE BETWEEN KIND OF ATOM
c      REAL FLAG
C
C
      CHARACTER*15 HKLLAB
C
C

      CALL CPU_TIME ( time_begin )

C------ SET MIN AND MAX SIN THETA/LAMBDA
      SMAX=0.
      SMIN=1./WAVE
C----- A BUFFER FOR ONE REFELCTION AND ITS R FACTOR
      LTEMPR = NFL
      NTEMPR = 7
      NFL = KCHNFL(NTEMPR)
C----- INITIALISE THE SORT BUFFER
      JSORT = -5
      MDSORT = NTEMPR
      NSORT = 30
      CALL SRTDWN(LSORT,MSORT,MDSORT,NSORT, JSORT, LTEMPR, XVALUR,
     1   0, DEF)
      JSORT = 5
C----- A BUFFER FOR ONE ENANTIOMER SENSITIVE REFLECTION
      LTEMPE = NFL
      NTEMPE = 7
      NFL = KCHNFL(NTEMPE)
C----- INITIALISE THE ENANTIOMER BUFFER
      JENAN = -6
      MDENAN = NTEMPE
      NENAN = 30
      CALL SRTDWN(LENAN,MENAN,MDENAN,NENAN, JENAN, LTEMPE, XVALUE,
     1   0, DEF2)
      JENAN = 6


      IF (ISTORE(L33CD+12).NE.0) THEN    ! Leverage calc.
C----- A BUFFER FOR ONE REFELCTION AND ITS LEVERAGE
        LTEMPL = NFL
        NTEMPL = 7              ! Seven items to be stored: H,K,L,STL2,LEV,FO,FC
        NFL = KCHNFL(LTEMPL)    ! Make the space
C----- INITIALISE THE SORT BUFFER
        JLEVER = -5             ! Sort on the fifth item (NB: abs)
        MDLEVE = NTEMPL         ! Five items to be stored
        NLEVER = 30             ! Worst 30 reflections to be kept
        CALL SRTDWN(LLEVER,MLEVER,MDLEVE,NLEVER,JLEVER,LTEMPL,XVALUL,
     1    -1, DEF3)             ! Init
        JLEVER = 4              ! Sort on the fifth item (NB: offset)
        REDMAX = 0.0

        WRITE(CMON,'(A,6(/,A))')
     1  '^^PL PLOTDATA _LEVP SCATTER ATTACH _VLEVP',
     1  '^^PL XAXIS TITLE ''k x Fo'' NSERIES=2 LENGTH=2000',
     1  '^^PL YAXIS TITLE ''Leverage, Pii'' ZOOM 0.0 1.0',
     1  '^^PL YAXISRIGHT TITLE ''tij**2/(1+Pii)''',
     1  '^^PL SERIES 1 TYPE SCATTER SERIESNAME ''Leverage''',
     1  '^^PL SERIES 2 TYPE SCATTER',
     2  '^^PL SERIESNAME ''Influence of remeasuring'' USERIGHTAXIS'
        CALL XPRVDU(NCVDU, 7,0)

      END IF

C----- SET PRINT COUNTER
      IENPRT = -1
      ILEVPR = 0
C----- SET BAD R FACTOR COUNTER
      IBADR = -1
C--INITIALISE THE TIMING FUNCTION
      CENTRO = .FALSE.
      IF ( IC .EQ. 1 ) CENTRO = .TRUE.
c      JD=-IC
      D=180.0/PI
      COS_ONLY = .FALSE.

      IF(CENTRO)THEN        ! CHECK IF THIS STRUCTURE IS CENTRO
        IF (SFLS_TYPE .NE. SFLS_REFINE) THEN  ! CHECK IF WE ARE DOING REFINEMENT
          COS_ONLY = .TRUE.  ! CENTRO WITH NO REFINEMENT  -  ONLY COS TERMS NEEDED
        END IF
      END IF

C--CLEAR THE VARIABLES FOR HOLDING THE OVERALL TOTALS
C----- GET THE OLD R FACTOR AND SET PRINT RATIO
      R = STORE(L6P+1) * .01 *3.
      RW=0.0
      FOABS = 0.0
      FOT=0.0
      FCT=0.0
      DFT=0.0
      WDFT=0.0
      AMINF=0.
      SFO=0.0
      SFC=0.0
      NT=0
      ACE=0.
      ACF = 0.
C----- OVERALL SCALE
      SCALEO=STORE(L5O)
C----- ENANTIOPOLE PARAMETER
      ENANT = STORE(L5O+4)
      CENANT  =  (1.- ENANT)
C----- POLARITY PARAMETER
      ANOM = STORE(L5O+3)
C--SET UP THE EXTINCTION VARIABLE
      EXT=0.
      EXT1=1.0
      EXT2=1.0
      EXT3=1.0
      DELTA=0.

      IF(EXTINCT)THEN   ! THE EXTINCTION PARAMETER IN LIST 5 SHOULD BE USED
        EXT=STORE(L5O+5)
        POL1=1.
        POL2=0.
        DEL=WAVE*WAVE/(STORE(L1P1+6)*STORE(L1P1+6))
        IF(NU.LT.0) THEN   ! CHECK IF WE ARE USING NEUTRONS OR XRAYS
C--WE ARE USING XRAYS
          DEL=DEL*WAVE*0.0794
          THETA2=THETA2/D ! SET UP THE POLARISATION CONSTANTS
          A=COS(THETA2)
          C=SIN(THETA2)
          S=COS(THETA1/D)
          A=A*A
          C=C*C
          S=S*S
          POL1=A+C*S
        END IF
      END IF
      POL2=C+A*S

C--CHECK IF A PRINT IS REQUIRED
      IF(REFPRINT) THEN 
        IF (ISSPRT .EQ. 0)  WRITE(NCWU,1750)
1750  FORMAT(/7X,'H',5X,'K',5X,'L',6X,'/FO/',5X,'/FC/',4X,'Phase',5X,
     2 'Delta    SQRT(W)*Delta',2X,'/FC''/',2X,'/FC''''/',2X,'D/F/ **2',
     3 1X,'T.B.R.(%)',2X,'SINTH/L/')
      END IF

      NO=JO
      NP=JP

      DO WHILE (.TRUE.)  ! START OF THE LOOP OVER REFLECTIONS

        IF( SFLS_TYPE .EQ. SFLS_CALC ) THEN
C Remove I/sigma(I) cutoff, temporarily, leaving all other filters
C in place.
          DO I28MN = L28MN,L28MN+((N28MN-1)*MD28MN),MD28MN
            IF(ISTORE(I28MN)-M6.EQ.20) THEN
              SAVSIG = STORE(I28MN+1)
              STORE(I28MN+1) = -99999.0
            END IF
          END DO
C Fetch reflection using all other filters:
          IFNR = KFNR(1)
C Put sigma filter back:
          DO I28MN = L28MN,M28MN,MD28MN
            IF(ISTORE(I28MN)-M6.EQ.20) THEN
              STORE(I28MN+1) = SAVSIG
            END IF
          END DO
        ELSE
          IFNR = KFNR(1)
        ENDIF

        IF(IFNR.LT.0) EXIT

        LAYER=-1   ! SET THE LAYER SCALING CONSTANTS INITIALLY
        SCALEL=1.0
        IF(LAYERED)THEN   ! CHECK IF THIS SCALE IS TO BE USED
          LAYER=KLAYER(I)-1  ! FIND THE LAYER NUMBER AND SET ITS VALUE
          IF ( IERFLG .LT. 0 ) GO TO 19900
          M5LS=L5LS+LAYER
          SCALEL=STORE(M5LS)
        END IF

        IBATCH=-1  ! SET THE INITIAL VALUES FOR THE BATCH SCALE FACTOR
        SCALEB=1.
        IF(BATCHED) THEN ! CHECK IF THE BATCH SCALE FACTOR SHOULD BE USED
          IBATCH=KBATCH(I)-1  ! FIND THE BATCH NUMBER AND SET THE SCALE
          IF ( IERFLG .LT. 0 ) GO TO 19900
          M5BS=L5BS+IBATCH
          SCALEB=STORE(M5BS)
        END IF

        SCALEK=1.   ! SET UP THE SCALE FACTORS CORRECTLY
        SCALES=SCALEL*SCALEB
        SCALEG=SCALEO*SCALES

        IF(SCALEG .GT. 0.000001) THEN   ! CHECK IF THE SCALE IS ZERO
          SCALEK=1./SCALEG   ! THE /FC/ SCALE FACTOR IS NOT ZERO  -  COMPUTE THE /FO/ SCALE FACTOR
        END IF

C--CLEAR THE PARTIAL CONTRIBUTION FLAGS FOR THIS REFLECTION
        ACT=0.0
        BCT=0.0
        ACN = 0.
        BCN = 0.
C--CHECK IF THE PARTIAL CONTRIBUTIONS ARE TO BE ADDED IN
        IF(PARTIALS) THEN 
          ACT=STORE(M6+7)
          BCT=STORE(M6+8)
          ACN = ACT
          BCN = BCT
        END IF

        FO=STORE(M6+3)  ! SET UP /FO/ ETC. FOR THIS REFLECTION
        W=STORE(M6+4)
        SCALEW=SCALEG*W

        NM=0  ! INITIALISE THE HOLDING STACK, DUMP ENTRIES
        NN=0
        JO=NO  ! Point JO back to beginning of PD list.
        JP=NP

        IF(.NOT.TWINNED)THEN   ! CHECK IF THIS IS TWINNED CALCULATION
          NL=0
          CALL XSFLSX
          JREF_STACK_PTR=ISTORE(JREF_STACK_START)
          CALL XAB2FC  ! DERIVE THE TOTALS AGAINST /FC/ FROM THOSE W.R.T. A AND B
        ELSE ! THIS IS A TWINNED CALCULATION  
          PH=STORE(M6)  ! PRESERVE THE NOMINAL INDICES
          PK=STORE(M6+1)
          PL=STORE(M6+2)
          NJ=NINT(STORE(M6+11))

          IF (NJ .EQ. 0) NJ = 12 ! IF THERE IS NO ELEMENT KEY, SET IT TO MOROHEDRAL TWINNING

          NK=NJ  ! FIND THE ELEMENT FOR WHICH THE INDICES ARE GIVEN
          DO WHILE ( NK .GT. 0 ) 
            NL=NK
            NK=NK/10
            LJX=NL-NK*10
            IF ( LJX .LE. 0 ) GO TO 19910    ! CHECK THAT THIS IS A 
            IF ( LJX .GT. N25 ) GO TO 19910  ! VALID ELEMENT NUMBER
          END DO

C CHECK IF 'NL' HOLDS THE ELEMENT NUMBER OF THE GIVEN INDICES.
          M25I=L25I+(NL-1)*MD25I  ! COMPUTE THE INDICES IN THE STANDARD REFERENCE SYSTEM
          SH=STORE(M25I)*PH+STORE(M25I+1)*PK+STORE(M25I+2)*PL
          SK=STORE(M25I+3)*PH+STORE(M25I+4)*PK+STORE(M25I+5)*PL
          SL=STORE(M25I+6)*PH+STORE(M25I+7)*PK+STORE(M25I+8)*PL

          NK=NJ  ! RESET THE FLAGS FOR THIS GROUP OF TWIN ELEMENTS, e.g. 1234

          DO WHILE ( NK .GT. 0 ) ! CHECK IF THERE ARE ANY MORE ELEMENTS TO PROCESS
            LJX=NK      ! FETCH THE NEXT ELEMENT
            NK=NK/10                                           ! e.g. 123
            NL=LJX-NK*10                                        ! e.g. 1234-1230 = 4
            M25=L25+(NL-1)*MD25   ! COMPUTE THE INDICES FOR THIS COMPONENT
            STORE(M6)=FLOAT(NINT(STORE(M25)*SH
     2                    +STORE(M25+1)*SK+STORE(M25+2)*SL))
            STORE(M6+1)=FLOAT(NINT(STORE(M25+3)*SH
     2                      +STORE(M25+4)*SK+STORE(M25+5)*SL))
            STORE(M6+2)=FLOAT(NINT(STORE(M25+6)*SH
     2                      +STORE(M25+7)*SK+STORE(M25+8)*SL))
            IF ( NM .GE. N25 ) GO TO 19920  ! WE HAVE USED TOO MANY ELEMENTS
            CALL XSFLSX  ! THIS ELEMENT IS OKAY  -  ENTER THE S.F.L.S MAIN LOOP
          END DO  ! END OF THIS TWINNED REFLECTION  

          FCEXT=0.  !  WIND UP AND CALCULATE THE TOTAL VA
          JREF_STACK_PTR=JREF_STACK_START  ! CALCULATE /FC/ AND ITS DERIVATIVES FOR EACH ELEMENT
          NQ=NM
          
          DO WHILE ( NQ .GT. 0 )  ! ACCESS THE NEXT ELEMENT IN THE STACK
            JREF_STACK_PTR=ISTORE(JREF_STACK_PTR)
C--COMPUTE THE TOTALS AGAINST /FC/ FOR THIS ELEMENT
            ACT=0.  ! CLEAR THE PARTIAL CONTRIBUTIONS
            BCT=0.
            JO=ISTORE(JREF_STACK_PTR+1)  ! SET THE POINTER FOR THE DERIVATIVES WITH RESPECT TO /FC/
            JP=ISTORE(JREF_STACK_PTR+2)
  
            CALL XAB2FC   ! CONVERT A AND B PARTS TO FC

            NI=ISTORE(JREF_STACK_PTR+8) ! ACCUMULATE /FCT/
            ISTORE(JREF_STACK_PTR+8)=ISTORE(JREF_STACK_PTR+8)-1
            LJU=L5ES+ISTORE(JREF_STACK_PTR+8)
            LJV=M5ES+ISTORE(JREF_STACK_PTR+8)
            FCEXT=FCEXT
     1       +STORE(LJU)*STORE(JREF_STACK_PTR+6)*STORE(JREF_STACK_PTR+6)

            IF(NF.GE.0) THEN  ! CHECK IF WE MUST PRINT THIS CONTRIBUTOR
              IF(NM.GT.1)THEN  ! CHECK IF THERE IS MORE THAN ONE CONTRIBUTOR
                IF(NQ.EQ.NM)THEN  ! CHECK IF THIS IS THE FIRST CONTRIBUTOR
                  IF (ISSPRT .EQ. 0) WRITE(NCWU,3350)
                END IF
C--PRINT THIS CONTRIBUTOR
                LJS=JREF_STACK_PTR+3
                A=STORE(JREF_STACK_PTR+7)*D
                C=STORE(JREF_STACK_PTR+6)*STORE(LJV)
                IF (ISSPRT .EQ. 0) THEN
                  WRITE(NCWU,3350)
     1               (STORE(LJT+3),LJT=JREF_STACK_PTR,LJS),A,C,NI
                ENDIF
3350            FORMAT(3X,3F6.0,9X,2F9.1,22X,F12.1,I4)
              END IF
            END IF
            NQ=NQ-1  ! UPDATE THE NUMBER OF ELEMENTS LEFT TO PROCESS
          END DO

          FC=SQRT(FCEXT)  ! COMPUTE THE OVERALL /FCT/ VALUE
          JO=NO
          JP=NP

          IF(.NOT.SCALED_FOT) THEN  ! WHICH TYPE OF /FO/ AND /FC/ WE ARE TO OUTPUT
            STORE(M6+3)=STORE(M6+10) ! OUTPUT THE TOTAL OVER ALL ELEMENTS
            STORE(M6+5)=FC
            STORE(M6+6)=0.
          ELSE
            JREF_STACK_PTR=ISTORE(JREF_STACK_START) ! OUTPUT THE VALUES FOR THE GIVEN INDICES AND ELEMENT
            LJV=ISTORE(JREF_STACK_PTR+8)+M5ES
            STORE(M6+3)=STORE(M6+10)
     1                    *STORE(JREF_STACK_PTR+6)*STORE(LJV)/FC
            STORE(M6+5)=STORE(JREF_STACK_PTR+6)*STORE(LJV)
            STORE(M6+6)=STORE(JREF_STACK_PTR+7)
          END IF
          FO=STORE(M6+10)      ! CALCULATE SOME NEEDED VALUES
          STORE(M6+5)=STORE(M6+5)*SCALES
          P=0.
          CALL XACRT(4)  ! ACCUMULATE THE /FO/ TOTALS
          IF (SFLS_TYPE .EQ. SFLS_REFINE) THEN ! CHECK IF WE ARE DOING REFINEMENT
            DO LJV=JO,JP  ! CALCULATE THE NECESSARY P.D.'S WITH RESPECT TO /FCT/.
              STORE(LJV)=0.
            END DO
            JREF_STACK_PTR=JREF_STACK_START  
            DO LJU=1,NM ! PASS AMONGST THE VARIOUS CONTRIBUTORS
              JREF_STACK_PTR=ISTORE(JREF_STACK_PTR) ! FIND THE ADDRESS OF THIS CONTRIBUTOR
              LJV=ISTORE(JREF_STACK_PTR+8)+L5ES
              A=STORE(JREF_STACK_PTR+6)*STORE(LJV)/FC
              LJS=ISTORE(JREF_STACK_PTR+1)
              N = JP - JO 
              DO J = 0, N  ! ADD IN THE DERIVATIVES
                STORE(JO+J) = STORE(JO+J) + STORE(LJS+J)*A
              END DO
            END DO

            M12=L12ES ! ADD IN THE CONTRIBUTIONS FOR THE ELEMENT SCALE FACTORS
            JREF_STACK_PTR=JREF_STACK_START
            NI=NM
            DO WHILE ( NI.GT.0 ) ! CHECK IF THERE ANY MORE SCALES TO PROCESS
              JREF_STACK_PTR=ISTORE(JREF_STACK_PTR) ! FETCH THE INFORMATION FOR THE NEXT ELEMENT SCALE FACTOR
              LJX=ISTORE(JREF_STACK_PTR+8)
              A=0.5*SCALEW
     1             *STORE(JREF_STACK_PTR+6)*STORE(JREF_STACK_PTR+6)/FC
              NI=NI-1
              CALL XADDPD ( A, LJX, JO, JQ, JR) 
            END DO
          END IF
        END IF

C--FINISH OFF THIS REFLECTION  -  COMPUTE THE OVERALL TOTALS
        FCEXT=FC
C--CHECK IF WE SHOULD INCLUDE EXTINCTION
        IF(EXTINCT)THEN ! WE SHOULD INCLUDE EXTINCTION
          A=AMIN1(1.,WAVE*ST)
          A=ASIN(A)*2.
 
          PATH=STORE(M6+9)  ! CHECK MEAN PATH LENGTH
          IF(PATH.LE.ZERO) PATH = 1.
 
          DELTA=DEL*PATH/SIN(A)  ! COMPUTE DELTA FOR NEUTRONS
          IF(NU.LT.0)THEN ! WE ARE USING XRAYS
            A=COS(A)
            A=A*A
            DELTA=DELTA*(POL1+POL2*A*A)/(POL1+POL2*A)
          END IF
          EXT1=1.+2.*EXT*FC*FC*DELTA ! COMPUTE THE MODIFIED /FC/
          EXT2=1.0+EXT*FC*FC*DELTA
          EXT3=EXT2/(EXT1**(1.25))
          FCEXT=FC*(EXT1**(-.25))
        END IF

        FCEXS=FCEXT*SCALEG ! THE VALUE OF /FC/ AFTER SCALE FACTOR APPLIED

        IF(.NOT.TWINNED)THEN ! CHECK IF THIS IS A TWINNED STRUCTURE
          STORE(M6+5)=FCEXT*SCALES ! STORE FC AND PHASE IN THE LIST 6 SLOTS
          STORE(M6+6)=P
        END IF

        IF(ND.GE.0)THEN ! CHECK IF THE PARTIAL CONTRIBUTIONS ARE TO BE OUTPUT
          STORE(M6+7)=ACT ! STORE THE NEW CONTRIBUTIONS
          STORE(M6+8)=BCT
          CALL XACRT(8)  ! ACCUMULATE THE TOTALS FOR THE NEW PARTS
          CALL XACRT(9)
        END IF

        A=FO*W    ! ADD IN THE COMPUTED VALUES OF /FC/ ETC., TO THE OVERALL TOTALS
        DF=FO-FCEXS
        WDF=W*DF
        S=SCALEK

        IF(NV.GE.0)THEN ! 4500,4450,4450 ! CHECK IF WE REFINING AGAINST /FO/ **2
          A=ABS(FO)*FO*W  ! COMPUTE W-DELTA FOR /FO/ **2 REFINEMENT
          DF=ABS(FO)*FO-FCEXS*FCEXS
          WDF=W*DF
          S=SCALEK*SCALEK
        END IF
        AMINF=AMINF+WDF*WDF  ! COMPUTE THE MINIMISATION FUNCTION

        IF ((SFLS_TYPE.NE.SFLS_CALC) .OR.(KALLOW(IN).GE.0)) THEN
C If #CALC, then L28 was adjusted earlier. Call KALLOW again to get normal R
          NT=NT+1     ! UPDATE THE REFLECTION COUNTER FLAG
          FOT=FOT+FO   ! COMPUTE THE TERMS FOR THE NORMAL R-VALUE
          FOABS = FOABS + ABS(FO)
          FCT=FCT+FCEXS
          DFT=DFT+ABS(ABS(FO) - FCEXS)
          WDFT=WDFT+WDF*WDF  ! COMPUTE THE TERMS FOR THE WEIGHTED R-VALUE
          RW=RW+A*A
        ENDIF

        IF(REFPRINT)THEN !   CHECK IF A PRINT OF THE RELFECTIONS IS NEEDED
          P=P*D             ! PRINT ALL REFLECTIONS
          UJ=FO*SCALEK
          VJ=WDF*S
          WJ=DF*S
          A=SQRT(AC*AC+BC*BC)
          S=SQRT(ACI*ACI+BCI*BCI)
          T=4.*(BC*BCI+AC*ACI)
          C=T*200.0/(2.*FC*FC-T)
          IF (ISSPRT .EQ. 0) THEN 
            WRITE(NCWU,4600)STORE(M6),STORE(M6+1),STORE(M6+2),UJ,
     2      FCEXT,P,WJ,VJ,A,S,T,C,ST
          ENDIF
4600    FORMAT(3X,3F6.0,3F9.1,E13.4,E13.4,F8.1,F8.1,F9.1,F10.1,F10.5)

        ELSE   ! Only print worst 25 agreements.

          UJ = FO*SCALEK
          RDJW = ABS(WDF)
          IF (RDJW .GT. ABS(XVALUR)) THEN
C----  H,K,L,FO,FC,/WDELTA/,FO/FC
            CALL XMOVE(STORE(M6), STORE(LTEMPR), 3)
            STORE(LTEMPR+3) = UJ
            STORE(LTEMPR+4) = FCEXT
            STORE(LTEMPR+5) = RDJW
            STORE(LTEMPR+6) = MIN(99., UJ / MAX(FCEXT , ZERO))
            CALL SRTDWN(LSORT,MSORT,MDSORT,NSORT, JSORT, LTEMPR, 
     1              XVALUR, 0, DEF)
          ENDIF
          IF ( ABS(UJ-FCEXT) .GE. R*UJ .AND. IBADR .LE. 50 ) THEN
            IF (IBADR .LT. 0) THEN
              IF (ISSPRT .EQ. 0) WRITE(NCWU,4651)
              IBADR = 0
4651          FORMAT(10X,' Bad agreements ',/
     1      /1X,'   h    k    l      Fo        Fc '/)
            ELSE IF (IBADR .LT. 25) THEN
              IF (ISSPRT .EQ. 0) 
     1          WRITE(NCWU,4652)STORE(M6),STORE(M6+1),
     2                          STORE(M6+2),UJ,FCEXT
4652            FORMAT(1X,3F5.0,2F9.2)
            ELSE IF (IBADR .EQ. 25) THEN
              IF (ISSPRT .EQ. 0) WRITE(NCWU,4653)
4653          FORMAT(/' And so on ------------'/)
            ENDIF
            IBADR = IBADR + 1
          ENDIF
        END IF



        IF(SFLS_TYPE .NE. SFLS_REFINE)THEN    ! NO REFINEMENT
          IF(SFLS_TYPE .EQ. SFLS_SCALE)THEN ! CHECK IF WE ARE REFINING ONLY THE SCALE FACTOR
 
C--COMPUTE THE TOTALS FOR REFINEMENT OF THE SCALE FACTOR ONLY
            A=W*SCALES*FCEXT
            IF(NV.GE.0) A=A*SCALES*FCEXT  ! IF WE ARE REFINING AGAINST /FO/ **2

C Originally, CRYSTALS computed the scale wrt F, but this is non-linear,
C so convergence was poor. Now the shifts are wrt F**2. This is taken car
C of when the shift is applied. See near label 6100.

            SFO=SFO+WDF*A   ! ACCUMULATE THE TERMS FOR THE SCALE FACTOR
            SFC=SFC+A*A
          END IF
        ELSE

C--ADD THE CONTRIBUTIONS OF THE OVERALL PARAMETERS AND SCALE FACTORS.
C  THESE ARE COMPUTED WITH RESPECT TO 'FC' MODIFIED FOR EXTINCTION, RATH
C  THAN WITH RESPECT TO 'FC'. THIS IS WHY THEY ALL CONTAIN '1./EXT3'
C  TERM WHICH IS REMOVED LATER WHEN THE DERIVATIVES ARE MODIFIED FOR
C  EXTINCTION. THE FIRST PARAMETER IS THE OVERALL SCALE FACTOR.

          A=W*FCEXT*SCALES/EXT3

C---- TO REFINE SCALE OF F**2 (RATHER THAN F), SQUARE AND
C      TAKE OUT THE CORRECTION FACTOR TO BE APPLIED LATER, NEAR LABEL 5300

          IF(NV .GE. 0) A = A * FCEXT * SCALES / ( 2. * FCEXS )
          LJX=0
          M12=L12O
          CALL XADDPD ( A, 0, JO, JQ, JR) 

          A=W*FCEXS*TC/EXT3       ! OVERALL TEMPERATURE FACTORS NEXT
          CALL XADDPD ( A, 1, JO, JQ, JR) 
          CALL XADDPD ( A, 2, JO, JQ, JR) 
 
          CALL XADDPD ( ACF, 3, JO, JQ, JR)   ! THE POLARITY PARAMETER

          CALL XADDPD ( ACE, 4, JO, JQ, JR)  ! THE ENANTIOPOLE PARAMETER - HOWARD FLACK ACTA 1983,A39,876

          A=-0.5*SCALEW*FC*FC*FC*DELTA/EXT2   ! NOW THE EXTINCTION PARAMETER DERIVED BY LARSON
          CALL XADDPD ( A, 5, JO, JQ, JR) 
 
          IF(LAYER.GE.0)THEN                 ! CHECK IF LAYER SCALES ARE BEING USED
            A=W*SCALEO*SCALEB*FCEXT/EXT3
            M12=L12LS
            CALL XADDPD ( A, LAYER, JO, JQ, JR)  ! THE LAYER SCALES
          END IF

          IF(IBATCH.GE.0) THEN           ! CHECK IF BATCH SCALES ARE BEING USED
            A=W*SCALEO*SCALEL*FCEXT/EXT3
            M12=L12BS
            CALL XADDPD ( A, IBATCH, JO, JQ, JR)  ! THE BATCH SCALES  
          END IF

          IF ( ( NV.GE.0 ) .OR. EXTINCT ) THEN  ! Either FO^2, or extinction correction required.

            A=1.0

            IF ( NV .GE. 0 ) A=2.0*FCEXS   ! Correct derivatives for refinement against Fo^2
            IF ( EXTINCT ) A=A*EXT3      ! Modify for extinction

            DO LJX=JO,JP ! MODIFY THE PARTIAL DERIVATIVES FOR EXTINCTION AND REFINEMENT AGAINST
              STORE(LJX)=STORE(LJX)*A
            END DO

          END IF

          IF (ISTORE(L33CD+5).EQ.1) THEN   ! Check if we should output matrix in MATLAB format.
            DO I = JO,JP-MOD(JP-JO,5)-1,5
              WRITE(NCFPU1,'(5G16.8,'' ...'')') (STORE(I+J),J=0,4)
            END DO
            WRITE(NCFPU1,'(5G16.8)') (STORE(JP+J),J=0-MOD(JP-JO,5),0)
            WRITE(NCFPU2,'(F16.8)') WDF
          END IF

          CALL XADRHS(WDF,STORE(JO),STR11(L11R),JP-JO+1)  ! ACCUMULATE THE RIGHT HAND SIDES

          IF(NEWLHS)THEN   ! ACCUMULATE THE LEFT HAND SIDES
 
            IF (ISTORE(L33CD+12).EQ.0) THEN    ! Just a normal accumulation.
               if (ISTORE(L33CD+13).EQ.0) THEN
                  CALL PARM_PAIRS_XLHS(STORE(JO), JP-JO+1, STR11(L11), 
     1             N11, istore(l12b+1), iresults, nresults)
               else
                  CALL XADLHS( STORE(JO), JP-JO+1, STR11(L11), N11,
     1                 STORE(L12B), N12B*MD12B, MD12B )
               end if
            ELSE                    ! No accumulation, compute leverages, Pii.
               if (ISTORE(L33CD+13).EQ.0) THEN
                  write(CMON,'(A)')
     1                 'SPARSE IS NOT USED FOR LEVERAGE'
                  CALL XPRVDU(NCVDU, 1,0)
               end if
               Pii = PDOLEV( ISTORE(L12B),MD12B*N12B,MD12B,
     1                    STR11(L11),N11,  STORE(JO),JP-JO+1,
     2                    ISTORE(L33CD+12), TIX, RED)
              REDMAX = MAX ( REDMAX, RED )

              WRITE(HKLLAB, '(2(I4,A),I4)') NINT(STORE(M6)), ',',
     1                                     NINT(STORE(M6+1)), ',',
     2                                     NINT(STORE(M6+2))
              CALL XCRAS(HKLLAB, IHKLLEN)
              WRITE(CMON,'(3A,4F11.4)')
     1       '^^PL LABEL ''',HKLLAB(1:IHKLLEN),''' DATA ',FO,Pii,FO,
     2        RED*1000000000.0
              CALL XPRVDU(NCVDU, 1,0)


              IF (( ILEVPR .LT. 30 ) .OR. ( PII .LT. XVALUL ) ) THEN
C----    H,K,L,SNTHL,LEV,
                CALL XMOVE(STORE(M6), STORE(LTEMPL), 3)
                STORE(LTEMPL+3) = SST
                STORE(LTEMPL+4) = Pii
                STORE(LTEMPL+5) = FO*SCALEK
                STORE(LTEMPL+6) = FCEXT
                CALL SRTDWN(LLEVER,MLEVER,MDLEVE,NLEVER, JLEVER, LTEMPL, 
     1          XVALUL,-1, DEF3)
                ILEVPR = ILEVPR + 1
              END IF
            END IF
          END IF
        END IF

        CALL XSLR(1)  ! STORE THE LAST REFLECTION ON THE DISC
        CALL XACRT(6)  ! ACCUMULATE TOTALS FOR /FC/ 
        CALL XACRT(7)  ! AND THE PHASE
        CALL XACRT(16)

        IF(SFLS_TYPE .eq. SFLS_CALC) THEN ! ADD DETAILS FOR ALL DATA WHEN 'CALC'
          IF (STORE(M6+20) .GE. RALL(1)) THEN
            RALL(2) = RALL(2) + 1.
            RALL(3) = RALL(3) + ABS(ABS(FO)-FCEXS)
            RALL(4) = RALL(4) + ABS(FO)
            RALL(5) = RALL(5) + WDF*WDF
            RALL(6) = RALL(6) + A*A
          ENDIF
          RALL(7) = RALL(7) + 1.
          RALL(8) = RALL(8) + ABS(ABS(FO)-FCEXS)
          RALL(9) = RALL(9) + ABS(FO)
          RALL(10) = RALL(10) + WDF*WDF
          RALL(11) = RALL(11) + A*A
        ENDIF

      END DO  ! END OF REFLECTION LOOP



C--END OF THE REFLECTIONS  -  PRINT THE R-VALUES ETC.

      IF (ISTORE(L33CD+12).NE.0) THEN    ! Leverage plot
        WRITE(CMON,'(A,F18.14,A/A)')'^^PL YAXISRIGHT ZOOM 0.0 ',
     1   REDMAX,' SHOW',
     1   '^^CR'
        CALL XPRVDU(NCVDU, 2,0)
      ENDIF

      IF (NT .LE. 0) THEN
      IF (ISSPRT .EQ. 0) WRITE(NCWU,5851)
      WRITE ( CMON, 5851)
      CALL XPRVDU(NCVDU, 1,0)
5851  FORMAT(
     1 ' No reflections have been used for the Structure Factor',
     2 ' calculation')
         R = 0.
         A = 0.
         T = 0.
         RW = 0.
         S = 0.
      ELSE
      IF (FOABS .LE. 0.0) GOTO 19940
      R=DFT/FOABS*100.0
C----- PATCH TO AVOID INCIPIENT DIVISION BY ZERO
      IF(RW .LE. 0) GOTO 19930
      RW=SQRT(WDFT/RW)*100.0
      A=FOT/SCALEO
      S=FCT/SCALEO
      T=DFT/SCALEO
      ENDIF

      IF(SFLS_TYPE .EQ. SFLS_SCALE) THEN  ! WE ARE TO CALCULATE A NEW SCALE FACTOR HERE
        BC=0.               
        IF (SFC.GT.ZEROSQ) BC=SFO/SFC
C6100    CONTINUE. Scale factor shift is wrt F**2, change is necessary.
        IF (NV .GE. 0) THEN   ! REMEMBER THE SHIFT IS IN F**2
            STORE(L5O) = SQRT(STORE(L5O)*STORE(L5O) + BC)
        ELSE
            STORE(L5O)=STORE(L5O)+BC
        ENDIF
      END IF

C--STORE THE SCALE AND PRINT IT
      SCALE=STORE(L5O)
      LJX = 0
      IF ( TWINNED )THEN
        LJX = 4
        IF ( SCALED_FOT ) LJX=8
      END IF
      IF ( SFLS_TYPE .NE. SFLS_REFINE ) LJX = LJX + 1
      IF ( SFLS_TYPE .NE. SFLS_SCALE ) LJX = LJX + 2
C----- ENATIOMER SENSITIVE REFLECTIONS
      IF (IENPRT .GE. 0) THEN
6110      FORMAT(I6,
     1    ' enantiomer sensitive reflections.',
     2    ' Rt = 100x abs(F+ - F-)/<F+,F-> ')
          WRITE ( CMON, 6110) IENPRT
          CALL XPRVDU(NCVDU, 1,0)
          IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(1)(:)
          WRITE(CMON,6111)
6111      FORMAT
     1    (2('   h   k   l    F+     Fo     F-     Rt  '))
          CALL XPRVDU(NCVDU, 1,0)
          IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(1)(:)
          DO MENAN = LENAN, LENAN+(NENAN-1)*MDENAN, 2*MDENAN
          WRITE ( CMON,'(3I4, 3F7.2, F6.2,2X,3I4, 3F7.2, F6.2)')
     1     ( (NINT(STORE(IXAP)), IXAP=JXAP, JXAP+2),
     2     (STORE(IXAP), IXAP= JXAP+3,JXAP+5), STORE(JXAP+6),
     3     JXAP= MENAN, MENAN+MDENAN, MDENAN)
          CALL XPRVDU(NCVDU, 1,0)
          IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(1)(:)
          END DO
      ENDIF

      IF (ILEVPR .GT. 0) THEN
6112      FORMAT(I6,' low leverage reflections.')
          WRITE ( CMON, 6112) MIN(30,ILEVPR)
          CALL XPRVDU(NCVDU, 1,0)
          RLEVNM = 0.0
          RLEVDN = 0.0
          DO  MLEVER = LLEVER, LLEVER+(NLEVER-1)*MDLEVE, MDLEVE
            RLEVNM = RLEVNM + ABS(STORE(MLEVER+5)-STORE(MLEVER+6))
            RLEVDN = RLEVDN + STORE(MLEVER+5)
          END DO

          WRITE(CMON,'(''R(lowleverage) = <Fo-Fc>/<Fo> ='',F9.2,''%'')')
     1     100.*RLEVNM/MAX(.001,RLEVDN)
          CALL XPRVDU(NCVDU,1,0)

          WRITE(CMON,6113)
6113      FORMAT (2('   h   k   l sintl2 Leverage    FO-FC    '))
          CALL XPRVDU(NCVDU, 1,0)

          DO  MLEVER = LLEVER, LLEVER+(NLEVER-1)*MDLEVE, 2*MDLEVE
            WRITE (CMON,'(2(3I4,F6.3,X,F7.5,F10.3,5X))')
     1       ( (NINT(STORE(IXAP)), IXAP=JXAP, JXAP+2),
     2       (STORE(IXAP), IXAP= JXAP+3,JXAP+4),
     2       STORE(JXAP+5)-STORE(JXAP+6),
     3       JXAP= MLEVER, MLEVER+MDLEVE, MDLEVE)
            CALL XPRVDU(NCVDU, 1,0)
          END DO
      ENDIF
C
C Only print disagreeable reflections during calc.
      IF( SFLS_TYPE .EQ. SFLS_CALC ) THEN
        WRITE (CMON ,'(/'' Target GOF ='',F6.2)') SQRT(AMINF/FLOAT(NT))
        CALL XPRVDU(NCVDU, 2,0)
        IF(ISSPRT.EQ.0) WRITE(NCWU, '(//)')
        IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(2)(:)
        WRITE ( CMON ,11)
        CALL XPRVDU(NCVDU, 1,0)
        IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(1)(:)
11      FORMAT(2('   h   k  l     Fo      Fc   GOF Fo/Fc','  '))
        DO MSORT = LSORT, LSORT+(NSORT-1)*MDSORT, 2*MDSORT
          WRITE ( CMON ,
     *     '(3I4, 2F7.1, F7.2, F5.2,2X,3I4, 2F7.1, F7.2, F5.2)')
     1     ( (NINT(STORE(IXAP)), IXAP=JXAP, JXAP+2),
     2     (STORE(IXAP), IXAP= JXAP+3,JXAP+6),
     3     JXAP= MSORT, MSORT+MDSORT, MDSORT)
          CALL XPRVDU(NCVDU, 1,0)
          IF(ISSPRT.EQ.0) WRITE(NCWU, '(A)') CMON(1)(:)
        END DO
      END IF
C
      IF (ISSPRT .EQ. 0) THEN
        WRITE(NCWU,5900)R,RW,A,S,T
5900    FORMAT(/30X,3('*')/29X,3('*')/' R-value    Weighted R',6X,
     2  12('*'),14X,12('*')/27X,13('*'),2X,'HERE IT IS',2X,12('*')/
     3  F7.2,F12.2,9X,12('*'),14X,12('*')/29X,3('*')/30X,3('*')//
     4  ' Sum of /FO/    Sum of /FC/    Sum of /Delta/',
     5  '    Minimization function',//F11.1,F15.1,F16.1,34X,
     6  ' On scale of /FC/')
        WRITE(NCWU,5950)FOT,FCT,DFT,AMINF
5950    FORMAT(/F11.1,F15.1,F16.1,E25.8,9X,' On scale of /FO/')
        WRITE(NCWU,6150) STORE(L5O), NT
        WRITE(NCWU,6250)JI,LJX
      ENDIF
C
6150  FORMAT(/,' New scale factor (G) is ',F10.5,
     1 ',  ',I6,' reflections used in refinement')
6250  FORMAT(/,' Structure factor least squares calculation',I5,
     2 '  ends',I3)

      IF (S .GT. ZERO) S = A/S

      WRITE ( CMON, 6260) JI, N12, MIN(R,99.99), MIN(RW,99.99), AMINF,
     1 MIN(999.99,S)

6260  FORMAT (' Cycle',I5,' Params',I5,' R{9,1 ',F5.2,
     2 '%{8,1 Rw{9,1 ',F5.2,
     1 '%{8,1 MinFunc ',G9.2,' SumFo/SumFc ',F6.2)
      CALL OUTCOL(6)
      CALL XPRVDU(NCVDU, 1, 0)
      CALL OUTCOL(1)

      CALL CPU_TIME ( time_end )
c      WRITE ( NCWU, '(A,F15.8)' )'SFLSC seconds: ',time_end - time_begin

      RETURN



19900 CONTINUE
C -- ERRORS
      RETURN
19910 CONTINUE
C -- INCORRECT ELEMENT NUMBER
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 19915 ) LJX , PH , PK , PL
      WRITE ( CMON, 19915) LJX , PH , PK , PL
      CALL XPRVDU(NCVDU, 1,0)
19915 FORMAT ( 1X , I5 , ' is an incorrect element number for ' ,
     1 'reflection ' , 3F5.0 )
      CALL XERHND ( IERERR )
      GO TO 19900
C
19920 CONTINUE
C -- TOO MANY ELEMENTS
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 19925 ) PH , PK , PL
      WRITE ( CMON , 19925 ) PH , PK , PL
      CALL XPRVDU(NCVDU, 1,0)
19925 FORMAT ( 1X , 'Too many elements given for reflection ', 3F5.0 )
      CALL XERHND ( IERERR )
      GO TO 19900
C
19930 CONTINUE
C------ SIGMA W*FO*FO .LE. ZERO ---- SUGGESTS PROBABLY NO WEIGHTS
      IF (ISSPRT .EQ. 0) WRITE(NCWU,19935)
      WRITE ( CMON, 19935)
      CALL XPRVDU(NCVDU, 2,0)
19935 FORMAT(1X,'The denominator for the weighted R factor ',
     1 'is less than or equal to zero.'/
     2 ' Check that you have applied weights.')
      CALL XERHND ( IERERR )
      GOTO 19900
C
19940 CONTINUE
C------ SIGMA FO .LE. ZERO ---- SUGGESTS PROBABLY NO CALCULATION
      IF (ISSPRT .EQ. 0) WRITE(NCWU,19945)
      WRITE ( CMON, 19945)
      CALL XPRVDU(NCVDU, 2,0)
19945 FORMAT(1X,'The denominator for the R factor ',
     1 'is less than or equal to zero.',/,
     2 ' No structure factors have been stored.')

      END




CODE FOR KLAYER
      FUNCTION KLAYER(IN)
C--COMPUTE THE LAYER SCALE INDEX FOR THE CURRENT REFLECTION.
C
C  IN  A DUMMY ARGUMENT.
C
C--RETURN VALUES OF 'KLAYER' ARE :
C
C  -1  NO LAYER SCALES IN LIST 5.
C  >0  THE LAYER SCALE INDEX.
C
C--
\ISTORE
C
\STORE
\XUNITS
\XSSVAL
\XLST05
\XLST06
\XERVAL
\XIOBUF
C
\QSTORE
C
      IDWZAP = IN
C--
      KLAYER=-1

      IF(MD5LS.GT.0)THEN  ! ARE THERE ANY LAYER SCALES STORED?

        A=STORE(L5LSC)*STORE(M6)+STORE(L5LSC+1)*STORE(M6+1)
     2   +STORE(L5LSC+2)*STORE(M6+2)  ! !  COMPUTE THE INDEX VALUE

        IF(STORE(L5LSC+4).LT.0) A=ABS(A) ! Take absolute value

        I=NINT(A+STORE(L5LSC+3))  ! COMPUTE THE OUTPUT INDEX

        IF((I.LE.0).OR.(I.GT.MD5LS))THEN  ! ILLEGAL LAYER SCALE VALUE
          CALL XERHDR(0)
          IF (ISSPRT .EQ. 0)
     1     WRITE(NCWU,1200)NINT(STORE(M6)),NINT(STORE(M6+1)),
     2     NINT(STORE(M6+2)),I
          WRITE(CMON,1200)NINT(STORE(M6)),NINT(STORE(M6+1)),
     2    NINT(STORE(M6+2)),I
          CALL XPRVDU(NCVDU, 1,0)
1200      FORMAT(' Reflection : ',3I5,
     2 '  generates an illegal layer scale index of ',I4)
          CALL XERHND ( IERERR )
          RETURN
        END IF

        KLAYER=I
      END IF
      RETURN
      END

CODE FOR KBATCH
      FUNCTION KBATCH(IN)
C--COMPUTE THE BATCH SCALE INDEX FOR THE CURRENT REFLECTION.
C
C  IN  A DUMMY ARGUMENT.
C
C--RETURN VALUES OF 'KBATCH' ARE :
C
C  -1  NO BATCH SCALES IN LIST 5.
C  >0  THE BATCH SCALE INDEX.
C
C--
\ISTORE
\STORE
\XUNITS
\XSSVAL
\XLST05
\XLST06
\XERVAL
\XIOBUF
\QSTORE

      IDWZAP = IN
      KBATCH=-1
      IF (MD5BS.GT.0) THEN   ! ARE ANY BATCH SCALES STORED
        I=NINT(STORE(M6+13))  ! COMPUTE THE INDEX VALUE
C--CHECK IF THE VALUE IS LARGE ENOUGH
        IF((I.LE.0).OR.(I.GT.MD5BS))THEN 
          CALL XERHDR(0)  ! ILLEGAL BATCH SCALE VALUE
          IF (ISSPRT .EQ. 0)
     1     WRITE(NCWU,1100)NINT(STORE(M6)),NINT(STORE(M6+1)),
     2      NINT(STORE(M6+2)),I
          WRITE(CMON,1100)NINT(STORE(M6)),NINT(STORE(M6+1)),
     2     NINT(STORE(M6+2)),I
          CALL XPRVDU(NCVDU, 1,0)
1100      FORMAT(' Reflection : ',3I5,
     2 '  generates an illegal batch scale index of ',I4)
          CALL XERHND ( IERERR )
          RETURN
        END IF
        KBATCH=I
      END IF
      RETURN
      END


CODE FOR XLINE
      SUBROUTINE XLINE (M2LI, M5ALI, M6LI,
     2 LIFAC, DLFLILE, DLFTHE, DLFPHI)
\ISTORE
C-C-C-AGREEMENT OF CONSTANTS AND VARIABLES
C-C-C-CELL-CONSTANTS, REFLECTION-INDICES
      REAL CONA, CONB, CONC, CONAL, CONBET, CONGA, COGAST
      REAL REFLH, REFLK, REFLL
C-C-C-COORDINATES FOR LINE (POLAR, CARTESIAN, TRICLINIC)
      REAL LILE, ANGLZD, AZIMXD, ANGLZ, AZIMX
      REAL LINCX, LINCY, LINCZ, LINX, LINY, LINZ
C-C-C-SOME TRANSFERRED STARTING-ADDRESSES OF ACTUAL (!) PARAMETERS
      INTEGER M2LI, M5ALI, M6LI
C-C-C-TRANSF. BETWEEN COORD. SYST. (CARTESIAN TO TRIGONAL)
      REAL CATRI11, CATRI12, CATRI13
      REAL CATRI21, CATRI22, CATRI23
      REAL CATRI31, CATRI32, CATRI33
C-C-C-SOME ABBREVIATIONS
C-C-C-...FOR STRUCTURFACTOR-CALCULATION
      REAL COSIA, COSIB, COSIC, COSIRO
      REAL DOTHLX, DOTHLY, DOTHLZ, DOTHL
      DOUBLE PRECISION LIFAC
C-C-C-...FOR DERIVATIVES
      REAL DLINXLL, DLINYLL, DLINZLL
      REAL DLINXTHE, DLINYTHE, DLINZTHE
      REAL DLINXPHI, DLINYPHI, DLINZPHI
      REAL DDOTLL, DDOTTHE, DDOTPHI
      DOUBLE PRECISION DLFLILE, DLFTHE, DLFPHI
\STORE
\XCONST
\XLST01
\QSTORE
C-C-C-CALCULATE THE LINE
C-C-C-ABBREVIATIONS FOR CONSTANTS AND VARIABLES
      CONA=STORE(L1P1)
      CONB=STORE(L1P1+1)
      CONC=STORE(L1P1+2)
      CONAL=STORE(L1P1+3)
      CONBET=STORE(L1P1+4)
      CONGA=STORE(L1P1+5)
      REFLH=STORE(M6LI)
      REFLK=STORE(M6LI+1)
      REFLL=STORE(M6LI+2)
      LILE=STORE(M5ALI+8)
C-C-C-(POLAR ANGLES IN UNITS OF 100 DEGREES)
      ANGLZD=STORE(M5ALI+9)
      AZIMXD=STORE(M5ALI+10)
C-C-C-TRANSFORMATION OF DEGREES (IN UNITS OF 100 DEGREES) TO RADIANS
      ANGLZ=ANGLZD*TWOPI/3.6
      AZIMX=AZIMXD*TWOPI/3.6
C-C-C-PREP. OF CALC. OF THE DOT-PROD. OF LINE AND HKL AND HKL-LENGTH
      COSIA=COS(CONBET)*COS(CONGA)-COS(CONAL)
      COSIB=COS(CONAL)*COS(CONGA)-COS(CONBET)
      COSIC=COS(CONAL)*COS(CONBET)-COS(CONGA)
      COSIRO=1+2*COS(CONAL)*COS(CONBET)*COS(CONGA)
     2 -(COS(CONAL))**2-(COS(CONBET))**2-(COS(CONGA))**2
C-C-C-CALCULATION OF RECIPROCAL CELL-CONSTANTS FROM REAL CELL-CONSTANTS
      COGAST=((COS(CONAL)*COS(CONBET))-COS(CONGA))
     2 /(SIN(CONAL)*SIN(CONBET))
C-C-C-GETTING MATRIX (TRANSF. CART. --> TRICL.) FROM CRYSTALS
      CATRI11=STORE(L1O2+0)
      CATRI12=STORE(L1O2+3)
      CATRI13=STORE(L1O2+6)
      CATRI21=STORE(L1O2+1)
      CATRI22=STORE(L1O2+4)
      CATRI23=STORE(L1O2+7)
      CATRI31=STORE(L1O2+2)
      CATRI32=STORE(L1O2+5)
      CATRI33=STORE(L1O2+8)
C-C-C-CALC. OF THE CARTESIAN COORD. OF LINE IN REAL SPACE
      LINCX=LILE*SIN(ANGLZ)*COS(AZIMX)
      LINCY=LILE*SIN(ANGLZ)*SIN(AZIMX)
      LINCZ=LILE*COS(ANGLZ)
C-C-C-CALC. OF THE TRICLINIC COORD. OF LINE IN REAL SPACE
      LINX=LINCX*CATRI11+LINCY*CATRI12+LINCZ*CATRI13
      LINY=LINCX*CATRI21+LINCY*CATRI22+LINCZ*CATRI23
      LINZ=LINCX*CATRI31+LINCY*CATRI32+LINCZ*CATRI33
C-C-C-CALC. OF SYMMETRY-EQUIVALENT DIRECTIONS (TRANSF. OF VECTOR-
C-C-C-END-POINT BY ROTATIONAL PART ONLY)
      LINX=LINX*STORE(M2LI)+LINY*STORE(M2LI+1)+LINZ*STORE(M2LI+2)
      LINY=LINX*STORE(M2LI+3)+LINY*STORE(M2LI+4)+LINZ*STORE(M2LI+5)
      LINZ=LINX*STORE(M2LI+6)+LINY*STORE(M2LI+7)+LINZ*STORE(M2LI+8)
C-C-C-CALC. DOT-PRODUCT OF HKL-VECTOR AND LINE-VECTOR IN REC. SPACE
      DOTHLX=COSIC*((REFLK*CONA/CONB)+REFLH*COS(CONGA))
     2 +COSIB*((REFLL*CONA/CONC)+REFLH*COS(CONBET))
     3 +COSIA*((REFLL*CONA*COS(CONGA)/CONC)
     4         +(REFLK*CONA*COS(CONBET)/CONB))
     5 +REFLH*(SIN(CONAL)**2)
     6 +(REFLK*CONA*(SIN(CONBET)**2)*COS(CONGA)/CONB)
     7 +(REFLL*CONA*(SIN(CONGA)**2)*COS(CONBET)/CONC)
      DOTHLY=COSIC*(REFLK*COS(CONGA)+(REFLH*CONB/CONA))
     2 +COSIB*((REFLL*CONB*COS(CONGA)/CONC)
     3         +(REFLH*CONB*COS(CONAL)/CONA))
     4 +COSIA*((REFLL*CONB/CONC)+REFLK*COS(CONAL))
     5 +(REFLH*CONB*(SIN(CONAL)**2)*COS(CONGA)/CONA)
     6 +REFLK*(SIN(CONBET)**2)
     7 +(REFLL*CONB*(SIN(CONGA)**2)*COS(CONAL)/CONC)
      DOTHLZ=COSIC*((REFLK*CONC*COS(CONBET)/CONB)
     2              +(REFLH*CONC*COS(CONAL)/CONA))
     3 +COSIB*(REFLL*COS(CONBET)+(REFLH*CONC/CONA))
     4 +COSIA*(REFLL*COS(CONAL)+(REFLK*CONC/CONB))
     5 +(REFLH*CONC*(SIN(CONAL)**2)*COS(CONBET)/CONA)
     6 +(REFLK*CONC*(SIN(CONBET)**2)*COS(CONAL)/CONB)
     7 +REFLL*(SIN(CONGA)**2)
      DOTHL=(LINX*DOTHLX+LINY*DOTHLY+LINZ*DOTHLZ)/COSIRO
C-C-C-CALCULATE FINAL FACTOR FOR LINE s
C-C-C-TEST WHETHER DOTHL APPROACHES ZERO
      IF (ABS(DOTHL) .LE. ZEROSQ) THEN
      LIFAC=1.0
      ELSE
      LIFAC=SIN(PI*DOTHL)/(PI*DOTHL)
      ENDIF
C-C-C-CALCULATE DERIVATIVES
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR LINE (LILE)
      DLINXLL=SIN(ANGLZ)*COS(AZIMX)*CATRI11
     2       +SIN(ANGLZ)*SIN(AZIMX)*CATRI12
     3       +COS(ANGLZ)*CATRI13
      DLINYLL=SIN(ANGLZ)*COS(AZIMX)*CATRI21
     2       +SIN(ANGLZ)*SIN(AZIMX)*CATRI22
     3       +COS(ANGLZ)*CATRI23
      DLINZLL=SIN(ANGLZ)*COS(AZIMX)*CATRI31
     2       +SIN(ANGLZ)*SIN(AZIMX)*CATRI32
     3       +COS(ANGLZ)*CATRI33
      DDOTLL=(DLINXLL*DOTHLX+DLINYLL*DOTHLY+DLINZLL*DOTHLZ)/COSIRO
C-C-C-TEST WHETHER DOTHL APPROACHES ZERO
      IF (ABS(DOTHL) .LE. ZEROSQ) THEN
      DLFLILE=0.0
      ELSE
      DLFLILE=((DOTHL*COS(PI*DOTHL)-SIN(PI*DOTHL)/PI)*DDOTLL)
     2 /(DOTHL**2)
      ENDIF
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR LINE (ANGLZ)
      DLINXTHE=LILE*COS(ANGLZ)*COS(AZIMX)*CATRI11
     2        +LILE*COS(ANGLZ)*SIN(AZIMX)*CATRI12
     3        -LILE*SIN(ANGLZ)*CATRI13
      DLINYTHE=LILE*COS(ANGLZ)*COS(AZIMX)*CATRI21
     2        +LILE*COS(ANGLZ)*SIN(AZIMX)*CATRI22
     3        -LILE*SIN(ANGLZ)*CATRI23
      DLINZTHE=LILE*COS(ANGLZ)*COS(AZIMX)*CATRI31
     2        +LILE*COS(ANGLZ)*SIN(AZIMX)*CATRI32
     3        -LILE*SIN(ANGLZ)*CATRI33
      DDOTTHE=(DLINXTHE*DOTHLX+DLINYTHE*DOTHLY+DLINZTHE*DOTHLZ)
     2        *TWOPI/(3.6*COSIRO)
C-C-C-TEST WHETHER DOTHL APPROACHES ZERO
      IF (ABS(DOTHL) .LE. ZEROSQ) THEN
      DLFTHE=0.0
      ELSE
      DLFTHE=((DOTHL*COS(PI*DOTHL)-SIN(PI*DOTHL)/PI)*DDOTTHE)
     2 /(DOTHL**2)
      ENDIF
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR LINE (AZIMX)
      DLINXPHI=-LILE*SIN(ANGLZ)*SIN(AZIMX)*CATRI11
     2        +LILE*SIN(ANGLZ)*COS(AZIMX)*CATRI12
      DLINYPHI=-LILE*SIN(ANGLZ)*SIN(AZIMX)*CATRI21
     2        +LILE*SIN(ANGLZ)*COS(AZIMX)*CATRI22
      DLINZPHI=-LILE*SIN(ANGLZ)*SIN(AZIMX)*CATRI31
     2        +LILE*SIN(ANGLZ)*COS(AZIMX)*CATRI32
      DDOTPHI=(DLINXPHI*DOTHLX+DLINYPHI*DOTHLY+DLINZPHI*DOTHLZ)
     2        *TWOPI/(3.6*COSIRO)
C-C-C-TEST WHETHER DOTHL APPROACHES ZERO
      IF (ABS(DOTHL) .LE. ZEROSQ) THEN
      DLFPHI=0.0
      ELSE
      DLFPHI=((DOTHL*COS(PI*DOTHL)-SIN(PI*DOTHL)/PI)*DDOTPHI)
     2 /(DOTHL**2)
      ENDIF
      END

CODE FOR XRING
      SUBROUTINE XRING (M2RI, STRI, M5ARI, M6RI,
     2 RIFAC, DRFRA, DRFTHE, DRFPHI)
\ISTORE
C-C-C-AGREEMENT OF CONSTANTS AND VARIABLES
C-C-C-CELL-CONSTANTS, REFLECTION-INDICES
      REAL CONA, CONB, CONC, CONAL, CONBET, CONGA
      REAL REFLH, REFLK, REFLL
C-C-C-PARAMETERS/COORDINATES FOR RING (POLAR, CARTESIAN, TRICLINIC)
      REAL RIRA, ANGLZD, AZIMXD
      DOUBLE PRECISION ANGLZ, AZIMX
      DOUBLE PRECISION LINCX, LINCY, LINCZ, LINX, LINY, LINZ
C-C-C-SOME TRANSFERRED STARTING-ADDRESSES OF ACTUAL (!) PARAMETERS
      INTEGER M2RI, M5ARI, M6RI
C-C-C-TRANSFERRED VALUE OF ST
      REAL STRI
C-C-C-TRANSF. BETWEEN COORD. SYST. (CARTESIAN TO TRIGONAL)
      REAL CATRI11, CATRI12, CATRI13
      REAL CATRI21, CATRI22, CATRI23
      REAL CATRI31, CATRI32, CATRI33
C-C-C-SOME ABBREVIATIONS
C-C-C-...FOR STRUCTURFACTOR-CALCULATION
      DOUBLE PRECISION COSIA, COSIB, COSIC, COSIRO
      DOUBLE PRECISION DOTHLX, DOTHLY, DOTHLZ, DOTHL
      DOUBLE PRECISION COSPSI, SINPSI
      DOUBLE PRECISION BESSR1, BESSR2, BESSR3, BESSR4, BESSR5, BESSR6
      DOUBLE PRECISION BESSS1, BESSS2, BESSS3, BESSS4, BESSS5, BESSS6
      DOUBLE PRECISION BESSP1, BESSP2, BESSP3, BESSP4, BESSP5
      DOUBLE PRECISION BESSQ1, BESSQ2, BESSQ3, BESSQ4, BESSQ5
      DOUBLE PRECISION ARGBES, ARGSQ, SICARG, RAR8SQ, RIFAC
C-C-C-...FOR DERIVATIVES
      DOUBLE PRECISION DLINXTHE, DLINYTHE, DLINZTHE
      DOUBLE PRECISION DLINXPHI, DLINYPHI, DLINZPHI
      DOUBLE PRECISION DDOTTHE, DDOTPHI, DRFOUT, DARGRA
      DOUBLE PRECISION DARGTHE, DARGPHI, DRFRA, DRFTHE, DRFPHI
\STORE
\XCONST
\XLST01
\QSTORE
C-C-C-VARIABLES FOR BESSEL-FUNCTIONS ARE PREOCCUPIED
      DATA BESSR1,BESSR2,BESSR3,BESSR4,BESSR5,BESSR6
     2 /57568490574.D0, -13362590354.D0, 651619640.7D0,
     3 -11214424.18D0, 77392.33017D0, -184.9052456D0/
      DATA BESSS1,BESSS2,BESSS3,BESSS4,BESSS5,BESSS6
     2 /57568490411.D0, 1029532985.D0, 9494680.718D0,
     3 59272.64853D0, 267.8532712D0, 1.D0/
      DATA BESSP1,BESSP2,BESSP3,BESSP4,BESSP5
     2 /1.D0, -.1098628627D-2, .2734510407D-4,
     3 -.2073370639D-5, .2093887211D-6/
      DATA BESSQ1,BESSQ2,BESSQ3,BESSQ4,BESSQ5
     2 /-.1562499995D-1, .1430488765D-3, -.6911147651D-5,
     3 .7621095161D-6, -.934945152D-7/
C-C-C-CALCULATE THE RING
C-C-C-ABBREVIATIONS FOR CONSTANTS AND VARIABLES
      CONA=STORE(L1P1)
      CONB=STORE(L1P1+1)
      CONC=STORE(L1P1+2)
      CONAL=STORE(L1P1+3)
      CONBET=STORE(L1P1+4)
      CONGA=STORE(L1P1+5)
      REFLH=STORE(M6RI)
      REFLK=STORE(M6RI+1)
      REFLL=STORE(M6RI+2)
      RIRA=STORE(M5ARI+8)
C-C-C-(POLAR ANGLES IN UNITS OF 100 DEGREES)
      ANGLZD=STORE(M5ARI+9)
      AZIMXD=STORE(M5ARI+10)
C-C-C-TRANSFORMATION OF DEGREES (IN UNITS OF 100 DEGREES) TO RADIANS
      ANGLZ=ANGLZD*TWOPI/3.6
      AZIMX=AZIMXD*TWOPI/3.6
C-C-C-PREP. OF CALC. OF THE DOT-PROD. OF RING-NORMAL, HKL(-LENGTH)
      COSIA=COS(CONBET)*COS(CONGA)-COS(CONAL)
      COSIB=COS(CONAL)*COS(CONGA)-COS(CONBET)
      COSIC=COS(CONAL)*COS(CONBET)-COS(CONGA)
      COSIRO=1+2*COS(CONAL)*COS(CONBET)*COS(CONGA)
     2 -(COS(CONAL))**2-(COS(CONBET))**2-(COS(CONGA))**2
C-C-C-GETTING MATRIX (TRANSF. CART. --> TRICL.) FROM CRYSTALS
      CATRI11=STORE(L1O2+0)
      CATRI12=STORE(L1O2+3)
      CATRI13=STORE(L1O2+6)
      CATRI21=STORE(L1O2+1)
      CATRI22=STORE(L1O2+4)
      CATRI23=STORE(L1O2+7)
      CATRI31=STORE(L1O2+2)
      CATRI32=STORE(L1O2+5)
      CATRI33=STORE(L1O2+8)
C-C-C-CALC. OF THE CARTESIAN COORD. OF RING-NORMAL IN REAL SPACE
      LINCX=SIN(ANGLZ)*COS(AZIMX)
      LINCY=SIN(ANGLZ)*SIN(AZIMX)
      LINCZ=COS(ANGLZ)
C-C-C-CALC. OF THE TRICLINIC COORD. OF RING-NORMAL IN REAL SPACE
      LINX=LINCX*CATRI11+LINCY*CATRI12+LINCZ*CATRI13
      LINY=LINCX*CATRI21+LINCY*CATRI22+LINCZ*CATRI23
      LINZ=LINCX*CATRI31+LINCY*CATRI32+LINCZ*CATRI33
C-C-C-CALC. OF SYMMETRY-EQUIVALENT DIRECTIONS (TRANSF. OF VECTOR-
C-C-C-END-POINT BY ROTATIONAL PART ONLY)
      LINX=LINX*STORE(M2RI)+LINY*STORE(M2RI+1)+LINZ*STORE(M2RI+2)
      LINY=LINX*STORE(M2RI+3)+LINY*STORE(M2RI+4)+LINZ*STORE(M2RI+5)
      LINZ=LINX*STORE(M2RI+6)+LINY*STORE(M2RI+7)+LINZ*STORE(M2RI+8)
C-C-C-CALC. DOT-PROD. OF HKL-VECT. AND RING-NORMAL-VECT. IN REC. SPACE
      DOTHLX=COSIC*((REFLK*CONA/CONB)+REFLH*COS(CONGA))
     2 +COSIB*((REFLL*CONA/CONC)+REFLH*COS(CONBET))
     3 +COSIA*((REFLL*CONA*COS(CONGA)/CONC)
     4         +(REFLK*CONA*COS(CONBET)/CONB))
     5 +REFLH*(SIN(CONAL)**2)
     6 +(REFLK*CONA*(SIN(CONBET)**2)*COS(CONGA)/CONB)
     7 +(REFLL*CONA*(SIN(CONGA)**2)*COS(CONBET)/CONC)
      DOTHLY=COSIC*(REFLK*COS(CONGA)+(REFLH*CONB/CONA))
     2 +COSIB*((REFLL*CONB*COS(CONGA)/CONC)
     3         +(REFLH*CONB*COS(CONAL)/CONA))
     4 +COSIA*((REFLL*CONB/CONC)+REFLK*COS(CONAL))
     5 +(REFLH*CONB*(SIN(CONAL)**2)*COS(CONGA)/CONA)
     6 +REFLK*(SIN(CONBET)**2)
     7 +(REFLL*CONB*(SIN(CONGA)**2)*COS(CONAL)/CONC)
      DOTHLZ=COSIC*((REFLK*CONC*COS(CONBET)/CONB)
     2              +(REFLH*CONC*COS(CONAL)/CONA))
     3 +COSIB*(REFLL*COS(CONBET)+(REFLH*CONC/CONA))
     4 +COSIA*(REFLL*COS(CONAL)+(REFLK*CONC/CONB))
     5 +(REFLH*CONC*(SIN(CONAL)**2)*COS(CONBET)/CONA)
     6 +(REFLK*CONC*(SIN(CONBET)**2)*COS(CONAL)/CONB)
     7 +REFLL*(SIN(CONGA)**2)
      DOTHL=(LINX*DOTHLX+LINY*DOTHLY+LINZ*DOTHLZ)/COSIRO
C-C-C-CALCULATE COSINE OF ANGLE BETWEEN HKL-VECTOR AND RING-NORMAL
      COSPSI=DOTHL/(2*STRI)
      IF (COSPSI .GT. 1.0) THEN
      COSPSI=1.0
      ELSE IF (COSPSI .LT. -1.0) THEN
      COSPSI=-1.0
      ENDIF
C-C-C-CALCULATE SINE OF ANGLE BETWEEN HKL-VECTOR AND RING-NORMAL
      SINPSI=SQRT(1-COSPSI**2)
C-C-C-CALCULATE FINAL FACTOR FOR RING s
      ARGBES=2*TWOPI*STRI*RIRA*SINPSI
      IF (ARGBES .LT. 8.) THEN
      ARGSQ=ARGBES**2
      RIFAC=(BESSR1+ARGSQ*(BESSR2+ARGSQ*(BESSR3+ARGSQ
     2 *(BESSR4+ARGSQ*(BESSR5+ARGSQ*BESSR6)))))
     3 /(BESSS1+ARGSQ*(BESSS2+ARGSQ*(BESSS3+ARGSQ
     4 *(BESSS4+ARGSQ*(BESSS5+ARGSQ*BESSS6)))))
      ELSE
      SICARG=ARGBES-.785398164
      RAR8SQ=(8./ARGBES)**2
      RIFAC=SQRT(.636619772/ARGBES)*(COS(SICARG)
     2 *(BESSP1+RAR8SQ*(BESSP2+RAR8SQ*(BESSP3+RAR8SQ
     3 *(BESSP4+RAR8SQ*BESSP5))))
     4 -(8./ARGBES)*SIN(SICARG)
     5 *(BESSQ1+RAR8SQ*(BESSQ2+RAR8SQ*(BESSQ3+RAR8SQ
     6 *(BESSQ4+RAR8SQ*BESSQ5)))))
      ENDIF
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR RING (ANGLZ)
      DLINXTHE=COS(ANGLZ)*COS(AZIMX)*CATRI11
     2        +COS(ANGLZ)*SIN(AZIMX)*CATRI12
     3        -SIN(ANGLZ)*CATRI13
      DLINYTHE=COS(ANGLZ)*COS(AZIMX)*CATRI21
     2        +COS(ANGLZ)*SIN(AZIMX)*CATRI22
     3        -SIN(ANGLZ)*CATRI23
      DLINZTHE=COS(ANGLZ)*COS(AZIMX)*CATRI31
     2        +COS(ANGLZ)*SIN(AZIMX)*CATRI32
     3        -SIN(ANGLZ)*CATRI33
      DDOTTHE=(DLINXTHE*DOTHLX+DLINYTHE*DOTHLY+DLINZTHE*DOTHLZ)
     2        *TWOPI/(3.6*COSIRO)
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR RING (AZIMX)
      DLINXPHI=-SIN(ANGLZ)*SIN(AZIMX)*CATRI11
     2        +SIN(ANGLZ)*COS(AZIMX)*CATRI12
      DLINYPHI=-SIN(ANGLZ)*SIN(AZIMX)*CATRI21
     2        +SIN(ANGLZ)*COS(AZIMX)*CATRI22
      DLINZPHI=-SIN(ANGLZ)*SIN(AZIMX)*CATRI31
     2        +SIN(ANGLZ)*COS(AZIMX)*CATRI32
      DDOTPHI=(DLINXPHI*DOTHLX+DLINYPHI*DOTHLY+DLINZPHI*DOTHLZ)
     2        *TWOPI/(3.6*COSIRO)
C-C-C-ABBR. FOR PART. DERIV. W.R.T. A AND (!) B FOR RING
C-C-C-OUTER DERIV. FOR RIRA, ANGLZ AND AZIMX (FOR ARGBES < 8.)
      IF (ARGBES .LT. 8.) THEN
      DRFOUT=ARGBES
     2 *((2*BESSR2+ARGSQ*(4*BESSR3+ARGSQ*(6*BESSR4+ARGSQ
     3 *(8*BESSR5+ARGSQ*10*BESSR6))))
     4 *(BESSS1+ARGSQ*(BESSS2+ARGSQ*(BESSS3+ARGSQ
     5 *(BESSS4+ARGSQ*(BESSS5+ARGSQ*BESSS6)))))
     6 -(2*BESSS2+ARGSQ*(4*BESSS3+ARGSQ*(6*BESSS4+ARGSQ
     7 *(8*BESSS5+ARGSQ*10*BESSS6))))
     8 *(BESSR1+ARGSQ*(BESSR2+ARGSQ*(BESSR3+ARGSQ
     9 *(BESSR4+ARGSQ*(BESSR5+ARGSQ*BESSR6))))))
     A /((BESSS1+ARGSQ*(BESSS2+ARGSQ*(BESSS3+ARGSQ
     B *(BESSS4+ARGSQ*(BESSS5+ARGSQ*BESSS6)))))**2)
C-C-C-OUTER DERIV. FOR RIRA, ANGLZ AND AZIMX (FOR ARGBES >/= 8.)
      ELSE
      DRFOUT=(SQRT(.636619772/ARGBES)/ARGBES)*((8./ARGBES)
     2 *(BESSQ1*(1.5*SIN(SICARG)-ARGBES*COS(SICARG))+RAR8SQ
     3 *(BESSQ2*(3.5*SIN(SICARG)-ARGBES*COS(SICARG))+RAR8SQ
     4 *(BESSQ3*(5.5*SIN(SICARG)-ARGBES*COS(SICARG))+RAR8SQ
     5 *(BESSQ4*(7.5*SIN(SICARG)-ARGBES*COS(SICARG))+RAR8SQ
     6  *BESSQ5*(9.5*SIN(SICARG)-ARGBES*COS(SICARG))))))
     7 -(BESSP1*(ARGBES*SIN(SICARG)+0.5*COS(SICARG))+RAR8SQ
     8 *(BESSP2*(ARGBES*SIN(SICARG)+2.5*COS(SICARG))+RAR8SQ
     9 *(BESSP3*(ARGBES*SIN(SICARG)+4.5*COS(SICARG))+RAR8SQ
     A *(BESSP4*(ARGBES*SIN(SICARG)+6.5*COS(SICARG))+RAR8SQ
     B  *BESSP5*(ARGBES*SIN(SICARG)+8.5*COS(SICARG)))))))
      ENDIF
C-C-C-INNER DERIV. FOR RIRA
      DARGRA=2*TWOPI*STRI*SINPSI
C-C-C-CHECK, WHETHER SINPSI APPROACHES ZERO
      IF (SINPSI .LT. ZEROSQ) THEN
        DRFTHE=0.0
        DRFPHI=0.0
      ELSE
C-C-C-INNER DERIV. FOR ANGLZ
        DARGTHE=-TWOPI*RIRA*DOTHL*DDOTTHE/(2*STRI*SINPSI)
C-C-C-INNER DERIV. FOR AZIMX
        DARGPHI=-TWOPI*RIRA*DOTHL*DDOTPHI/(2*STRI*SINPSI)
C-C-C-PART. DERIV. W.R.T. A AND (!) B FOR RING (ANGLZ,AZIMX,RIRA)
        DRFTHE=DRFOUT*DARGTHE
        DRFPHI=DRFOUT*DARGPHI
      ENDIF
      DRFRA=DRFOUT*DARGRA
      END

CODE FOR XSPHERE
      SUBROUTINE XSPHERE (STSP, M5ASP, SPHEFAC, DSFRAD)
\ISTORE
C-C-C-TRANSFERRED STARTING-ADDRESSES OF M5A
      INTEGER M5ASP
C-C-C-TRANSFERRED VALUE OF ST
      REAL STSP
C-C-C-AGREEMENT OF VARIABLES (SPHERE-FACTOR AND DERIVATIV)
      DOUBLE PRECISION SPHEFAC
      DOUBLE PRECISION DSFRAD
\STORE
\XCONST
\QSTORE
C-C-C-CALCULATE THE SPHERE-FACTOR
      SPHEFAC=(SIN(4*PI*STORE(M5ASP+8)*STSP))/(4*PI*STORE(M5ASP+8)*STSP)
C-C-C-CALCULATE THE DERIVATIVE W.R.T. SPHERE-FACTOR FOR RADIUS
      DSFRAD=((COS(4*PI*STSP*STORE(M5ASP+8))
     2 *4*PI*STSP*STORE(M5ASP+8))-(SIN(4*PI*STSP*STORE(M5ASP+8))))
     3 /(4*PI*STSP*(STORE(M5ASP+8))**2)
      END


CODE FOR PDOLEV
      FUNCTION PDOLEV( L12, N12, MD12B, V, N11, DF, NDF, JPNX, TIX, RED)
      DIMENSION L12(N12), V(N11), DF(NDF)
C Work out leverage and some other things. See Prince, Mathematical
c Techniques in Crystallography and Materials Science, 2nd Edition,
c Springer-Verlag. pp120-123

C  L12 is an array of size N12 containing information about the
C  blocking of the array V.

C  V is of size N11, but may be in blocks (see L12)

C  DF is the current row of the design matrix. (Called A below).

C  P = A.V.At
c  where P is the projection (say hat) matrix.
c        A is the LHS
c        V is the inverse normal matrix (must be already known).
c  The leverages are the diagonal elements of the hat matrix, Pii.

C Ti = Ai.Vn, then t^2ij/(1+Pii) is the amount by which a repeated
c measurement of the ith reflection will reduce the variance of the
c estimate of the LJTh parameter.

C JPNX is the (one-based) index of the parameter of interest. E.g
C 1 is usually the scale factor. See \PRINT 22 for indices.

C For calculation of TIx, remember that the matrix V is packed into a
C lower triangle so that each column starts from the diagonal. Thus we
C accumulate TIx when either the row or column matches JPNX.

C Return values:
c      PDOLEV - (function return) the leverage value of this reflection
c      TIX    - the value of ziVn for the selected parameter (JPNX)
c      RED    - the amount by which repeated measurement of this
c               reflection will reduce the JPNXth parameter's variance.

       M11 = 1
       PII = 0.0
       TIx = 0.0
       JPN = JPNX - 1

       DO I = 1,N12,MD12B        ! Loop over each block
         IBS = L12(I+1)             ! IBS:= Number of rows in block
         DO J = 0, IBS-1            ! Loop over each row
           DO K = 0, IBS-J-1          ! Loop over each column.
             DOUB = 2.0                 ! Add in off-diagonals twice.
             IF ( K.EQ.0 ) DOUB = 1.0   ! Add on-diagonals once.
             PII = PII + DOUB * DF(1+J) * DF(1+J+K) * V(M11)
             IF ( J .EQ. JPN ) THEN   ! This is the row of interest for Tij
               TIx = TIx + DF(1+J) * V(M11)
             ELSE IF ( K .EQ. JPN ) THEN   ! This is also the row of interest for Tij
               TIx = TIx + DF(1+K) * V(M11)
             END IF
             M11 = M11 + 1
           END DO
         END DO
       END DO

       RED = (TIX**2)/(1.0+PII)
       PDOLEV = PII
       RETURN
      END


      SUBROUTINE XSFLSX
C
C--MAIN S.F.L.S. LOOP  -  CALCULATES A AND B AND THEIR DERIVATIVES
C
C  NL     ELEMENT NUMBER OF THIS REFLECTION (MAY BE SET TO 0)
C  T      TEMPERATURE FACTOR
C  FOCC   FORMFACTOR * SITE OCC * CHEMICAL OCC * DIFABS CORECTION
C  TFOCC  T*FOCC
C  AP     A PART FOR EACH SYMMETRY POSITION FOR EACH ATOM
C  BP     B PART FOR EACH SYMMETRY POSITION FOR EACH ATOM
C  BT     TOTAL B PART FOR EACH ATOM
C  AT     TOTAL A PART FOR EACH ATOM

C--
\ISTORE
\STORE
\XSFWK
\XWORKB
\XSFLSW
\XCONST
\XLST01
\XLST02
\XLST03
\XLST05
\XLST06
\XLST12
\QSTORE

      REAL FLAG
      LOGICAL ATOM_REFINE

C-C-C-...FOR STRUCTURE FACTOR-CALCULATION
      DOUBLE PRECISION SLRFAC
C-C-C-...FOR DERIVATIVES
      DOUBLE PRECISION DSIZE, DDECLINA, DAZIMUTH

      REAL ALPD(14),BLPD(14)   ! Use local arrays for better optimisation?

C Some constants for chebychev approx.
      REAL S0,S1,S2,S3,C0,C1,C2,C3,DD
      DATA S0/1.570795134/
      DATA S1/-.645925832/
      DATA S2/.079500304/
      DATA S3/-.004370784/
      DATA C0/.999993249/
      DATA C1/-1.233483666/
      DATA C2/.252578000/
      DATA C3/-.019094240/

      INTEGER ISTACK

      DD=1.0/TWOPI

      ISTACK=-1   ! CLEAR OUT A FEW CONSTANTS
      AC=0.
      BC=0.
      ACI=0.
      BCI=0.
      ACD=0.
      BCD=0.
C--SEARCH FOR THIS REFLECTION IN THE REFLECTION HOLDING STACK
      JREF_STACK_PTR=JREF_STACK_START
      LJX=NM
C--FETCH THE INFORMATION FOR THE NEXT REFLECTION IN THE STACK
      STACKSEARCH: DO WHILE(.TRUE.)
        NI=ISTORE(JREF_STACK_PTR)
        LJU=ISTORE(NI+9)
        LJV=ISTORE(NI+10)
C--LOOP OVER THE EQUIVALENT POSITIONS STORED
        DO LJW=LJU,LJV,NR
          PSHIFT=STORE(LJW+3)
          FRIED=1.0
C--CHECK THE GIVEN INDICES
          BD = ABS(STORE(M6)  -STORE(LJW)  )  ! 0 if same indices
     1        +ABS(STORE(M6+1)-STORE(LJW+1))
     2        +ABS(STORE(M6+2)-STORE(LJW+2))   
          BF = ABS(STORE(M6)+STORE(LJW)    )  ! 0 if Friedel opposite
     1        +ABS(STORE(M6+1)+STORE(LJW+1))
     2        +ABS(STORE(M6+2)+STORE(LJW+2))

          IF ( BF .LT. 0.5 ) THEN 
             PSHIFT=-PSHIFT   ! USE FRIEDEL'S LAW
             FRIED=-1.0
          END IF

          IF ((BD.LT.0.5) .OR. (BF.LT.0.5)) THEN ! REFLECTION FOUND IN THE STACK
            LJY=NI
            IF(LJX.GT.0) THEN  ! CHECK IF WE HAVE USED IT BEFORE
C--WE NEED THIS REFLECTION TWICE
              DO WHILE ( ISTORE(NI).GT.0 )  ! FIND THE END BLOCK
                JREF_STACK_PTR=NI
                NI=ISTORE(NI)
              END DO

              LJU=NI
              LJV=LJY
              DO J=1,4  ! DUPLICATE THE ENTRY  -  TRANSFER A, B ETC.
                STORE(LJU+3)=STORE(LJV+3)
                STORE(LJU+13)=STORE(LJV+13)
                LJU=LJU+1
                LJV=LJV+1
              END DO
              IF( SFLS_TYPE .EQ. SFLS_REFINE ) THEN  ! WE ARE DOING REFINEMENT
                LJX=ISTORE(NI+18)  ! TRANSFER THE P.D.'S
                LJU=ISTORE(LJY+18)
                LJV=ISTORE(LJY+19)
                N = LJV - LJU
                DO J = 0, N
                  STORE(LJX+J) = STORE(LJU+J)
                END DO
              END IF

              LJX=ISTORE(NI+9)   ! TRANSFER THE EQUIVALENT INDICES
              LJU=ISTORE(LJY+9)
              LJV=ISTORE(LJY+10)
              DO J=LJU,LJV,NR
                STORE(LJX)=STORE(J)
                STORE(LJX+1)=STORE(J+1)
                STORE(LJX+2)=STORE(J+2)
                STORE(LJX+3)=STORE(J+3)
                LJX=LJX+NR
              END DO
            END IF
            EXIT STACKSEARCH
          END IF
        END DO 

C--NOT THIS EQUIVALENT

        IF(ISTORE(NI).LE.0) THEN ! CHECK IF THERE ARE MORE IN THE STACK
C--THIS IS THE END OF THE STACK  -  WE MUST DO A CALCULATION HERE
          ISTACK=0
          NN=NN+1
          PSHIFT=0.
          FRIED=1.0
          EXIT STACKSEARCH
        END IF

        LJX=LJX-1  ! SET UP THE FLAGS FOR THE NEXT REFLECTION IN THE STACK
        JREF_STACK_PTR=NI
      END DO STACKSEARCH


      ISTORE(JREF_STACK_PTR)=ISTORE(NI)   ! SWITCH THE CURRENT BLOCK TO 
      ISTORE(NI)=ISTORE(JREF_STACK_START)   ! THE TOP OF THE STACK
      ISTORE(JREF_STACK_START)=NI

      STORE(NI+3)=STORE(M6)   ! SET UP THE CURRENT SET OF INDICES
      STORE(NI+4)=STORE(M6+1)
      STORE(NI+5)=STORE(M6+2)
      ISTORE(NI+8)=NL
      STORE(NI+11)=PSHIFT
      STORE(NI+12)=FRIED
      NM=NM+1

      IF(ISTACK.LT.0)RETURN  ! CHECK IF WE MUST CALCULATE THIS REFLECTION

C--CALCULATE THE INFORMATION FOR THE SYMMETRY POSITIONS
      M2=L2
      M2T=L2T
      DO LJZ=1,N2
        STORE(M2T)=STORE(M6)*STORE(M2)+STORE(M6+1)*STORE(M2+3)
     2   +STORE(M6+2)*STORE(M2+6)
        STORE(M2T+1)=STORE(M6)*STORE(M2+1)+STORE(M6+1)*STORE(M2+4)
     2   +STORE(M6+2)*STORE(M2+7)
        STORE(M2T+2)=STORE(M6)*STORE(M2+2)+STORE(M6+1)*STORE(M2+5)
     2   +STORE(M6+2)*STORE(M2+8)
        STORE(M2T+3)=(STORE(M6)*STORE(M2+9)+STORE(M6+1)*STORE(M2+10)
     2   +STORE(M6+2)*STORE(M2+11))*TWOPI  ! CALCULATE THE H.T TERMS
        IF ( ( LJZ .EQ. 1 ) .OR. ( .NOT. ISO_ONLY ) ) THEN ! ANISO CONTRIBUTIONS ARE REQUIRED
          STORE(M2T+4)=STORE(M2T)*STORE(M2T)
          STORE(M2T+5)=STORE(M2T+1)*STORE(M2T+1)
          STORE(M2T+6)=STORE(M2T+2)*STORE(M2T+2)
          STORE(M2T+7)=STORE(M2T+1)*STORE(M2T+2)
          STORE(M2T+8)=STORE(M2T)*STORE(M2T+2)
          STORE(M2T+9)=STORE(M2T)*STORE(M2T+1)
        END IF
        STORE(M2T)=STORE(M2T)*TWOPI
        STORE(M2T+1)=STORE(M2T+1)*TWOPI
        STORE(M2T+2)=STORE(M2T+2)*TWOPI
        M2=M2+MD2
        M2T=M2T+MD2T
      END DO
C--CALCULATE SIN(THETA)/LAMBDA SQUARED
      SST=STORE(L1S)*STORE(L2T+4)+STORE(L1S+1)*STORE(L2T+5)
     2 +STORE(L1S+2)*STORE(L2T+6)+STORE(L1S+3)*STORE(L2T+7)
     3 +STORE(L1S+4)*STORE(L2T+8)+STORE(L1S+5)*STORE(L2T+9)
      ST=SQRT(SST)
      SMIN=MIN(SMIN,ST)
      SMAX=MAX(SMAX,ST)
C--CALCULATE THE TEMPERATURE FACTOR COEFFICIENT
      TC=-SST*TWOPIS*4.
C--CHECK IF THE ANISO TERMS ARE REQUIRED
      IF(.NOT. ISO_ONLY) THEN 
        M2T=L2T
        DO LJZ=1,N2
          STORE(M2T+4)=STORE(M2T+4)*STORE(L1A)
          STORE(M2T+5)=STORE(M2T+5)*STORE(L1A+1)
          STORE(M2T+6)=STORE(M2T+6)*STORE(L1A+2)
          STORE(M2T+7)=STORE(M2T+7)*STORE(L1A+3)
          STORE(M2T+8)=STORE(M2T+8)*STORE(L1A+4)
          STORE(M2T+9)=STORE(M2T+9)*STORE(L1A+5)
          M2T=M2T+MD2T
        END DO
      END IF

      CALL XSCATT(ST)  ! CALCULATE THE FORM FACTORS
      M3TR=L3TR  ! COMPUTE THE RATIO OF IMAGINARY TO REAL FORM FACTORS
      M3TI=L3TI
      DO LJZ=1,N3
        STORE(M3TR)=STORE(M3TR)*G2
        STORE(M3TI)=STORE(M3TI)*G2
        IF(STORE(M3TR).LE.ZERO)THEN  ! REAL PART IS ZERO  
          STORE(M3TI)=0. ! SO IS THE IMAGINARY NOW
        ELSE   ! REAL PART IS OKAY
          STORE(M3TI)=STORE(M3TI)/STORE(M3TR)
        END IF
        M3TR=M3TR+MD3TR  ! UPDATE THE POINTERS
        M3TI=M3TI+MD3TI
      END DO

      IF(SFLS_TYPE .EQ. SFLS_REFINE) THEN    ! CHECK IF WE ARE DOING REFINEMENT

        DO LJZ=JO,JP
          STORE(LJZ)=0.           ! CLEAR THE FINAL PARTIAL DERIVATIVE AREA TO ZERO
        END DO
        LJS=JR
        N = N12*JQ
        DO J = 0, N-1            ! CLEAR THE TEMPORARY PARTIAL DERIVATIVE AREAS TO ZERO
          STORE(LJS+J) = 0.0
        END DO
        LJS=JN
        DO J= 0, JQ-1            ! CLEAR THE DUMMY LOCATIONS
          STORE(LJS+J)=0.
        END DO
        M12=L12                  ! SET THE ATOM POINTER IN LIST 12
      END IF


C
C--START OF THE LOOP BASED ON THE ATOMS
C

      M5A=L5
      DO LJY=1,N5

        AT=0.  ! CLEAR THE ACCUMULATION VARIABLES
        BT=0.

        ATOM_REFINE = .FALSE. 

        IF(SFLS_TYPE .EQ. SFLS_REFINE) THEN   ! CHECK IF REFINEMENT IS BEING DONE
          CALL XZEROF ( ALPD(1),11 )  ! CLEAR PARTIAL DERIVATIVE STACKS
          CALL XZEROF ( BLPD(1),11 )
          L12A=ISTORE(M12+1)
          IF ( L12A .GE.0 ) ATOM_REFINE = .TRUE.  ! Set if any params of this atom are being refined
          M12=ISTORE(M12)
        END IF

        M3TR=L3TR+ISTORE(M5A)  ! PICK UP THE FORM FACTORS FOR THIS ATOM
        M3TI=L3TI+ISTORE(M5A)
        FOCC = STORE(M3TR) * STORE(M5A+2) * STORE(M5A+13) ! MODIFY FOCC FOR OTHER FC CORRECTIONS

        FLAG=STORE(M5A+3)   ! PICK UP THE TYPE OF THIS ATOM
        IF(NINT(FLAG) .EQ. 1) THEN  ! CHECK THE TEMPERAURE TYPE FOR THIS ATOM
          T=EXP(STORE(M5A+7)*TC)  ! CALCULATE THE ISO-TEMPERATURE FACTOR COEFFICIENTS FOR THIS ATOM
          TFOCC=T*FOCC
        END IF

        M2T=L2T
        M2=L2   ! M2 (ADDR. FOR TRANSF.MAT.) IS RESET TO ADDR. FOR 1ST SYM.OP.
        DO LJX=1,N2T  ! LOOP CYCLING OVER THE DIFFERENT EQUIVALENT POSITIONS FOR THIS ATOM
          A=STORE(M5A+4)*STORE(M2T)+STORE(M5A+5)*STORE(M2T+1)
     2     +STORE(M5A+6)*STORE(M2T+2)+STORE(M2T+3)              ! CALCULATE H'.X+H.T
          SLRFAC=1.0    ! STARTING-VALUES FOR ADDITIONAL FACTOR AND DERIVATIVES
          DSIZE=1.0
          DDECLINA=1.0
          DAZIMUTH=1.0

          IF (NINT(FLAG) .EQ. 0) THEN   ! CALCULATE THE ANISO-TEMPERATURE FACTOR
            T=EXP(STORE(M5A+7)*STORE(M2T+4)+STORE(M5A+8)*STORE(M2T+5)
     2       +STORE(M5A+9)*STORE(M2T+6)+STORE(M5A+10)*STORE(M2T+7)
     3       +STORE(M5A+11)*STORE(M2T+8)+STORE(M5A+12)*STORE(M2T+9))
            TFOCC=T*FOCC
          ELSE IF ( NINT(FLAG) .GE. 2) THEN
            IF (NINT(FLAG) .EQ. 2) THEN  ! CALC SPHERE TF
              CALL XSPHERE (ST, M5A, SLRFAC, DSIZE)
            ELSE IF (NINT(FLAG) .EQ. 3) THEN   ! CALC LINE TF
              CALL XLINE (M2, M5A, M6, SLRFAC, DSIZE, DDECLINA,DAZIMUTH)
            ELSE IF (NINT(FLAG) .EQ. 4) THEN   ! CALC RING TF
              CALL XRING (M2, ST, M5A,M6,SLRFAC,DSIZE,DDECLINA,DAZIMUTH)
            END IF
            T=EXP(STORE(M5A+7)*TC)
            TFOCC=T*FOCC
            TFOCC=TFOCC*SLRFAC
          ENDIF

C--CALCULATE THE SIN/COS TERMS   (NB This is a Chebychev approximation - v. fast)
          A=A*DD
          A=4.*(A-FLOAT(INT(A)))
          IF(A .EQ. 0) THEN
            S=0.
            C=1.
            GOTO 8850
          ELSE IF ( A .LT. 0 ) THEN
            A=A+4.
          END IF
          S=1.

          IF(A.EQ.2.)THEN
            S=0.
            C=-1.
            GOTO 8850
          ELSE IF ( A .GT. 2 ) THEN 
            S=-1.
            A=A-2.
          END IF
          C=S

          IF(A.EQ.1.)THEN 
            C=0.
            GOTO 8850
          ELSE IF ( A .GT. 1 ) THEN
            C=-C
            A=2.-A
          END IF
          B=A*A
          C=C*(C0+B*(C1+B*(C2+B*C3)))

          IF(COS_ONLY) GOTO 8900

          S=S*A*(S0+B*(S1+B*(S2+B*S3)))

8850      CONTINUE
C--CALCULATE THE B CONTRIBUTION
          BP=S*TFOCC
          BT=BT+BP

C--CALCULATE THE A CONTRIBUTION
8900      CONTINUE
          AP=C*TFOCC
          AT=AT+AP

C--CHECK IF ANY REFINEMENT IS BEING DONE
          IF(ATOM_REFINE)THEN
C-CALCULATE THE PARTIAL DERIVATIVES W.R.T. A FOR X,Y AND Z
C-C-C-CALCULATE THE PARTIAL DERIVATIVES W.R.T. A FOR OCC,X,Y AND Z
            ALPD(1)=ALPD(1)+T*C*SLRFAC
            ALPD(3)=ALPD(3)-STORE(M2T)*BP
            ALPD(4)=ALPD(4)-STORE(M2T+1)*BP
            ALPD(5)=ALPD(5)-STORE(M2T+2)*BP
C--CHECK THE TEMPERATURE FACTOR TYPE
            IF(NINT(FLAG) .NE. 1) THEN
C-C-C-CHECK WHETHER WE HAVE SPHERE, LINE OR RING
              IF (NINT(FLAG) .LE. 1) THEN
C--CALCULATE THE PARTIAL DERIVATIVES W.R.T. A FOR THE ANISO-TERMS
                ALPD(6)=ALPD(6)+STORE(M2T+4)*AP
                ALPD(7)=ALPD(7)+STORE(M2T+5)*AP
                ALPD(8)=ALPD(8)+STORE(M2T+6)*AP
                ALPD(9)=ALPD(9)+STORE(M2T+7)*AP
                ALPD(10)=ALPD(10)+STORE(M2T+8)*AP
                ALPD(11)=ALPD(11)+STORE(M2T+9)*AP
              ELSE
C-C-C-CALC. THE PART. DERIV. W.R.T. A FOR ISO-TERM + SPECIAL FIGURES
                ALPD(6)=ALPD(6)+TC*AP
                ALPD(7)=ALPD(7)+((DSIZE*AP)/SLRFAC)
                ALPD(8)=ALPD(8)+((DDECLINA*AP)/SLRFAC)
                ALPD(9)=ALPD(9)+((DAZIMUTH*AP)/SLRFAC)
              ENDIF
            ELSE
C--CALCULATE THE PARTIAL DERIVATIVES W.R.T. A FOR U[ISO]
              ALPD(6)=ALPD(6)+TC*AP
            ENDIF

C--GOTO THE NEXT PART - DEPENDS ON WHETHER THE STRUCTURE IS CENTRO
            IF(.NOT. CENTRO) THEN
C--CALCULATE THE PARTIAL DERIVATIVES W.R.T. B FOR X,Y AND Z
C-C-C-CALCULATE THE PARTIAL DERIVATIVES W.R.T. B FOR OCC,X,Y AND Z
              BLPD(1)=BLPD(1)+T*S*SLRFAC
              BLPD(3)=BLPD(3)+STORE(M2T)*AP
              BLPD(4)=BLPD(4)+STORE(M2T+1)*AP
              BLPD(5)=BLPD(5)+STORE(M2T+2)*AP
C--CHECK THE TEMPERATURE FACTOR TYPE
              IF(NINT(FLAG) .NE. 1) THEN
C-C-C-CHECK WHETHER WE HAVE SPHERE, LINE OR RING
                IF (NINT(FLAG) .LE. 1) THEN
C--CALCULATE THE PARTIAL DERIVATIVES W.R.T. B FOR THE ANISO-TERMS
                  BLPD(6)=BLPD(6)+STORE(M2T+4)*BP
                  BLPD(7)=BLPD(7)+STORE(M2T+5)*BP
                  BLPD(8)=BLPD(8)+STORE(M2T+6)*BP
                  BLPD(9)=BLPD(9)+STORE(M2T+7)*BP
                  BLPD(10)=BLPD(10)+STORE(M2T+8)*BP
                  BLPD(11)=BLPD(11)+STORE(M2T+9)*BP
                ELSE
C-C-C-CALC. THE PART. DERIV. W.R.T. B FOR ISO-TERM + SPECIAL FIGURES
                  BLPD(6)=BLPD(6)+TC*BP
                  BLPD(7)=BLPD(7)+((DSIZE*BP)/SLRFAC)
                  BLPD(8)=BLPD(8)+((DDECLINA*BP)/SLRFAC)
                  BLPD(9)=BLPD(9)+((DAZIMUTH*BP)/SLRFAC)
                ENDIF
              ELSE
C--CALCULATE THE PARTIAL DERIVATIVES W.R.T. B FOR U[ISO]
                BLPD(6)=BLPD(6)+TC*BP
              ENDIF
            END IF
          END IF


          M2T=M2T+MD2T  ! UPDATE THE SYMMETRY INFORMATION POINTER
          M2=M2+MD2     ! M2 (ADDR. FOR TRANSF.MAT.) IS INCREASED FOR NEXT SYM.OP.
        END DO    ! LOOP ON EQUIVALENT POSITIONS ENDS  -  COMPUTE THE TOTALS FOR THIS ATO

        AC=AC+AT
        BC=BC+BT

        IF (ANOMAL) THEN  ! CHECK IF ANOMALOUS DISPERSION IS BEING CONSIDERED
          AIMAG=ANOM*STORE(M3TI)  ! CALCULATE THE IMAGINARY PARTS
          ACI=ACI-BT*AIMAG
          BCI=BCI+AT*AIMAG
          IF (SFLS_TYPE .EQ. SFLS_REFINE) THEN   ! ANY REFINEMENT AT ALL?
            ACD=ACD-BT*STORE(M3TI)   ! DERIVATIVES FOR POLARITY PARAMETER
            BCD=BCD+AT*STORE(M3TI)
          END IF
        END IF


        IF(ATOM_REFINE)THEN  ! CHECK IF ANY REFINEMENT IS BEING DONE
          ALPD(1) = STORE(M3TR) * STORE(M5A+13) * ALPD(1)  ! CALCULATE THE PARTIAL DERIVATIVES 
          BLPD(1) = STORE(M3TR) * STORE(M5A+13) * BLPD(1)  ! W.R.T. A AND B FOR OCC

          DO WHILE (L12A.GT.0)  ! LOOP ADDING THE PARTIAL DERIVATIVES INTO THE TEMPORARY STACKS

            M12A=ISTORE(L12A+4)
            MD12A=ISTORE(L12A+1)  ! SET UP THE CONDITIONS OF THIS ATOM
            LJU=ISTORE(L12A+2)
            LJV=ISTORE(L12A+3)

            IF(MD12A.LT.2)THEN    ! WEIGHTS ARE UNITY
              IF ( CENTRO ) THEN
                IF ( ANOMAL ) THEN    ! UNITY, CENTRO AND ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)
                    STORE(LJT+1)=STORE(LJT+1)+ALPD(M12A-1)*AIMAG
                    M12A=M12A+1
                  END DO
                ELSE                 ! UNITY, CENTRO AND NO ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)
                    M12A=M12A+1
                  END DO
                END IF
              ELSE
                IF ( ANOMAL ) THEN    ! UNITY, NON-CENTRO AND ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)
                    STORE(LJT+3)=STORE(LJT+3)+ALPD(M12A-1)*AIMAG
                    STORE(LJT+2)=STORE(LJT+2)-BLPD(M12A-1)*AIMAG
                    STORE(LJT+1)=STORE(LJT+1)+BLPD(M12A-1)
                    M12A=M12A+1
                  END DO
                ELSE                  ! UNITY, NON-CENTRO AND NO ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)
                    STORE(LJT+1)=STORE(LJT+1)+BLPD(M12A-1)
                    M12A=M12A+1
                  END DO
                END IF
              END IF
            ELSE       ! WEIGHTS DIFFER FROM UNITY
              IF ( CENTRO ) THEN
                IF ( ANOMAL ) THEN    ! NON-UNITY, CENTRO AND ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    A=ALPD(M12A-1)*STORE(LJW+1)
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+A
                    STORE(LJT+1)=STORE(LJT+1)+A*AIMAG
                    M12A=M12A+1
                  END DO
                ELSE                 ! NON-UNITY, CENTRO AND NO ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)*STORE(LJW+1)
                    M12A=M12A+1
                  END DO
                END IF
              ELSE
                IF ( ANOMAL ) THEN  ! NON-UNITY, NON-CENTRO AND ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)*STORE(LJW+1)
                    A=STORE(LJW+1)*AIMAG
                    STORE(LJT+3)=STORE(LJT+3)+ALPD(M12A-1)*A
                    STORE(LJT+2)=STORE(LJT+2)-BLPD(M12A-1)*A
                    STORE(LJT+1)=STORE(LJT+1)+BLPD(M12A-1)*STORE(LJW+1)
                    M12A=M12A+1
                  END DO
                ELSE               ! NON-UNITY, NON-CENTRO AND NO ANOMALOUS DISPERSION
                  DO LJW=LJU,LJV,MD12A
                    LJT=ISTORE(LJW)
                    STORE(LJT)=STORE(LJT)+ALPD(M12A-1)*STORE(LJW+1)
                    STORE(LJT+1)=STORE(LJT+1)+BLPD(M12A-1)*STORE(LJW+1)
                    M12A=M12A+1
                  END DO
                END IF
              END IF
            END IF
            L12A=ISTORE(L12A)
          END DO            
        END IF
        M5A=M5A+MD5A
      END DO             ! END OF ATOM CYCLING LOOP

      IF(CENTRO) THEN ! CHECK IF THIS STRUCTURE IS CENTRO
        BC=0.         ! Zero appropriate parts.
        ACI=0.
      END IF

      STORE(NI+13)=AC   ! STORE THE RESULTS OF THIS 
      STORE(NI+14)=ACI  ! CALCULATION IN THE STACK
      STORE(NI+15)=BC
      STORE(NI+16)=BCI

      M2I=L2I
      LJU=ISTORE(NI+9)  ! STORE THE EQUIVALENT INDICES AND THE PHASE SHIFT
      LJV=ISTORE(NI+10)
      DO LJW=LJU,LJV,NR
        STORE(LJW)=STORE(M6)*STORE(M2I)+STORE(M6+1)*STORE(M2I+3)
     2          +STORE(M6+2)*STORE(M2I+6)
        STORE(LJW+1)=STORE(M6)*STORE(M2I+1)+STORE(M6+1)*STORE(M2I+4)
     2          +STORE(M6+2)*STORE(M2I+7)
        STORE(LJW+2)=STORE(M6)*STORE(M2I+2)+STORE(M6+1)*STORE(M2I+5)
     2          +STORE(M6+2)*STORE(M2I+8)
        STORE(LJW+3)=-(STORE(LJW)*STORE(M2I+9)
     1               +STORE(LJW+1)*STORE(M2I+10)
     2               +STORE(LJW+2)*STORE(M2I+11))*TWOPI
        M2I=M2I+MD2I
      END DO

      IF(SFLS_TYPE .EQ. SFLS_REFINE) THEN    ! CHECK IF WE ARE DOING REFINEMENT
        LJU=ISTORE(NI+18)    ! TRANSFER THE P.D.'S TO THE STACK
        LJV=ISTORE(NI+19)
        LJS=JR
        DO LJW=LJU,LJV
          STORE(LJW)=STORE(LJS)
          LJS=LJS+1
        END DO
      END IF

      RETURN
      END


      SUBROUTINE XAB2FC
C--CONVERSION OF THE A AND B PARTS INTO /FC/ TERMS
C
C  ICONT  SET TO THE RETURN ADDRESS
C  JO     ADDRESS OF THE AREA FOR THE OUTPUT DERIVATIVES W.R.T. /FC/
C  JP     LAST WORD OF THE ABOVE AREA
C  JREF_STACK_PTR     ADDRESS OF THIS REFLECTION IN THE STACK

\ISTORE
\STORE
\XSFWK
\XWORKB
\XSFLSW
\XCONST
\XLST06
\QSTORE

C--FETCH A AND B ETC. FROM THE STACK
      AC=STORE(JREF_STACK_PTR+13)
      ACI=STORE(JREF_STACK_PTR+14)
      BC=STORE(JREF_STACK_PTR+15)
      BCI=STORE(JREF_STACK_PTR+16)
      PSHIFT=STORE(JREF_STACK_PTR+11)
      FRIED=STORE(JREF_STACK_PTR+12)
      ACT=AC+ACI*FRIED+ACT
      BCT=BC*FRIED+BCI+BCT


      IF ( ABS(ACT) .LT. 0.001 ) THEN  ! A-PART is 0
        IF ( ABS(BCT) .LT. 0.001) THEN  ! B-PART is 0
          ACT = 0.000001
          BCT = 0.
        ELSE                            ! B-PART non-zero
          ACT = 0.
        END IF
      ELSE                             ! A-PART non-zero
        IF ( ABS(BCT) .LT. 0.001) THEN  ! B-PART is zero
          BCT = 0.
        END IF
      END IF


C--COMPUTE /FC/ AND THE PHASE FOR THE GIVEN ENANTIOMER
      FCSQ = ACT*ACT + BCT*BCT
      FP = SQRT(FCSQ)
      FC = FP                     ! SAVE THE TOTAL MAGNITUDE
      P=AMOD(ATAN2(BCT,ACT)+PSHIFT,TWOPI)  ! THE PHASE

      IF (ENANTIO) THEN
        ACN = ACN+AC-ACI*FRIED   ! COMPUTE FRIEDEL PAIR
        BCN = BCN+BCI-BC*FRIED
        FNSQ = ACN*ACN + BCN*BCN
        FN = SQRT (FNSQ)
C----- LARGE ENANTIOMER DIFFERENCES
        DENAN = 200. * ABS(FN-FP)/(FN+FP)
        IF (DENAN .GT. XVALUE) THEN
          CALL XMOVE(STORE(M6), STORE(LTEMPE), 3)  ! H,K,L,F+,FO,F-,R
          STORE(LTEMPE+3) = FP
          STORE(LTEMPE+4) = FO * SCALEK
          STORE(LTEMPE+5) = FN
          STORE(LTEMPE+6) = DENAN
          CALL SRTDWN(LENAN,MENAN,MDENAN,NENAN, JENAN, LTEMPE, 
     1    XVALUE,0, DEF2)
          IENPRT = IENPRT +1
        ENDIF

        FESQ = FCSQ*CENANT + FNSQ*ENANT   ! THE TOTAL EQUIVALENT INTENSITY
        IF (FESQ .LE. 0.0) THEN
          FC = SIGN(1.,FESQ)*SQRT(max(zero,ABS (FESQ)))
        ELSE
          FC = SQRT(FESQ)
        ENDIF

        COSA = CENANT * FP / FC   ! THE RELATIVE CONTRIBUTIONS 
        SINA =  ENANT * FN / FC   ! OF THE COMPONENTS
      ELSE
        FNSQ = FCSQ
      ENDIF

      STORE(JREF_STACK_PTR+6) = FC
      STORE(JREF_STACK_PTR+7) = P

      IF(SFLS_TYPE .EQ. SFLS_REFINE) THEN   ! CHECK IF WE ARE DOING REFINEMENT
        LJS=ISTORE(JREF_STACK_PTR+18)     ! TRANSFER PARTIAL DERIVATIVES FROM TEMPORARY
        TEMP = SCALEW / FC   ! TO PERMANENT STORE
        COSP = ACT * TEMP
        SINP = BCT * TEMP
        COSPN = ACN * TEMP
        SINPN = BCN * TEMP
        ACE  = 0.5 * (FNSQ-FCSQ) * TEMP

        IF ( CENTRO .EQV. ANOMAL ) THEN ! NON-CENTRO WITHOUT ANOMALOUS DISPERSION
                                       ! OR CENTRO WITH ANOMALOUS

          IF ( .NOT. CENTRO ) SINP=SINP*FRIED ! NON-CENTRO WITHOUT AD

          N = JP-JO
          DO J = 0, N
            STORE(JO+J) = STORE(LJS+J*JQ)*COSP+ STORE(LJS+J*JQ+1)*SINP
          END DO
          ACF = BCD*SINP
          IF (ENANTIO) THEN   ! MODIFY THE EXISTING DERIVATIVES
            LJS = ISTORE(JREF_STACK_PTR+18)
            N = JP-JO
            DO J = 0, N
              STORE(JO+J) = STORE(JO+J)*COSA +
     1        SINA*(STORE(LJS+J*JQ)*COSPN + STORE(LJS+J*JQ+1)*SINPN)
            END DO
            ACF = ACF * COSA + SINA * BCD * SINPN
          END IF
          STORE(JN+1)=0.0
          STORE(JN)=0.0
        ELSE IF ( CENTRO .AND. (.NOT. ANOMAL) ) THEN ! CENTRO WITHOUT ANOMALOUS DISPERSION
          N = JP-JO
          DO J = 0, N
            STORE(JO+J) = STORE(LJS+J*JQ)*COSP
          END DO
          STORE(JN)=0.0
        ELSE                              ! NON-CENTRO WITH ANOMALOUS DISPERSION
          N = JP-JO
          DO J = 0, N
            STORE(JO+J) = (STORE(LJS+J*JQ)+STORE(LJS+J*JQ+2)*FRIED)*COSP
     1                + (STORE(LJS+J*JQ+1)*FRIED+STORE(LJS+J*JQ+3))*SINP
          END DO
          ACF = (ACD * COSP * FRIED) + (BCD * SINP)
          IF (ENANTIO) THEN  ! MODIFY THE EXISTING DERIVATIVES
            LJS = ISTORE(JREF_STACK_PTR+18)
            N = JP-JO
            DO J = 0, N
              STORE(JO+J) = STORE(JO+J)*COSA + SINA*
     1        ((STORE(LJS+J*JQ)-STORE(LJS+J*JQ+2)*FRIED)*COSPN +
     2        (STORE(LJS+J*JQ+3)-STORE(LJS+J*JQ+1)*FRIED)*SINPN)
            END DO
            ACF = ACF*COSA + SINA * (BCD*SINPN - ACD*COSPN*FRIED)
          END IF
          STORE(JN+3)=0.0
          STORE(JN+2)=0.0
          STORE(JN+1)=0.0
          STORE(JN)=0.0
        END IF
      END IF            
      RETURN
      END


      SUBROUTINE XADDPD ( A, JX, JO, JQ, JR) 
\ISTORE
\STORE
\XLST12
\QSTORE

C--ROUTINE TO ADD P.D.'S WITH RESPECT TO /FC/ FOR THE OVERALL PARAMETER
C  A     THE DERIVATIVE TO BE ADDED
C  JX    ITS POSITION IN THE OVERALL PARAMETER LIST SET IN M12
C  JO    ADDRESS COMPLETE PARTIAL DERIVATIVES
C  JQ    NUMBER OF PARTIAL DERIVATIVES PER REFLECTION (0,1,2 OR 4)
C  JR    ADDRESS PARTIAL DERIVATIVES BEFORE THEY ARE ADDED TOGETHER

C And in common:
C  M12   ADDRESS OF THE HEADER FOR THE PARAMETER IN LIST 12

C--SET UP THE LIST 12 FLAGS
      L12A=ISTORE(M12+1)
      IF(ISTORE(M12+1).GT.0) THEN 
        DO WHILE ( L12A .GT. 0 )
          IF(ISTORE(L12A+4).LE.JX)THEN ! THE PART STARTS LOW ENOUGH DOWN
            MD12A=ISTORE(L12A+1)
            LJU=ISTORE(L12A+2)+(JX-ISTORE(L12A+4))*MD12A
            IF(LJU.LE.ISTORE(L12A+3)) THEN  ! CHECK IF THIS PARAMETER IS IN RANGE
              LJT=(ISTORE(LJU)-JR)/JQ  ! FIND PARAMETER IN DERIVATIVE STACK
              IF(LJT.GE.0)THEN        ! PARAMETER HAS BEEN REFINED?
                LJT=LJT+JO
                IF(MD12A.LT.2)THEN  ! IS WEIGHT GIVEN OR ASSUMED UNITY?
                  STORE(LJT)=STORE(LJT)+A              ! THE WEIGHT IS UNITY
                ELSE
                  STORE(LJT)=STORE(LJT)+A*STORE(LJU+1)  ! THIS WEIGHT IS GIVEN
                END IF
              END IF
            END IF
          END IF
          L12A=ISTORE(L12A)  ! PASS ONTO THE NEXT PART
        END DO
      END IF
      RETURN
      END
