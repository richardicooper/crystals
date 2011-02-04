C $Log: not supported by cvs2svn $
C Revision 1.55  2010/07/21 15:57:54  djw
C Change order of list 6 header lines
C
C Revision 1.54  2010/07/16 11:35:31  djw
C Enable XPCHLX to output lists 12 and 16 to the cif file.  This means carrying the I/O chanel (as NODEV)
C in XPCHLX,XPCHLH,PPCHND and XPCHUS.
C Fixed oversight in distangle for esds of H-bonds
C
C Revision 1.53  2010/06/03 16:58:11  djw
C Add comments to expalin the different #PUNCH 6 x keys
C
C Revision 1.52  2010/05/04 10:39:45  djw
C Concatenate type and serial in SHELX format atoms. (Previously there was a space for old crtstals compatibility)
C
C Revision 1.51  2009/10/13 16:42:37  djw
C Change format of Audit Date to keep PLATON happly
C
C Revision 1.50  2009/03/24 08:06:33  djw
C Make the SHELX TITL card in the HKL file a REMark
C
C Revision 1.49  2008/10/01 11:11:54  djw
C Support for treatment of Deuterium as hydrogen
C
C Revision 1.48  2008/03/31 14:54:08  djw
C Move the Firedel flag in SYST into the JCODE slot. Previously (in corrections of phase) it zapped Fourier maps
C
C Revision 1.47  2008/03/07 16:09:48  djw
C changes to help with the correct computation of Fourier maps from twinned crystals.  THe old COPY67 subroutine did not pack the data properly unless the keys were the default keys.  The job is now done
C
C Revision 1.46  2008/01/25 14:59:47  djw
C re-format bdp to conform to Mercury
C
C Revision 1.45  2007/12/14 16:38:20  djw
C Output structure name into data files
C
C Revision 1.44  2007/10/09 06:55:22  djw
C Add support for multi-struxture cifs
C
C Revision 1.43  2005/01/23 08:29:11  rich
C Reinstated CVS change history for all FPP files.
C History for very recent (January) changes may be lost.
C
C Revision 1.1.1.1  2004/12/13 11:16:08  rich
C New CRYSTALS repository
C
C Revision 1.42  2004/11/11 15:54:40  rich
C Fix occupancies and H atom positions in SHELX output.
C
C Revision 1.41  2004/07/12 15:52:30  stefan
C Fixed a problem where the new code for '#punch 12 B' would not compile on Mandrake or MacOS X.
C Also does it in a nicer manner rather then the infinate loop with an if to break it.
C
C Revision 1.40  2004/07/09 12:28:16  rich
C \punch 12 b  writes a easy to read version of list 22
C to the punch file. It can't be read back in, of course.
C May develop this into something for the CIF.
C
C Revision 1.39  2004/04/21 13:11:45  rich
C Added "#PUNCH 6 G" command, it outputs a SHELX format reflection
C file, but using slightly perturbed Fcalc^2 and made-up sigma(F-calc^2).
C
C Added a routine ISCNTRC(HKL) to determine if a given reflection is
C in a centrosymmetric class of reflections (e.g. the h0l class in monoclinic-b
C ). Used in plot of phase distribution to exclude this class of reflections.
C Added text to xphase.scp to explain this.
C
C Revision 1.38  2004/03/01 11:39:41  rich
C Put data_ block header on .fcf file.
C
C Revision 1.37  2003/12/01 09:31:36  rich
C Use longer buffer for cell parameter output in FCF file.
C
C Revision 1.36  2003/08/18 11:20:01  rich
C For output of shelx hkl files - if FOsq exceeds 1E6 then output in F8.1
C format. If Fosq exceeds 1E7 output in I8 format.
C
C Revision 1.35  2003/07/04 16:37:47  rich
C Solve two problems with punch twinned list6's. (1) The element field
C was only I3 - changed it to I10 to allow for a full 9 element twin.
C (2) Added a blank line after the terminating -512: the twin format
C uses a two line format statement, previouslt the next line was a
C CRYSTALS comment '#' generating a disconcerting, though harmless, message
C when reading in the data.
C
C Revision 1.34  2003/06/27 10:11:33  rich
C Added "#PUNCH 6 F" - outputs a plain HKLF4 format listing to the
C punch file with no headers or anything.
C
C Revision 1.33  2003/02/14 17:09:02  djw
C Extend codes to work wih list 6 and list 7.  Note that sfls, calc and
C recine have the parameter ityp06, which corresponds to the types
C pickedip for lists 6 and 7  from the command file
C
C Revision 1.32  2003/01/15 10:57:05  rich
C \PUNCH 6 E punches a CIF format reflection file with F squared instead of
C Fs (PUNCH 6 B)
C
C Revision 1.31  2003/01/13 17:30:15  rich
C In FCF punch: Use M6+20 for ratio, rather than incorrectly calculating it.
C
C Revision 1.30  2002/06/28 16:13:08  Administrator
C ensure that the field NEW can hold characters
C
C Revision 1.29  2002/05/31 14:41:09  Administrator
C Update SHELX SPECIAL output
C
C Revision 1.28  2002/05/15 17:20:56  richard
C To the fcf output file, I have added:
C 1) Cell params - useful for cross checking that fcf belongs to cif.
C 2) _refln_observed_status - this is 'o' for a refl used in the refinement.
C '<' if rejected by I/sigmaI cutoff or 'x' if rejected for some other reason.
C ('<' appears in preference to 'x' if both apply)
C
C Revision 1.27  2002/01/24 15:44:57  Administrator
C OPEN/CLOSE file for publish.fcf in script
C
C Revision 1.26  2001/12/18 17:55:09  Administrator
C put SCALEi cards into CHIME output
C
C Revision 1.25  2001/11/23 08:58:08  Administrator
C Patches to facilitate link to SQUEEZE
C
C Revision 1.24  2001/10/16 11:52:05  ckp2
C Fix punching of very old (MD5=14) list 5's.
C
C Revision 1.23  2001/10/16 11:49:01  ckp2
C Forgot L5 offset in PUnCH41
C
C Revision 1.22  2001/10/16 11:23:32  Administrator
C Add missing common block to punch 41
C
C Revision 1.21  2001/10/09 10:34:40  ckp2
C Punch 41 for Simon's project.
C
C Revision 1.20  2001/10/05 13:31:52  ckp2
C
C Implementation of Lists 40 and 41.
C ===================================
C New commands:
C #LIST 41 - contains a list of bonds and bondtypes. It is generated by typing
C #BONDCALC which calculates bonds from LIST1,2,5,29 and 40.
C 40 contains info about how to do the bond calculation and can override
C covalent radii, force or break specific bonds and set limits for pairs
C of elements.
C #PUNCH 40 A - produces a LIST 40, #PUNCH 40 B - produces a #BONDING command
C which may be used to input a list 40 in a more user friendy manner (no READ
C card). #BONDING may also be used to EXTEND an existing list 40.
C #SUM L 40 - summary of bonding building info. #SUM L 41 - the bonds.
C #BONDCALC creates a L40 if there is none, and also only carries out calculation
C if significant change has occured to L5. (unless "#BONDCALC FORCE").
C See manual for more details.
C
C Revision 1.19  2001/08/14 10:22:38  ckp2
C When punching SHELX files old scheme only allowed serials up to 99. New
C version allows up to 999 for one character elements. Two downward counters
C are maintained for one character and two character elements with out of
C range serials.
C
C Revision 1.18  2001/06/18 08:28:49  richard
C Array names (JFOO & JFOT) used as scalar variable in calls to KCOMP. Fixed.
C
C Revision 1.17  2001/03/08 14:33:45  richard
C Correct punching of the last four items of LIST 5
C
C Revision 1.16  2001/02/26 10:28:03  richard
C RIC: Added changelog to top of file
C
C      A     COMPRESSED PUNCH FORMAT
C                  XPCH6G(LSTNO,ICLASS)
C      B     CIF OUTPUT F's
C                  XPCH6C(LSTNO,0)
C      C     NORMAL DATA, ONE REFLECTION PRE CARD
C                  XPCH6S(LSTNO,LSTNO)
C      D     OBSERVED QUANTITIES ONLY
C                  XPCH6O(LSTNO)
C      E     CIF OUTPUT F^2's
C                  XPCH6C(LSTNO,1)
C      F     PLAIN SHELX HKL OUTPUT
C                  XPCH6X(LSTNO,0)
C      G     SHELX HKL OUTPUT of FC with made up sigmas.
C                  XPCH6X(LSTNO,1)
C      H     CIF OUTPUT F^2's  on scale of Fc
C                  XPCH6C(LSTNO,2)

C
CODE FOR XPCH5S
      SUBROUTINE XPCH5S(IN)
