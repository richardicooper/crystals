C ---- changes to this file
C 1. include \CAMWIN for rescaling pixel values
C 2. most mouse routines commented out - not required under Windows
C 3. see cljf for many other changes (mostly in lower case)

CRYSTALS CODE FOR SPECIFIC.FOR
CAMERON CODE FOR SPECIFIC
CODE FOR ZCLRA
      SUBROUTINE ZCLRA (IX1,IY1,IX2,IY2,ICOL)
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
#endif
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
#endif
      INTEGER IX1,IY1,IX2,IY2,ICOL

#if defined(_DOS_) 
      INTEGER*2 IXX1,IYY1,IXX2,IYY2,ICOL1
      ixx1 = nint(float(ix1)*scale_X)
      iyy1 = nint(float(iy1)*scale_Y)
      ixx2 = nint(float(ix2)*scale_X) - 1
      iyy2 = nint(float(iy2)*scale_Y) - 1
      ICOL1 = ICOL
      CALL CLEAR_SCREEN_AREA@(IXX1,IYY1,IXX2,IYY2,ICOL1)

C&&GIDGIL      CHARACTER*80 CHARTC
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IPTS(8)
#endif
#if defined(_WXS_) 
      INTEGER IPTS(8)

C &&GIDGIL      WRITE(CHARTC,1)'^^CH CLEAR'
C &&GIDGIL1     FORMAT (A)
C &&GIDGIL      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCLR
#endif
#if defined(_WXS_) 
              CALL FSTCLR

C &&GIDGIL      WRITE(CHARTC,2)'^^CH RGB',
C &&GIDGIL     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GIDGIL     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GIDGIL     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GIDGIL2     FORMAT (A,3(1X,I3))
C &&GIDGIL      CALL ZMORE(CHARTC,0)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GIDGIL      WRITE(CHARTC,3)'^^CH POLYF 4',IX1,IY1,IX1,IY2,
C &&GIDGIL     1  IX2,IY2,IX2,IY1
C &&GIDGIL3     FORMAT(A,8(1X,I5))
C &&GIDGIL      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      IPTS(1) = IX1
      IPTS(2) = IY1
      IPTS(3) = IX1
      IPTS(4) = IY2
      IPTS(5) = IX2
      IPTS(6) = IY2
      IPTS(7) = IX2
      IPTS(8) = IY1
      CALL FSTFPO(4,IPTS)
#endif
#if defined(_WXS_) 
      IPTS(1) = IX1
      IPTS(2) = IY1
      IPTS(3) = IX1
      IPTS(4) = IY2
      IPTS(5) = IX2
      IPTS(6) = IY2
      IPTS(7) = IX2
      IPTS(8) = IY1
      CALL FSTFPO(4,IPTS)

#endif
      RETURN
      END
 
CODE FOR ZDLINE
      SUBROUTINE ZDLINE (IX1,IY1,IX2,IY2,ICOL)
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
#endif
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
#endif
      INTEGER IX1,IY1,IX2,IY2,ICOL
#if defined(_DOS_) 
      INTEGER*2 IXX1,IYY1,IXX2,IYY2,ICOL1
      ixx1 = nint(float(ix1)*scale_X)
      iyy1 = nint(float(iy1)*scale_Y)
      ixx2 = nint(float(ix2)*scale_X) 
      iyy2 = nint(float(iy2)*scale_Y)
      ICOL1 = ICOL
      CALL DRAW_LINE@ (IXX1,IYY1,IXX2,IYY2,ICOL1)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CHARACTER*80 CHARTC
#endif
#if defined(_WXS_) 
      CHARACTER*80 CHARTC
C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)
c
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH LINE',IX1,IY1,IX2,IY2
C &&GILGID3     FORMAT(A,4(1X,I4))
C &&GILGID      CALL ZMORE(CHARTC,0)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL FSTLIN( IX1, IY1, IX2, IY2 )
#endif
#if defined(_WXS_) 
      CALL FSTLIN( IX1, IY1, IX2, IY2 )
#endif
      RETURN
      END
 
CODE FOR ZDTEXT
      SUBROUTINE ZDTEXT (TEXT,IX,IY,ICOL)
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
      INCLUDE 'CAMGRP.INC'
#endif
#if defined(_WXS_) 
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
      INCLUDE 'CAMGRP.INC'
#endif
      CHARACTER*(*) TEXT
      INTEGER ICOL
