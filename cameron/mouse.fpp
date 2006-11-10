C $Log: not supported by cvs2svn $
C Revision 1.14  2005/02/08 16:13:13  stefan
C 1. Removed a conflict line which I had missed.
C
C Revision 1.13  2005/02/08 15:59:47  stefan
C 1. Added precompiler if's for the mac source
C
C Revision 1.2  2004/12/13 16:16:48  rich
C Changed GIL to _GIL_ etc.
C
C Revision 1.1.1.1  2004/12/13 11:16:11  rich
C New CRYSTALS repository
C
C Revision 1.11  2004/02/04 16:58:11  stefan
C Changes for Mac command line version
C
C Revision 1.10  2003/05/07 12:18:53  rich
C
C RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
C using only free compilers and libraries. Hurrah, but it isn't very stable
C yet (CRYSTALS, not the compilers...)
C
C Revision 1.9  2002/06/26 11:56:43  richard
C Fixes for label mouse.
C
C Revision 1.8  2001/07/16 07:58:23  ckp2
C Do Cameron window update the old fashioned way. Instead of calling FSTSHW to indicate
C that the picture is ready to show, send the ^^CH SHOW command.
C
C Revision 1.7  1999/06/06 19:43:13  dosuser
C RIC: Replaced "^^CH SHOW" commands with direct calls to FSTSHW().
C
C Revision 1.6  1999/06/04 11:43:00  dosuser
C RIC: Added support for linux graphical interface version (GIL)
C
C Revision 1.5  1999/05/10 17:45:20  dosuser
C RIC: Oops. Too many IFs in ZLBUT. One of them has been removed.
C
C Revision 1.4  1999/05/07 15:29:12  dosuser
C RIC: Added support for 'mouse label' in the GID version.
C
C Revision 1.3  1999/02/23 19:44:55  dosuser
C RIC: The New Cameron Sources. Now we have one set of source code
C      for the DOS (Salford) and GID (DF&VC++) versions.
C      Need new scripts for some of the Cameron features. Need new
C      makefile.
C


CRYSTALS CODE FOR MOUSE.FOR
CODE FOR ZMLAB
      SUBROUTINE ZMLAB
C This routine controls the MOUSE movement of atomic labelling. It
C operators as follows :-
C 1) 1st left mouse button click - select label.
C The selected label disappears (is written in the background color)
C and is outlined with a red?? box.
C The atom referred to by the label is highlighted by a cross.
C 2) 2nd left mouse button click is the new label position.
C Draw label in new position. Turn off cross. Get rid of box
C around old label position.
C
C If the user hits the right mouse button then the operation is stopped.
C If the user hits the V key (for view) then the picture is redrawn and
C labelling is then resumed.
      
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOM.INC'
      INCLUDE 'CAMANA.INC'
      INCLUDE 'CAMDAT.INC'
      INCLUDE 'CAMCAL.INC'
      INCLUDE 'CAMMSE.INC'
      INCLUDE 'CAMMEN.INC'
      INCLUDE 'CAMCHR.INC'
      INCLUDE 'CAMGRP.INC'
      INCLUDE 'CAMCOL.INC'
      INCLUDE 'CAMFLG.INC'
      INCLUDE 'CAMSHR.INC'
      INCLUDE 'CAMVER.INC'
      INCLUDE 'CAMKEY.INC'
      INCLUDE 'CAMBTN.INC'
      INCLUDE 'CAMBLK.INC'
      INCLUDE 'XIOBUF.INC'

      INTEGER IB,KK
C THE CODE BELOW IS THE 'EVENT LOOP' WHICH ACTS ON BUTTON PRESSES AND
C V KEY PRESSES.
C Update status bar
      CALL ZMORE('Mouse label control activated.',0)
      CALL ZMORE('Options: Click atom to label',0)
      CALL ZMORE('         Click label to move, then new location',0)
      CALL ZMORE('         V to update view, RETURN to end labelling',0)
      CALL ZMORE1('Mouse label control activated.',0)