C--PUNCH LIST 5 IN CRYSTALS FORMAT
C      IN 1 EVERYTHING
C         0 ONLY ATOMS
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
C--LOAD LIST 5 FROM THE DISC
      IF (KHUNTR (5,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL05
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--PUNCH OUT THE LIST HEADING
      IF (IN .GT. 0) THEN
       CALL XPCHLH(LN5,NCPU)
C--OUTPUT THE CONTENTS RECORD
       WRITE(NCPU,1000)N5,MD5LS,MD5ES,MD5BS
1000  FORMAT(13HREAD NATOM = ,I6,11H, NLAYER = ,I4,13H, NELEMENT = ,I4,
     2 11H, NBATCH = ,I4)
C--OUTPUT THE OVERALL PARAMETERS
       WRITE(NCPU,1050) STORE(L5O),STORE(L5O+1),STORE(L5O+2),
     1 STORE(L5O+3),STORE(L5O+4),STORE(L5O+5)
1050  FORMAT(8HOVERALL ,F11.6,4(1X,F9.6),1X,F17.7)
      ENDIF
C--CHECK FOR SOME ATOMS
      IF(N5)1200,1200,1100
C--OUTPUT THE ATOMS
1100  CONTINUE
      M5 = L5
      DO 1170 K = 1, N5
C----- DONT PUNCH 'SPARE' FOR THE MOMENT - IT CAUSES PROBLEMS
C      WITH ALIEN PROGRAMS
CDJWNOV2000 REINTRODUCE PUNCHING OF ALL DATA
C      MD5TMP = MIN (13, MD5)
      MD5TMP = MIN(18, MD5) 
      J = M5 + 13
C ISTORE bits will only print if J=18, not if J=14.
      WRITE(NCPU,1150) (STORE(I), I = M5, J),
     1                (ISTORE(I), I= J+1, M5+MD5TMP -1 )
1150  FORMAT
     1 ('ATOM ',A4,1X,6F11.6/
     2 'CON U[11]=',6F11.6/
     3 'CON SPARE=',F11.2,3I11,7X,A4)
      M5 = M5 + MD5
1170  CONTINUE
C--CHECK IF THERE ARE ANY LAYER SCALES TO OUTPUT
      IF (IN .LE. 0) GOTO 1700
1200  CONTINUE
      IF(MD5LS)1350,1350,1250
C--PUNCH THE LAYER SCALES
1250  CONTINUE
      M5LS=L5LS+MD5LS-1
      WRITE(NCPU,1300)(STORE(I),I=L5LS,M5LS)
1300  FORMAT(10HLAYERS    ,6F11.6/(10HCONTINUE  ,6F11.6))
C--CHECK IF THERE ARE ANY ELEMENT SCALES TO OUTPUT
1350  CONTINUE
      IF(MD5ES)1500,1500,1400
C--OUTPUT THE ELEMENT SCALES
1400  CONTINUE
      M5ES=L5ES+MD5ES-1
      WRITE(NCPU,1450)(STORE(I),I=L5ES,M5ES)
1450  FORMAT(10HELEMENTS  ,6F11.6/(10HCONTINUE  ,6F11.6))
C--CHECK IF THERE ARE ANY BATCH SCALS TO BE OUTPUT
1500  CONTINUE
      IF(MD5BS)1650,1650,1550
C--OUTPUT THE BATCH SCALE FACTORS
1550  CONTINUE
      M5BS=L5BS+MD5BS-1
      WRITE(NCPU,1600)(STORE(I),I=L5BS,M5BS)
1600  FORMAT(10HBATCH     ,6F11.6/(10HCONTINUE  ,6F11.6))
C--AND NOW THE 'END'
1650  CONTINUE
      CALL XPCHND(ncpu)
1700  CONTINUE
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 5 )
      RETURN
      END
C
C
CODE FOR XPCH5X
      SUBROUTINE XPCH5X
C--PUNCH LIST 5 IN X-RAY FORMAT
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
C--LOAD LIST 5
      CALL XFAL05
      IF ( IERFLG .LT. 0 ) GO TO 9900
      F=1./STORE(L5O)
      WRITE(NCPU,1000)F
1000  FORMAT(//7HSCALE  ,F10.6,4H   1)
      M5=L5
      F=4.*TWOPIS
      N=999
      DO 1400 I=1,N5
      ISTORE(M5+1)=NINT(STORE(M5+1))
      ISTORE(M5+1)=IABS(ISTORE(M5+1))
      IF(ISTORE(M5+1)-1000)1150,1050,1050
1050  CONTINUE
      ISTORE(M5+1)=N
      N=N-1
      IF(N)1100,1100,1150
1100  CONTINUE
      N=999
1150  CONTINUE
C-C-C-TRANSFORM U TO B
C      STORE(M5+3)=STORE(M5+3)*F
C-C-C-CHECK WHETHER ATOM IS ANISOTROPIC
      IF(ABS(STORE(M5+3))-UISO)1180,1190,1190
C-C-C-ANISOTROPIC ATOM
1180  CONTINUE
      WRITE(NCPU,1200)STORE(M5),ISTORE(M5+1),STORE(M5+4),STORE(M5+5),
     2 STORE(M5+6),STORE(M5+3),STORE(M5+2)
      GOTO 1250
C-C-C-ISOTROPIC ATOM, SPHERE, LINE OR RING
1190  CONTINUE
C-C-C-TRANSFORM U TO B
      STORE(M5+7)=STORE(M5+7)*F
      WRITE(NCPU,1200)STORE(M5),ISTORE(M5+1),STORE(M5+4),STORE(M5+5),
     2 STORE(M5+6),STORE(M5+7),STORE(M5+2)
      GOTO 1350
1200  FORMAT(7HATOM   ,A3,I3,3F8.5,F6.3,F5.2)
C      IF(ABS(STORE(M5+3))-UISO)1250,1350,1350
1250  CONTINUE
      J=M5+7
      K=M5+12
      WRITE(NCPU,1300)STORE(M5),ISTORE(M5+1),(STORE(L),L=J,K)
1300  FORMAT(7HUIJ    ,A3,I3,6F8.5)
1350  CONTINUE
      M5=M5+MD5
1400  CONTINUE
      RETURN
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 5 )
      END
C
C
CODE FOR XPCH5C
      SUBROUTINE XPCH5C(ISPACE)
C---- PUNCH LIST 5 IN SHELDRICK FORMAT
C
C--
      CHARACTER*7 CATNM
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XCOMPD.INC'
C
      INCLUDE 'QSTORE.INC'
      DATA KHYD /'H   '/
      DATA KDET /'D   '/
C
C--LOAD LIST 3, TO FIND THE FORM FACTORS TO BE USED
      IF (KHUNTR (3,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL03
      IF (KHUNTR (5,0, IADDL,IADDR,IADDD, -1) .LT. 0) CALL XFAL05
      IF ( IERFLG .LT. 0 ) GO TO 9900
C----- OUTPUT A TITLE, FIRST 40 CHARACTERS ONLY
      WRITE(NCPU,'(''REM TITL '',10A4)') (KTITL(I),I=1,10)
      M5=L5
      L5A=NFL
      M5A=L5A
      DO 1000 I=1,N5
      ISTORE(M5A)=ISTORE(M5)
      M5=M5+MD5
      M5A=M5A+1
1000  CONTINUE
C--LINK LISTS 5 AND 3
      I=KSET53(0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
      M5=L5
      M5A=L5A
      N=99
      NOOO = 999
      NOO  = 99
      NO   = 9
      WRITE(NCPU,1050)
1050  FORMAT(/1H )
C--PUNCH EACH ATOM  -  ONE AT A TIME
      DO 1450 I=1,N5
      ISTORE(M5)=ISTORE(M5)+1
      L=M5+4
      M=M5+6
      J=NINT(STORE(M5+1))
      J=IABS(J)

      WRITE(CATNM,'(A)') ISTORE(M5A)
      CALL XCTRIM (CATNM, ITRIM)

      IF (ITRIM .EQ. 2) THEN
        IF ( J.GT.999 ) THEN
           J = NOOO
           NOOO = NOOO - 1
           IF ( NOOO .LE. 0 ) THEN
              NOOO = 999
           END IF
        END IF
      ELSE IF (ITRIM .EQ. 3) THEN
        IF ( J.GT.99 ) THEN
           J = NOO
           NOO = NOO - 1
           IF ( NOO .LE. 0 ) THEN
              NOO = 99
           END IF
        END IF
      ELSE 
        IF ( J.GT.9 ) THEN
           J = NO
           NO = NO - 1
           IF ( NO .LE. 0 ) THEN
              NO = 9
           END IF
        END IF
      END IF

      IF ( ISPACE .EQ. 0 ) ITRIM = ITRIM + 1

      IF (J.LT.10) THEN
        WRITE( CATNM (ITRIM:), '(I1)') J
      ELSE IF (J.LT.100) THEN
        WRITE( CATNM (ITRIM:), '(I2)') J
      ELSE 
        WRITE( CATNM (ITRIM:), '(I3)') J
      ENDIF

cdjwapr2010
c      call xcras ( catnm, itemp)

      HFIX = 0.0
      IF( (ISTORE(M5A).EQ.KHYD) .OR. (ISTORE(M5A).EQ.KDET))
     1  HFIX = 10.0
C
C--CHECK WHETHER ISO OR ANISO
C-C-C-CHECK WHETHER ANISO OR ISO/SPHERE/LINE/RING
      IF(ABS(STORE(M5+3))-UISO)1250,1350,1350
C-C-C-ANISO
1250  CONTINUE
      M5O=M5+7
      L5O=M5+12
      WRITE(NCPU,1300)CATNM,ISTORE(M5),(STORE(K)+HFIX,K=L,M),
     2 10.0+STORE(M5+2),(STORE(K),K=M5O,L5O)
1300  FORMAT(A7,1X,I5,6F10.5,2H =/5X,4F10.5)
      GOTO 1400
C-C-C-ISO/SPHERE/LINE/RING
1350  CONTINUE
      WRITE(NCPU,1300)CATNM,ISTORE(M5),(STORE(K)+HFIX,K=L,M),
     2 10.+STORE(M5+2),STORE(M5+7)
1400  CONTINUE
      M5=M5+MD5
      M5A=M5A+1
1450  CONTINUE
      RETURN
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 5 )
      RETURN
      END
C
CODE FOR XPCH5D
      SUBROUTINE XPCH5D
C----- OUTOUT ATOMS IN 'CHIME' PDB FORMAT
CDJWFEB2000
C--
      CHARACTER*6 CLAB
      INCLUDE 'ISTORE.INC'
      DIMENSION A(3)
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLISTI.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'XSSCHR.INC'
      INCLUDE 'UFILE.INC'
C
      INCLUDE 'QSTORE.INC'
C
      IF (KEXIST(1) .LT. 1) THEN
      WRITE(CMON,'('' No Cell Parameters Available'')')
      CALL XPRVDU(NCVDU, 1,0)
      RETURN
      ENDIF
      IF (KEXIST(5) .LT. 1) THEN
      WRITE(CMON,'('' No Atoms Available'')')
      CALL XPRVDU(NCVDU, 1,0)
      RETURN
      ENDIF
      CALL XFAL01
      CALL XFAL05
      write(cmon,'(a)') 'Writing PDB data to .PDB file'
      CALL XPRVDU(NCVDU, 1,0)
C---- OPEN THE .XYZ FILE
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(6, KDEV , 'PUBLISH.PDB', 11)
C----- CELL PARAMETERS
      WRITE(NCFPU1,9100) (STORE(I),I=L1P1,L1P1+2)
     1 ,(RTD*STORE(I),I=L1P1+3,L1P1+5)
9100  FORMAT('CRYST1',3F9.3,3F7.2)
C----- RECIPROCAL ORTHOGONALISATION MATRIX
      K=L1O2
      DO 1 J=1,3
      WRITE(NCFPU1,9150) J,(STORE(I),I=K,K+2), 0.0
      K=K+3
1     CONTINUE
9150  FORMAT('SCALE',4X,I1,3F10.5,5X,F10.5) 
C---- FROM CCDC - JAN08
C     FORMAT(6A1,4X,3F10.5,5X,F10.5)
      M5 = L5
      DO 100 I = 1, N5
C--COMPUTE THE ORTHOGONAL COORDINATES OF THE ATOM
      CALL XMLTTM(STORE(L1O1),STORE(M5+4),A,3,3,1)
      WRITE(CLAB,'(A4)') STORE(M5)
      IF (CLAB(2:2) .EQ. ' ') THEN
            CLAB(2:2) = CLAB(1:1)
            CLAB(1:1) = ' '
      ENDIF
      IF (STORE(M5+1) .LE. 9 ) THEN
       WRITE(CLAB(3:3),'(I1)') NINT(STORE(M5+1))
      ELSE IF (STORE(M5+1) .LE. 99 ) THEN
       WRITE(CLAB(3:4),'(I2)') NINT(STORE(M5+1))
      ELSE IF (STORE(M5+1) .LE. 999 ) THEN
       WRITE(CLAB(3:5),'(I3)') NINT(STORE(M5+1))
      ENDIF
      WRITE(NCFPU1,  105) I, CLAB, A
105   FORMAT('ATOM',I7,1X,A6,7X,'0',4X,3F8.3)

      M5 = M5 + MD5
100   CONTINUE
C Close the .PDB FILE
        CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
        CALL XRDOPN(7, KDEV , CSSMAP, LSSMAP)
      RETURN
      END
C
CODE FOR XPCH5E
      SUBROUTINE XPCH5E(ITYPE)
C--PRINT LIST 5 WITH ESDS/CREATE LIST 9
c
c      ITYPE 1 FOR PRINTED LIST
C      ITYPE 2 FOR CREATION OF LIST 9
C
c      This is really horrid code (DJW, Feb2011)
c      A LIST 5 and LIST 12 is loaded
c      The short records are over written with esds from LIST 12
c      The atom records are created elsewhere in memory and the 
c      L5 addresses set to point to them. 
c      The fiddled-with list is then written to disk as a LIST 9
C
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
C
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XAPK.INC'
C
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'QSTORE.INC'
C
C
C--INITIALISE THE TIMING
      CALL XTIME1(2)
c-- set the output type
      lnout = 9
      CALL XRSL
      CALL XCSAE
C--LOAD A FEW LISTS
      CALL XFAL01
      CALL XFAL05
      CALL XFAL23
      write(cmon,'(a)') 'Writing simple esd file'
      call xprvdu(ncvdu, 1,0)
      iupdat = istore(l23sp+1)
      toler = store(l23sp+5)
      call xprc17 (0, 0, TOLER, -1)
C       FORM THE ABSOLUTE LIST 12
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
c
C
c
C--SET THE POINTERS TO LOOP OVER ALL THE ATOMS
         M5=L5
         M12=L12
C----- SET AUXILLIARY LIST 5 ADDRESSES
         L5A=L5
         M5A=L5
         N5A=N5
         MD5A=MD5
C--SET THE NEW ATOMS UP AT THE TOP OF CORE IN A LIST 9
         LN=lnout
         IREC=1002
         N9A=N5
         MD9A=13
         L9A=KCHLFL(MD9A*N9A)
         M9A=L9A

C--LOOP OVER THE ATOMS
      DO K=1,N5
C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD
        MD5A=M5+NKA-1
        N5A=NKA-2
        CALL SAPPLY (J)
        IF (ITYPE .EQ. 1) THEN
            write(ncpu,20) istore(m5), nint(store(m5+1)), 
     1      (store(idjw),idjw=m5+2, m5+13)
            write(ncpu,20) istore(m5), nint(store(m5+1)), 
     1      (bpd(idjw),idjw=1, 11)
20          format(a4,i4,12f11.6)
            write(ncpu,'(/)')
        ELSE
c--         move the type and serial
            call xmove(store(m5),store(m9a),2)
c--         move the esds
            call xmove(bpd(1),store(m9a+2),11)
        ENDIF
C
1585    CONTINUE
C -- UPDATE THE ATOM INFORMATION FOR THE NEXT ATOM
        M12=ISTORE(M12)
        M5=M5+MD5
        M5A=M5A+MD5
        M9A=M9A+MD9A
      END DO
c
c  reset the LIST 5 pointers into LIST 9
      l5=l9a
      m5=l9a
      md5=md9a
c
c      twin element scales - this overwrites LIST 5
c
      l5a = l5es
      m5a = m5es
      md5a= md5es
      n5a = n5es
      m12 = l12es
      l9es = l5es
      m9es = m5es
      mdes= md5es
      n9es = n5es
      if(md5a .gt. 0) then
c--calculate the e.s.d.'s and store them in bpd
       jp = 1
       call xpesd ( 2, jp)
       call xmove(bpd(1),store(l9es),md5a)
      endif
C
c      overall param  - this overwrites LIST 5
c
      l5a = l5o
      m5a = m5o
      md5a= md5o
      n5a = n5o
      m12 = l12o
      l9o = l5o
      m9o = m5o
      mdo= md5o
      n9o = n5o
      if(md5a .gt. 0) then
c--calculate the e.s.d.'s and store them in bpd
       jp = 1
       call xpesd ( 2, jp)
       call xmove(bpd(1),store(l9o),md5a)
      endif
C
1250  CONTINUE
      IF (ITYPE .EQ. 1) GOTO 2300
C--CREATE THE OUTPUT LIST TYPE
      NEW=1
      CALL XCPYL5(5,LNOUT,N9A,NEW)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1300)LNOUT,N5
      WRITE ( CMON ,1300)LNOUT,N5
      CALL XPRVDU(NCVDU, 1,0)
1300  FORMAT(' The new list ',I3,' contains ',I5,' atoms')
      MD5=MD5A
      CALL XSTR05(LNOUT,0,NEW)
C
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
      END
C

CODE FOR XPCH38
      SUBROUTINE XPCH38
C--PUNCH LIST 38 IN CRYSTALS FORMAT
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST38.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
C--LOAD LIST 38 FROM THE DISC
      CALL XFAL38
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--PUNCH OUT THE LIST HEADING
      LN38 = 38
      CALL XPCHLH (LN38,NCPU)
C--OUTPUT THE CONTENTS RECORD
      WRITE(NCPU,1000) N38GR, N38AT, N38LK, N38OR, N38VC
1000  FORMAT('READ NGROUP= ',I5, ' NATOM= ',I5, ' NLINK= ',I5,
     2 ' NORIGIN= ',I5, ' NVECTOR= ',I5)
C
C----- CHECK FOR SOME GROUPS
      IF(N38GR)8200,8200,1100
1100  CONTINUE
      M38GR = L38GR
      M38LK = L38LK
      M38OR = L38OR
      M38VC = L38VC
      M38AT = L38AT
C----- LOOP OVER ALL GROUPS - REMEMBER THERE IS A LINK FOR EACH GROUP.
C
      DO 2000 M38 = 1,N38GR
      I = M38GR + MD38GR -1
      WRITE(NCPU,1200) (STORE(J),J=M38GR,I)
1200  FORMAT('GROUP ',A4,1X,F5.0,1X,F4.0,4(1X,F10.5),/
     2 ('CONT      ',6(1X,F10.5)) )
      I = M38LK + MD38LK -1
      WRITE(NCPU,1250) (ISTORE(J),J=M38LK,I)
1250  FORMAT('LINK',6X,6(1X,2I5))
C
C----- ANY ATOM CARDS ?
      IF (ISTORE(M38LK +1)) 1300,1300,1400
1300  CONTINUE
      WRITE(NCAWU,1350)
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,1350)
      ENDIF
1350  FORMAT(1X,' LIST 38 error. A group contains no atoms ')
      GOTO 9900
1400  CONTINUE
      I = M38AT + MD38AT*ISTORE(M38LK +1) -1
      WRITE(NCPU,1450) (STORE(J),J=M38AT,I)
1450  FORMAT('ATOM      ', A4,1X,F5.0)
      M38AT = M38AT + MD38AT*ISTORE(M38LK +1)
C
C----- ANY ORIGIN CARDS ?
      IF (ISTORE(M38LK+3)) 1600,1600,1500
1500  CONTINUE
      I = M38OR + MD38OR*ISTORE(M38LK +3) -1
      WRITE(NCPU,1550) (STORE(J),J=M38OR,I)
1550  FORMAT(('ORIGIN    ', A4,6(1X,F5.0)))
      M38OR = M38OR + MD38OR*ISTORE(M38LK+3)
1600  CONTINUE
C
C----- ANY VECTOR CARDS ?
      IF (ISTORE(M38LK+5)) 1750,1750,1650
1650  CONTINUE
      I = M38VC + MD38VC*ISTORE(M38LK +5) -1
      WRITE(NCPU,1700) (STORE(J),J=M38VC,I)
1700  FORMAT(('VECTOR    ', A4,6(1X,F5.0)))
      M38VC = M38VC + MD38VC*ISTORE(M38LK+3)
1750  CONTINUE
C
      M38GR = M38GR + MD38GR
      M38LK = M38LK + MD38LK
2000  CONTINUE

C--AND NOW THE 'END'
      CALL XPCHND(ncpu)
      CALL XPCHUS(ncpu)
      RETURN
C
8200  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      WRITE(NCWU,8300)
      ENDIF
      WRITE(NCAWU,8300)
8300  FORMAT(' There are no GROUP definitions stored')
      GOTO 9900
C
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 38 )
      RETURN
      END