#if defined(_DOS_) 
      INTEGER*2 ICOL1,IXX,IYY
      increment=10
      if(xwin .eq. 800)  increment=15
      if(xwin .eq. 1024) increment=20
      if(xwin .gt. 1024) increment=25
      ixx = nint(float(ix)*scale_X)
      iyy = nint(float(iy)*scale_Y) + increment
      call set_text_attribute@(font,size,rotation,italic)
      if(xwin .gt. 800) call BoldFont(1)
      ICOL1 = ICOL
      CALL DRAW_TEXT@( TEXT,IXX,IYY,ICOL1)

C &&GILGID      CHARACTER*80 CHARTC
C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH TEXT',IX,IY,'''',
C &&GILGID     1 TEXT(1:LEN(TEXT)),''''
C &&GILGID3     FORMAT(A,1X,2(I4,1X),3A)
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL FSTEXT( IX, IY, TEXT(1:LEN(TEXT)), -IFONT )
#endif
#if defined(_WXS_) 
      CALL FSTEXT( IX, IY, TEXT(1:LEN(TEXT)), -IFONT )

#endif
      RETURN
      END
 
CODE FOR ZFILEL
      SUBROUTINE ZFILEL (IXC,IYC,IMAJ,IMIN,ICOL)
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
#endif
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
#endif
      INTEGER IMAJ,IMIN,ICOL
#if defined(_DOS_) 
      INTEGER*2 IMAJ1,IMIN1,ICOL1,ixc1,iyc1
      ixc1  = nint(float(ixc)*scale_X)
      iyc1  = nint(float(iyc)*scale_Y)
      imaj1 = nint(float(imaj)*scale_X)
      imin1 = nint(float(imin)*scale_Y)
      ICOL1 = ICOL
      CALL FILL_ELLIPSE@( IXC1,IYC1,IMAJ1,IMIN1,ICOL1)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CHARACTER*80 CHARTC
#endif
#if defined(_WXS_) 
      CHARACTER*80 CHARTC
C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH ELLIF',IXC,IYC,IMAJ,IMIN
C &&GILGID3     FORMAT(A,4(1X,I4))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTFEL ( IXC, IYC, IMAJ, IMIN )
#endif
#if defined(_WXS_) 
              CALL FSTFEL ( IXC, IYC, IMAJ, IMIN )
            
#endif
      RETURN
      END
 
 
CODE FOR ZPLINE
      SUBROUTINE ZPLINE (IX,IY,N,ICOL)
      INTEGER IX(N),IY(N),ICOL
      
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

#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
      INTEGER*2 ICOL1

C &&GILGID      CHARACTER*80 CHARTC
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IPTS(2000)    
#endif
#if defined(_WXS_) 
      INTEGER IPTS(2000)    

#endif
      IF (N.GT.1000) N = 1000

      ICOL1 = MIN ( ICOL, 15 )

      DO 10 I = 1 , N

#if defined(_DOS_) 
        ixx2(i) = nint(float(ix(i))*scale_X)
        iyy2(i) = nint(float(iy(i))*scale_Y)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
        IPTS(I*2 - 1) = IX(I)
        IPTS(I*2    ) = IY(I)
#endif
#if defined(_WXS_) 
        IPTS(I*2 - 1) = IX(I)
        IPTS(I*2    ) = IY(I)

#endif
10    CONTINUE

#if defined(_DOS_) 
      ICOL1 = ICOL
      CALL POLYLINE@(IXX2,IYY2,N,ICOL1)

