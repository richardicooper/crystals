CODE FOR ANISO
      SUBROUTINE ANISO
      CALL XSYSDC(-1,1)
      CALL XANISO
      RETURN
      END
C
CODE FOR XANISO
      SUBROUTINE XANISO
C--CONTROL ROUTINE FOR ANISO CALCULATIONS
C
C--
C
\XUNITS
&PPC\XGSTOP
C--LOAD THE NEXT '#INSTRUCTION'
1000  CONTINUE
      NUM=KNXTOP(LSTOP,LSTNO,ICLASS)
C--CHECK IF WE SHOULD RETURN
      IF(NUM)1100,1100,1200
1100  CONTINUE
      RETURN
C--BRANCH ON THE TYPE OF OPERATION
1200  CONTINUE
      GO TO (2000,3000,8000,8100,1300),NUM
1300  STOP 343
C
C--COMPUT THE COMPONENTS AND COSINES FROM THE ANISO T.F.'S
2000  CONTINUE
      CALL XPRAXI( -1, -1, 0, J, K, L, 2, 0)
      GO TO 1000
C
C--TLS CALCULATIONS
3000  CONTINUE
      CALL RSUB06
      GO TO 1000
C
C--'#END' INSTRUCTION
8000  CONTINUE
      CALL XMONTR(-1)
      CALL XEND
&PPCCS***
&PPC      IF ( GLSTOP .EQ. 1 ) THEN
&PPC          GOTO 1100
&PPC      ELSE
&PPCCE***
      GO TO 1000
&PPCCS***
&PPC      ENDIF
&PPCCE***
C
C--'#TITLE' INSTRUCTION
8100  CONTINUE
      CALL XRCN
      GO TO 1000
      END
C
