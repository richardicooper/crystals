CODE FOR XSETMT
      SUBROUTINE XSETMT(II,IJ,IK,IL,IM,IN)
C--SET UP THE CONSTANTS REQUIRED FOR THE MATRIX ACCUMULATION
C
C--ALL THE ARGUMENTS ARE DUMMY ARGUMENTS, AND ARE USED TO MAINTAIN
C  COMPATIBILITY WITH THE MACHINE CODE VERSION OF THIS ROUTINE.
C
C--
\ISTORE
C
\STORE
\XUNITS
\XLISTI
\XLST11
      COMMON/XACC11/LW11,MW11,MDW11,NW11,LW11T
\XLST12
C
\QSTORE
C
C--SET THE NUMBER OF ELEMENTS TO BE ACCUMULATED AT ONE GO
      NW11 = 8
C--SET THE POINTER TO THE LAST BLOCK DETAIL
      M12B=L12B+(N12B-1)*MD12B
C--SET THE STACK TO HOLD THE FIRST MATRIX AND LAST DERIV ELEMENTS
      LW11=NFL
      LN=11
      IREC=1001
      MDW11=2
      MW11=KCHNFL(N12*MDW11)
C--SET UP THE AREA FOR TEMPORARY DERIV STORAGE
      IREC=1002
      LW11T=KADD11(IREC,MD11,N12+NW11)
      IF ( IERFLG .LT. 0 ) GO TO 9900
      MW11=LW11
C--SET UP THE 'DO' LOOP END VARIABLES
      M11=L11
      DO 1700 I=L12B,M12B,MD12B
      L=LW11T+ISTORE(I+1)-1
C--FIND THE ORDER OF THE CURRENT MATRIX BLOCK
      N=ISTORE(I+1)
C--LOOP OVER EACH LINE OF THE MATRIX
      DO 1600 J=LW11T,L
      ISTORE(MW11)=J+((L-J+NW11)/NW11-1)*NW11
C--SET THE FIRST ELEMENT OF THE MATRIX
      ISTORE(MW11+1)=M11
      M11=M11+N
      N=N-1
      MW11=MW11+MDW11
1600  CONTINUE
1700  CONTINUE
C -- GENERAL AND ERROR RETURN
9900  CONTINUE
      RETURN
      END
C
CODE FOR XADLHS
      SUBROUTINE XADLHS
C--ADD THE DERIVATIVES INTO THE L.H.S. OF THE NORMAL MATRIX
C
C--THE COMMON BLOCK 'XACC11' IS USED FOR THE FORTRAN MATRIX
C  ACCUMULATION ROUTINES :
C
C  LW11   ADDRESS OF THE FIRST WORD OF STACK OF 'DO' LOOP TERMINATORS
C  MDW11  NUMBER OF WORDS PER ENTRY IN THE STACK (=2)
C
C         THE ENTRIES IN THE STACK ARE :
C
C         0  THE 'DO' LOOP TERMINATOR FOR THE CURRENT PARAMETER.
C         1  THE FIRST ELEMENT IN THE MATRIX FOR THE CURRENT PARAMETER.
C
C  NW11   NUMBER OF ELEMENTS ACCUMULATED PER PASS (=4)
C  LW11T  ADDRESS OF TEMPORARY STORAGE TO BE USED FOR P.D.'S .
C
C--
\TYPE11
\ISTORE
      DIMENSION I11COM(5)
C
\STORE
\XSTR11
      COMMON /XACC11/ J11COM(5)
\XLST12
\XWORKA
C
      EQUIVALENCE (I11COM(1),LW11), (I11COM(2),MW11), (I11COM(3),MDW11)
      EQUIVALENCE (I11COM(4),NW11), (I11COM(5),LW11T)
\QSTORE
\QSTR11
C----- MOVE THE COMMON BLOCK VARIABLES INTO LOCAL
      CALL XMOVE(J11COM(1),I11COM(1),5)
C
C--LOOP OVER THE BLOCKS OF THE MATRIX
      KA=JO
      MW11=LW11
      DO 2500 I=L12B,M12B,MD12B
C--TRANSFER THE DERIVATIVES FOR THIS BLOCK TO 'LW11T' AND ADD ENOUGH BLA
      L=LW11T+ISTORE(I+1)-1