C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL1+1)),
     1                      NINT(4.05*IVGACL(2,ICOL1+1)),
     1                      NINT(4.05*IVGACL(3,ICOL1+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL1+1)),
     1                      NINT(4.05*IVGACL(2,ICOL1+1)),
     1                      NINT(4.05*IVGACL(3,ICOL1+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH FPOLYE',N,ID
C &&GILGID3     FORMAT(A,2(1X,I6))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTEPO ( N, IPTS )
#endif
#if defined(_WXS_) 
              CALL FSTEPO ( N, IPTS )

#endif
      RETURN
      END
 
CODE FOR ZVGAEL
      SUBROUTINE ZVGAEL (IXC,IYC,IMAJ,IMIN,ICOL)
      INTEGER IMAJ,IMIN,ICOL
#if defined(_DOS_) 
      INTEGER*2 IMAJ1,IMIN1,ICOL1,ixc1,iyc1
      INCLUDE 'CAMWIN.INC'
#endif
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMCOL.INC'
#endif
#if defined(_DOS_) 
      ixc1  = nint(float(ixc)*scale_X)
      iyc1  = nint(float(iyc)*scale_Y)
      imaj1 = nint(float(imaj)*scale_X)
      imin1 = nint(float(imin)*scale_X)
      ICOL1 = ICOL
      CALL ELLIPSE@( IXC1,IYC1,IMAJ1,IMIN1,ICOL1)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
C      CHARACTER*80 CHARTC
#endif
#if defined(_WXS_) 
C      CHARACTER*80 CHARTC
C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH ELLIE',IXC,IYC,IMAJ,IMIN
C &&GILGID3     FORMAT(A,4(1X,I4))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTEEL ( IXC, IYC, IMAJ, IMIN )
#endif
#if defined(_WXS_)
              CALL FSTEEL ( IXC, IYC, IMAJ, IMIN )
#endif

      RETURN
      END
 
 
 
CODE FOR ZBEEP
      SUBROUTINE ZBEEP
#if defined(_DOS_) 
      CALL BEEP@
#endif
      RETURN
      END
 
 
 
CODE FOR ZCOLCH
      SUBROUTINE ZCOLCH (IREG,IR,IG,IB)
      INTEGER IREG,IR,IG,IB
#if defined(_DOS_) 
      INTEGER*2 IRREG,IRR,IGG,IBB
      IRREG = IREG
      IRR = IR
      IGG = IG
      IBB = IB
      CALL SET_VIDEO_DAC@(IRREG,IRR,IGG,IBB)
      CALL SET_PALETTE@(IRREG,IRREG)
#endif
      RETURN
      END
 
CODE FOR ZUPCAS
      SUBROUTINE ZUPCAS (CTEXT)
      CHARACTER*(*) CTEXT
      CHARACTER*160 CTEXT1
      NALEN = MIN(LEN(CTEXT),160)
      CALL XCCUPC(CTEXT(1:NALEN),CTEXT1(1:NALEN))
      CTEXT=CTEXT1(1:NALEN)
      RETURN
      END
 
 
CODE FOR ZISSUE
      SUBROUTINE ZISSUE (CTEXT,IFAIL)
      CHARACTER*(*) CTEXT
      INTEGER*2 IFF
cdjw call CRYSTALS detach subroutine
CVAX      INCLUDE '($LIBDEF)'
CVAX      I = LIB$SPAWN (CTEXT)
CDOS      CALL CISSUE(CTEXT,IFF)
      call xdetch(ctext)
      iff = 0
      IFAIL = IFF
      RETURN
      END
 
 
CODE FOR ZGTKEY
      SUBROUTINE ZGTKEY (KK)
      INTEGER KK
#if defined(_DOS_) 
      INTEGER*2 KKK,get_wkey@
      kkk=0
      kkk=get_wkey@()
      KK = KKK
#else
      CALL ZMORE('Error: ZGTKEY called',0)
#endif
      RETURN
      END
 
 
CODE FOR ZPRNT
      SUBROUTINE ZPRNT (CTEXT)
C THIS PRINTS OUT ON THE SCREEN WITHOUT PUTTING A RETURN AT THE END
      
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

      CHARACTER*(*) CTEXT
CVAX      WRITE (IGOUT,'(A,$)') CTEXT
#if defined(_DOS_) 
      CALL COUA@(CTEXT)
#endif
      RETURN
      END
 
 
CODE FOR ZINCH
      SUBROUTINE ZINCH (CL)
      INCLUDE 'CAMPAR.INC'
      INCLUDE 'CAMBLK.INC'
      CHARACTER*(ICLEN) CL
      CL = CHRBUF(1:ICLEN)
      RETURN
      END
 
 
CODE FOR LFILES
      LOGICAL FUNCTION LFILES (ITYPIN,FILEN,ID)
C THIS ROUTINE HANDLES THE FILE OPEN/CLOSE STATEMENTS
C VARIABLES :
C ITYPIN =  0 Close file
C          1+ these specify the different types of file opening
C NOTE THAT THE EXISTENCE OF THE FILE AND ITS FORMAT SHOULD
C ALREADY HAVE BEEN CHECKED BEFORE CALLING THIS ROUTINE.
C ID         This is the unit number of the device
C NEGATIVE NUMBERS ARE RELATED TO THE ENVIRONMENT VARIABLE
CNOV98 CRCAMER.
C CRYSDIR.
      
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

      CHARACTER*(*) FILEN
      CHARACTER*80 FILENM
      LOGICAL LOPEN
      LFILES = .TRUE.
      ITYPE = ITYPIN
      FILENM = FILEN
C FILE OPEN
      IF (ITYPE.LT.0) THEN
        CALL ZFPATH (FILENM)
        ITYPE = -ITYPE
      ENDIF
10    CONTINUE
      IF (ITYPE.EQ.1) THEN
C WE NEED TO CHECK WHETHER THE FILE EXISTS ALREADY
        OPEN (UNIT=ID,FILE=FILENM,
#if !defined(_DOS_) 
     1         STATUS = 'OLD' ,
#else
     1         STATUS ='READONLY' ,
#endif
#if defined(_VAX_) 
     1         SHARED ,
     1         READONLY ,
#endif
#if defined(_PPC_) 
     1         READONLY ,
#endif
#if defined(_DVF_) || defined(_GID_) 
     1         READONLY ,
#endif
     1 ERR=999)
      ELSE IF (ITYPE.EQ.2) THEN
        OPEN (UNIT=ID,FILE=FILENM,STATUS='UNKNOWN',
     + ERR=999)
        REWIND ID
      ELSE IF (ITYPE.EQ.3) THEN
        OPEN (UNIT=ID,FILE=FILENM,STATUS='UNKNOWN',FORM='UNFORMATTED'
     + ,ERR=999)
      ELSE IF (ITYPE.EQ.4) THEN
        OPEN (UNIT=ID,FILE=FILENM,STATUS='OLD',FORM='UNFORMATTED',
     +  ERR=999)
      ELSE IF (ITYPE.EQ.5) THEN
       OPEN (UNIT=ID, FILE=FILENM, STATUS='NEW')
CVAX      OPEN (UNIT=ID, FILE=FILENM, STATUS='NEW',
CVAX     + CARRIAGECONTROL='LIST')
      ELSE IF (ITYPE.EQ.6) THEN
        OPEN (UNIT=ID,FILE=FILENM,STATUS='OLD',FORM='FORMATTED',
     c ACCESS='DIRECT',RECL=80,ERR=999)
      ELSE IF (ITYPE.EQ.7) THEN
        OPEN (UNIT=ID,FILE=FILENM,STATUS='NEW',FORM='FORMATTED',
     c ACCESS='DIRECT',RECL=80)
      ELSE IF (ITYPE.EQ.8) THEN
        OPEN (UNIT=ID,STATUS='SCRATCH',ACCESS='DIRECT',
     + FORM='UNFORMATTED',RECL=160,ERR=999)
      ELSE IF (ITYPE.EQ.9) THEN
        OPEN (UNIT=ID, STATUS='SCRATCH', ACCESS='SEQUENTIAL',
     + FORM='FORMATTED',ERR=999)
      ELSE IF (ITYPE.EQ.0) THEN
        CLOSE(ID)
      ENDIF
      RETURN
999   CONTINUE
C ERROR - IS THE FILE ALREADY OPEN?
      INQUIRE (UNIT=ID,OPENED=LOPEN)
      IF (LOPEN) THEN
        CLOSE(ID)
        GOTO 10
      ENDIF
      CALL ZMORE ('Error opening file '// FILENM, 0)
      CALL ZMORE1 ('Error opening file '// FILENM, 0)
      LFILES = .FALSE.
      END
 
 
CODE FOR ZFPATH
      SUBROUTINE ZFPATH (CFNAME)
      CHARACTER*(*) CFNAME
      CHARACTER*80 CNPATH
      INTEGER LENNAM
C THIS ROUTINE CALLS THE CRYSTALS ROUTINE FOR FILENAME DETERMINATION
C WHICH IS IN DUPLICAT.FOR
CNOV98      CNPATH = 'CRCAMER:'//CFNAME
      CNPATH = 'CRYSDIR:'//CFNAME
      CALL MTRNLG (CNPATH,'OLD',LENNAM)
      CFNAME = CNPATH
      RETURN
      END
 
CODE FOR ZPOLGN
      SUBROUTINE ZPOLGN ( IX,IY,N,ICOL)
      INTEGER IX(N),IY(N),ICOL
      
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

#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
      INTEGER*2 ICOL2,HANDLE,ERROR

C &&GILGID      CHARACTER*80 CHARTC
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IPTS(2000)    
#endif
#if defined(_WXS_) 
      INTEGER IPTS(2000)    

#endif
#if defined(_DOS_) 

      ICOL2 = ICOL

C&GIL      WRITE(6,*) 'ZPOLGN, N: ', N
C&GIL      WRITE(6,*) 'ZPOLGN2, N: ', N

#endif
      DO 10 I = 1 , N
#if defined(_DOS_) 
        ixx2(i) = nint(float(ix(i))*scale_X)
        iyy2(i) = nint(float(iy(i))*scale_Y)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
        IPTS(I*2 - 1) = IX(I)
        IPTS(I*2    ) = IY(I)
#endif
#if defined(_WXS_) 
        IPTS(I*2 - 1) = IX(I)
        IPTS(I*2    ) = IY(I)
#endif
10    CONTINUE

c&GIL      WRITE(6,*) 'ZPOLGN3, N: ', N


#if defined(_DOS_) 
      CALL CREATE_POLYGON@(IXX2,IYY2,N,HANDLE,ERROR)
      CALL FILL_POLYGON@(HANDLE,ICOL2,ERROR)
      CALL DELETE_POLYGON_DEFINITION@(HANDLE,ERROR)

C &&GILGID      WRITE(CHARTC,2)'^^CH RGB',
C &&GILGID     1 NINT(4.05*IVGACL(1,ICOL+1)),
C &&GILGID     2 NINT(4.05*IVGACL(2,ICOL+1)),
C &&GILGID     3 NINT(4.05*IVGACL(3,ICOL+1))
C &&GILGID2     FORMAT (A,3(1X,I3))
C &&GILGID      CALL ZMORE(CHARTC,0)

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )
#endif
#if defined(_WXS_) 
              CALL FSTCOL ( NINT(4.05*IVGACL(1,ICOL+1)),
     1                      NINT(4.05*IVGACL(2,ICOL+1)),
     1                      NINT(4.05*IVGACL(3,ICOL+1)) )

C &&GILGID      WRITE(CHARTC,3)'^^CH FPOLYF',N,ID
C &&GILGID3     FORMAT(A,2(1X,I6))
C &&GILGID      CALL ZMORE(CHARTC,0)

c&GIL      WRITE(6,*) 'ZPOLGN4, N: ', N

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
              CALL FSTFPO ( N, IPTS )
#endif
#if defined(_WXS_) 
              CALL FSTFPO ( N, IPTS )

#endif
      RETURN
      END



CODE FOR ZGTARA
C THIS SUBROUTINE GETS THE POLYGONAL AREA FOR THE INCLUDE/EXCLUDE
C COMMANDS
      SUBROUTINE ZGTARA (IX,IY,N,IPPOS)
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
      INTEGER IX(N),IY(N)
      INTEGER*4 IXX,IYY,IXPOS,IYPOS,IXOLD,IYOLD,IXINIT,IYINIT
      INTEGER*4 IB
      LOGICAL LCROSS
      INTEGER IPPOS
      IPPOS = -1

      icol = 14
      call SetGraphicsCursor(2)
      call graphics_write_mode@(3)

C NOW BEGIN TO LOOP
      IXOLD = -1
      IYOLD = -1
      IXINIT = -1
      IYINIT = -1
      LCROSS = .TRUE.
      IPPOS = 0
30    CONTINUE

C cljf
C Check for keypresses
      call zgtky1(kk)

C Check for mouse action
      IB = KMSGET(JX,JY,JF)
      JX = JX * SCALE_X
      JY = JY * SCALE_Y
C Case: Right mouse-click or return key pressed.
      IF (((IB.EQ.0).and.(JF.LT.0)).or. KK.EQ.13) then
C     Delete the polygon
        IF (IXOLD.NE.-1) THEN
          CALL DRAW_LINE@(IXOLD,IYOLD,IXPOS,IYPOS,ICOL)
        ENDIF
        IF (IPPOS.GT.1) THEN
          DO 80 I = IPPOS-1, 1, -1
            IXOLD = IX(I)
            IYOLD = IY(I)
            IXPOS = IX(I+1)
            IYPOS = IY(I+1)
            CALL DRAW_LINE@(IXOLD,IYOLD,IXPOS,IYPOS,ICOL)
80        CONTINUE
        ENDIF
        IPPOS = 0
        call SetGraphicsCursor(1)
        call graphics_write_mode@(1)
        call zmore1(' ',0)
        return
      ENDIF

C Case: Left mouse-click.
      IF ((IB.EQ.0).AND.(JF.GT.0)) THEN
        IXPOS = JX
        IYPOS = JY
C     Store current pivot point in IXOLD,IYOLD
        IXOLD = IXPOS
        IYOLD = IYPOS
C     Case: Initial point.
        IF (IXINIT.EQ.-1) THEN
          IXINIT = IXPOS
          IYINIT = IYPOS
        ENDIF
C     Add point to list
        IPPOS = IPPOS + 1
        IX(IPPOS) = IXPOS
        IY(IPPOS) = IYPOS
C     Check for click on initial point
        IF (.NOT.LCROSS) THEN
C     Set the first and last points equal
          IX(IPPOS) = IX(1)
          IY(IPPOS) = IY(1)
          call SetGraphicsCursor(1)
C     Scale the values (window version)
          do i=1,ippos
             ix(i)=nint(float(ix(i))/scale_X)
             iy(i)=nint(float(iy(i))/scale_Y)
          enddo
          call zmore1(' ',0)
          call graphics_write_mode@(1)
          RETURN
        ENDIF

C     Case: No mouse click, initial point set already.
      ELSE IF (IXOLD.NE.-1) THEN
        IXX = JX
        IYY = JY
C        The mouse has moved
        IF (ABS(IXX-IXPOS).NE.0 .OR. ABS(IYY-IYPOS).NE.0) THEN
          CALL DRAW_LINE@(IXOLD,IYOLD,IXPOS,IYPOS,ICOL)
C          Update the mouse position variables
          IXPOS = IXX
          IYPOS = IYY
          CALL DRAW_LINE@(IXOLD,IYOLD,IXPOS,IYPOS,ICOL)
        ENDIF
C DO WE NEED TO CHANGE THE CURSOR ?
        IF (ABS(IXX-IXINIT).LT.4.AND.ABS(IYY-IYINIT).LT.4) THEN
          IF (LCROSS) THEN
            call SetGraphicsCursor(3)
            LCROSS = .FALSE.
          ENDIF
        ELSE IF (.NOT.LCROSS) THEN
            call SetGraphicsCursor(2)
            LCROSS = .TRUE.
        ENDIF
      ENDIF
      GOTO 30

#endif
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      INTEGER IX(N),IY(N)
      INTEGER IXPOS,IYPOS
      INTEGER IPPOS
      CHARACTER CLINE*80
      IUNIT = 5
      IPPOS = 0
      CALL ZMORE('^^CO SET _CAMERONVIEW GETAREA=YES',0)
100   CONTINUE   ! NOW BEGIN TO LOOP
      ISTAT = KRDLIN ( IUNIT, CLINE, LENUSE )
      IF (CLINE(1:6).NE.'LCLICK') THEN
        IF (CLINE(1:6).EQ.'CLOSED') THEN  !Closed the polygon.
          IPPOS = IPPOS + 1
          IX(IPPOS) = IX(1)
          IY(IPPOS) = IY(1)
          RETURN
        ELSE               !Cancelled the polygon.
          CALL ZMORE('^^CO SET _CAMERONVIEW GETAREA=NO',0)
          IPPOS = 0
          RETURN
        ENDIF
      ELSE                   !Get some coordinates.
            READ (CLINE(7:),*)IXPOS, IYPOS
            IPPOS = IPPOS + 1
            IX(IPPOS) = IXPOS
            IY(IPPOS) = IYPOS
      ENDIF
      GOTO 100
#endif

      END

#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      SUBROUTINE FSTLIN(IX1, IY1, IX2, IY2)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTLINE (JX1, JY1, JX2, JY2)
          !DEC$ ATTRIBUTES C :: fastline
          !DEC$ ATTRIBUTES VALUE :: JX1
          !DEC$ ATTRIBUTES VALUE :: JY1
          !DEC$ ATTRIBUTES VALUE :: JX2
          !DEC$ ATTRIBUTES VALUE :: JY2
          INTEGER JX1, JY1, JX2, JY2
          END SUBROUTINE FASTLINE
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IX1, IX2, IY1, IY2
#endif
#if defined(_WXS_) 
      INTEGER IX1, IX2, IY1, IY2
#endif
#if defined(_GNUF77_) 
      CALL FASTLINE(%VAL(IX1), %VAL(IY1), %VAL(IX2), %VAL(IY2))
#endif
#if defined(_DIGITALF77_) 
      CALL FASTLINE(IX1, IY1, IX2, IY2)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_WXS_) 
      RETURN
      END

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTFEL(IX, IY, IW, IH)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTFEL(IX, IY, IW, IH)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTFELLI (JX, JY, JW, JH)
          !DEC$ ATTRIBUTES C :: fastfelli
          !DEC$ ATTRIBUTES VALUE :: JX
          !DEC$ ATTRIBUTES VALUE :: JY
          !DEC$ ATTRIBUTES VALUE :: JW
          !DEC$ ATTRIBUTES VALUE :: JH
          INTEGER JX, JY, JW, JH
          END SUBROUTINE FASTFELLI
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IX, IY, IW, IH
#endif
#if defined(_WXS_) 
      INTEGER IX, IY, IW, IH
#endif
#if defined(_GIL_)  || defined(_MAC_)
      CALL FASTFELLI(%VAL(IX), %VAL(IY), %VAL(IW), %VAL(IH))
#endif
#if defined(_GNUF77_) 
      CALL FASTFELLI(%VAL(IX), %VAL(IY), %VAL(IW), %VAL(IH))
#endif
#if defined(_DIGITALF77_) 
      CALL FASTFELLI(IX, IY, IW, IH)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_WXS_) 
      RETURN
      END

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTEEL(IX, IY, IW, IH)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTEEL(IX, IY, IW, IH)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTEELLI (JX, JY, JW, JH)
          !DEC$ ATTRIBUTES C :: fasteelli
          !DEC$ ATTRIBUTES VALUE :: JX
          !DEC$ ATTRIBUTES VALUE :: JY
          !DEC$ ATTRIBUTES VALUE :: JW
          !DEC$ ATTRIBUTES VALUE :: JH
          INTEGER JX, JY, JW, JH
          END SUBROUTINE FASTEELLI
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IX, IY, IW, IH
#endif
#if defined(_WXS_) 
      INTEGER IX, IY, IW, IH
#endif
#if defined(_DIGITALF77_) 
      CALL FASTEELLI(IX, IY, IW, IH)
#endif
#if defined(_GNUF77_) 
      CALL FASTEELLI(%VAL(IX), %VAL(IY), %VAL(IW), %VAL(IH))
#endif
      RETURN
      END

#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTFPO(NV, IPTS)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTFPO(NV, IPTS)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTFPOLY (NV, IPTS)
          !DEC$ ATTRIBUTES C :: fastfpoly
          !DEC$ ATTRIBUTES VALUE :: NV
          !DEC$ ATTRIBUTES REFERENCE :: IPTS
          INTEGER NV, IPTS(2000)
          END SUBROUTINE FASTFPOLY
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER NV, IPTS(2000)
#endif
#if defined(_WXS_) 
      INTEGER NV, IPTS(2000)
#endif
#if defined(_DIGITALF77_) 
      CALL FASTFPOLY(NV, IPTS)
#endif
#if defined(_GIL_)  || defined(_MAC_)
      CALL FASTFPOLY(%VAL(NV), IPTS)
#endif
#if defined(_DIGITALF77_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_GNUF77_) 
      CALL FASTFPOLY(%VAL(NV), IPTS)
      RETURN
      END
#endif

#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTEPO(NV, IPTS)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTEPO(NV, IPTS)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTEPOLY (NV, IPTS)
          !DEC$ ATTRIBUTES C :: fastepoly
          !DEC$ ATTRIBUTES VALUE :: NV
          !DEC$ ATTRIBUTES REFERENCE :: IPTS
          INTEGER NV, IPTS(2000)
          END SUBROUTINE FASTEPOLY
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER NV, IPTS(2000)
#endif
#if defined(_WXS_) 
      INTEGER NV, IPTS(2000)
#endif
#if defined(_GIL_)  || defined(_MAC_)
      CALL FASTEPOLY(%VAL(NV), IPTS)
#endif
#if defined(_GNUF77_) 
      CALL FASTEPOLY(%VAL(NV), IPTS)
#endif
#if defined(_DIGITALF77_) 
      CALL FASTEPOLY(NV, IPTS)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_WXS_) 
      RETURN
      END

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTEXT(IX, IY, CTEXT, IFSIZE)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTEXT(IX, IY, CTEXT, IFSIZE)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTTEXT (JX, JY, CALINE, JFS)
          !DEC$ ATTRIBUTES C :: fasttext
          !DEC$ ATTRIBUTES VALUE :: JX
          !DEC$ ATTRIBUTES VALUE :: JY
          !DEC$ ATTRIBUTES VALUE :: JFS
          !DEC$ ATTRIBUTES REFERENCE :: CALINE
          INTEGER JX,JY, JFS
          CHARACTER CALINE
          END SUBROUTINE FASTTEXT
      END INTERFACE