C
CODE FOR XPCH6S
      SUBROUTINE XPCH6S(IULN, iuln2)
C  PUNCH C      PUNCH LIST 6/7 IN SHORT CRYSTALS FORMAT
C
C--
      DIMENSION JFOT(1), JFOO(1)
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
      DATA JFOT(1)/10/
      DATA JFOO(1)/3/
C
C     H              K              L              /FO/           SQRTW
C     /FC/           PHASE          A-PART         B-PART         TBAR
C     /FOT/          ELEMENTS       SIGMA(/FO/)    BATCH          INDICES
C     BATCH/PHASE    SINTH/L**2     FO/FC          JCODE          SERIAL
C     RATIO          THETA          OMEGA          CHI            PHI
C     KAPPA          PSI            CORRECTIONS    FACTOR1        FACTOR2
C     FACTOR3        RATIO/JCODE    NOTHING
C
      IF (KEXIST(1) .GE. 1) CALL XFAL01
C--SET UP LIST 6 FOR READING ONLY
      IN = 0
      CALL XFAL06(IULN, IN)
      IF ( IERFLG .LT. 0 ) GO TO 9900

CDJW mar08
      lout = ln6
      if (iuln .ne. iuln2) then
            if (lout.eq.6) then 
                  lout=7
                  write(ncpu,100) 6,7
            else
                  lout=6
                  write(ncpu,100) 7,6
            endif
