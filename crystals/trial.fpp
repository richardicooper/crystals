C $Log: not supported by cvs2svn $
C Revision 1.4  2000/12/05 12:44:42  CKP2
C make SLANT into subroutine
C
C Revision 1.3  2000/10/31 15:38:04  ckp2
C Link to XVSLANT code.
C
CODE FOR TRIAL
      SUBROUTINE TRIAL
      CALL XSYSDC(-1,1)
      CALL XTRLC
      RETURN
      END
C
CODE FOR XTRLC
      SUBROUTINE XTRLC
C--SLANT FOURIER AND TRIAL MAP CONTROL ROUTINE
C*******************************************************
C
C              Maximise THE PEARSON CORRELATION COEFF
C
C    r = [SIG{(Fo-<Fo>)(Fc-<Fc>)}] / [SIG(Fo-<Fo>)**2. SIG(Fc->Fc>)**2]
C         all coefficients are moduli
C
C--
C      ST UP A DUMMY ARRAY SO THAT XSLANT CAN BE CALLED INTERNALLY
      DIMENSION ADJW(1), IDJW(1)
      EQUIVALENCE (ADJW(1), IDJW(1))
\ISTORE
C
\STORE
\XUNITS
\XLST50
C
\QSTORE
C
C--LOAD THE NEXT '#INSTRUCTION'
1000  CONTINUE
      NUM=KNXTOP(LSTOP,LSTNO,ICLASS)
C--CHECK IF WE SHOULD RETURN
      IF(NUM)1100,1100,1200
1100  CONTINUE
      RETURN
C--BRANCH ON THE TYPE OF OPERATION
1200  CONTINUE
      GOTO (2100,2200,2300,1500),NUM
C1500  STOP 413
1500  CALL GUEXIT(413)
C
C--'#TRIAL' INSTRUCTION
2100  CONTINUE
      CALL XTRIAL
      GOTO 1000
C
C--'#SLANT' INSTRUCTION
2200  CONTINUE
      ADJW(1) = -100.
      CALL XSLANT(IDJW,1)
      GOTO 1000

C--'#VSLANT' INSTRUCTION
2300  CONTINUE
      CALL XVSLANT
      GOTO 1000
      END
C