&CYBC----- VECTORISABLE CODE FOR CYBER
&CYB      N = ISTORE(I+1)
&CYBCVD$L NODEPCHK
&CYB      DO 2000 J = 0, N-1
&CYB      STR11(LW11T+J) = STORE(KA+J)
&CYB2000  CONTINUE
&CYB      KA = KA + N
&CYBC--BLANK OUT THE LAST (NW11-1) SLOTS
&CYB      DO 2010 J = L+1, L+NW11-1
&CYB      STR11(J)=0.0
&CYB2010  CONTINUE
#CYB      DO 2000 J=LW11T,L
#CYB      STR11(J)=STORE(KA)
#CYB      KA=KA+1
#CYB2000  CONTINUE
#CYBC--BLANK OUT THE LAST (NW11-1) SLOTS
#CYB      STR11(L+1)=0.
#CYB      STR11(L+2)=0.
#CYB      STR11(L+3)=0.
#CYB      STR11( L+4) = 0.
#CYB      STR11( L+5) = 0.
#CYB      STR11( L+6) = 0.
#CYB      STR11( L+7) = 0.
C--LOOP OVER THE DIFFERENT ROWS OF THE MATRIX
      DO 2300 J=LW11T,L
C--FIND THE 'DO' LOOP END VARIABLE
      M=ISTORE(MW11)
C--FIND THE MATRIX START ADDRESS
      KB=ISTORE(MW11+1)
      MW11=MW11+MDW11
C----- SET THE CONSTANT TERM
      STR11J = STR11(J)
C--LOOP OVER THE COLUMNS OF THE CURRENT ROW
&CYBC----- VECTORISABLE CODE FOR CYBER
&CYB      N = (M-J+NW11)/NW11*NW11
&CYBCVD$L NODEPCHK
&CYB      DO 2100 K = 0, N-1
&CYB      STR11(KB+K) = STR11(KB+K) + STR11J *STR11(J+K)
&CYB2100  CONTINUE
#CYBC----- DO-LOOP UNROLLING. THIS TECHNIQUE MAY DRAMATICALY SPEED UP
#CYBC----- THE ACCUMULATION ON SOME COMPILERS. THE VAX COMPILER RECOGNIS
#CYBC----- WHAT IS HAPPENING, AND PRODUCES CODE OF EQUAL SPEED FOR EITHE
#CYBC----- TECHNIQUE.
#CYB      DO 2100 K=J,M,NW11
#CYB      STR11(KB  ) = STR11(KB  ) +STR11J *STR11(K  )
#CYB      STR11(KB+1) = STR11(KB+1) +STR11J *STR11(K+1)
#CYB      STR11(KB+2) = STR11(KB+2) +STR11J *STR11(K+2)
#CYB      STR11(KB+3) = STR11(KB+3) +STR11J *STR11(K+3)
#CYB      STR11(KB+4) = STR11(KB+4) +STR11J *STR11(K+4)
#CYB      STR11(KB+5) = STR11(KB+5) +STR11J *STR11(K+5)
#CYB      STR11(KB+6) = STR11(KB+6) +STR11J *STR11(K+6)
#CYB      STR11(KB+7) = STR11(KB+7) +STR11J *STR11(K+7)
#CYB      KB=KB+NW11
#CYB2100  CONTINUE
2300  CONTINUE
2500  CONTINUE
C----- RESTORE THE COMMON BLOCK VARIABLES
      CALL XMOVE(I11COM(1),J11COM(1),5)
      RETURN
      END
C
CODE FOR XADRHS
      SUBROUTINE XADRHS(WDF)
C--ADD INTO THE R.H.S. OF THE NORMAL EQUATIONS
C
C  WDF  SQRT(W)*(/FO/ - /FC/)
C
C--
C
\TYPE11
\ISTORE
C
\STORE
\XSTR11
\XLST11
\XWORKA
C
\QSTORE
\QSTR11
C
      CALL XMOVE(WDF,DA,1)
      J=L11R
&CYBC----- VECTORISABLE CODE FOR CYBER
&CYB      N = JP - JO
&CYBCVD$L NODEPCHK
&CYB      DO 1000, I = 0, N
&CYB      STR11(J+I) = STR11(J+I) + STORE(JO+I)*DA
&CYB1000  CONTINUE
#CYB      DO 1000 I=JO,JP
#CYB      STR11(J) = STR11(J) + STORE(I)*DA
#CYB      J=J+1
#CYB1000  CONTINUE
      RETURN
      END