100   format('# punching list', i3, ' as list',i3)
      endif            
c
cdjwjan2001
C -- CHECK IF 'FO ' OR 'FOT' HAS BEEN SAVED
c
      JNFO=KCOMP(1,JFOO(1)+l6,ISTORE(L6DMP),MD6DMP,1)
      JNFT=KCOMP(1,JFOT(1)+l6,ISTORE(L6DMP),MD6DMP,1)
c
c      DO 1900 I=L6DMP,M6DMP
C---- SET POINTERS TO INFORMATION ON DISK
c         IF ((ISTORE(I)-M6).EQ.JFOO(1)) IRFO=JFOO(1)
c         IF ((ISTORE(I)-M6).EQ.JFOT(1)) IRFT=JFOT(1)
c         ISTORE(I)=ISTORE(I)-M6+ISTORE(KX+1)
c1900  CONTINUE
c
cdjwjan2001
C--PUNCH THE INITIAL HEADING
      CALL XPCHLH(lout,NCPU)
C--PUNCH THE 'READ', 'INPUT' AND 'FORMAT' CARDS
      if (jnft .ge. 1) then
      WRITE(NCPU,1000)
      else
      write (ncpu,1001)
      endif
C>DJW280896
C-------      TWINNED
1000  FORMAT('READ NCOEFFICIENT = 11, TYPE = FIXED, UNIT = DATAFILE' ,
     1 ', CHECK=NO' /
     3 'FORMAT (3F4.0, F10.2, F8.2, F10.2, F8.4, F10.2, ',
     4 'F10.0, / G12.5, F4.0)'/
     4 'store ncoef=9'/
     5 'outPUT indices /FO/ SIGMA SQRTW /FC/ PHASE RATIO/JCODE ',
     5 ' /FOT/ ELEMENTS',/
     2 'INPUT H K L /FO/ SIGMA /FC/ PHASE /FOT/ ELEMENTS'
     4 ,' SQRTW JCODE' /
     5 'END')
c
C------      NOT TWINNED
1001  FORMAT('READ NCOEFFICIENT = 9, TYPE = FIXED, UNIT = DATAFILE' ,
     1 ', CHECK=NO' /
     2 'INPUT H K L /FO/ SIGMA /FC/ PHASE SQRTW JCODE' /
     3 'FORMAT (3F4.0, F10.2, F8.2, F10.2, F8.4, G12.5, F4.0)'/
     4 'store ncoef=7'/
     5 'outPUT indices /FO/ SIGMA SQRTW /FC/ PHASE RATIO/JCODE ',/
     6 'END')
C<DJW280896
C--FETCH THE NEXT REFLECTION
1050  CONTINUE
CDJWMAR99       PUNCH LESS THANS
C      IF (KFNR(IN)) 1250, 1100, 1100
      IF (KLDRNR(IN)) 1250, 1100, 1100
C--FIX THE INDICES
1100  CONTINUE
      J=M6+2
      DO 1150 I=M6,J
      ISTORE(I)=NINT(STORE(I))
1150  CONTINUE
C--FIX THE ELEMENTS
      ISTORE(M6+11)=NINT(STORE(M6+11))
C--PUNCH THE REFLECTION
      if (jnft .ge. 1) then
C  TWINNED
      WRITE(NCPU,1200)(ISTORE(I),I=M6,J),STORE(M6+3),STORE(M6+12),
     2 STORE(M6+5),STORE(M6+6),STORE(M6+10),ISTORE(M6+11),
     3 STORE(M6+4), NINT(STORE(M6+18))
1200  FORMAT(3I4,F10.2,F8.2,F10.2,F8.4,F10.2,I10, / G12.5,I4)
      else
C  nOT TWINNED
      WRITE(NCPU,1201)(ISTORE(I),I=M6,J),STORE(M6+3),STORE(M6+12),
     2 STORE(M6+5),STORE(M6+6),STORE(M6+4),NINT(STORE(M6+18))

1201  FORMAT(3I4,F10.2,F8.2,F10.2,F8.4,G12.5,I4)
      endif
      GOTO 1050
C--TERMINATE THE LIST
1250  CONTINUE
      I = -512
      WRITE(NCPU,1200)I
      if (jnft .ge. 1) then
        WRITE(NCPU,'(/)')   ! Otherwise read picks up following # as error.
      end if
      CALL XPCHUS(ncpu)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 6 )
      RETURN
      END
C
CODE FOR XPCH6O
      SUBROUTINE XPCH6O(IULN)
C  PUNCH D      PUNCH THE OBSERVED QUANTITIES FOR EACH REFLECTION ON
C             SEVERAL LINES INFULL CRYSTALS FORMAT
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
      IF (KEXIST(1) .GE. 1) CALL XFAL01
C--SET UP LIST 6 FOR READING ONLY
      IN = 0
      CALL XFAL06(IULN, IN)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--PUNCH THE INITIAL HEADING
      CALL XPCHLH(LN6,NCPU)
C--PUNCH THE 'READ', 'INPUT' AND 'FORMAT' CARDS
      WRITE(NCPU,1000)
1000  FORMAT(53HREAD NCOEFFICIENT = 12, TYPE = FIXED, UNIT = DATAFILE ,
     1  10H, CHECK=NO/
     2 41HINPUT H K L /FO/ SIGMA(/FO/) JCODE RATIO ,
     3 38H BATCH TBAR CORRECTIONS /FOT/ ELEMENTS/14HFORMAT (3F4.0,,
     4 44HF10.2,F8.2,F3.0,F7.1,F3.0,2E12.5,F10.2,F3.0)/3HEND)
C--FETCH THE NEXT REFLECTION
1050  CONTINUE
CDJWMAR99       PUNCH LESS THANS
C      IF (KFNR(IN)) 1250, 1100, 1100
      IF (KLDRNR(IN)) 1250, 1100, 1100
