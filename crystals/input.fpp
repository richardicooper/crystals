C $Log: not supported by cvs2svn $
C Revision 1.17  2010/07/16 11:35:31  djw
C Enable XPCHLX to output lists 12 and 16 to the cif file.  This means carrying the I/O chanel (as NODEV)
C in XPCHLX,XPCHLH,PPCHND and XPCHUS.
C Fixed oversight in distangle for esds of H-bonds
C
C Revision 1.16  2010/05/04 10:40:42  djw
C Call new-style (i.e. correct) SHELX atom output
C
C Revision 1.15  2009/11/03 11:17:43  djw
C Add comments and set up processing for LIST 18, the SMILES string
C
C Revision 1.14  2009/10/13 16:40:32  djw
C Fix typo in old COMMENT card
C
C Revision 1.13  2005/01/23 08:29:11  rich
C Reinstated CVS change history for all FPP files.
C History for very recent (January) changes may be lost.
C
C Revision 1.1.1.1  2004/12/13 11:16:09  rich
C New CRYSTALS repository
C
C Revision 1.12  2004/07/09 12:28:16  rich
C \punch 12 b  writes a easy to read version of list 22
C to the punch file. It can't be read back in, of course.
C May develop this into something for the CIF.
C
C Revision 1.11  2003/05/13 17:03:55  rich
C Corrected slightly illegal comment from 3 years ago.
C
C Revision 1.10  2001/12/12 17:49:01  Administrator
C matrix calculator
C
C Revision 1.9  2001/10/09 10:34:39  ckp2
C Punch 41 for Simon's project.
C
C Revision 1.8  2001/10/08 12:25:58  ckp2
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
C Revision 1.7  2001/10/05 13:31:51  ckp2
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
C Revision 1.6  2001/02/26 10:26:48  richard
C Added changelog to top of file
C
C
CODE FOR INPUT
      SUBROUTINE INPUT
      CALL XSYSDC(-1,1)
      CALL XLNIOA
      RETURN
      END
C
CODE FOR XLNIOA
      SUBROUTINE XLNIOA
C--FIRST CONTROL ROUTINE FOR LIST INPUT AND OUTPUT.

      CHARACTER *80 CLINE
      CHARACTER*4 CTXT(4)
      INCLUDE 'PLSTHN.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCARDS.INC'
      INCLUDE 'XLST50.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'XLSTHN.INC'
      INCLUDE 'XIOBUF.INC'
      DATA CTXT   / 'LIST', 'END ', 'BLOC', 'NO  ' /

C--LOAD THE NEXT '#INSTRUCTION'
c      see also PRCSS.FPP
      NUM=KNXTOP(LSTOP,LSTNO,ICLASS)
c      write(ncawu,'(4(a,i6))') 'INPUT  List op =', lstop, ' List no =',
c     1  LSTNO, ' Iclass=', iclass, '  Num = ', num
C--CHECK IF WE SHOULD RETURN
      IF(NUM.LE.0) RETURN

C--CHECK IF THIS IS A LIST OPERATION
      IF(LSTOP)1210,1210,1250
C--NOT A LIST OPERATION  -  BRANCH ON ITS TYPE
1210  CONTINUE
      GOTO (1220, 1230, 1240, 1245, 4000, 4400, 4500,
     1 4600, 4700, 1215), NUM

1215  CONTINUE
      GOTO 9920

C--'#SFLS' INSTRUCTION  -  READ THE S.F.L.S DETAILS
1220  CONTINUE
      CALL XRD33
      GOTO 1225

C--'#CYCLENDS' INSTRUCTION
1230  CONTINUE
      I=KRDDPV(ISTORE(NFL),1)

C--AND CHECK LIST 33
1225  CONTINUE
      CALL XCYCLE
      RETURN

C--'#END' INSTRUCTION
1240  CONTINUE
      CALL XMONTR(-1)
      CALL XEND
      RETURN

C--'#TITLE' INSTRUCTION
1245  CONTINUE
      CALL XRCN
      RETURN

C--BRANCH ON THE TYPE OF LIST OPERATION
1250  CONTINUE
      GOTO (2100,6000,7000,1300),LSTOP
1300  CALL GUEXIT(130)

