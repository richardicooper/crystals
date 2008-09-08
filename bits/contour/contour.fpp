CRYSTALS CODE FOR MAPPER
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.2  1999/11/02 17:29:59  ckp2
C RIC: Removed carriage returns
C
      PROGRAM FOUMAP
#include "CONCOM.INC"
      EXTERNAL ASHLEY

      CALL SETSCR
      CALL NORMAL
      CALL READER
      CALL SPLIT
      CALL SORTER 
      CALL PLOTMA
      call KILWIN
      STOP
      END
CRYSTALS CODE FOR CONTOR
      SUBROUTINE CONTOR( E, NPH, NPV, NMP, D, NC, IE, JCHAIN, IT, JBUF,
     +                   XL, YL, AGLINE, ZMINLV, ZSCFTR, ZDEPTH, ICOL )
C
C -- THIS ROUTINE CONTOURS A SET OF POINTS AT ONE OR MORE CONTOUR
C    LEVELS.
C
C -- Contouring package, generalised from
C    CODE DUE TO G.M. SHELDRICK. SEPT 1981.
C
C -- See also HEAP & PINK, NPL DNAM REPORT 81, DECEMBER (1969).
C    and DAYHOFF, COMM ASS COMPT MACH, 6,620-622, (1963)
C
C -- INTERFACED TO DGO BY EKD
C
C
C -- ARGUMENTS:-
C      E           DATA POINTS DIMENSIONS NPH*NPV
C      NPH         NUMBER OF HORIZONTAL POINTS
C      NPV         NUMBER OF VERTICAL POINTS
C      NMP         NPH*NPV
C      D           CONTOUR HEIGHTS DIMENSION NC
C      NC          NUMBER OF CONTOURS (COPIED TO NCONT)
C      IE          WORKSPACE DIMENSION LCHAIN
C      LCHAIN      SUGGEST MINIMUM OF 4*NPH*NPV
C      IT          WORKSPACE DIMENSION JBUF
C      JBUF        SUGGEST MINIMUM OF 2*(NPV+NP)
C      XL          LENGTH OF X AXIS
C      YL          LENGHT OF Y AXIS
C      AGLINE      CALCULATED LINE (CONTOUR) LENGTH
C      ZMINLV      BASE VALUE FOR Z LOCATION OF CONTOUR 
C      ZSCFTR      SCALE FACTOR FOR SHIFTING CONTOUR IN Z PLANE
C      ZDEPTH      WHERE IN Z TO START DRAWING CONTOURS FROM
C
C      ICOL        ADDED BY ASHLEY 27-1-93 FOR COLOUR SCHEME
C
C -- MODIFIED:-
C      29-APR-1986       JRC   1. ADD INITIAL BIAS FOR ZERO, AS WELL
C                                 AS OTHER VALUES OF 'D'
C                              2. PREVENT DIVISION BY ZERO IF TWO
C                                 ADJACENT POINTS ARE ZERO, AND THUS
C                                 APPEAR TO INVOLVE A CHANGE OF SIGN
C                                 WHICH IS AN ILLUSION.
C
C       2-MAY-1986       JRC   FIX A PROBLEM WITH NEGATIVE VALUES
C
C      31-MAR-1986       EKD   FIX SMOOTHING PROBLEMS NOT CONSIDERING
C                              THAT E() IS UNNORMALISED
C
C      31-JUL-1986       PWB   ( PSR #366 ) FIX PROBLEM CAUSING FLOATING
C                              OVERFLOW WHEN DATA SUPPLIED CONTAINS VERY
C                              LARGE VALUES, ESPECIALLY THOSE GENERATED
C                              BY 'GRID'
C
C      22-SEP-1987       NWM   USE SLIGHTLY DIFFERENT SMOOTHING
C
C      30-OCT-1989       PGWY  ADD 'ZMINLV' AND 'ZSCFTR'. THESE VALUES 
C                              WERE BEING PASSED IN USING 'TRAMAT' AS A 
C                              FUDGE, HOWEVER FOR 3D STUDY PLOTS, 
C                              REQUIRE 'TRAMAT' TO ROTATE THE CONTOUR 
C                              PLOTS.
C
C      29-JAN-1990       PGWY  ADD 'ZDEPTH'.. POSITION IN Z TO START 
C                              DRAWING CONTOURS FROM.
C
C       5-Oct-1990       PWB   Change TYPE statement to WRITE.
C
C       28-NOV-1990      EKD   MAP IT WORK WITH NON-CUBIC GRID
C
C      16-Aug-1991       PWB   Tidy for PC version
C
C      14-OCT-1991       EKD   Make second argument to PENSEL 0.
C
C
C     TAKEN OUT BY ASHLEY 26-1-93
C      #include '(DGOCO1)'
C      #include '(DGOCO3)'
C
C ADDED BY ASHLEY 26-1-93
      INTEGER*4 XL, YL, ICOL(16)
C TYPE DECLARATIONS MADE 1-2-93 BY ASHLEY
C TO TRY AND FIX BUG
      INTEGER*4 IB, JBUF, IT, IE, NC, NMP, NPV, NPH, JCHAIN,
     +          ICOLNM, IDGODB, ITRAM, ITPSAV, IDEV, I, NMAX,
     +          NTOT, NCHK, NCONT, J, LCHAIN, M, NPOINT,MA, NA,
     +          N, JY, J1X, J2X, J1Y, J2Y, L, K, NI, NX, NY, NT
      REAL W, X, Y, ZDEPTH, ZSCFTR, ZMINLV, AGLINE, D, E,
     +     BOBIAS, PMAXVL, UNIT, EMIN, EMAX, ERMAX, ERANGE,
     +     XSCFTR, YSCFTR, AXMAX, VRT, HRZ, ALIMIT, XLIML,
     +     YLIML, XLIMH, YLIMH, WMAX, RX, RY, CXFTR, CYFTR,
     +     P, Q, WGRAD, Z, ZOLD, U, V, T, YPT, XPT, ZPT, XPTOLD,
     +     YPTOLD, XPTASH, YPTASH
C
      DIMENSION E(NMP),IE(JCHAIN),D(NC),IT(JBUF)
      DIMENSION IB(4),W(20),X(20)
      DIMENSION Y(20)
C
      LOGICAL L6XXX
C
      DATA BOBIAS / 0.00001 /
      DATA PMAXVL / 1.0E+17 /
C
C ADDED BY ASHLEY 26-1-93 INITIALISE UNDEC. VARIABLES
      ICOLNM = 16-NC
      IDGODB = 150
      ITRAM = 6
      ITPSAV = 3
      IDEV = 10
      UNIT = 480.0
C -- Initialise line length calculator
C
      AGLINE = 0.0
C
C -- S6xxx does not want to wait till next draw if ITPSAV.gt.20
C
      L6XXX = ( ( ITPSAV .GT. 20 ) .AND. ( IDEV .NE. 10 ) .AND.
     +          ( IDEV .NE. 11 ) )
C
C -- Find min and max E for normalisation
C
      EMIN =  9.9E+35
      EMAX = -9.9E+35
C
      DO 1 I = 1, NMP
        EMIN = MIN( E(I), EMIN )
        EMAX = MAX( E(I), EMAX )
1     CONTINUE
C
      ERMAX = MAX( ABS( EMAX ), ABS( EMIN ), ABS( EMAX - EMIN ) )
C
      IF( ERMAX .LT. 1.0 ) THEN
        ERANGE = 1.0
      ELSE
        ERANGE = 1.0 / ERMAX
      ENDIF
C
C -- A Bodge to reduce the probability of too many map heights
C    falling exactly at the requested contour height.
C
      DO 2 I = 1, NC
        IF( ABS( D( I ) ) .LT. BOBIAS ) THEN
          D(I) = -BOBIAS
        ELSE
          D(I) = -BOBIAS * D(I) + D(I)
        ENDIF
2     CONTINUE
C
C -- Beware of some confusion over X and Y references to
C    horizontal an vertical
C
C -- Scale x and y axis to 250.
C
      XSCFTR = XL / 250.
      YSCFTR = YL / 250.
C
C -- Maximum axis
C
      AXMAX = AMAX1( 250., 250. )
      NMAX = MAX ( NPV, NPH )
      VRT = FLOAT( NMAX ) * 250. / ( FLOAT( NPV ) * AXMAX )
      HRZ = FLOAT( NMAX ) * 250. / ( FLOAT( NPH ) * AXMAX )
C      VRT = 1.0 
C      HRZ = 1.0 
      ALIMIT = 0.
      IF( L6XXX ) ALIMIT = UNIT
      XLIML = ALIMIT
      YLIML = ALIMIT
      XLIMH = 250. - ALIMIT
      YLIMH = 250. - ALIMIT
C
C -- Number of last box
C
      NTOT = ( NPH ) * ( NPV - 1 )
C
C -- Number first box in top row
C
      NCHK = NTOT - NPH
C
C -- For ITPSAV > 20 set up gradient check
C
      NCONT = NC
      WMAX = 1.0E+35
      IF( .NOT. L6XXX ) GOTO 5
      NCONT = 1
      WMAX = D(2)
C
C -- Initialise workspace .. EKD safeguard
C
5     CONTINUE
      DO 10 J = 1, JCHAIN
        IE(J) = 0
10    CONTINUE
C
      DO 12 J = 1, JBUF
        IT(J) = 0
12    CONTINUE
C
C -- Chain length. Space available is JCHAIN
C
      LCHAIN = JCHAIN - 6
C
C -- Weight matrices for x & y directions
C    points count clockwise round 3x3 square
C    point 9 is equivalent to point 1, point 10 is at centre.
C
      X(10) = 0.
      DO 22 I = 1, 10
        Y(I) = 0.
22    CONTINUE
C
      DO 14 I = 3, 5
        Y(I) = 100.
        Y(I+4) = -100.
14    CONTINUE
      Y(1) = -100.
C
      DO 15 I = 1, 9
        X(I) = Y(10-I)
15    CONTINUE
C
C -- Compute bounds and scales
C
      IT(2) = 2
      IT(1) = 5
      DO 34 I = 3, 12
        W(I) = 0.
34    CONTINUE
C
      DO 35 I = 6, 9
        W(I) = 200.
35    CONTINUE
C
      DO 36 I = 3, 11, 2
        IT(I) = NPV * INT( VRT * W(I) )
        IT(I+1) = NPH * INT( HRZ * W(I+1) )
36    CONTINUE
C
      IB(1) = IT(3) + 2
      IB(2) = IT(7) - 2
      IB(3) = IT(10) + 2
      IB(4) = IT(6) - 2
C
C -- Further scaling responsibility of calling program
C
      RY = FLOAT( NPV - 1 ) * VRT * 200.0
      RX = FLOAT( NPH - 1 ) * HRZ * 200.0
      CXFTR = AXMAX / RX
      CYFTR = AXMAX / RY 
C
C -- Interpolate on grid to get triangular mesh.
C
C -- Each cell of the grid is taken and the
C    value at the centre of each side and diagonal estimated.
C
      M = 0
C
C -- Initialise contour point counter
C
      NPOINT = 0
30    CONTINUE
      M = M + 1
C
C
C -- Any more contours
C
      IF( M .GT. NCONT ) GOTO 990
      ICOLNM = ICOLNM + 1
      MA = 0
C
C -- Base address of contour point chain
C
      NA = -1
      N = 0
16    CONTINUE
      N = N + 1
C
C -- Covered all boxes ?
C
      IF( N .GT. NTOT ) GOTO 65
C
C -- Exceeded right most box ?
C
      IF( MOD( N, NPH ) .EQ. 0 ) GOTO 16
C
C  -- EKD major modification to extend contoured area
C     to #include edges
C
      JY = N + NPH
C
C -- If edge of grid change reference to points off map to edge
C    horizontal edges
C
      IF( MOD( N+1, NPH ) - 2 ) 110, 120, 130
C
C -- Right edge
C
110   CONTINUE
      J1X = N - 1
      J2X = N + 1
      GOTO 140
C
C -- Left edge
C
120   CONTINUE
      J1X = N
      J2X = N + 2
      GOTO 140
C
C -- Middle
C
130   CONTINUE
      J1X = N - 1
      J2X = N + 2
C
C -- Vertical edges
C
140   CONTINUE
      IF( N .LT. NPH ) THEN
C
C -- Bottom row
C
        J2Y = N + NPH + NPH
        J1Y = N
      ELSE IF( N .LT. NCHK ) THEN
C
C -- Middle
C
        J2Y = N + NPH + NPH
        J1Y = N - NPH
      ELSE
C
C -- Top row
C
        J2Y = N + NPH
        J1Y = N - NPH
      ENDIF
C
C -- Box corners
C
      W(1) = E(N)
      W(3) = E(N+1)
      W(7) = E(JY)
      W(5) = E(JY+1)
      W(9) = W(1)
C
C -- Corners edges
C
      W(2) =0.0625*(8.*(W(1)+W(3))+ERANGE*(W(1)+W(3)-E(J1X)-E(J2X)))
      W(4) =0.0625*(8.*(W(3)+W(5))+ERANGE*(W(3)+W(5)-E(J1Y+1)-E(J2Y+1)))
      W(6) =0.0625*(8.*(W(5)+W(7))+ERANGE*(W(5)+W(7)
     1        -E(J2X+NPH)-E(J1X+NPH)))
      W(8) =0.0625*(8.*(W(7)+W(9))+ERANGE*(W(7)+W(9)-E(J2Y)-E(J1Y)))
C
C -- Bias current contour to zero
C
      DO 17 I = 1, 9
        W(I) = W(I) - D(M)
        IF( ABS(W(I)) .GT. PMAXVL ) GOTO 16
17    CONTINUE
C
C -- Centre of face
C
      W(10) = 0.25*(W(2)+W(4)+W(6)+W(8))
     1       +ERANGE*(W(2)+W(4)+W(6)+W(8)-W(1)-W(3)-W(5)-W(7))/12.
C
C -- Row address
C
      P=FLOAT(N/NPH)*200.+100.
C
C -- Column address
C
      Q = FLOAT( MOD( N - 1, NPH ) ) * 200. + 100.
      J = 10
      L = 0
18    CONTINUE
      L = L + 1
      K = L + 1
C
C -- Find if contour cuts triangle edges.
C
      DO 20 NI = 1, 3
      IF(ITRAM.EQ.2.OR.ITRAM.EQ.6)THEN
        IF(J.EQ.10.OR.K.EQ.10)GOTO 19
      ENDIF
      IF(W(J)*W(K) .GT. 0.000) GOTO 19
C
C -- Find relative height
C
      WGRAD=W(K)-W(J)
C
C -- Check that the contor actually cuts this line
C
      IF((ABS(WGRAD)-BOBIAS).LT.0.) GOTO 19
      Z=W(K)/WGRAD
C
C -- Need gradient for ITPSAV > 20
C    To weed out points too close to existing coontours
C    gradient along triangle edge J K is W(J)-W(K)
C
      IF( .NOT. L6XXX ) GOTO 50
      IF( ABS( WGRAD ) .LT. WMAX ) GOTO 50
      IF( IDGODB .EQ. 160 ) GOTO 50
      ZOLD = Z
      IF( W(K) .GT. 0. ) Z = MIN( Z - .1, 0.0001 )
      IF( W(K) .LT. 0. ) Z = MAX( 0.9999, Z + .1 )
      IF( IDGODB .EQ. 140 ) PRINT *,WMAX,WGRAD,U,V,Z,ZOLD,W(J),W(K)
C     IF( W(J) .GT. W(K) ) Z = 0.
50    CONTINUE
      T = 1. - Z
      U = VRT * ( Z * X(J) + T * X(K) + P )
      V = HRZ * ( Z * Y(J) + T * Y(K) + Q )
C
C -- Insert point in contour chain
C
      NA = NA + 2
      IE( NA ) = INT(U)
      IE( NA + 1 ) = INT(V)
      IF( MOD( NA, 4 ) .NE. 3 ) GOTO 19
      IF( IE( NA ) .NE. IE( NA - 2 ) ) GOTO 19
C
C -- Weed out redundant points
C
      IF( IE( NA + 1 ) .EQ. IE( NA - 1 ) ) NA = NA - 4
19    CONTINUE
      I = J
      J = K
      K = L
      L = I
20    CONTINUE
      IF( NA .LT. LCHAIN ) GOTO 63
C
C -- Too little workspace
C
      WRITE ( * , * ) 'DGO-E- too little workspace .. forced interrupt'
C
C -- Forced interupt
C
C
C REMOVED BY ASHLEY 28-1-93
C      CALL DOCTLC
C
C ADDED BY ASHLEY 28-1-93
      CALL WAIT (10.0)
      RETURN
63    CONTINUE
C
C -- Any more points in box?
C
      IF( L - 8 ) 18, 16, 16
65    CONTINUE
C
C -- End of counter chain
C
      I = 0
      GOTO 41
C
66    CONTINUE
      GOTO 30
C
64    CONTINUE
      NA = 0
C
C -- Go back to do next contour.
C
      GOTO 66
C
C -- Interpolate between contour points.
C
41    CONTINUE
      MA = ( ( NA + 1 ) / 2 ) + MA
C
C -- Store empty?
C
21    CONTINUE
      IF( NA .LT. 0 ) GOTO 64
      N = NA
C
C -- Examine chain from top down
C
23    CONTINUE
C
C -- Point in range?
C
      IF( IE(N  ) .LT. IB(1) ) GOTO 24
      IF( IE(N+1) .LT. IB(3) ) GOTO 24
      IF( IE(N  ) .GT. IB(2) ) GOTO 24
      IF( IE(N+1) .GT. IB(4) ) GOTO 24
C
C -- Remove point from chain
C
      N = N - 2
      IF( N .GT. 1 ) GOTO 23
24    CONTINUE
      NX = IE(N)
      NY = IE(N+1)
      NT = 6
      IT(5) = NX
      IT(6) = NY
25    CONTINUE
      N = -1
      IE(NA+2) = NX
      IE(NA+3) = NY
C
C -- Search chain from bottom to find points coincident
C    with current point.
C
26    CONTINUE
      N = N + 2
      IF( NX .NE. IE(N) ) GOTO 26
      IF( NY .NE. IE(N+1) ) GOTO 26
C
C -- Stop search if pointers cross.
C
      IF( N .GT. NA ) GOTO 126
C
C -- Coincident but not identical, ie no match
C
      L = 8 * ( ( N + 3 ) / 4 ) - N - 4
      NX = IE(L)
      NY = IE(L+1)
C
      J = IE(NA)
      K = IE(NA+1)
      IE(L) = IE(NA-2)
      IE(L+1) = IE(NA-1)
      IE(N) = J
      IE(N+1) = K
      NA = NA - 4
C
C -- Add point just found to buffer of points to be connected.
C
      NT = NT + 4
      IT(NT-1) = NX
      IT(NT  ) = NY
C
C -- If buffer not full, get another point
C
      IF( NT .LT. ( JBUF - 7 ) ) GOTO 25
C
C -- Buffer full or nomore points to contour.
C
126   CONTINUE
C
C -- Any points in buffer?
C
      IF( NT .EQ. 6 ) GOTO 21
C
C -- Yes- smooth and interpolate go generate plotting points.
C    Note start and end points have been stored for each vector
C
      IT(1) = IT(5)
      IT(2) = IT(6)
      IT(NT+4) = IT(NT)
      IT(NT+3) = IT(NT-1)
C
C -- Coordinates not cooincident?
C
      IF( IT(NT) .NE. IT(2) ) GOTO 125
      IF( IT(NT-1) .NE. IT(1) ) GOTO 125
      IT(1) = IT(NT-5)
      IT(2) = IT(NT-4)
      IT(NT+3) = IT(9)
      IT(NT+4) = IT(10)
C
C -- Smooth over buffer
C
125   CONTINUE
      DO 127 K = 7, NT, 4
        L = K + 1
        DO 227 J = K, L
          IT(J)=INT(0.5+.60355*(FLOAT(IT(J-2))+FLOAT(IT(J+2)))-
     +                 0.10355*(FLOAT(IT(J-6))+FLOAT(IT(J+6))))
227     CONTINUE
127   CONTINUE
C
C -- Number of points
C
      K = ( NT - 4 ) / 4
C
C -- Call to graphics package DGO
C    Assumes device nomination, including scaling,pen selection
C    etc is performed by calling program
C    Set max and min to within box
C
      YPT = FLOAT(IT(5))*CYFTR
      YPT = MAX(YPT,YLIML)
      YPT = MIN(YPT,YLIMH)
      XPT = FLOAT(IT(6))*CXFTR
      XPT = MAX(XPT,XLIML)
      XPT = MIN(XPT,XLIMH)
C
C -- Set ZPT ( contour height - contour min level * scale factor to 
C    provide z depth + start position to draw at in z ) 
C
C!!      IF( ITRAM .LT. 0 ) THEN
C!!        ZPT = ( D(M) - TRAMAT(2,1) ) * TRAMAT(1,1)
C!!      ELSE
C!!        ZPT = 0.
C!!      ENDIF
      ZPT = ( ( D(M) - ZMINLV ) * ZSCFTR ) + ZDEPTH
C
C -- Move to start
C
C -- Patch ...
C
C      IF( ( IDGODB .EQ. 150 ) .AND. L6XXX ) CALL PENSEL( 2, 0., 0 )
C      CALL MOVTO3( XPT * XSCFTR, YPT * YSCFTR, ZPT )
C ADDED BY ASHLEY 26-1-93
      XPTOLD = XPT * XSCFTR
      YPTOLD = YPT * YSCFTR
      CALL STALIN (XPTOLD, YPTOLD, XPTOLD, 
     +   YPTOLD, NPH, NPV, ICOL (ICOLNM), ICOLNM, D, NC)
      XPTOLD = XPT
      YPTOLD = YPT
C
      J = 5
C
C -- Loop round other points and draw
C
      DO 230 N = 1, K
        J = J + 4
        YPT = FLOAT(IT(J))*CYFTR
        YPT = MAX(YPT,YLIML)
        YPT = MIN(YPT,YLIMH)
        XPT = FLOAT(IT(J+1))*CXFTR
        XPT = MAX(XPT,XLIML)
        XPT = MIN(XPT,XLIMH)
        NPOINT = NPOINT + 1
C        CALL LINTO3( XPT * XSCFTR, YPT * YSCFTR, ZPT )
C ADDED BY ASHLEY 26-1-93
      XPTOLD = XPTOLD * XSCFTR
      YPTOLD = YPTOLD * YSCFTR
      XPTASH = XPT * XSCFTR
      YPTASH = YPT * YSCFTR
C ADDED BY ASHLEY 26-1-93
      CALL CONLIN (XPTOLD, YPTOLD, XPTASH, YPTASH, 
     +             NPH, NPV, ICOL ( ICOLNM ) )
C
C -- Calculate the line length
C
        IF( N .GT. 1 ) THEN
          AGLINE = AGLINE + SQRT( ((XPT-XPTOLD)*XSCFTR)**2
     +                              + ((YPT-YPTOLD)*YSCFTR)**2 )
        ENDIF
C ADDED BY ASHLEY 27-1-93
        XPTOLD = XPT
        YPTOLD = YPT
C
230   CONTINUE
C
C -- Process more plot chain.
C
      GOTO 21
C
990   CONTINUE
      RETURN
      END
CRYSTALS CODE FOR ASHLEY
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.3  1999/12/08 15:56:46  ckp2
C djw  New colour table
C
C Revision 1.2  1999/11/02 17:29:55  ckp2
C RIC: Removed carriage returns
C
      BLOCK DATA ASHLEY
C BLOCK DATA FOR THE FOURIER MAP PLOTTER
C      #include 'concom.cmn'
#include "CONCOM.INC"

      logical wnstop
      COMMON /WINSTP/ wnSTOP
      DATA wnSTOP /.FALSE./


C
C SG COLOUR SCHEME
C      DATA ICOL / 0, 8, 1, 9, 3, 10, 2, 11, 6, 12, 4,
C     2           13, 5, 14, 15, 7 /
C VGA COLOUR SCHEME
cdjwdec99      DATA ICOL / 0, 6, 4, 12, 14, 10, 2, 11, 3, 9, 1,
cdjwdec99     2            5, 13, 8, 7, 15 /
cdjwdec99      DATA ICOL /  0, 8, 6, 4, 5, 1, 3, 2, 10, 9, 11,
cdjwdec99     1 13, 12, 14, 7, 15 /
cdjwdec99      DATA ICOL /  0, 8, 1, 4, 5, 2, 6, 3, 9, 11, 10, 13, 12, 14,
cdjwdec99     1 7, 15 /
      DATA ICOL /  0, 8, 1, 4, 5, 2, 6, 3, 9, 12, 13, 10, 14,
     1 7, 11, 15 /
      DATA IPCOL / 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
     2             13, 14, 15, 16 /
C      DATA IPCOL / 10, 9.5, 9, 8.5, 8, 7.5, 7, 6.5,
C     2            6, 5.5, 5, 4, 3, 2, 1, 0 /
      DATA IPLIND / 1,2,1,0,3,2,4,2,5,2,6,2,7,2,8,2,
     2              1,1,2,1,3,1,4,1,5,1,6,1,7,1,8,1 /
      DATA MT1 / 9 /
      DATA L81/ 1 /
      DATA NLEVEL, ILVLOS / 16, 0 /
      DATA RMAXIM, RMINIM / -100000., 100000. /
      DATA RXSIZ, RYSIZ / 640., 480. /
      DATA RXORIG, RYORIG / 0., 0. /
      DATA ILOGFL / 0 /
      DATA ICOLFL / 1 /
      DATA ISCRN / -1 /
      DATA ITXTCO / 7 /
      DATA INPDEV, IOUTSC / 5, 6 /
      DATA IDEVIC / 1 /
      DATA IPFILE / 13 /
      DATA IPSOSX, IPSOSY / 50, 50 /
      DATA IBTXCO / 15 /
C SG POSITIONS SCHEME
C      DATA IXCPOS / 482, 485, 490, 495, 500, 505, 548, 560, 610, 620 /
C      DATA IYCPOS / 10, 15, 29, 35, 40, 60, 80, 110, 130, 150,
C     2             190, 200, 210, 250, 270, 274, 290, 290, 294, 310,
C     3             310, 330, 350, 364, 390, 412, 424, 436, 468 /
C VGA POSITIONS SCHEME
      DATA IXCPOS / 482, 485, 490, 495, 500, 505, 548, 560, 610,
     2               620 /
      DATA IYCPOS / 10, 15, 19, 35, 40, 60, 80, 110, 130, 150, 180,
     2              200, 220, 250, 270, 290, 290, 310, 310, 310,
     3              330, 330, 350, 364, 390, 412, 424, 436, 468 /


      END
CRYSTALS CODE FOR AJICONT
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.2  1999/11/02 17:30:01  ckp2
C RIC: Removed carriage returns
C
      SUBROUTINE XCNTOR
C A SUBROUTINE TO SET UP ALL THE VARIABLES BEFORE THE CONTOURING
C PROPER IS CALLED
      save
#include "CONCOM.INC"
c      #include 'concom.cmn'
      REAL TMIN, TMAX
      INTEGER*4 IPOINT, INYNZ, ITEMP (16)
      INTEGER*2 KEY
      CHARACTER*20 CIN
      DIMENSION E( 499999 )
      DIMENSION D (16)
      DIMENSION IE (499999)
      DIMENSION IT (50000)
      LCHAIN = 20*(NUM(1)*NUM(2)+100)
      JBUF = 10*(NUM(1)+NUM(2)+100)
      TMIN = 100000.
      TMAX =-100000.
      ZDEPTH = 0.0
      ZMINLV = 0.0
      ZSCFTR = 0.0
      IPOINT = 1
      NC = NLEVEL
      INYNZ = NUM(1)*NUM(2)
      DO 800 I = 1+NUM(1)*NUM(2)*LEVEL,1+NUM(1)*NUM(2)*(LEVEL+1)
            E (IPOINT) = FSTORE (I)
            IF (FSTORE(I).GT.TMAX) TMAX = FSTORE(I)
            IF (FSTORE(I).LT.TMIN) TMIN = FSTORE(I)
            IPOINT = IPOINT + 1
800   CONTINUE
      CALL CLRSCR
      CALL XLVLNM (TMAX, TMIN)

      CALL ZTXT(CIN,'Manually set contour heights? (Y/[N]) ')
400   CONTINUE
       CALL UCASE (CIN)
      
       IF ((CIN(1:1).EQ.'N').OR.(CIN(1:1).EQ.' ')) THEN
            IF (ISPOSN.EQ.1) THEN
                DO 700 I = 1, NLEVEL
                        D(I) = RMINIM + FACTOR * (I-1)
700             CONTINUE
            ELSE
                DO 713 I = ISPOSN, NLEVEL
                        D(I-ISPOSN) = RMINIM + FACTOR * (I-1)
713             CONTINUE
                ILVLOS = ISPOSN
                NLEVEL = NLEVEL - ISPOSN
                NC = NLEVEL 
            ENDIF
       ELSE IF(CIN(1:1).EQ.'Y') THEN
           CALL XSTLVL (D, NC)
           NLEVEL = NC
       ELSE
           CALL ZTXT(CIN,'MANUALLY SET CONTOUR HEIGHTS? (Y/[N]) ')
           GOTO 400
       ENDIF

      CALL CLRSCR
      CALL XCOLKY 
      CALL XTITL2 
      CALL MSG 
      CALL CONTOR (E, NUM(2), NUM(1), INYNZ, D, NC, IE, LCHAIN, IT,
     +   JBUF, NUM(2), NUM(1), AGLINE, ZMINLV, ZSCFTR, ZDEPTH, ICOL)
      CALL RMMSG
505   CONTINUE
      CALL MSG2 
      CALL GETKEY ( KEY, 0 )
      CALL UPCASE (KEY)
      CALL RMMSG2
      IF ((KEY.EQ.1).OR.(KEY.EQ.0)) THEN
           GO TO 505
      ENDIF
      IF (KEY.EQ.72) THEN
         CALL PSSTUP (ITEMP, D, NC)
         CALL MSG
         CALL CONTOR (E, NUM(2), NUM(1), INYNZ, D, NC, IE, LCHAIN, IT,
     +   JBUF, NUM(2), NUM(1), AGLINE, ZMINLV, ZSCFTR, ZDEPTH, ICOL)
         CALL PSSTOP (ITEMP)
         CALL RMMSG
      ENDIF
      NLEVEL = 16
      ILVLOS = 0
      CALL CLRSCR
      RETURN
      END
C
      SUBROUTINE XLVLNM (TMAX, TMIN)
C ALLOWS YOU TO SET THE CONTOUR LEVELS
      CHARACTER*80 COUT
#include "CONCOM.INC"
c      #include 'concom.cmn'
      REAL TMAX, TMIN
      WRITE (COUT,'(A,F8.3,1X,F8.3)')
     1   'The current min and max are ',TMIN,TMAX
      CALL ZMSG(COUT)
      RETURN
      END
c
      SUBROUTINE XSTLVL (D, NC)
C ALLOWS THE USER TO SET THE CONTOUR LEVELS
#include "CONCOM.INC"
c      #include 'concom.cmn'
      REAL D (16)
      INTEGER*4 NC
      CHARACTER CIN*15, COUT*30
410   CONTINUE
      CALL ZTXT(CIN,'How many levels? (Max=16) ')
      READ (CIN,'(I4)',ERR=410) NC
      IF (NC.GT.16) GO TO 410
      ILVLOS = NLEVEL - NC
      DO 420 I = 1, NC
          WRITE (COUT,401) I
415       CONTINUE
             CALL ZTXT(CIN,COUT)
          READ (CIN,*,ERR=415) D (I)
420   CONTINUE
401   FORMAT (1X, 'Enter the value for level ',I2)
      RETURN
      END
CRYSTALS CODE FOR EXTRAS
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.2  1999/11/02 17:29:58  ckp2
C RIC: Removed carriage returns
C
      SUBROUTINE XCOLKY 
C DRAWS THE KEY FOR THE COLOUR SCHEME
c      #include 'concom.cmn'
#include "CONCOM.INC"
      INTEGER*2 IX1, IY1, IX2, IY2, IYC
      INTEGER*4 I
      CHARACTER*80 CNUM
      IX1 = IXCPOS (9)
      IX2 = IXCPOS (10)
      IY1 = IYCPOS (2)
      IY2 = IYCPOS (4)
      IYC = IYCPOS (3)
      CNUM = '  '
      DO 190 I = 1, NLEVEL
            CALL DRWREC(IX1, IY1, IX2, IY2, 16-NLEVEL+I )
            WRITE (CNUM,'(I2)') I-1
            CALL DRWTXT (CNUM, IX2, IYC, ITXTCO)
            IY1 = IY1 + 28
            IY2 = IY1 + 20
            IYC = IYC + 28
190   CONTINUE
      RETURN
      END
C
      SUBROUTINE XCTRIM( CSOURC, NCHAR)
C TRIM OFF TRAILING SPACES IN A STRING
C      CSOURC - SOURCE STRING
C      NCHAR   - LAST NON-SPACE CHARACTER
      INTEGER*4 NCHAR, LENGTH, I
      CHARACTER *(*) CSOURC
      CHARACTER *1 CBLANK
      DATA CBLANK /' '/
      LENGTH = LEN (CSOURC)
      DO 300 I = LENGTH, 1, -1
      IF (CSOURC(I:I) .NE. CBLANK) GOTO 310
300   CONTINUE
      I = 0
310   CONTINUE
      NCHAR = I
      RETURN
      END
C
      SUBROUTINE PSSTUP (ITEMP, D, NC)
C SETS UP THE POSTSCRIPT FILE
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*4 ITEMP (16), NC
      REAL D (NC)
      CHARACTER*30 CFILEN, CSTRNA
      CALL ZTXT(CFILEN,'Name of output file? ')
C      WRITE (IOUTSC, '(A21,$)') 'Name of output file? '
C      READ (INPDEV,'(A30)') CFILEN
      CALL ZTXT(CSTRNA,'Name of structure? ')
C      WRITE (IOUTSC, '(A19,$)') 'Name of structure? '
C      READ (INPDEV, '(A30)') CSTRNA
      OPEN (UNIT=IPFILE, STATUS='UNKNOWN', FILE=CFILEN)
      WRITE (IPFILE, '(A2)') '%!'
      WRITE (IPFILE, '(A7)') 'newpath'
      DO 456 I = 1, 16
           ITEMP (I) = ICOL (I)
           ICOL (I) = IPCOL (I)
456   CONTINUE
      IDEVIC = 2
      CALL PSPAGE (CFILEN, CSTRNA, D, NC)
      RETURN
      END
C
      SUBROUTINE PSSTOP (ITEMP)
C CLOSES THE POST SCRIPT FILE
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*4 ITEMP (16)
      WRITE (IPFILE, '(A15)') 'stroke showpage'
      CLOSE (IPFILE)
      IDEVIC = 1 
      DO 457 I = 1, 16
             ICOL (I) = ITEMP (I)
457   CONTINUE
      RETURN
      END
C
      SUBROUTINE PSBGLI (IX1, IY1, ITCOL, ICOLNM, DCON, NC)
C SENDS THE OUTPUT TO A POSTSCRIPT FILE
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*2 IX1, IY1, IXLIM1, IYLIM1, IXLIM2, IYLIM2
      INTEGER*4 ITCOL, ICOLNM, NC, ITEMP
      REAL RCOL, RPSTXC, DCON (NC)
      RPSTXC = 0.0
      RCOL = REAL ( ITCOL )
      RCOL = RCOL * 0.1
      ITEMP = ITCOL - ILVLOS
      IXLIM1 = INT (RXSCAL*NUM(2)*0.95)
      IYLIM1 = INT (RYSCAL*NUM(1)*0.95)
      IXLIM2 = INT (RXSCAL*NUM(2)*0.02)
      IYLIM2 = INT (RYSCAL*NUM(1)*0.02)
      IF ((IX1.LT.IXLIM1).AND.(IY1.LT.IYLIM1).AND.(IX1.GT.IXLIM2)
     2   .AND.(IY1.GT.IYLIM2)) THEN
            WRITE (IPFILE, '(A6)') 'stroke'
            WRITE (IPFILE, 523) RPSTXC
            WRITE (IPFILE, 524) IY1+IPSOSY, IX1+IPSOSX
            WRITE (IPFILE, 525) ITEMP
525   FORMAT ('(',I2,')', ' show')
      ENDIF
      WRITE (IPFILE, '(A6)') 'stroke'
      IF (DCON(ITEMP).GE.0) THEN
            WRITE (IPFILE, 527) IPLIND (1, 2), IPLIND (2, 2)
      ELSE
            WRITE (IPFILE, 527) IPLIND (1, 1), IPLIND (2, 1)
      ENDIF
C      WRITE (IPFILE, 523) RCOL
      WRITE (IPFILE, 524) IY1+IPSOSY, IX1+IPSOSX
523   FORMAT ( 1X, F4.2, 1X, 'setgray')
524   FORMAT (1X, I3, 1X, I3, ' moveto')
527   FORMAT (1X, '[',I2, 1x, I2, '] 0 setdash')
      RETURN
      END
C
      SUBROUTINE PSCOLI (IX1, IY1)
C SENDS THE OUTPUT TO A POSTSCRIPT FILE
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*2 IX1, IY1
      WRITE (IPFILE, 592) IY1+IPSOSY, IX1+IPSOSX
592   FORMAT (1X, I3, 1X, I3, ' lineto')
      RETURN
      END    
C
      SUBROUTINE PSPAGE (CFILEN, CSTRNA, D, NC)
C DRAWS THE POSTSCRIPT PAGE LAYOUT
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*4 IXSIZ, IYSIZ, IXORIG, IYORIG, NC
      REAL D(NC)
      CHARACTER*30 CFILEN, CSTRNA
      IXORIG = INT (RXORIG)
      IYORIG = INT (RYORIG)
      IXSIZ = INT (RXSCAL*NUM(2))
      IYSIZ = INT (RYSCAL*NUM(1))
      WRITE (IPFILE, '(A21)') '/Times-Roman findfont'
      WRITE (IPFILE, '(A13)') '20 scalefont'
      WRITE (IPFILE, '(A7)') 'setfont'
      WRITE (IPFILE, '(A14)') '50 760 moveto'
      WRITE (IPFILE, 2022) CSTRNA
2022  FORMAT ('(Structure = ',A30,') show')
      WRITE (IPFILE, '(A14)') '50 740 moveto'
      WRITE (IPFILE, 2021) CFILEN
2021  FORMAT ('(Filename = ',A30,') show')
      CALL PSKEY (D, NC)
      WRITE (IPFILE, '(A21)') '/Times-Roman findfont'
      WRITE (IPFILE, '(A12)') '4 scalefont'
      WRITE (IPFILE, '(A7)') 'setfont'
      WRITE (IPFILE, 404 ) IYORIG + IPSOSY, IXORIG + IPSOSX
      WRITE (IPFILE, 405 ) IYORIG + IPSOSY, IXSIZ + IPSOSX
      WRITE (IPFILE, 405 ) IYSIZ + IPSOSY, IXSIZ + IPSOSX
      WRITE (IPFILE, 405 ) IYSIZ + IPSOSY, IXORIG + IPSOSX
      WRITE (IPFILE, 405 ) IYORIG + IPSOSY, IXORIG + IPSOSX
      WRITE (IPFILE, '(A17)') ' 0.1 setlinewidth'
404   FORMAT (1X, I3, 1X, I3, ' moveto')
405   FORMAT (1X, I3, 1X, I3, ' lineto')
      RETURN
      END
C
      SUBROUTINE PSKEY (D, NC)
C DRAWS A KEY TO INDICATE THE VALUE OF THE CONTOUR LEVELS
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*4 NC, I, IX, IY
      REAL D(NC)
      IX = 50
      IY = 670
      WRITE (IPFILE, '(A21)') '/Times-Roman findfont'
      WRITE (IPFILE, '(A13)') '14 scalefont'
      WRITE (IPFILE, '(A7)') 'setfont'
      WRITE (IPFILE, '(A14)') '50 720 moveto'
      WRITE (IPFILE, '(A41)')
     + '(Dotted lines indicate negative rho) show'
      WRITE (IPFILE, '(A14)') '50 705 moveto'
      WRITE (IPFILE, '(A40)') 
     + '(Solid lines indicate positive rho) show'
      WRITE (IPFILE, '(A21)') '/Times-Roman findfont'
      WRITE (IPFILE, '(A13)') '9 scalefont'
      WRITE (IPFILE, '(A7)') 'setfont'
      WRITE (IPFILE, '(A14)') '50 685 moveto'
      WRITE (IPFILE, '(A13)') ' (KEY:) show'
      DO 4131 I = 1, NC
            WRITE (IPFILE, 4132) IX, IY
            WRITE (IPFILE, 4133) I, D(I)
4132  FORMAT (1X, I3, 1X, I3, 1X, 'moveto')
4133  FORMAT (1X, '(',I2, ' = ', F9.3, ') show')
            IY = IY - 8
4131  CONTINUE
      WRITE (IPFILE, '(A14)') '50 40 moveto '
      WRITE (IPFILE, '(A49)') 
     + '(Fourier Map Plotter by Ashley Ibbett 1993.) show'
      RETURN
      END
CRYSTALS CODE FOR VGACALLS
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.2  1999/11/02 17:30:00  ckp2
C RIC: Removed carriage returns
C
      SUBROUTINE DRWREC (IX1, IY1, IX2, IY2, IPOSN)
&DVF      USE DFLIB
C DRAWS A RECTANGLE AT THE POINTS SPECIFIED
c      #include 'concom.cmn'
#include "CONCOM.INC"
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
      INTEGER*2 IX1, IX2, IY1, IY2, RES
      INTEGER*4 IPOSN
&DOS      CALL FILL_RECTANGLE@ (IX1, IY1, IX2, IY2, ICOL (IPOSN) )
&DVF      RES= SETCOLOR ( ICOL (IPOSN) )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, IX1, IY1, IX2, IY2 )
C      CALL WINSET (ISCRN)
C      CALL CMOV2S (IX1, IY1)
C      CALL COLOR (ICOL (IPOSN) )
C      CALL RECTFS (IX1, IY1, IX2, IY2)
      RETURN
      END