C--FIX THE INDICES
1100  CONTINUE
      J=M6+2
      DO 1150 I=M6,J
      ISTORE(I)=NINT(STORE(I))
1150  CONTINUE
C--FIX THE ELEMENTS
      ISTORE(M6+11)=NINT(STORE(M6+11))
C--FIX THE 'JCODE', 'SERIAL' AND 'BATCH'
      ISTORE(M6+18)=NINT(STORE(M6+18))
      ISTORE(M6+13)=NINT(STORE(M6+13))
      ISTORE(M6+19)=NINT(STORE(M6+19))
C--PUNCH THE REFLECTION
      WRITE(NCPU,1200)(ISTORE(I),I=M6,J),STORE(M6+3),STORE(M6+12),
     2 ISTORE(M6+18),STORE(M6+20),ISTORE(M6+13),STORE(M6+9),
     3 STORE(M6+27),STORE(M6+10),ISTORE(M6+11)
1200  FORMAT(3I4,F10.2,F8.2,I3,F7.1,I3,2E12.5,F10.2,I3)
      GOTO 1050
C--TERMINATE THE LIST
1250  CONTINUE
      I = -512
      WRITE(NCPU,1200)I
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 6 )
      RETURN
      END
C
CODE FOR XPCH6G
      SUBROUTINE XPCH6G(IULN, IN)
C  PUNCH A   GENERAL COMPRESSED PUNCHING ROUTINES FOR LIST 6
C
C  IN  THE TYPE OF PUNCHING REQUIRED :
C
C      IN - NOT USED (AUG95)
C      -1  '/FO/', OR '/FOT/' AND 'ELEMENTS', DEPENDING UPON LIST 13.
C       0  AS FOR -1, EXCEPT THAT 'RATIO' IS ALSO PUNCHED.
C
C--THE INITIAL INDICES FOR EACH KL GROUP APPEAR ON A SEPARATE CARD.
C  THE END OF EACH KL GROUP IS INDICATED BY A NEGATIVE CARD SEQUENCE
C  NUMBER FOR THE LAST CARD.
C
C--THE FORMAT OF EACH CARD IS   (HSTEP  KEY1  KEY2  .  .)  REPEATED
C  THE 'HSTEP' GIVES THE INCREMENT FROM THE LAST REFLECTION, SO THAT THE
C  DATA MUST BE SORTED.
C
C--INDEX STEPS WHICH ARE NEGATIVE LEAD TO THE REFLECTION BEING REJECTED
C  ON INPUT.
C
C--
      INCLUDE 'ISTORE.INC'
C
      DIMENSION AA(5),IPOS(5)
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST13.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
      IF (KEXIST(1) .GE. 1) CALL XFAL01
C----- DEFINE IN TO BE 0, I,E. FULL PUNCH
      IN = 0
C--INCREMENT THE VALUE OF 'IN'
      IN=IN+2
C--SET THE NUMBER OF COEFFICIENTS, APART FROM THE INDICES
      NW=IN
C--LOAD LIST 13
      CALL XFAL13
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--CHECK IF THIS STRUCTURE IS TWINNED
      IF(ISTORE(L13CD+1))1050,1000,1000
C--TWINNED  -  ADJUST 'IN' AND 'NW'
1000  CONTINUE
      IN=IN+2
      NW=IN-1
C--CLEAR THE CORE
1050  CONTINUE
      CALL XRSL
      CALL XCSAE
C--SET UP LIST 6 FOR INPUT
      IN1 = 0
      CALL XFAL06(IULN, IN1)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C--BRANCH ON THE INPUT TYPE
      GOTO(1200,1150,1300,1250,1100),IN
C1100  STOP 230
1100  CALL GUEXIT(230)
C--/FO/ AND RATIO
1150  CONTINUE
      IPOS(2)=M6+20
C--/FO/
1200  CONTINUE
      IPOS(1)=M6+3
      GOTO 1350
C--/FOT/, ELEMENTS AND RATIO
1250  CONTINUE
      IPOS(3)=M6+20
C--/FOT/ AND ELEMENTS
1300  CONTINUE
      IPOS(1)=M6+10
      IPOS(2)=M6+11
C--FIND THE MULTIPLIERS
1350  CONTINUE
      DO 1450 I=1,NW
      M6DTL=L6DTL+MD6DTL*(IPOS(I)-M6)
C--CHECK IF THERE ARE ANY DETAILS STORED
      AA(I)=1.
      IF(STORE(M6DTL+3)-ZERO)1450,1400,1400
C--COMPUTE THE MULTIPLIER
1400  CONTINUE
      AA(I)=999./STORE(M6DTL+1)
1450  CONTINUE
C--CHECK IF THIS IS FOR A TWINNED CRYSTAL
      IF(IN-2)1550,1550,1500
C--TWINNED  -  MULTIPLIER FOR ELEMENTS IS 1.0
1500  CONTINUE
      AA(2)=1.
C--PUNCH THE LIST TYPE
1550  CONTINUE
      CALL XPCHLH(LN6,NCPU)
C--PUNCH THE 'READ' CARD
      I=NW+3
      WRITE(NCPU,1600)I
1600  FORMAT(20HREAD NCOEFFICIENT = ,I5,
     2 36H, TYPE = COMPRESSED, UNIT = DATAFILE)
C--CHECK FOR A TWINNED STRUCTURE
      IF(IN-2)1650,1650,1750
C--NOT TWINNED
1650  CONTINUE
      WRITE(NCPU,1700)(IB,I=1,IN)
1700  FORMAT(20HINPUT  H  K  L  /FO/,2A1,5HRATIO)
      GOTO 1850
C--TWINNED STRUCTURE
1750  CONTINUE
      WRITE(NCPU,1800)(IB,I=3,IN)
1800  FORMAT(31HINPUT  H  K  L  /FOT/  ELEMENTS,2A1,5HRATIO)
C--OUTPUT THE MULTIPLIERS
1850  CONTINUE
      WRITE(NCPU,1900)(AA(I),I=1,NW)
1900  FORMAT(28HMULTIPLIERS  1.0  1.0  1.0  ,3F17.9)
      CALL XPCHND(ncpu)
C--SET UP A FEW INITIAL CONSTANTS
      CALL XPCHIN(80)
      IK1=-1000000
C--FETCH THE NEXT REFLECTION
1950  CONTINUE
CDJWMAR99       PUNCH LESS THANS
C      IF (KFNR(IN)) 1250, 1100, 1100
      IF (KLDRNR(IN1)) 2400, 2000, 2000
C--COMPUTE THE INDICES
2000  CONTINUE
      JH=NINT(STORE(M6))
      IK=NINT(STORE(M6+1))
      IL=NINT(STORE(M6+2))
C--CHECK IF 'K' HAS CHANGED SINCE THE LAST REFLECTION
      IF(IK-IK1)2200,2050,2200
C--'K' HAS NOT CHANGED  -  CHECK IF 'L' HAS CHANGED
2050  CONTINUE
      IF(IL-IL1)2200,2100,2200
C--THIS IS THE SAME 'KL' PAIR  -  OUTPUT 'H' AND THE COEFFICIENTS
2100  CONTINUE
      CALL XPCHAR(JH)
      DO 2150 M=1,NW
      L=IPOS(M)
      I=NINT(STORE(L)*AA(M))
      CALL XPCHAR(I)
2150  CONTINUE
      GOTO 1950
C--CHANGE 'KL' PAIRS  -  OUTPUT THE TERMINATOR
2200  CONTINUE
      IF(IK1+1000000)2250,2350,2250
C--THIS IS NOT THE FIRST REFLECTION
2250  CONTINUE
      CALL XPCHAR(512)
C--CHECK IF 'L' HAS CHANGED
      IF(IL-IL1)2300,2350,2300
C--NEW LINE FOR NEXT 'L' VALUE
2300  CONTINUE
      CALL XPCHLL
2350  CONTINUE
      CALL XPCHAR(IK)
      CALL XPCHAR(IL)
      IK1=IK
      IL1=IL
      GOTO 2100
C--END OF THE REFLECTIONS  -  OUTPUT THE TERMINATOR
2400  CONTINUE
      CALL XPCHAR(-512)
      CALL XPCHLL
      CALL XPCHUS(ncpu)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 6 )
      END
CODE FOR XPCH6C
      SUBROUTINE XPCH6C(IULN,KF)
C PUNCH B,E,H  CIF FORMAT PUNCH
C KF  0 - F's
C     1 - F^2's
C     2 - F^2'S ON SCALE OF FC
CDJWMAY99 - OUTPUT TO FOREIGN PUNCH UNIT
      CHARACTER*80 CBUF
      DIMENSION KDEV(4)
      DIMENSION IVEC(20), ESD(6)
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'XSSCHR.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST28.INC'
      INCLUDE 'XLST31.INC'
      INCLUDE 'XLST13.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'ICOM31.INC'
      INCLUDE 'QLST31.INC'
      CHARACTER*12 CTEMP
      CHARACTER*1 CALW(3)
      CHARACTER CCELL(3)*1,CANG(3)*5
      DATA CCELL/'a','b','c'/
      DATA CANG/'alpha','beta','gamma'/
      DATA CALW /'o','<','x'/
      INCLUDE 'IDIM31.INC'
      CALL XRSL
      CALL XCSAE