#endif
#if defined(_DIGITALF77_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IX, IY, IFSIZE
      CHARACTER*(*) CTEXT
      CHARACTER*80  NTEXT
      NTEXT = CTEXT
#endif
#if defined(_GIL_)  || defined(_MAC_)
      CALL FASTTEXT(%VAL(IX), %VAL(IY), NTEXT, %VAL(IFSIZE))    
#endif
#if defined(_GNUF77_) 
      INTEGER IX, IY, IFSIZE
      CHARACTER*(*) CTEXT
      CHARACTER*80  NTEXT
      NTEXT = CTEXT
      CALL FASTTEXT(%VAL(IX), %VAL(IY), NTEXT, %VAL(IFSIZE))    
#endif
#if defined(_DIGITALF77_) 
      CALL FASTTEXT(IX, IY, NTEXT, IFSIZE )
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_WXS_) 
      RETURN
      END

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTCOL(IR, IG, IB)
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTCOL(IR, IG, IB)
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTCOLOUR ( JR, JG, JB )
          !DEC$ ATTRIBUTES C :: fastcolour
          !DEC$ ATTRIBUTES VALUE :: JR
          !DEC$ ATTRIBUTES VALUE :: JG
          !DEC$ ATTRIBUTES VALUE :: JB
          INTEGER JR, JG, JB
          END SUBROUTINE FASTCOLOUR
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      INTEGER IR, IG, IB
#endif
#if defined(_WXS_) 
      INTEGER IR, IG, IB