C
      SUBROUTINE NORMAL
C RETURNS THE SCREEN TO TEXT MODE
      RETURN
      END
C
      SUBROUTINE GETKEY ( DATA , IMODE )
&DVF      USE DFLIB
&DVF      TYPE (xycoord) xy
C RETURNS THE VALUE OF THE KEY PRESSED
&DOS      #include <WINDOWS.INS>
&DVF      CHARACTER*1 CDAT
#include "CONCOM.INC"
      INTEGER*2 DATA
&DOS      INTEGER*2 get_wkey1@
      logical wnstop
      COMMON /WINSTP/ wnSTOP

      IF(IMODE.EQ.0) THEN
&DOS          CALL CLEAR_SCREEN_AREA@(0,NINT(RYSIZ)+1,
&DOS     1                            NINT(RXSIZ),NINT(RYSIZ)+10,0)
&DVF          RES= SETCOLOR ( 0 )
&DVF          RES= RECTANGLE ( $GFILLINTERIOR,0, NINT(RYSIZ)+1 ,
&DVF     1                     NINT(RXSIZ) , NINT(RYSIZ)+10  )
&DOS          CALL DRAW_TEXT@('Ready   ',10,NINT(RYSIZ)+1,15)
&DVF          RES= SETCOLOR ( 15 )
&DVF          CALL MOVETO(10,NINT(RYSIZ+1),xy)
&DVF          CALL OUTGTEXT('Ready   ')
      ENDIF