10    CONTINUE

C This machine specific stuff is much easier to understand
C if you look at the Fortran that is generated by EDITOR...

C Get the mouse information
#if defined(_DOS_) 
      IB = KMSGET(JX,JY,JF)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      IUNIT = 5
      IB = KRDLIN ( IUNIT, CLINE, LENUSE )
#endif
#if defined(_WXS_) 
      IUNIT = 5
      IB = KRDLIN ( IUNIT, CLINE, LENUSE )

#endif
#if defined(_DOs_) 
      IF ((IB.EQ.0).AND.(JF.GT.0)) THEN
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      IF ( CLINE(1:6) .EQ. 'LCLICK' ) THEN
#endif
#if defined(_WXS_) 
      IF ( CLINE(1:6) .EQ. 'LCLICK' ) THEN
C Left mouse button has been pressed.
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
        READ (CLINE(7:),*)JX,JY
#endif
#if defined(_WXS_) 
        READ (CLINE(7:),*)JX,JY
#endif
        CALL ZLBUT(JX,JY)
        GOTO 10

#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      ELSE IF ( CLINE(1:1) .EQ. 'V' ) THEN
        CALL ZDOVI
        GOTO 10
      ELSE
#endif
#if defined(_WXS_) 
      ELSE IF ( CLINE(1:1) .EQ. 'V' ) THEN
        CALL ZDOVI
        GOTO 10
      ELSE

#endif
#if defined(_DOS_) 
      ELSE IF ((IB.EQ.0).AND.(JF.LT.0)) THEN

C Right mouse button has been pressed.
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
C Non-left click action e.g. return,
#endif
        RETURN
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      ENDIF
#endif
#if defined(_DOS_) 
      ENDIF

C Check the keyboard
      CALL ZGTKY1(KK)
      IF ((KK.EQ.ICUV).OR.(KK.EQ.ICLV)) THEN
C V KEY HAS BEEN PRESSED - WE NEED TO REDRAW THE PICTURE
        CALL ZDOVI
        GOTO 10
      ENDIF
C ALSO RETURN ON A RETURN KEY HIT
      IF (KK.EQ.ICRET) THEN
        RETURN
      ENDIF
      GOTO 10
#endif
      END
 
CODE FOR ZLBUT
      SUBROUTINE ZLBUT (IMX,IMY)
C A LEFT MOUSE BUTTON PRESS HAS BEEN FOUND - LOOK TO SEE WHETHER THERE
C IS A LABEL UNDER THE MOUSE CURSOR.
      
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOM.INC'
      INCLUDE 'CAMANA.INC'
      INCLUDE 'CAMDAT.INC'
      INCLUDE 'CAMCAL.INC'
      INCLUDE 'CAMMSE.INC'
      INCLUDE 'CAMMEN.INC'
      INCLUDE 'CAMCHR.INC'
      INCLUDE 'CAMGRP.INC'
      INCLUDE 'CAMCOL.INC'
      INCLUDE 'CAMFLG.INC'
      INCLUDE 'CAMSHR.INC'
      INCLUDE 'CAMVER.INC'
      INCLUDE 'CAMKEY.INC'
      INCLUDE 'CAMBTN.INC'
      INCLUDE 'CAMBLK.INC'
      INCLUDE 'XIOBUF.INC'
      include 'XUNITS.INC'

      CHARACTER*20 CLAB
      INTEGER IMX,IMY,IX,IY,ICOL,IB,KK
      REAL LABLN
C WORK OUT THE LIMITS - THE LABELS SHOULD ONLY GO INTO THE MIDDLE 90%
C OF THE SCREEN
C      XMIN = (-0.9*XCEN)/SCALE + XCP
C      XMAX = (0.9*XCEN)/SCALE + XCP
C      YMIN = (-0.9*YCEN)/SCALE + YCP
C      YMAX = (0.9*YCEN)/SCALE + YCP
      TENPIX = REAL(IFONT)*2.5/SCALE
      RSMALL = ( 2.0 / SCALE ) **2