#endif
#if defined(_GIL_)  || defined(_MAC_)
      CALL FASTCOLOUR(%VAL(IR), %VAL(IG), %VAL(IB))
#endif
#if defined(_GNUF77_) 
      CALL FASTCOLOUR(%VAL(IR), %VAL(IG), %VAL(IB))
#endif
#if defined(_DIGITALF77_) 
      CALL FASTCOLOUR(IR, IG, IB)
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      RETURN
      END
#endif
#if defined(_WXS_) 
      RETURN
      END

#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      SUBROUTINE FSTCLR()
#endif
#if defined(_WXS_) 
      SUBROUTINE FSTCLR()
#endif
#if defined(_DIGITALF77_) 
      INTERFACE
          SUBROUTINE FASTCLEAR ()
          !DEC$ ATTRIBUTES C :: fastclear
          END SUBROUTINE FASTCLEAR
      END INTERFACE
#endif
#if defined(_GID_) || defined(_GIL_)  || defined(_MAC_)
      CALL FASTCLEAR()
      RETURN
      END
#endif
#if defined(_WXS_) 
      CALL FASTCLEAR()
      RETURN
      END

c&&GILGID      SUBROUTINE FSTSHW()
c&WXS      SUBROUTINE FSTSHW()
c&GID      INTERFACE
c&GID          SUBROUTINE FASTSHOW ()
cC Suits you.
c&GID          !DEC$ ATTRIBUTES C :: fastshow
c&GID          END SUBROUTINE FASTSHOW
c&GID      END INTERFACE
c&&GILGID      CALL FASTSHOW()
c&&GILGID      RETURN
c&&GILGID      END
c&WXS      CALL FASTSHOW()
c&WXS      RETURN
c&WXS      END