CRICAUG00 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
CDJW02  DO OPENS IN SCRIPT
CDJW02      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
CDJW02      CALL XRDOPN(6, KDEV , CSSFCF, LSSFCF)
      IF (KEXIST(1) .GE. 1) CALL XFAL01
      CALL XFAL05
      IN = 0
      CALL XFAL06(IULN, IN)
      IF (IERFLG .LT. 0) GOTO 9900

      IF ( KEXIST(31) .GE. 1 ) THEN
        CALL XLDLST (31,ICOM31,IDIM31,0)
      ELSE
        L31 = -1
      END IF

      SCALE6 = STORE(L5O)
      WRITE(NCFPU1, '(''data_1 '')')
      WRITE(NCFPU1, '(''#  '',10A4)') (KTITL(I),I=1,10)
      CALL XDATER ( CBUF(1:8))
      WRITE(NCFPU1,'(''_audit_creation_date  '',6X, 
     1 ''"'', 3(A2,A))')
     2 CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2),'"'
      WRITE(NCFPU1, '(''_audit_creation_method      CRYSTALS '',/)')

C --  CONVERT ANGLES TO DEGREES.
      STORE(L1P1+3)=RTD*STORE(L1P1+3)
      STORE(L1P1+4)=RTD*STORE(L1P1+4)
      STORE(L1P1+5)=RTD*STORE(L1P1+5)
      CALL XZEROF (ESD,6)
      IF (L31.GE.1) THEN
C---- SCALE DOWN THE ELEMENTS OF THE V/CV MATRIX
        SCALE=STORE(L31K)
        M31=L31
        ESD(1)=SQRT(STORE(M31)*SCALE)
        ESD(2)=SQRT(STORE(M31+6)*SCALE)
        ESD(3)=SQRT(STORE(M31+11)*SCALE)
        ESD(4)=SQRT(STORE(M31+15)*SCALE)*RTD
        ESD(5)=SQRT(STORE(M31+18)*SCALE)*RTD
        ESD(6)=SQRT(STORE(M31+20)*SCALE)*RTD
      END IF

      M1P1 = L1P1
      DO I=1,3
          CALL XFILL (IB,IVEC,16)
          CALL SNUM (STORE(M1P1),ESD(I),-3,0,10,IVEC)
          WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
          CALL XCRAS (CBUF,N)
          WRITE (NCFPU1,600) CCELL(I)(1:1),CBUF(1:N)
600       FORMAT ('_cell_length_',A,T35,A)
          CALL XFILL (IB,IVEC,16)
          CALL SNUM (STORE(M1P1+3),ESD(I+3),-2,0,10,IVEC)
          WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
          CALL XCRAS (CBUF,N)
          J=INDEX(CBUF(1:N),'.')
          IF (J.EQ.0) J=MAX(1,N)
          TEMP=STORE(M1P1+3)-INT(STORE(M1P1+3))
          IF (TEMP.LE.ZERO) N=MAX(1,J-1)
          WRITE (NCFPU1,650) CANG(I)(1:5),CBUF(1:N)
650       FORMAT ('_cell_angle_',A,T35,A)
          M1P1=M1P1+1
      END DO

      IF (KF .EQ. 2) THEN
       WRITE(NCFPU1,'(/''# NOTE FO on scale of Fc, '', F12.5)')
     1               1./SCALE6
      ELSE
       WRITE(NCFPU1,'(/''# NOTE Fc on scale of Fo, '', F12.5)')SCALE6
      ENDIF
      WRITE(NCFPU1,'(''# Status flags: '')')
      WRITE(NCFPU1,'(''#    o - used in refinement '')')
      WRITE(NCFPU1,'(''#    < - excluded by I/sigmaI cutoff '')')
      WRITE(NCFPU1,'(''#    x - excluded for another reason  '')')

      IF ( KF.EQ. 0 )  THEN
         WRITE(NCFPU1,1000)
      ELSE
         WRITE(NCFPU1,1001)
      END IF
1000  FORMAT ( /,'loop_',/,'_refln_index_h'/,'_refln_index_k'/,
     1 '_refln_index_l'/,'_refln_F_meas'/,'_refln_F_calc'/,
     2 '_refln_F_sigma'/,'_refln_observed_status')
1001  FORMAT ( /,'loop_',/,'_refln_index_h'/,'_refln_index_k'/,
     1 '_refln_index_l'/,'_refln_F_squared_meas'/,
     2 '_refln_F_squared_calc'/,
     3 '_refln_F_squared_sigma'/,'_refln_observed_status')



C---- GET SIGMA THRESHOLD FROM L28
      S6SIG = -200.0
      IF ( N28MN .GT. 0 ) THEN
        INDNAM = L28CN
        DO I = L28MN , M28MN , MD28MN
            WRITE ( CTEMP , '(3A4)') (ISTORE(J), J=INDNAM,INDNAM+2)
            IF (INDEX(CTEMP,'RATIO') .GT. 0) THEN
              S6SIG = STORE(I+1)
            ENDIF
            INDNAM = INDNAM + MD28CN
        END DO
      ENDIF
 
1840  CONTINUE
      ISTAT = KLDRNR (IN)
      IF (ISTAT .LT. 0) GOTO 1850

      I = NINT(STORE(M6))
      J = NINT(STORE(M6+1))
      K = NINT(STORE(M6+2))
      IF (KF .EQ. 2) THEN
       FO = STORE(M6+3)/ SCALE6
       FC = STORE(M6+5)
       S =  MAX(0.0,STORE(M6+12))/ SCALE6
      ELSE
       FO = STORE(M6+3)
       FC = STORE(M6+5) * SCALE6
       S =  MAX(0.0,STORE(M6+12))
      ENDIF
C
C
      IF ( KF.NE. 0 ) THEN
         CALL XSQRF(FOS, FO, FABS, SIGMA, S)
         FCS = FC*FC
      END IF

      IF ( STORE(M6+20) .LT. S6SIG) THEN
        IALW = 2                    !Rejected by sigma cutoff.
      ELSE IF (KALLOW(IN).LT.0) THEN
        IALW = 3                    !Rejected by something else.
      ELSE
        IALW = 1                    !Used.
      END IF

      IF ( KF.NE. 0 ) THEN
        WRITE(NCFPU1,'(3I4,3F12.2,1X,A1)')I,J,K,FOS,FCS,SIGMA,CALW(IALW)
      ELSE
         WRITE(NCFPU1,'(3I4,3F12.2,1X,A1)')I, J, K, FO, FC, S,CALW(IALW)
      END IF
      GOTO 1840
1850  CONTINUE
      GOTO 9999
9900  CONTINUE
      WRITE(NCFPU1,'(''#  '',10A4)') (KTITL(I),I=1,10)
9999  CONTINUE
CRIGAUG00 - CLOSE CIF
CDJW02      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
      RETURN
      END
CODE FOR XPCH6X
      SUBROUTINE XPCH6X(IULN,IFOFC)
C----- SHELX FORMAT PUNCH
C - List number (6 or 7) for loading the right reflection list.
C - IFOFC: 0 - punch FOsq, 1 - punch FCsq with made up errors sigma.
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XLST06.INC'
      CALL XRSL
      CALL XCSAE
      IN = 0
      CALL XFAL06(IULN, IN)
      IF (IERFLG .LT. 0) GOTO 9999

c      M6DTL=L6DTL+3*MD6DTL
c      E=STORE(M6DTL+1)       ! FETCH THE MAXIMUM VALUE OF /FO/

1840  CONTINUE
        IF ( KLDRNR (IN) .LT. 0 ) GOTO 9999
        IF ( IFOFC .EQ. 0 ) THEN
          CALL XSQRF(FOS, STORE(M6+3), FABS, SIGMA, STORE(M6+12))
        ELSE
C This is just a test, don't use these numbers for anything important.
          FOS = STORE(M6+5) * STORE(M6+5)
C Make up a sigma that is proportional to the sqrt of FOS, but
C doesn't quite ever drop to zero.
          SIGMA = 0.676 * STORE(M6+5) + 3.1
C The errors in FOS/SIGMA should be normally distributed, assume
C sigma's underestimated by a factor of 5.
          X = XRAND ( 1.0, 1 )
          FOS = FOS + 5 * SIGMA * X
        END IF

        IF      (FOS.LT.100000.00) THEN
          WRITE(NCPU,'(3I4,2F8.2)')(NINT(STORE(M6+I)),I=0,2),FOS,SIGMA
        ELSE IF (FOS.LT.1000000.0) THEN
          WRITE(NCPU,'(3I4,2F8.1)')(NINT(STORE(M6+I)),I=0,2),FOS,SIGMA
        ELSE IF (FOS.LT.100000000) THEN
          WRITE(NCPU,'(3I4,I8,F8.0)')(NINT(STORE(M6+I)),I=0,2),
     1     NINT(FOS),SIGMA
        ELSE
          WRITE(NCPU,'(3I4,G8.3,F8.1)')(NINT(STORE(M6+I)),I=0,2),
     1     FOS,SIGMA
        END IF
      GOTO 1840
9999  CONTINUE
      RETURN
      END
C
CODE FOR XPCHIN
      SUBROUTINE XPCHIN(IN)
