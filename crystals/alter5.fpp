C $Log: not supported by cvs2svn $
C
CODE FOR ALTER5
      SUBROUTINE ALTER5
      CALL XSYSDC(-1,1)
      CALL XMODL5
      RETURN
      END
C
CODE FOR XMODL5
      SUBROUTINE XMODL5
C--SUBROUTINE TO MODIFY THE CONTENTS OF LIST 5.
C
\XUNITS
\XERVAL
&PPC\XGSTOP
C
C--
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
      GO TO ( 2000, 3000, 4000, 8000, 8100, 8200, 5000,
     2 6000, 9910 ) , NUM
      GO TO 9910
C
C--ROUTINES TO MODIFY LIST 5
2000  CONTINUE
      CALL XMOD05
      GO TO 1000
C
C--ROUTINE TO CONVERT ANISO TEMPERATORE FACTORS.
3000  CONTINUE
      CALL XBUC
      GO TO 1000
C
C--ROUTINE TO GENERATE HYDROGEN ATOMS
4000  CONTINUE
      CALL SYDROG
      GO TO 1000
C
C----- PERHYDRO COMMAND
5000  CONTINUE
      CALL XPERHY
      GOTO 1000
C
C----- VOIDS COMMAND
6000   CONTINUE
      CALL XVOID
      GOTO 1000
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
&PPC      GO TO 1000
&PPCCS***
&PPC      ENDIF
&PPCCE***
C
C--'#TITLE' INSTRUCTION
8100  CONTINUE
      CALL XRCN
      GO TO 1000
C --
8200  CONTINUE
C -- 'REGULARISE' INSTRUCTION
      CALL XREGUL
      GO TO 1000
C
9910  CONTINUE
      CALL XERHND ( IERPRG )
      GO TO 1000
C
      END
C