&DOS10    CALL TEMPORARY_YIELD@
&DOS          IF(WNSTOP) CALL EXIT(0)
&DOS          DATA = GET_wKEY1@()
&DOS      IF(DATA.EQ.0) GOTO 10
&DVF      CDAT = GETCHARQQ()
&DVF      DATA = ICHAR(CDAT)

      IF(IMODE.EQ.0) THEN
&DOS          CALL CLEAR_SCREEN_AREA@(0,NINT(RYSIZ)+1,
&DOS     1                            NINT(RXSIZ),NINT(RYSIZ)+10,0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, 0, NINT(RYSIZ)+1,
&DVF     1                   NINT(RXSIZ),NINT(RYSIZ)+10)
&DOS          CALL DRAW_TEXT@('Working ',10,NINT(RYSIZ)+1,15)
&DVF          RES= SETCOLOR ( 15 )
&DVF          CALL MOVETO(10,NINT(RYSIZ)+1,xy)
&DVF          CALL OUTGTEXT('Working   ')
      ENDIF
&DOS      CALL TEMPORARY_YIELD@
      RETURN
      END
C

      subroutine kilwin
&DOS      #include <windows.ins>
&DOS      integer GraphicsHandle
&DOS      COMMON /CONWIN/ GRAPHICSHANDLE
&DOS      GraphicsHandle=0
&DOS      call window_update@(GraphicsHandle)
      RETURN
      END

      SUBROUTINE SETSCR