C CONVERT TO ANGSTROM COORDINATES
      X = (IMX-XCEN-XOFF)/SCALE + XCP
      Y = (IMY-YCEN-YOFF)/SCALE + YCP
C      IF (X.LT.XMIN .OR. X.GT.XMAX .OR. Y.LT.YMIN .OR. Y.GT.YMAX)
C     + RETURN
C NOW LOOP OVER ALL LABELLED ATOMS
      ILNO = 0
      DO 10 I = ISVIEW, IFVIEW-1 , IPACKT
C DO NOT COUNT EXCLUDED ATOMS
        IF (RSTORE(I+IPCK+1).LT.0) GOTO 10
C CHECK FOR ATOM LABELLING
        IF (NINT(RSTORE(I+IATTYP+2)).NE.1) GOTO 10
C GET THE ATOM LABEL POSITION
        RLX = RSTORE(I+ILAB)
        RLY = RSTORE(I+ILAB+1)
        RLL = MAX( RSTORE(I+ILAB+2), TENPIX*3.0)
C CHECK FOR X COORD FIRST
        IF ((X.GE.RLX).AND.(X.LE.RLX+RLL)) THEN
C NOW CHECK Y COORD
          IF ((Y.GE.RLY).AND.(Y.LE.RLY+TENPIX)) THEN
C WE HAVE FOUND A LABEL.
            ILNO = I
            GOTO 20
          ENDIF
        ENDIF
10    CONTINUE
20    CONTINUE
      IF (ILNO.EQ.0) THEN
C WE HAVE NOT FOUND A LABEL. LOOK FOR AN ATOM INSTEAD.
        DO 40 I = ISVIEW , IFVIEW-1 , IPACKT
C DO NOT INCLUDE EXCLUDED ATOMS
          IF (RSTORE(I+IPCK+1).LT.0.0) GOTO 40
          D = (X-RSTORE(I+IXYZO))**2 + (Y-RSTORE(I+IXYZO+1))**2
          IF (D.LE.RSTORE(I+IATTYP+4)**2.OR.D.LE.RSMALL) THEN
C WE HAVE FOUND AN ATOM - IS IT ALREADY LABELLED?
            IF (NINT(RSTORE(I+IATTYP+2)).EQ.1) GOTO 50
C IF NOT DRAW THE LABEL AND LABEL IT
            IX = NINT (( RSTORE(I+IXYZO) - XCP)*SCALE)
            IY = NINT (( RSTORE(I+IXYZO+1) - YCP)*SCALE)
            ILL = (I-IRATOM)/IPACKT + ICATOM
            IL = INDEX (CSTORE(ILL),' ') - 1
            IF (IL.LT.1) GOTO 40
C CHECK FOR PACK LABELLING
            IF ((IPACK.GT.0).AND.(IPLAB.EQ.1)) THEN
              CALL ZPLABL (I,CLAB,IL)
            ELSE
              CLAB = CSTORE(ILL)
cdjwnov06
              IL = max(1, INDEX (CSTORE(ILL),' ') - 1)
            ENDIF
C DRAW THE LABEL
            CALL ZDRTEX(IX,IY,CLAB(1:IL),IDEVCL(ILABCL+1))
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
            CALL ZMORE('^^CH SHOW',0)
            CALL ZMORE('^^CR',0)
#endif
#if defined(_WXS_) 
            CALL ZMORE('^^CH SHOW',0)
            CALL ZMORE('^^CR',0)
c &&GILGID            CALL FSTSHW()
C SAVE THE LABEL COORDINATES
#endif
            RSTORE(I+ILAB) = RSTORE(I+IXYZO)
            RSTORE(I+ILAB+1) = RSTORE(I+IXYZO+1)
            RSTORE(I+ILAB+2) = IL*TENPIX*0.8
            RSTORE(I+IATTYP+2) = 1.0
            GOTO 50
          ENDIF