C--INITIATE PUNCHING CONSTANTS
C
C  IN  NUMBER OF CHARACTERS ON A LINE
C
C--THIS SET OF ROUTINES USES THE VARIABLES IN 'XWORKA' :
C
C  JO  BOTTOM LOCATION MINUS ONE FOR THE OUTPUT ARRAY
C  JP  BOTTOM LOCATION FOR THE OUTPUT ARRAY
C  JQ  TOP LOCATION FOR THE OUTPUT ARRAY PLUS TWO
C  JR  TOP LOCATION FOR THE OUTPUT ARRAY
C  JS  CURRENT POSITION IN THE OUTPUT ARRAY
C
C--
      INCLUDE 'STORE.INC'
      INCLUDE 'XLISTI.INC'
      INCLUDE 'XWORKA.INC'
C
      IREC=7501
C--SET UP THE CONSTANTS
      JO=NFL-1
      JP=NFL
      JQ=KCHNFL(IN+1)
      JR=JQ-2
      JS=JO
      RETURN
      END
C
CODE FOR XPCHAR
      SUBROUTINE XPCHAR(N)
C--OUTPUT A NUMBER TO THE BUFFER
C
C  N  THE NUMBER TO BE OUTPUT
C
C--
C
C
      DIMENSION IT(20)
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCHARS.INC'
C
      INCLUDE 'QSTORE.INC'
C
C--INSERT THE FINAL BLANK
      M=1
      IT(M)=IB
      I=IABS(N)
C--CHECK IF THE VALUE IS ZERO
      IF(I)1050,1000,1050
C--THE VALUE IS ZERO
1000  CONTINUE
      M=2
      IT(M)=NUMB(1)
      GOTO 1200
C--PROCESS THE NEXT NUMBER
1050  CONTINUE
      J=I
      I=I/10
      J=J-I*10
      M=M+1
      IT(M)=NUMB(J+1)
      IF(I)1100,1100,1050
C--CHECK THE SIGN OF THE INPUT NUMBER
1100  CONTINUE
      IF(N)1150,1200,1200
C--INSERT THE NEGATIVE SIGN
1150  CONTINUE
      M=M+1
      IT(M)=MINUS
C--CHECK IF THERE IS ROOM FOR THIS NUMBER IN THE CORE BUFFER
1200  CONTINUE
      IF(JS+M-JQ)1300,1250,1250
C--PRINT THE LAST CARD
1250  CONTINUE
      CALL XPCHLL
C--OUTPUT THE LAST NUMBER
1300  CONTINUE
      JS=JS+M
      J=JS
      DO 1350 I=1,M
      ISTORE(J)=IT(I)
      J=J-1
1350  CONTINUE
      RETURN
      END
C
CODE FOR XPCHLL
      SUBROUTINE XPCHLL
C--OUTPUT THE LAST CARD THAT HAS BEEN ASSEMBLED
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XWORKA.INC'
C
      INCLUDE 'QSTORE.INC'
C
C--PUNCH THE LAST CARD
      JS=MIN0(JS,JR)
      WRITE(NCPU,1000)(ISTORE(I),I=JP,JS)
1000  FORMAT(80A1)
      JS=JO
      RETURN
      END
C
CODE FOR XPCHLH
      SUBROUTINE XPCHLH(IN,NODEV)
C--PUNCH OUT THE LIST HEADING
C
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
C
      CALL XDATE(A,B)
      CALL XTIME(C,D)
      WRITE(NODEV,1000)IH,IH,A,B,C,D,IH,IH,IN
1000  FORMAT(A1,79X/A1,12H Punched on ,2A4,4H at ,2A4,47X
     1 /A1,79X/A1,4HLIST,I7,68(' '))
      RETURN
      END
C
CODE FOR XPCHND
      SUBROUTINE XPCHND(nodev)
C--PUNCH OUT AN 'END'
C
C--
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
C
      WRITE(Nodev,1000)
1000  FORMAT(3HEND,77(' '))
      RETURN
      END
C
C
CODE FOR XPCHUS
      SUBROUTINE XPCHUS(nodev)
C
C----- WRITE A 'USE' CARD
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCHARS.INC'
C
      WRITE ( Nodev , 1000 ) IH, IH
1000  FORMAT(A1,' Remove space after hash to activate next line',/
     1  A1, ' USE LAST')
      RETURN
      END

C
C
C
CODE FOR XPCHLX
      SUBROUTINE XPCHLX(NUMB,IADDD,LENGRP,NGRP,NODEV)
C--PUNCH A CARD IMAGE PRODUCED BY THE LEXICAL SCANNER.
C      (SEE ALSO XPRTLC)
C
C  NUMB    THE CARD NUMBER.
C  IADDD   THE DISC ADDRESS OF THE LOGICAL CARD.
C  LENGRP  THE LENGTH OF EACH REAL CARD.
C  NGRP    THE NUMBER OF REAL CARDS IN THIS LOGICAL CARD.
C  NODEV   FORTRAN IO UNIT 
C
C--
      CHARACTER *88 CLINE
C
      DIMENSION CARD(20)
C
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
C
C--MARK THIS AS THE FIRST REAL CARD
      J=0
C--FIND THE ADDRESS AND LENGTH POINTERS
      N=NGRP
      M=LENGRP
      L=IADDD
C--FIND THE LENGTH TO PRINT
      K=MIN0(M,20)
C--CHECK IF THERE ARE MORE CARDS TO PRINT
1000  CONTINUE
      IF(N)1050,1050,1100
C--NO MORE CARDS  -  RETURN
1050  CONTINUE
      RETURN
C--READ THIS IMAGE DOWN
1100  CONTINUE
      CALL XDOWNF(L,CARD(1),K)
C--UPDATE THE POINTERS
      L=L+KINCRF(M)
      N=N-1
C--CHECK IF THIS IS THE FIRST CARD
      WRITE(CLINE,1200)  CARD
      CALL XCTRIM (CLINE, NCHAR)
      KK = MIN0 ( 80, NCHAR)
      WRITE(NODEV,'(A)')  CLINE(1:KK)
      IF (NCHAR .GE. 81) THEN
       KK = KK + 1
       WRITE(NODEV,'(A)')  CLINE(KK:NCHAR)
      ENDIF
1200  FORMAT(20A4)
      J=1 + J
      GOTO 1000
      END
CODE FOR XPCH40
      SUBROUTINE XPCH40(ICLASS)
C--PUNCH LIST 40 IN LIST 40 FORMAT, OR #BONDING FORMAT
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST40.INC'
      INCLUDE 'XOPVAL.INC'
C
      INCLUDE 'QSTORE.INC'
C
      INCLUDE 'XCHARS.INC'
C
      CHARACTER * 32 CATOM1, CATOM2, CBLANK
      DATA CBLANK /' '/

C--LOAD LIST 40 FROM THE DISC
      CALL XFAL40
      IF ( IERFLG .LT. 0 ) GO TO 9900

C--PUNCH EITHER A LIST 40, OR AN #BONDING INSTRUCTION TO CREATE A LIST 40.
      IF ( ICLASS .EQ. 1 ) THEN

C--PUNCH OUT THE LIST HEADING
       LN40 = 40
       CALL XPCHLH (LN40,NCPU)

C--OUTPUT THE DEFAULTS RECORD
       WRITE(NCPU,10)NINT(STORE(L40T)),STORE(L40T+1),NINT(STORE(L40T+2))
10     FORMAT('DEFAULTS TOLTYPE=',I2,' TOLERANCE=',F6.3,
     1        ' MAXBONDS =',I4)
     
C--OUTPUT THE CONTENTS RECORD
       WRITE(NCPU,11) N40E,N40P,N40M,N40B
11     FORMAT('READ NELEM=',I5,' NPAIR=',I5,' NMAKE=',I5,' NBREAK=',I5)

C--OUTPUT ANY ELEMENT CARDS
       DO I = L40E,L40E+(MD40E*(N40E-1)),MD40E
         WRITE(NCPU,12) ISTORE(I), STORE(I+1), NINT(STORE(I+2))
12       FORMAT('ELEMENT ',A4,' RADIUS=',F6.3,' MAXBONDS=',I4)
       END DO

C--OUTPUT ANY PAIR CARDS
       DO I = L40P,L40P+(MD40P*(N40P-1)),MD40P
        WRITE(NCPU,13) ISTORE(I),ISTORE(I+1),
     1                 STORE(I+2),STORE(I+3),NINT(STORE(I+4))
13      FORMAT('PAIR',3X,2(1X,A4),' MIN=',F6.3,' MAX=',F6.3,' BOND=',I4)
       END DO

14     FORMAT(A,2X,2(1X,A4,1X,I4,5(1X,I3)),1X,I4)
15     FORMAT(A,2X,2(1X,A4,1X,I4,5(1X,I3)))
C--OUTPUT ANY BONDS TO MAKE
       DO I = L40M,L40M+(MD40M*(N40M-1)),MD40M
        WRITE(NCPU,14)'MAKE ',
     1        (ISTORE(I+K),(ISTORE(I+J+K),J=1,6),K=0,7,7),ISTORE(I+14)
       END DO

C--OUTPUT ANY BONDS TO BREAK
       DO I = L40B,L40B+(MD40B*(N40B-1)),MD40B
        WRITE(NCPU,15)'BREAK',
     1                (ISTORE(I+K),(ISTORE(I+J+K),J=1,6),K=0,7,7)
       END DO


      ELSE

       CALL XDATE(A,B)
       CALL XTIME(C,D)
       WRITE(NCPU,20)IH,IH,A,B,C,D,IH,IH
20     FORMAT(A1,79X/A1,' Punched on ',2A4,' at ',2A4,47X
     1 /A1,79X/A1,'BONDING',I7,68(' '))