C SETS UP THE SCREEN
&DVF      USE DFLIB
&DVF      USE DFWIN
#include "CONCOM.INC"
&DVF      INTEGER*2 RES
&DVF      logical*4 status
&DVF      type (windowconfig)wc
&DVF      type (qwinfo)win
C      CALL VGA@
c      #include <WINDOWS.INS>
&DOS      external f_close
&DOS      integer f_close
&DOS      integer GraphicsHandle
&DOS      COMMON /CONWIN/ GRAPHICSHANDLE

&DOS      GraphicsHandle=-1
&DOS      i=winio@('%ca[Contour Native 32-bit]&')
&DOS      i=winio@('%sp&',0,0)
&DOS      i=winio@('%cc&',f_close)
&DOS      i=winio@('%bg[black]&')
&DOS      i=winio@('%gr[black]%lw',NINT(RXSIZ),NINT(RYSIZ)+10,
&DOS     1 GraphicsHandle)

&DVF      wc.numtextcols=80
&DVF      wc.numtextrows=30
&DVF      wc.title='Ibbett-Contour'
&DVF      wc.numxpixels=650
&DVF      wc.numypixels=490
&DVF      i = GetWindowLong( GetHWndQQ(QWIN$FRAMEWINDOW), GWL_STYLE )
&DVF      i = ior( iand( i, not(WS_THICKFRAME) ), WS_BORDER )
&DVF      i = iand( i, not(WS_HSCROLL) )
&DVF      k = SetWindowLong( GetHWndQQ(QWIN$FRAMEWINDOW), GWL_STYLE, i )    
&DVF      i = GetWindowLong( GetHWndQQ(0), GWL_STYLE )
&DVF      i=ior(iand(i,not(WS_CAPTION.or.WS_SYSMENU.or.WS_THICKFRAME)),
&DVF     1    WS_BORDER)
&DVF      k = SetWindowLong( GetHWndQQ(0), GWL_STYLE, i )     
&DVF      win.x = 0
&DVF      win.y = 0
&DVF      win.w = 640
&DVF      win.h = 490
&DVF      win.type=qwin$set
&DVF      dummy4 = setwsizeqq(qwin$framewindow,win)
&DVF      status = getwsizeqq(QWIN$FRAMEWINDOW,QWIN$SIZECURR, win)
&DVF      status=setwindowconfig(wc)
&DVF      if(.not.status)status=setwindowconfig(wc)
&DVF      i = MoveWindow( GetHWndQQ(0), 0, 0, 740, 590, .TRUE.) 
&DVF      call clearscreen($GCLEARSCREEN)
&DVF      status = UpdateWindow(GETHANDLEFRAMEQQ())    

