CODE FOR PRCSS
      SUBROUTINE PRCSS
      CALL XSYSDC(-1,1)
      CALL XPRCLS
      RETURN
      END
C
CODE FOR XPRCLS
      SUBROUTINE XPRCLS
C--LIST PROCESSING CONTROL ROUTINES
C
\XUNITS
C--
C
C--FETCH THE NEXT '#INSTRUCTION' FROM THE INPUT STREAM
1000  CONTINUE
      NUM=KNXTOP(LSTOP,LSTNO,ICLASS)
C--CHECK IF WE SHOULD RETURN
      IF(NUM)1100,1100,1200
1100  CONTINUE
      RETURN
C--BRANCH ON THE TYPE OF OPERATION
1200  CONTINUE
      IF(LSTOP-1)1250,1250,3000
C--LIST PROCESSING
1250  CONTINUE
      GOTO (2100, 2200, 2300,1300 ),  NUM
1300  STOP 160
C
C--PROCESS LIST 12 TO PRODUCE LIST 22
2100  CONTINUE
      CALL XPRC12
      GOTO 1000
C
C--PROCESS LIST 16 TO PRODUCE LIST 26
2200  CONTINUE
      CALL XPRC16
      GOTO 1000
C
C----- PROCESS LISTS 5 AND 12 TO SET UP SPECIAL POSITION CONDITIONS
2300  CONTINUE
      CALL XSPECM
      GOTO 1000
C
C--LIST PRINTING OR PUNCHING
3000  CONTINUE
      IF(LSTOP-2)3100,3200,3100
C--ILLEGAL OPERATION
3100  CONTINUE
      CALL XMONTR(0)
      GOTO 1000
C--CHECK FOR LIST 22 PRINT
3200  CONTINUE
      IF(NUM-1)3100,3300,3100
C--PRINT LIST 22
3300  CONTINUE
      CALL XRSL
      CALL XCSAE
      CALL XMONTR(-1)
      CALL XPRT22
      GOTO 1000
      END