C--LIST INPUT  -  BRANCH ON THE LIST TYPE
2100  CONTINUE

      IF ( LSTNO .LE. 0 ) GO TO 9920
      IF ( LSTNO .GT. MAXLST ) GO TO 9920
      IHANDL = ILSTHN(LSTNO)
      GO TO ( 3100 , 3200 , 3300 , 3400 , 3600 ,
     2 3900 , 9920 , 9920 ) , IHANDL
      GO TO 9920



C--INPUT OF LIST 1
3100  CONTINUE
      CALL XRD01
      RETURN

C--INPUT OF LIST 2
3200  CONTINUE
      CALL XRD02
      RETURN

C--GENERAL INPUT FOR LISTS THAT CAN BE OVERWRITTEN
3300  CONTINUE
      CALL XRDLN(LSTNO,-1)
      RETURN

C--GENERAL INPUT FOR LISTS THAT CANNOT BE OVERWRITTEN
3400  CONTINUE
      CALL XRDLN(LSTNO,0)
      RETURN

C--LEXICAL SCANNER INPUT
3600  CONTINUE
      CALL XRDLEX(LSTNO)
      RETURN

3900  CONTINUE
C -- LIST NUMBER NOT ALLOWED
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 3905 ) LSTNO
      WRITE ( NCAWU , 3905 ) LSTNO
      WRITE ( CMON, 3905) LSTNO
      CALL XPRVDU(NCVDU, 1,0)
3905  FORMAT ( 1X , 'List number ' , I4 , ' is not allowed' )
      CALL XERHND ( IERERR )
      RETURN

4000  CONTINUE
C----- 'CLEAR INSTRUCTION FOR DEFAULT LISTS'
C----- FORMATS FOR INTERNAL READS
4010  FORMAT( A1, A, I4)
C----- READ ANY REMAINING DATA
      IF (KRDDPV (LSTNO, 1) .LT. 0) GOTO 9920
C----- SEE IF WE WANT THIS LIST
      IF ( (LSTNO .NE. 12) .AND. (LSTNO .NE. 16) .AND.
     1  (LSTNO .NE. 17)) THEN
        IF (ISSPRT .EQ. 0) WRITE(NCWU,4150) LSTNO
        WRITE(NCAWU,4150) LSTNO
        WRITE ( CMON, 4150) LSTNO
        CALL XPRVDU(NCVDU, 1,0)
4150    FORMAT(' List type ',I6, ' may not be CLEARed ')
      RETURN
      ENDIF
C
C----- STORE THE SYSTEM REQUEST QUEUE IF NECESARY
      CALL XSSRQ (IADDRQ, NSRQ)
      WRITE(CLINE, 4010) IH, CTXT(1), LSTNO
C----- WRITE TO SRQ
      CALL XISRC (CLINE)
C----- BRANCH TO MESSAGE
      IF (LSTNO .EQ. 12) THEN
C----- 'BLOCK'
        CALL XISRC (CTXT(3))
      ELSE IF ( (LSTNO .EQ. 16) .OR. (LSTNO .EQ. 17)) THEN
C----- 'NO' FOR LIST 16, 17
        CALL XISRC (CTXT(4))
      ENDIF
C----- ALWAYS INSERT 'END'
      CALL XISRC (CTXT(2))
      IF (NSRQ .NE. 0) CALL XRSRQ( IADDRQ, NSRQ)
      RETURN

4400  CONTINUE
C----- QUICKSTART
      CALL XQSTRT
      RETURN

4500  CONTINUE
C----- COMPOSITION
      CALL XFMULA
      RETURN

4600  CONTINUE
C----- FINDFRAG
      CALL XFINDR
      RETURN

4700  CONTINUE
C----- MATRIX ARITHMETIC
      CALL SMATRX
      RETURN

C--LIST PRINT ROUTINE
6000  CONTINUE
      ITEMP1=NR60
      ITEMP2=NR61
      NR60=0
      NR61=0
      I=KRDDPV(ISTORE(NFL),4)
      NR60=ITEMP1
      NR61=ITEMP2
      CALL XRSL
      CALL XCSAE
C--CHECK FOR A PRINT OF LIST 12 OR LIST 16
      IF ( LSTNO .EQ. 11 ) GO TO 6600
      IF ( LSTNO .EQ. 12 ) GO TO 6500
      IF ( LSTNO .EQ. 16 ) GO TO 6500
      IF ( LSTNO .EQ. 18 ) GO TO 6500