&DVF      I=SETEXITQQ(QWIN$EXITNOPERSIST)
C&DVF      CALL SETVIEWPORT( 0,0, 640, 490 )
&DVF      RES = INITIALIZEFONTS()
&DVF      RES = SETFONT('t''Courier''h10w8b')

C      INTEGER IRXSIZ, IRYSIZ
C      IRXSIZ = INT (RXSIZ)
C      IRYSIZ = INT (RYSIZ)
C      CALL FOREGR
C      CALL PREFSI (IRXSIZ, IRYSIZ)
C      ISCRN = WINOPE ("Fourier", 7)
C      CALL DRAWMO (NORMDR)
C      CALL COLOR (BLACK)
C      CALL CLEAR
C      CALL ORTHO2 (RXORIG, RXSIZ, RYSIZ, RYORIG)
C      CALL SGCOLS 
      RETURN
      END

      INTEGER FUNCTION F_CLOSE()
      logical wnstop
      COMMON /WINSTP/ wnSTOP
      wnSTOP = .TRUE.
      F_CLOSE = 0
      END

C
      SUBROUTINE GREYSCAL 
C SETS THE COLOURS TO GREYS
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
#include "CONCOM.INC"
      RETURN
      END
C
      SUBROUTINE DRWTXT (CTXT, IX, IY, ITCOL)
C DRAWS TEXT ON THE SCREEN
&DVF      USE DFLIB
#include "CONCOM.INC"
&DVF      TYPE (xycoord) xy
c      #include 'concom.cmn'
      INTEGER*2 IX, IY
      INTEGER*4 ITCOL, NCHAR
      CHARACTER*(*) CTXT
      CALL XCTRIM (CTXT, NCHAR)
C      CALL WINSET (ISCRN)
C      CALL CMOV2S (IX, IY)
C      CALL COLOR (ITCOL)
C      CALL CHARST (CTXT(1:NCHAR), NCHAR)
&DOS      CALL DRAW_TEXT@ (CTXT(1:NCHAR), IX, IY, ITCOL)
&DVF      RES= SETCOLOR ( ITCOL )
&DVF      CALL MOVETO(IX,IY,xy)
&DVF      CALL OUTGTEXT(CTXT(1:NCHAR))
      RETURN
      END
C
      SUBROUTINE WAIT (TIME)
C STOPS THE OUTPUT FOR GIVEN TIME
      REAL TIME
&DOS      CALL SLEEP@ (TIME)
C      CALL SLEEP (INT (TIME))
      RETURN
      END
C
      SUBROUTINE TITLES 
C DRAWS THE TITLES
#include "CONCOM.INC"
c      #include 'concom.cmn'
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
      CALL DRWTXT ('LOWEST', IXCPOS (8), IYCPOS(1), ITXTCO )
      CALL DRWTXT ('HIGHEST', IXCPOS(8), IYCPOS(29), ITXTCO )
      CALL DRWTXT ('FOURIER MAP', IXCPOS(3), IYCPOS(5), ITXTCO )
      CALL DRWTXT ('PLOTTER', IXCPOS(5),IYCPOS(6), ITXTCO )
      CALL DRWTXT ('by', IXCPOS (6)+20,IYCPOS(7), ITXTCO )
      CALL DRWTXT ('Ashley Ibbett', IXCPOS (2),IYCPOS(8), ITXTCO )
      CALL DRWTXT ('ALT+ENTER=', IXCPOS(3) ,IYCPOS(11), ITXTCO )
      CALL DRWTXT ('Toggle full', IXCPOS(3), IYCPOS(12), ITXTCO )
      CALL DRWTXT ('screen mode.', IXCPOS(3), IYCPOS(13), ITXTCO )
      CALL DRWTXT ('/=UP', IXCPOS(3), IYCPOS(14), ITXTCO )
      CALL DRWTXT ('\=DOWN', IXCPOS(3),IYCPOS(15), ITXTCO )
      CALL DRWTXT ('1-9=HIDE LEVEL', IXCPOS(2), 
     2               IYCPOS(23), ITXTCO )
      CALL DRWTXT ('N & BELOW', IXCPOS(3), IYCPOS(24), ITXTCO )
      CALL DRWTXT ('0=RESET', IXCPOS(3), IYCPOS(25), ITXTCO )
      CALL DRWTXT ('SPACE', IXCPOS(3),IYCPOS(26), ITXTCO )
      CALL DRWTXT ('TO',IXCPOS(6),IYCPOS(27), ITXTCO )
      CALL DRWTXT ('END',IXCPOS(5),IYCPOS(28), ITXTCO )
      CALL DRWTXT ('D=CONTOUR',IXCPOS(3), IYCPOS(22), ITXTCO )
      RETURN
      END
C
      SUBROUTINE XTITL2 
C DRAWS UP THE TITLES FOR THE CONTOUR SECTION
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
#include "CONCOM.INC"
c      #include 'concom.cmn'
      CALL DRWTXT ('LOWEST', IXCPOS(8),IYCPOS(1), ITXTCO )
      CALL DRWTXT ('HIGHEST', IXCPOS(8), IYCPOS(29), ITXTCO )
      CALL DRWTXT ('CONTOUR', IXCPOS(2), IYCPOS(5), ITXTCO )
      CALL DRWTXT ('MAP', IXCPOS(5),IYCPOS(6), ITXTCO )
      RETURN
      END
C
      SUBROUTINE BEEP
C MAKES THE COMPUTER BEEP
&DOS      CALL BEEP@
      RETURN
      END
C
      SUBROUTINE SWPCOL
&DVF      USE DFLIB
C TOGGLES B&W/COL DISPLAY
#include "CONCOM.INC"
c      #include 'concom.cmn'
&DOS      CALL CLEAR_SCREEN_AREA@ (IXCPOS(1), IYCPOS(16),
&DOS     2            IXCPOS(7), IYCPOS(18), 0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, IXCPOS(1), IYCPOS(16),
&DVF     2 IXCPOS(7), IYCPOS(18) )
      CALL DRWTXT ('C=COL', IXCPOS(3), IYCPOS(17), ITXTCO )
      RETURN
      END