C--OUTPUT THE DEFAULTS RECORD IN #BONDING FORMAT
       WRITE(NCPU,21)NINT(STORE(L40T)),STORE(L40T+1),NINT(STORE(L40T+2))
21     FORMAT('DEFAULTS TOLTYPE=',I2,' TOLERANCE=',F6.3,
     1        ' MAXBONDS =',I4)
     
C--OUTPUT ANY ELEMENT CARDS
       DO I = L40E,L40E+(MD40E*(N40E-1)),MD40E
         WRITE(NCPU,22) ISTORE(I), STORE(I+1), NINT(STORE(I+2))
22       FORMAT('ELEMENT ',A4,' RADIUS=',F6.3,' MAXBONDS=',I4)
       END DO

C--OUTPUT ANY PAIR CARDS
       DO I = L40P,L40P+(MD40P*(N40P-1)),MD40P
        WRITE(NCPU,23) ISTORE(I), ISTORE(I+1),STORE(I+2),
     1                 STORE(I+3), NINT(STORE(I+4))
23      FORMAT('PAIR',3X,2(1X,A4),' MIN=',F6.3,' MAX=',F6.3,
     1         ' BOND=',I4)
       END DO


24      FORMAT (3A, ' to ', A, '   BOND=',I4)
25      FORMAT (3A, ' to ', A)
C--OUTPUT ANY BONDS TO MAKE
       DO I = L40M,L40M+(MD40M*(N40M-1)),MD40M
        CALL CATSTR (STORE(I),FLOAT(ISTORE(I+1)),
     2                ISTORE(I+2),ISTORE(I+3),
     3                ISTORE(I+4),ISTORE(I+5),ISTORE(I+6),
     4                CATOM1, LATOM1)
        CALL CATSTR (STORE(I+7),FLOAT(ISTORE(I+8)),
     2                ISTORE(I+9),ISTORE(I+10),
     3                ISTORE(I+11),ISTORE(I+12),ISTORE(I+13),
     4                CATOM2, LATOM2)
        WRITE (NCPU,24)'MAKE    ',CBLANK(1: 21-LATOM1),
     2                  CATOM1(1:LATOM1), CATOM2(1:LATOM2),ISTORE(I+14)
       END DO

C--OUTPUT ANY BONDS TO BREAK
       DO I = L40B,L40B+(MD40B*(N40B-1)),MD40B
        CALL CATSTR (STORE(I),FLOAT(ISTORE(I+1)),
     2                ISTORE(I+2),ISTORE(I+3),
     3                ISTORE(I+4),ISTORE(I+5),ISTORE(I+6),
     4                CATOM1, LATOM1)
        CALL CATSTR (STORE(I+7),FLOAT(ISTORE(I+8)),
     2                ISTORE(I+9),ISTORE(I+10),
     3                ISTORE(I+11),ISTORE(I+12),ISTORE(I+13),
     4                CATOM2, LATOM2)
        WRITE (NCPU,25)'BREAK   ',CBLANK(1: 21-LATOM1),
     2                  CATOM1(1:LATOM1), CATOM2(1:LATOM2)
       END DO

      END IF



C--AND NOW THE 'END'
      CALL XPCHND(ncpu)
      CALL XPCHUS(ncpu)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 38 )
      RETURN
      END


CODE FOR XPCH41
      SUBROUTINE XPCH41
C--PUNCH LIST 41 IN SIMON BORWICK FORMAT
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XLST41.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'XCHARS.INC'

      CHARACTER * 32 CATOM1, CATOM2, CBLANK
      DATA CBLANK /' '/

      IF (KEXIST(5) .LT. 1) THEN
        WRITE(CMON,'('' No Atoms available '')')
        CALL XPRVDU(NCVDU, 1,0)
        RETURN
      ENDIF

C--LOAD LISTS 5 and 41 FROM THE DISC
      CALL XFAL05
      CALL XFAL41
      IF ( IERFLG .LT. 0 ) GO TO 9900

      WRITE(NCPU,'(A)')'# Summary of list 41 (bonding)'


      DO M41B = L41B, L41B + (N41B-1)*MD41B, MD41B
        IA1 = L5 + ISTORE(M41B)*MD5
        IA2 = L5 + ISTORE(M41B+6)*MD5

        WRITE (NCPU,'(A4,6I6,2X,A4,6I6,2X,F10.5)')
     1   ISTORE(IA1), NINT(STORE(IA1+1)),
     2   (ISTORE(M41B+J),J=1,5),
     1   ISTORE(IA2), NINT(STORE(IA2+1)),
     2   (ISTORE(M41B+J),J=7,11), STORE(M41B+13)

      END DO

C--AND NOW THE 'END'
      CALL XPCHND(ncpu)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 38 )
      RETURN
      END


CODE FOR XPCH22
      SUBROUTINE XPCH22(ICLASS)
C--PUNCH LIST 22 IN SIMPLE TO READ FORMAT
C  ICLASS  NOT YET USED
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XUSLST.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'ICOM12.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XLST24.INC'
      INCLUDE 'XSTR11.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XAPK.INC'
      INCLUDE 'XOPK.INC'
      INCLUDE 'XSCALE.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'QLST12.INC'
      CHARACTER *6 FLAG, IBLANK
      DATA IBLANK /'      '/


      WRITE(CMON,'(A)') 'Punch list 22'
      CALL XPRVDU(NCVDU,1,0)

C--LOAD LIST 5 FROM THE DISC
      CALL XFAL05
      IF ( IERFLG .LT. 0 ) GO TO 9900
      JQ=2
      JS=1
      CALL XFAL12(JS,JQ,JR,JN)

C--PUNCH OUT THE LIST HEADING
      LN22 = 22
      CALL XPCHLH (LN22,NCPU)

C      JT            ABSOLUTE L.S. PARAMETER NO.
C      JS            PHYSICAL PARAMETER NO FROM WHICH TO START SEARCH
C      JX            RELATIVE PARAMETER NO

      JX = 12
      M5 = L5 - MD5
      M12 = L12O
      L12A = NOWT
      JS = 0

      FLAG = IBLANK

      DO WHILE(M12 .GE. 0)   ! More stuff in L12
        IF(ISTORE(M12+1).GT.0) THEN ! Any refined params
C--COMPUTE THE ADDRESS OF THE FIRST PART FOR THIS GROUP
          L12A=ISTORE(M12+1)
C--CHECK IF THIS PART CONTAINS ANY REFINABLE PARAMETERS
2250  CONTINUE
          DO WHILE(L12A.GT.0) ! --CHECK IF THERE ARE ANY MORE PARTS FOR THIS ATOM OR GROUP
            IF(ISTORE(L12A+3).LT.0) EXIT
C--SET UP THE CONSTANTS TO PASS THROUGH THIS PART
            MD12A=ISTORE(L12A+1)
            JU=ISTORE(L12A+2) 
            JV=ISTORE(L12A+3)
            JS=ISTORE(L12A+4)+1
C--SEARCH THIS PART OF THIS ATOM
            DO JW=JU,JV,MD12A
              JT=ISTORE(JW)

c1950    FORMAT(/' Block',I4/8X,'Param.',4X,'Rel. param.',4X,
c     2  'Calc. shift',4X,'Shift ratio',4X,'E.S.D.',5X,'Shift/E.S.D.',
c     3  4X,'Type',3X,'Serial',4X,'Coordinate'/)

              NB=17
              ILEBP = 0
              DO NA=1,NSC
                IF(ICOM12(NB).EQ.M12) THEN
C--LAYER OR ELEMENT BATCH OR PARAMETER PRINT
                   ILEBP = 1
                   EXIT
                END IF
                NB=NB+4
              END DO

              IF ( ILEBP .EQ. 1 ) THEN
                WRITE(NCPU,2750)FLAG,JT,
     2          (KSCAL(NC,NA+2),NC=1,2),JS


C--CHECK IF THIS IS AN OVERALL PARAMETER
              ELSE IF (M12.EQ.L12O) THEN
                WRITE(NCPU,2750)JT,(KVP(JRR,JS),JRR=1,2)
2750   FORMAT(1X,I12,26X,2A4,I3)
              ELSE  
C-C-C-DISTINCTION BETWEEN ANISO'S AND ISO/SPECIAL'S FOR PRINT
                IF((STORE(M5+3) .GE. 1.0) .AND. (JS .GE. 8)) THEN
                 WRITE(NCPU,3050)JT,STORE(M5),
     2           NINT(STORE(M5+1)),(ICOORD(JRR,JS+NKAO),JRR=1,NWKA)
                ELSE
                 WRITE(NCPU,3050)JT,STORE(M5),
     2           NINT(STORE(M5+1)),(ICOORD(JRR,JS),JRR=1,NWKA)
                ENDIF
              ENDIF
3050  FORMAT(1X,I12,8X,A4,I4,1X,3A4)
C
C--INCREMENT TO THE NEXT PARAMETER OF THIS PART
              JS=JS+1
            END DO
C--CHANGE PARTS FOR THIS ATOM OR GROUP
            L12A=ISTORE(L12A)
          END DO
        END IF
C--MOVE TO THE NEXT GROUP OR ATOM
        M5=M5+MD5
        M12=ISTORE(M12)
      END DO

C--AND NOW THE 'END'
      CALL XPCHND(ncpu)
      CALL XPCHUS(ncpu)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 38 )
      RETURN
      END