#endif
      SUBROUTINE ZMORE1(text,iarg)
C ---- updates text message in status bar - iarg is not used but kept
C      for compatibility with CAMERON function ZMORE
#if defined(_DOS_) 
      INCLUDE 'CAMWIN.INC'
#endif
      character*(*) text
C&&GILWXS      character*70 text
      CHARACTER*80 ntext
      
      NTEXT = TEXT
c      WRITE(99,'(2A)')'zmore1:  ',text
c      WRITE(99,'(2A)')'zmore1n: ',ntext

C DOS VERSION NO LONGER HAS STATUS LINE. (SPACE SAVER)
C&DOS      Status$Text=text
C&DOS      call window_update@(Status$Text)
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_)
      CALL XCTRIM(NTEXT,ITL)
      IF ( ITL .LE. 2 ) RETURN
      ITL = MIN ( ITL, 70 )
      CALL ZMORE('^^WI SET PROGOUTPUT TEXT=',0)
      CALL ZMORE('^^WI '''//NTEXT(1:ITL)//'''',0)
      CALL ZMORE('^^CR',0)
#endif
      end

CODE FOR ZGTKY1
      SUBROUTINE ZGTKY1 (KK)
      INTEGER KK
      
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

#if defined(_DOS_) 
      integer*2 kkk,get_wkey1@
      kkk=0
      kkk = get_wkey1@()
      KK = KKK
CDJWNOV98
      IF (KK .EQ. ICRET) CALL ZMORE1(' ',0)
#else
      KK = 0
#endif
#if !defined(_DOS_) 
      CALL ZMORE('Error ZGTKY1 called',0)
#endif
      END
 