C
      SUBROUTINE SWAPKY 
&DVF      USE DFLIB
C TOGGLES LOG/EXP DISPLAY
#include "CONCOM.INC"
&DOS      CALL CLEAR_SCREEN_AREA@ (IXCPOS(1), IYCPOS(19),
&DOS     2            IXCPOS(7), IYCPOS(21), 0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, IXCPOS(1), IYCPOS(19),
&DVF     2 IXCPOS(7), IYCPOS(21) )
      IF (ILOGFL.EQ.0) THEN
         CALL DRWTXT ('L=LOG', IXCPOS(3), IYCPOS(20), ITXTCO )
      ELSE
         CALL DRWTXT ('N=NORM', IXCPOS(3), IYCPOS(20), ITXTCO )
      ENDIF
      RETURN
      END
C
      SUBROUTINE MSG
&DVF      USE DFLIB
C PRINTS UP A WAIT MESSAGE
&DVF      USE DFLIB
#include "CONCOM.INC"
&DVF      TYPE (xycoord) xy

&DOS      CALL DRAW_TEXT@ ('*WAIT*',IXCPOS(3),IYCPOS(12),IBTXCO)
&DVF      RES= SETCOLOR ( IBTXCO )
&DVF      CALL MOVETO(IXCPOS(3),IYCPOS(12),xy)
&DVF      CALL OUTGTEXT('*WAIT*')
      CALL BEEP
      RETURN
      END
C
      SUBROUTINE RMMSG
&DVF      USE DFLIB
C REMOVES MESSAGE
#include "CONCOM.INC"
&DOS      CALL CLEAR_SCREEN_AREA@ (IXCPOS(1), IYCPOS(11),
&DOS     2          IXCPOS(7), IYCPOS(13), ICOL (1))
&DVF      RES= SETCOLOR ( ICOL(1) )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, IXCPOS(1), IYCPOS(11),
&DVF     2 IXCPOS(7), IYCPOS(13) )
      RETURN
      END
C
      SUBROUTINE MSG2
C PUTS MESSAGE ON SCREEN
#include "CONCOM.INC"
      CALL DRWTXT ('PRESS',IXCPOS(4),IYCPOS(14), ITXTCO)
      CALL DRWTXT ('A KEY',IXCPOS(4), IYCPOS(15),ITXTCO)
      CALL DRWTXT ('TO', IXCPOS(6), IYCPOS(17),ITXTCO)
      CALL DRWTXT ('RETURN',IXCPOS(3),IYCPOS(20),ITXTCO)
      CALL DRWTXT ('H=HARDCOPY',IXCPOS(3),IYCPOS(25), ITXTCO)
      RETURN
      END      
C      
      SUBROUTINE RMMSG2 
C REMOVES MESSAGE
&DVF      USE DFLIB
#include "CONCOM.INC"
&DOS      CALL CLEAR_SCREEN_AREA@ (IXCPOS(1), IYCPOS(13),
&DOS     2          IXCPOS(7), IYCPOS(23), ICOL (1))
&DVF      RES= SETCOLOR ( ICOL(1) )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, IXCPOS(1), IYCPOS(13),
&DVF     2 IXCPOS(7), IYCPOS(23) )
      RETURN
      END
C
      SUBROUTINE DRAWNUM (CTXT, IX1, IY1, ITCOL )
C DRAWS NUMBERS ON KEY
&DVF      USE DFLIB
#include "CONCOM.INC"
&DVF      TYPE (xycoord) xy
      INTEGER*2 IX1, IY1
      INTEGER*4 ITCOL, ILEN
      CHARACTER*2 CTXT
      ILEN = 2
&DOS      CALL DRAW_TEXT@ (CTXT, IX1, IY1, ITCOL)
&DVF      RES= SETCOLOR ( ITCOL )
&DVF      CALL MOVETO(IX1,IX2,xy)
&DVF      CALL OUTGTEXT(CTXT)
      RETURN
      END
C
      SUBROUTINE COLSCR
C RESETS THE SCREEN TO COLOUR
#include "CONCOM.INC"
      RETURN
      END
C
      SUBROUTINE REFRSH 
C REFRESHES THE WINDOW
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
#include "CONCOM.INC"
c      #include 'concom.cmn'
C      CALL WINSET (ISCRN)
C      CALL COLOR (BLACK)
C      CALL CLEAR
C      CALL COLSCR 
      CALL XCOLKY 
      CALL TITLES 
      CALL SWAPKY 
      CALL SWPCOL
      RETURN
      END
C
      SUBROUTINE SGCOLS
C SETS UP THE COLOURS ON THE SG
C ##include <gl/fgl.h>
C ##include <gl/fdevice.h>
#include "CONCOM.INC"
c      #include 'concom.cmn'
      INTEGER*4 I, R, G, B, J
      INTEGER*4 ITEMP (32)
      DATA ITEMP/0, 0, 0, 0, 1, 255, 0, 0, 2,
     +  0, 255, 0, 3, 255, 255, 0, 4, 0, 0, 255,
     +  5, 255, 0, 255, 6, 0, 255, 255, 7, 255,
     +  255, 255/
      DO 400 J = 1, 32, 4
C           CALL MAPCOL (ITEMP(J), ITEMP(J+1),
C     +          ITEMP(J+2), ITEMP(J+3))
400   CONTINUE
      I = 8
      R = 170
      G = 0
      B = 0
C      CALL MAPCOL (I, R, G, B)
      I = 9
      R = 255
      G = 127
      B = 0
C      CALL MAPCOL (I, R, G, B)
      I = 10
      R = 127
      G = 255
      B = 0
C      CALL MAPCOL (I, R, G, B)
      I = 11
      R = 0
      G = 255
      B = 127
C      CALL MAPCOL (I, R, G, B)
      I = 12
      R = 0
      G = 127
      B = 255
C      CALL MAPCOL (I, R, G, B)
      I = 13
      R = 127
      G = 0
      B = 255
C      CALL MAPCOL (I, R, G, B)
      I = 14
      R = 100
      G = 100
      B = 100
C      CALL MAPCOL (I, R, G, B)
      I = 15
      R = 200
      G = 200
      B = 200
C      CALL MAPCOL (I, R, G, B)
      RETURN
      END
C
      SUBROUTINE DRWLIN (X1, Y1, X2, Y2, NPH, NPV, ITCOL)
C DRAWS A LINE BETWEEN THE SPECIFIED POINTS
&DVF      USE DFLIB
#include "CONCOM.INC"
&DVF      TYPE (xycoord) xy
&DVF      INTEGER*2 RES
      REAL X1, X2, Y1, Y2, XTEMPV, XTEMPH
      INTEGER*2 IX1, IX2, IY1, IY2, ITCOL
C      INTEGER*2 IPT1(2), IPT2(2)
      INTEGER*4 NPH, NPV, ITCOL2
      XTEMPV = RYSIZ/NPH
      XTEMPH = RYSIZ/NPV
      IF (XTEMPV.LT.XTEMPH) THEN
            IX1 = NINT (X1 * XTEMPV)
            IX2 = NINT (X2 * XTEMPV)
            IY1 = NINT (Y1 * XTEMPV)
            IY2 = NINT (Y2 * XTEMPV)
      ELSE
            IX1 = NINT (X1 * XTEMPH)
            IX2 = NINT (X2 * XTEMPH)
            IY1 = NINT (Y1 * XTEMPH)
            IY2 = NINT (Y2 * XTEMPH)
      ENDIF
&DOS      CALL DRAW_LINE@ (IY1, IX1, IY2, IX2, ITCOL)
&DVF      RES= SETCOLOR ( ITCOL )
&DVF      CALL MOVETO(IY1,IX1,xy)
&DVF      RES= LINETO(IY2, IX2)
      RETURN
      END
C
      SUBROUTINE XGTSCL
C WORKS OUT THE SCALING FOR THE VGA SCREEN
#include "CONCOM.INC"
c      REAL RXSCAL, RYSCAL
      RXSCAL = RYSIZ/NUM(2)
      RYSCAL = RYSIZ/NUM(1)
      IF (RXSCAL.LT.RYSCAL) THEN
            RYSCAL = RXSCAL     
      ELSE
            RXSCAL = RYSCAL
      ENDIF
      RETURN
      END
C
      SUBROUTINE CLRSCR 
C CLEARS THE SCREEN
&DVF      USE DFLIB
&DVF      INTEGER*2 RES
#include "CONCOM.INC"
&DOS      CALL CLEAR_SCREEN_AREA@(0,0,NINT(RXSIZ),NINT(RYSIZ),0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, 0, 0,NINT(RXSIZ),NINT(RYSIZ))
      RETURN
      END
C
      SUBROUTINE CONLIN (X1, Y1, X2, Y2, NPH, NPV, ITCOL)
C DRAWS A LINE BETWEEN THE SPECIFIED POINTS
&DVF      USE DFLIB
&DVF      TYPE (xycoord) xy
&DVF      INTEGER*2 RES
#include "CONCOM.INC"
c      #include 'concom.cmn'
      REAL X1, X2, Y1, Y2, XTEMPV, XTEMPH
      INTEGER*2 IX1, IX2, IY1, IY2
C      INTEGER*2 IPT1(2), IPT2(2)
      INTEGER*4 NPH, NPV, ITCOL
      XTEMPV = RYSIZ/NPH
      XTEMPH = RYSIZ/NPV
      IF (XTEMPV.LT.XTEMPH) THEN
            IX1 = NINT (X1 * XTEMPV)
            IX2 = NINT (X2 * XTEMPV)
            IY1 = NINT (Y1 * XTEMPV)
            IY2 = NINT (Y2 * XTEMPV)
      ELSE
            IX1 = NINT (X1 * XTEMPH)
            IX2 = NINT (X2 * XTEMPH)
            IY1 = NINT (Y1 * XTEMPH)
            IY2 = NINT (Y2 * XTEMPH)
      ENDIF
      IF (IDEVIC.EQ.2) THEN
           CALL PSCOLI (IX2, IY2)
           RETURN
      ENDIF
&DOS      CALL DRAW_LINE@ (IY1, IX1, IY2, IX2, ITCOL)
&DVF      RES= SETCOLOR ( ITCOL )
&DVF      CALL MOVETO(IY1,IX1,xy)
&DVF      RES= LINETO(IY2, IX2)
      RETURN
      END
C
      SUBROUTINE STALIN (X1, Y1, X2, Y2, NPH, NPV, ITCOL,
     +                     ICOLNM, D, NC)
C DRAWS A LINE BETWEEN THE SPECIFIED POINTS
&DVF      USE DFLIB
&DVF      TYPE (xycoord) xy
&DVF      INTEGER*2 RES
#include "CONCOM.INC"
      REAL X1, X2, Y1, Y2, XTEMPV, XTEMPH, D(NC)
      INTEGER*2 IX1, IX2, IY1, IY2