40      CONTINUE
50      CONTINUE
        RETURN
      ENDIF
      IX = NINT (( RLX - XCP) * SCALE )
      IY = NINT (( RLY - YCP )*SCALE )
      ILL = (ILNO-IRATOM)/IPACKT + ICATOM
      IL  = INDEX (CSTORE(ILL),' ') - 1
      IF (IL.LT.1) RETURN
C CHECK FOR PACK LABELLING
      IF ((IPACK.GT.0).AND.(IPLAB.EQ.1)) THEN
        CALL ZPLABL (ILNO,CLAB,IL)
      ELSE
        CLAB = CSTORE(ILL)
cdjwnov06
        IL = max(1, INDEX (CSTORE(ILL),' ') - 1)
      ENDIF
C FIND OUT THE LABEL LENGTH
      LABLN = TENPIX * REAL(IL) * 0.8
C NEED TO HIDE THE MOUSE CURSOR DURING DRAWING
C NOW DRAW THE ATOM LABEL IN THE BACKGROUND COLOUR
      CALL ZDRTEX (IX,IY,CLAB(1:IL),IDEVCL(IBACK+1))
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
#endif
#if defined(_WXS_) 
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
c &&GILGID      CALL FSTSHW()
C DRAW THE CROSS AND THE BOX
#endif
      ICOL = 4
      CALL ZMBXCR (ILNO,ICOL,ICOL)
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
#endif
#if defined(_WXS_) 
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
c &&GILGID      CALL FSTSHW()
C NOW WAIT FOR THE NEXT LEFT BUTTON PRESS
#endif
30    CONTINUE

C DVF GUI VERSION CODE
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      IUNIT = 5
      IB = KRDLIN ( IUNIT, CLINE, LENUSE )
      IF ( CLINE(1:6) .NE. 'LCLICK' ) THEN
#endif
#if defined(_WXS_) 
      IUNIT = 5
      IB = KRDLIN ( IUNIT, CLINE, LENUSE )
      IF ( CLINE(1:6) .NE. 'LCLICK' ) THEN
C THIS ATOM IS NOT TO BE LABELLED
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
          CALL ZMBXCR(ILNO,IBACK,IBACK)
          RSTORE(ILNO+IATTYP+2) = 0.0
          RETURN
      ENDIF
      READ (CLINE(7:),*)IMX,IMY
#endif
#if defined(_WXS_) 
          CALL ZMBXCR(ILNO,IBACK,IBACK)
          RSTORE(ILNO+IATTYP+2) = 0.0
          RETURN
      ENDIF
      READ (CLINE(7:),*)IMX,IMY

C SALFORD DOS AND WIN32 CODE.
#endif
#if defined(_DOS_) 
      IB = KMSGET(IMX,IMY,JF)
      IF ((IB.LT.0).AND.(JF.LE.0)) THEN
C No mouse click, check for keypresses.
        CALL ZGTKY1 (KK)
        IF ((CHAR(KK).EQ.'N').OR.(CHAR(KK).EQ.'n')) THEN
C THIS ATOM IS NOT TO BE LABELLED
          CALL ZMBXCR(ILNO,IBACK,IBACK)
          RSTORE(ILNO+IATTYP+2) = 0.0
          RETURN
        ELSE IF (CHAR(KK).NE.'#') THEN
          GOTO 30
        ENDIF
      ENDIF

C LEFT BUTTON HAS BEEN PRESSED
C CONVERT THE COORDS TO ORTHOGONAL ONES
#endif
      RSTORE(ILNO+ILAB) = (IMX-XCEN-XOFF)/SCALE + XCP
      RSTORE(ILNO+ILAB+1) = (IMY-YCEN-YOFF)/SCALE + YCP
      RSTORE(ILNO+ILAB+2) = LABLN