C      IF ( LSTNO .EQ. 37 ) GO TO 6500
C--NORMAL LIST PRINT
      CALL XPRTLN(LSTNO)
      RETURN
C
C--LEXICAL SCANNER PRINT
6500  CONTINUE
      CALL XPRTLX(LSTNO,ICLASS,NCPU)
      RETURN
C
C--PRINT OF LIST 11
6600  CONTINUE
      I=ICLASS+2
C--BRANCH ON THE TYPE
      GOTO (6610,6620,6630,6605),I
C6605  STOP 132
6605  CALL GUEXIT(132)
C--PRINT THE CORRELATION COEFFICIENTS ABOVE 0.25
6610  CONTINUE
      CALL XPR11L(0.25)
      RETURN
C--PRINT THE COMPLETE COVARIANCE MATRIX
6620  CONTINUE
      CALL XPR11C
      RETURN
C--PRINT THE MATRIX AS STORED
6630  CONTINUE
      CALL XPR11N
      RETURN
C
C--LIST PUNCH ROUTINE
7000  CONTINUE
      ITEMP1=NR60
      ITEMP2=NR61
      NR60=0
      NR61=0
      I=KRDDPV(ISTORE(NFL),4)
      NR60=ITEMP1
      NR61=ITEMP2
      CALL XRSL
      CALL XCSAE
C--CHECK THAT THIS IS LIST 5
      IF (LSTNO - 5) 7100, 7300, 7400

C----- NOT PERMITTED
7100  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE ( NCWU , 7200 ) IH
      WRITE ( NCAWU , 7200 ) IH
      WRITE ( CMON, 7200) IH
      CALL XPRVDU(NCVDU, 1,0)
7200  FORMAT ( 1X , 'Illegal list number for ' , A1 , 'PUNCH' )
      CALL XERHND ( IERERR )
      RETURN

C--CHECK THE TYPE OF PUNCH
7300  CONTINUE
CDJWFEB2000      IF(ICLASS)7310,7320,7330
      GOTO (7310,7320,7330,7340), ICLASS+2
C--NORMAL PUNCH FORMAT
7310  CONTINUE
      CALL XPCH5S(1)
      RETURN
C--'XRAY' FORMAT
7320  CONTINUE
      CALL XPCH5X
      RETURN
C--CAMBRIDGE FORMAT
7330  CONTINUE
cdjwapr2010      CALL XPCH5C(0)
      CALL XPCH5C(1)
      RETURN
7340  CONTINUE
C----- 'CHIME' XYZ FORMAT
      CALL XPCH5D
      RETURN

7400  CONTINUE
C----- CHECK IF LIST 12, 16 OR 17 or 18
      IF ((LSTNO .EQ. 16) .OR. (LSTNO .EQ. 17)
     1  .OR. (LSTNO .EQ. 18) ) THEN
         IF ( ICLASS .EQ. -1 ) THEN  ! LIST AS CARD IMAGES
            CALL XPRTLX (LSTNO, 1,NCPU)
         ELSE 
            CALL XPRTLX (LSTNO, 1,NCFPU1) !LIST TO CIF OUTPUT 
         END IF
         RETURN
      ENDIF
      IF (LSTNO .EQ. 12) THEN
         IF ( ICLASS .EQ. 0 ) THEN ! LIST 22 AS COLUMN
            CALL XPCH22 (ICLASS+2)
         ELSE IF ( ICLASS .EQ. -1 ) THEN  ! LIST 12 AS CARD IMAGES
            CALL XPRTLX (LSTNO, 1,NCPU)
         ELSE 
            CALL XPRTLX (LSTNO, 1,NCFPU1) !LIST 12 TO CIF OUTPUT 
         END IF
         RETURN
      ENDIF
C----- CHECK IF LIST 41
      IF (LSTNO.EQ.41) THEN
            CALL XPCH41
            RETURN
      END IF
C----- CHECK IF LIST 40
      IF (LSTNO.EQ.40) THEN
            CALL XPCH40 (ICLASS+2)
            RETURN
      END IF
C----- CHECK IF LIST 38
      IF(LSTNO - 38) 7100, 7410, 7100
7410  CONTINUE
      CALL XPCH38
      RETURN
9920  CONTINUE
C -- INTERNAL ERROR
      CALL XOPMSG ( IOPCRY , IOPINT , 0 )
      CALL GUEXIT(2009)
      END