C      INTEGER*2 IPT1(2), IPT2(2)
      INTEGER*4 NPH, NPV, ITCOL, ICOLNM, NC
      XTEMPV = RYSIZ/NPH
      XTEMPH = RYSIZ/NPV
      IF (XTEMPV.LT.XTEMPH) THEN
            IX1 = NINT (X1 * XTEMPV)
            IX2 = NINT (X2 * XTEMPV)
            IY1 = NINT (Y1 * XTEMPV)
            IY2 = NINT (Y2 * XTEMPV)
      ELSE
            IX1 = NINT (X1 * XTEMPH)
            IX2 = NINT (X2 * XTEMPH)
            IY1 = NINT (Y1 * XTEMPH)
            IY2 = NINT (Y2 * XTEMPH)
      ENDIF
      IF (IDEVIC.EQ.2) THEN
          CALL PSBGLI (IX2, IY2, ITCOL, ICOLNM, D, NC)
          RETURN
      ENDIF
&DOS      CALL DRAW_LINE@ (IY1, IX1, IY2, IX2, ITCOL)
&DVF      RES= SETCOLOR ( ITCOL )
&DVF      CALL MOVETO(IY1,IX1,xy)
&DVF      RES= LINETO(IY2, IX2)
      RETURN
      END
C



CODE FOR ZTXT
      SUBROUTINE ZTXT ( CTEXT , CPRMPT)
C THIS ROUTINE READS IN THE TEXT ONE CHARACTER AT A TIME AND WRITES IT
C OUT IN AN APPROPRIATE PLACE. DELETION IS ALSO ALLOWED
C Is 'deletion' a real word?
&DVF      USE DFLIB
&DVF      INTEGER*2 RES
#include "CONCOM.INC"
      INTEGER IX1,IPL
      CHARACTER*(*) CTEXT
      CHARACTER*(*) CPRMPT
      INTEGER*2 kk, ix,iy
&DOS      #include <WINDOWS.INS>

C Calculate length of prompt string
      IPL=0
      DO 5 I=1,LEN(CPRMPT)
5       IF(CPRMPT(I:I).NE.' ')IPL=I
      DO 7 I=1,LEN(CTEXT)
7       CTEXT(I:I) = ' '
      ITC = 0
      IX1 = IPL*8
      IY = 480
      ix = 0
&DOS      CALL CLEAR_SCREEN_AREA@(0,IY,640,490,0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, 0,IY,640,490)
      CALL DRWTXT(CPRMPT(1:IPL),ix,IY,15)

10    CONTINUE
      CALL GETKEY(KK,1)
      IF (KK.EQ.13) THEN                          !  THIS IS RETURN
&DOS          CALL CLEAR_SCREEN_AREA@(0,IY,640,490,0)
&DVF          RES= SETCOLOR ( 0 )
&DVF          RES= RECTANGLE ($GFILLINTERIOR, 0,IY,640,490)
          ix = 10
          CALL DRWTXT('Working ',ix,iy,15)
&DOS          CALL TEMPORARY_YIELD@
          RETURN
      ELSE IF ((KK.EQ.8).AND.(ITC.GT.0)) THEN     !  THIS IS DELETE
&DOS          call CLEAR_SCREEN_AREA@(IX1,IY,IX1+8,IY+15,0)
&DVF          RES= SETCOLOR ( 0 )
&DVF          RES= RECTANGLE ($GFILLINTERIOR, IX1,IY,IX1+8,IY+15)
          CTEXT(ITC:ITC) = ' '     
          ITC = ITC - 1
          IX1 = IX1 - 8
      ELSE IF ((IX1.LT.632).AND.(ITC.LT.LEN(CTEXT))) THEN 
          ITC = ITC + 1
          CTEXT(ITC:ITC) = CHAR(KK)
          IX1 = IX1 + 8
          CALL DRWTXT(CTEXT(ITC:ITC),IX1,IY,15)
      ENDIF
      GOTO 10
                                    
      END


CODE FOR ZMSG
      SUBROUTINE ZMSG ( CTEXT )
&DVF      USE DFLIB
&DVF      INTEGER*2 RES
      integer *2 ix,iy
      CHARACTER*(*) CTEXT
&DOS      #include <WINDOWS.INS>

      IY = 480
      ix = 1

&DOS      CALL CLEAR_SCREEN_AREA@(0,IY,640,490,0)
&DVF      RES= SETCOLOR ( 0 )
&DVF      RES= RECTANGLE ($GFILLINTERIOR, 0,IY,640,490)
      CALL DRWTXT(CTEXT,ix,IY,15)
&DOS      CALL TEMPORARY_YIELD@

      RETURN
      END
CRYSTALS CODE FOR DRWPLOT
C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:38  rich
C New CRYSTALS repository
C
C Revision 1.5  2003/07/23 10:47:37  djw
C CONTOUR - try to trap other MT file errors
C
C Revision 1.4  2003/07/23 10:40:52  djw
C CONTOUR - try formatted read before unformatted
C
C Revision 1.3  2003/01/17 12:16:35  rich
C New version of contour, uses compaq compiler and graphics libraries.
C
C Revision 1.2  2001/01/30 12:27:36  CKP2
C try to fix irregularities at edges
C
C Revision 1.1  2000/08/09 13:39:51  CKP2
C All of CONTOUR
C
C Revision 1.3  1999/11/02 17:29:57  ckp2
C RIC: Removed carriage returns
C
      SUBROUTINE READER 
C READS IN THE DATA FROM THE BINARY FILE
C LEAVING GAPS FOR THE NEW POINTS TO BE CREATED
C
C      #include 'concom.cmn'
#include "CONCOM.INC"
      CHARACTER CFILE*80, CZAP*4
      CHARACTER CMNAM*80
      LOGICAL LEXIST
      INTEGER*4 I, J, K, POINT
      REAL TEMP(5000)
      POINT = 1
      CFILE = ' '
10    CONTINUE

C GET NAME OF FILE AND CHECK IT EXISTS

C      WRITE (IOUTSC, '(a20,$)') 'Name of input file? '
C      READ  (INPDEV, '(A80)') CFILE
&DOS      CFILE = CMNAM()
&DVF      CALL GetArg(1,cfile,optlen)

      IF(CFILE(1:1).EQ.' ') THEN
        CALL ZTXT(CFILE,'Name of input file?')
      ENDIF
11    CONTINUE
      INQUIRE (FILE=CFILE, EXIST=LEXIST)
      IF ( .NOT. LEXIST ) THEN
        CALL ZTXT(CFILE,'File not found. Name of input file:')
        GOTO 11
      ENDIF


c
CRICjul99>> allow reading from a normal formatted file
C           then try unformatted file
c
      CALL ZMSG ('Reading in data from ASCII file.')
C OPEN THE FILE AND READ IN DATA
C
      OPEN(UNIT = MT1, FILE = CFILE, STATUS = 'OLD',ERR=250)
110   FORMAT (A)
111   FORMAT (F15.0)
112   FORMAT (I8)
      READ (MT1,110,ERR=200) CZAP    !Info, down, across and section
      READ (MT1,110,ERR=200) CZAP    !Trans
      DO I = 1, 9
          READ (MT1,111,ERR=200) TRANS (I)
      END DO
      READ (MT1,110,ERR=200) CZAP    !Plane trans
      READ (MT1,110,ERR=200) CZAP    !Plane trans
      READ (MT1,110,ERR=200) CZAP    !Plane trans
      READ (MT1,110,ERR=200) CZAP    !Cell
      DO I = 1, 6
          READ (MT1,111,ERR=200) CELL (I)
      END DO
      READ (MT1,110) CZAP    !L14
      DO I = 1, 12
          READ (MT1,111,ERR=200) SECT (I)
      END DO
      READ (MT1,110) CZAP    !Size
      DO I = 1, 3
          READ (MT1,112,ERR=200) NUM (I)
      END DO
 
      DO I = 1, NUM (3)
            READ (MT1,110,ERR=200) CZAP  !BLOCK
            READ (MT1,112,ERR=200) NYNZ(I)  !Block size
            DO J = L81, L81+NYNZ(I)-1
                  READ (MT1,111,ERR=200) TEMP(J)  !Data
            END DO
            DO J = 1, NUM(1)
                  DO K = 1, NUM(2)
C CLEVER LITTLE LOOP TO LEAVE GAPS IN FSTORE!
                        FSTORE (POINT) = TEMP ((J-1)*NUM(2)+K)
                        POINT = POINT + 2
                  END DO
                  POINT = POINT + (2*NUM(2))
            END DO
      END DO
      L81 = L81 + NUM(1)*NUM(2)*NUM(3)
      NUM(1) = NUM(1)*2
      NUM(2) = NUM(2)*2
      goto 300



c 
250   continue
      CLOSE (MT1)
      CALL ZMSG ('Try reading in unformatted data')
      OPEN(UNIT = MT1, FILE = CFILE, STATUS = 'OLD',
     +     FORM  = 'UNFORMATTED', ERR=150)
      REWIND (MT1)
C      READ (MT1) (NUM(I),I=1,3), (IXYZ(I),I=1,3)
      READ (MT1,ERR=100) CZAP
C      write (6,*) czap
      READ (MT1,ERR=100) CZAP, (TRANS (I), I=1,9)
C      write (6,*) CZAP, TRANS
      READ (MT1,ERR=100) CZAP, (CELL (I), I=1,6)
C      write (6,*) czap, cell
      READ (MT1) CZAP, (SECT (I), I=1,12)
C      write (6,*) czap, sect
      READ (MT1) CZAP, (NUM (I), I=1,3)
C      write (6,*) czap, num
      DO 20 I = 1, NUM (3)
C PUT THE DATA IN A TEMPORARY ARRAY
            READ (MT1) NYNZ(I), (TEMP(J), J=L81, (L81 +
     +             NYNZ(I) -1 ))
            DO 30 J = 1, NUM(1)
                        FSTORE (POINT) = TEMP ((J-1)*NUM(2)+K)
                        POINT = POINT + 2
40                CONTINUE
                  POINT = POINT + (2*NUM(2))
30          CONTINUE
20    CONTINUE
      L81 = L81 + NUM(1)*NUM(2)*NUM(3)
      NUM(1) = NUM(1)*2
      NUM(2) = NUM(2)*2
      CLOSE (MT1)
      goto 300
c
100   CONTINUE
150   continue
200   continue
      call zmsg('Unidentified failure during read MT read')
      stop
c
300   continue
      CLOSE (MT1)
      RETURN
      END
C
C
C
      SUBROUTINE SORTER
C WORKS OUT THE MAX AND MIN VALUES
C IF REQUIRED
C
C      #include 'concom.cmn'
#include "CONCOM.INC"
      REAL RMINIT
      RMINIT = 100000.0