C CHECK THAT THE LABEL POSITION IS VALID
C      IF (RSTORE(ILNO+ILAB).LT.XMIN .OR.
C     + RSTORE(ILNO+ILAB)+LABLN.GT. XMAX .OR.
C     + RSTORE(ILNO+ILAB+1).LT.YMIN .OR.
C     + RSTORE(ILNO+ILAB+1)+TENPIX.GT.YMAX) THEN
C        CALL ZBEEP
C        GOTO 30
C      ENDIF
C DRAW THE CROSS AND THE BOX
      CALL ZMBXCR (ILNO,IBACK,IBACK)
C NOW DRAW THE NEW LABEL
      IX = IMX - XCEN - XOFF
      IY = IMY - YCEN - YOFF
      CALL ZDRTEX (IX,IY,CLAB(1:IL),IDEVCL(ILABCL+1))
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
#endif
#if defined(_WXS_) 
      CALL ZMORE('^^CH SHOW',0)
      CALL ZMORE('^^CR',0)
c &&GILGID      CALL FSTSHW()
#endif
      RETURN
      END
 
 
CODE FOR ZMBXCR
      SUBROUTINE ZMBXCR (ILNO,ICOL1,ICOL2)
      
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOM.INC'
      INCLUDE 'CAMANA.INC'
      INCLUDE 'CAMDAT.INC'
      INCLUDE 'CAMCAL.INC'
      INCLUDE 'CAMMSE.INC'
      INCLUDE 'CAMMEN.INC'
      INCLUDE 'CAMCHR.INC'
      INCLUDE 'CAMGRP.INC'
      INCLUDE 'CAMCOL.INC'
      INCLUDE 'CAMFLG.INC'
      INCLUDE 'CAMSHR.INC'
      INCLUDE 'CAMVER.INC'
      INCLUDE 'CAMKEY.INC'
      INCLUDE 'CAMBTN.INC'
      INCLUDE 'CAMBLK.INC'
      INCLUDE 'XIOBUF.INC'

      INTEGER IBX(5),IBY(5),IX,IY,ICOL1,ICOL2
C THIS ROUTINE DRAWS A CROSS OVER THE ATOM IN COLOUR ICOL1
C AND A BOX AROUND THE LABEL IN COLOUR ICOL2
      TENPIX = REAL(IFONT)*2.5/SCALE
      RLX = RSTORE(ILNO+ILAB)
      RLY = RSTORE(ILNO+ILAB+1)
      RLL = MAX(RSTORE(ILNO+ILAB+2), 3.0*TENPIX)
      IX = NINT ((RSTORE(ILNO+IXYZO) - XCP)*SCALE + XCEN + XOFF)
      IY = NINT ((RSTORE(ILNO+IXYZO+1) - YCP)*SCALE + YCEN + YOFF)
      IBX(1) = IX
      IBX(2) = IX
      IBY(1) = IY - 25
      IBY(2) = IY + 25
      CALL ZPLINE(IBX,IBY,2,ICOL1)
      IBX(1) = IX - 25
      IBX(2) = IX + 25
      IBY(1) = IY
      IBY(2) = IY
      CALL ZPLINE(IBX,IBY,2,ICOL1)
      IX = NINT (( RLX - XCP) * SCALE + XCEN + XOFF)
      IY = NINT (( RLY - YCP) * SCALE + YCEN + YOFF)
      IBX(1) = IX - 2
      IBX(2) = IBX(1) + RLL*SCALE + 2
      IBX(3) = IBX(2)
      IBX(4) = IBX(1)
      IBX(5) = IBX(1)
      IBY(1) = IY - 2
      IBY(2) = IBY(1)
      IBY(3) = IBY(1) + TENPIX*SCALE + 4
      IBY(4) = IBY(3)
      IBY(5) = IBY(1)
      CALL ZPLINE(IBX,IBY,5,ICOL2)
      RETURN
      END