C      WRITE (IOUTSC,*) 'SORTING DATA'
      CALL ZMSG('Sorting data')
      DO 50 I = 1, NUM(1)*NUM(2)*NUM(3)
            IF (FSTORE(I).LT.RMINIT) THEN
                  RMINIT = FSTORE(I)
            ENDIF
50    CONTINUE
            DO 60 I = 1, NUM(1)*NUM(2)*NUM(3)
C                  FSTORE(I) = FSTORE(I)-RMINIT+1
                  IF (FSTORE(I).GT.RMAXIM) THEN
                        RMAXIM = FSTORE(I)
                  ELSE IF (FSTORE(I).LT.RMINIM) THEN
                        RMINIM = FSTORE(I)
                  ENDIF
60    CONTINUE
      FACTOR = (RMAXIM - RMINIM) / NLEVEL
      RETURN
      END
C
C
      SUBROUTINE PLOTMA
C PLOTS THE MAP ON THE SCREEN
C
c      #include 'concom.cmn'
#include "CONCOM.INC"
      REAL RCUR, GSTORE (499999)
      INTEGER*4 I, J, K, INEPT, IPOSN
      INTEGER*2 IX1, IX2, IY1, IY2, KEY
      ISPOSN = 1
      LEVEL = 0
      CALL XGTSCL
      CALL XCOLKY
      CALL TITLES
      CALL SWAPKY
      CALL SWPCOL
70    CONTINUE
      IFLAG = 0
C
C NESTED DO LOOPS READ THE DATA IN THE RIGHT ORDER
C
      DO 80 INEPT = 1 + NUM(1)*NUM(2)*LEVEL,
     +              1 + NUM(1)*NUM(2)*(LEVEL+1), NUM(1)*NUM(2)+1
         DO 90 I = 1, (NUM(1)*NUM(2)) - NUM(2) , NUM(2)
            DO 100 J = 1, NUM(2) 
                  DO 110 K = 1, 16 
                        RCUR = RMINIM + (FACTOR*(K-1))
                        IF (FSTORE(INEPT+I+J-2).GT.RCUR) THEN
                              IPOSN = K
                        ENDIF
110               CONTINUE
            GSTORE(INEPT+I+J-2) = IPOSN
            IX1 = NINT (RXSCAL*(I/NUM(2)))
            IX2 = NINT (IX1+RXSCAL)
            IY1 = NINT (RYSCAL*(J-1))
            IY2 = NINT (IY1+RYSCAL)
            IF ((GSTORE(INEPT+I+J-2).GT.GSTORE(INEPT
     + +I+J-2-(NUM(1)*NUM(2)))).AND.(IFLAG.NE.0))
     +         THEN
                  CALL DRWREC (IX1, IY1, IX2, 
     +            IY2, IPOSN)
            ELSE IF (IFLAG.NE.0) THEN
                 GSTORE(INEPT+I+J-2) = GSTORE(INEPT
     +                 +I+J-2-(NUM(1)*NUM(2)))
            ELSE IF ((IFLAG.EQ.0).AND.(IPOSN.GT.ISPOSN)) THEN
                  CALL DRWREC (IX1, IY1, IX2, 
     +            IY2, IPOSN )
            ELSE IF (IPOSN.LE.ISPOSN) THEN
                  CALL DRWREC (IX1, IY1, IX2, 
     +            IY2, 1 )
            END   IF
100         CONTINUE
90       CONTINUE
      IFLAG= 1
80    CONTINUE
85    continue
C
C CHOOSE WHAT TO DO NEXT
C
      CALL MOVER (KEY)
      IF ((KEY.EQ.32).OR.(KEY.EQ.27).OR.(KEY.EQ.81)) THEN
            GOTO 130
      ELSEIF ((KEY.EQ.66).AND.(ICOLFL.EQ.1)) THEN
            CALL GREYSCAL (ICOL)
            ICOLFL = 0
            CALL SWPCOL
cdjwdev2000            GOTO 80
            GOTO 85
      ELSEIF ((KEY.EQ.67).AND.(ICOLFL.EQ.0)) THEN
            CALL COLSCR 
            CALL XCOLKY                                      
            CALL TITLES 
            ICOLFL = 1
            CALL SWPCOL
            CALL SWAPKY 
            GOTO 70
      ELSEIF ((KEY.EQ.76).AND.(ILOGFL.EQ.0)) THEN
            CALL TKLOGS 
            GO TO 70
      ELSEIF ((KEY.EQ.78).AND.(ILOGFL.EQ.1)) THEN
            CALL TKLOGS 
            GO TO 70
      ELSEIF (KEY.EQ.1) THEN
            CALL REFRSH 
            GO TO 70
      ELSEIF (KEY.EQ.68) THEN
            CALL XCNTOR 
            CALL REFRSH 
            GO TO 70
      ELSE
            GO TO 70
      ENDIF
130   CONTINUE
      CALL NORMAL
      RETURN
      END      
C
C
      SUBROUTINE MOVER ( KEY )
C WAITS FOR A KEY PRESS, IF LEVEL CHANGE IS CALLED FOR
C TAKES ACTION OR ELSE RETURNS THE VALUE OF KEY.
C
#include "CONCOM.INC"
c      #include 'concom.cmn'
&DOS      #include <WINDOWS.INS>
      INTEGER*2 KEY
140   CONTINUE
&DOS      CALL TEMPORARY_YIELD@
      CALL GETKEY ( KEY , 0 )
C
C CAPITALIZE THE LETTER
C
      CALL UPCASE (KEY)
C
C CHECK THAT THE KEY IS ALLOWED
C
      IF ((KEY.NE.92).AND.(KEY.NE.47).AND.(KEY.NE.32).AND.
     +   (KEY.NE.66).AND.(KEY.NE.67).AND.(KEY.NE.76)
     +   .AND.(KEY.NE.78).AND.(KEY.NE.1).AND.
     +   (KEY.NE.68).AND.((KEY.LT.48).OR.(KEY.GT.57))
     +   .AND.(KEY.NE.27).AND.(KEY.NE.81))
     +   GO TO 140
C
C NOW TAKE APPROPRIATE ACTION
C
      IF (KEY.EQ.47) THEN
            LEVEL = LEVEL + 1
      ELSEIF (KEY.EQ.92) THEN
            LEVEL = LEVEL - 1
      ENDIF
      IF (LEVEL.LT.0) THEN
            LEVEL = 0 
      ELSEIF (LEVEL.GE.NUM(3)) THEN
            LEVEL = NUM(3) - 1
            GO TO 140
      ELSEIF ((KEY.GT.48).AND.(KEY.LE.57)) THEN
            ISPOSN = KEY - 47
      ELSEIF (KEY.EQ.48) THEN
            ISPOSN = 1
      ENDIF
      RETURN
      END     
C
C
      SUBROUTINE SPLIT 
C CALCULATES NEW VALUES OF ELECTRON DENSITY TO INCREASE RESOLUTION
C EACH POINT IS SPLIT INTO FOUR BY COMPARISON WITH ITS NEIGHBOURS
c      #include 'concom.cmn'
#include "CONCOM.INC"
      character *32 ctemp
      INTEGER*4 I, J, IPOINT
      IPOINT = 0
C      WRITE(IOUTSC,*) 'CREATING NEW VALUES'
      CALL ZMSG('Interpolating points')
      DO 150 J = 1, NUM(1) * NUM(3)
      DO 160 I = 1, NUM(2), 2
            FSTORE( IPOINT + NUM(2) + I) = 
     + (FSTORE(I+IPOINT) + FSTORE ( ( (2*NUM(2))+I+IPOINT)))/2
160   CONTINUE
      IPOINT = IPOINT + 2*NUM(2)
150   CONTINUE
      DO 170 I = 1, NUM(1) * NUM(2) * NUM(3), NUM(2)
            DO 180 J = 1, NUM(2)-1 , 2
                  FSTORE (I+J) = (FSTORE(I+J-1)+FSTORE(I+J+1))/2
180   CONTINUE
170   CONTINUE
      RETURN
      END
C
      SUBROUTINE TKLOGS 
C TAKES LOGS/EXPONENTIALS OF VALUES
c      #include 'concom.cmn'
#include "CONCOM.INC"
      INTEGER*4 I
      REAL RTEMP1, RTEMP2, RTEMP3
      RMINIM = 100000.0
      RMAXIM = -100000.0
      CALL MSG
      DO 230 I = 1, NUM(1)*NUM(2)*NUM(3)
            IF (ILOGFL.EQ.1) THEN
                  RTEMP1 = ABS (FSTORE(I))
                       RTEMP2 = EXP (RTEMP1)
                       RTEMP3 = SIGN (RTEMP2, FSTORE(I))
                       FSTORE (I) = RTEMP3
            ELSE IF (ILOGFL.EQ.0) THEN
                  RTEMP1 = ABS (FSTORE(I))
                      IF (RTEMP1.LT.1.) THEN
                        FSTORE(I) = 0.
                      ELSE
                        RTEMP2 = LOG (RTEMP1)
                        RTEMP3 = SIGN (RTEMP2, FSTORE(I))
                        FSTORE(I) = RTEMP3
                      ENDIF
            ENDIF
            IF (FSTORE(I).GT.RMAXIM) THEN
                  RMAXIM = FSTORE(I)
            ELSE IF (FSTORE(I).LT.RMINIM) THEN
                  RMINIM = FSTORE(I)
            ENDIF
230   CONTINUE
      FACTOR = (RMAXIM - RMINIM) / NLEVEL
      IF (ILOGFL.EQ.0) THEN
            ILOGFL = 1
      ELSE
            ILOGFL = 0
      ENDIF
      CALL SWAPKY 
      CALL RMMSG 
      RETURN
      END
C
      SUBROUTINE UPCASE ( KEY )
C IF A LOWER CASE KEY IS PRESSED, CAPITALIZE IT
      INTEGER*2 KEY
      IF ( KEY.GT.97 ) THEN 
            KEY = KEY - 32
      ENDIF
      RETURN
      END

      SUBROUTINE UCASE ( CLOWER )
C
C -- CONVERT STRING TO UPPERCASE
C
C      CLOWER      SOURCE STRING TO BE CONVERTED
C      CUPPER      RESULTANT STRING
C
C
      CHARACTER*(*) CLOWER
C
      CHARACTER*26 CALPHA , CEQUIV
C
      DATA CALPHA / 'abcdefghijklmnopqrstuvwxyz' /
      DATA CEQUIV / 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' /
C
C
C
      LENGTH = LEN ( CLOWER ) 
C
C -- SEARCH FOR LOWERCASE CHARACTERS AND CONVERT TO UPPERCASE
      DO 2000 I = 1 , LENGTH
        IPOS = INDEX ( CALPHA , CLOWER(I:I) )
        IF ( IPOS .GT. 0 ) CLOWER(I:I) = CEQUIV(IPOS:IPOS)
2000  CONTINUE

      RETURN
      END
