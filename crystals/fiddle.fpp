C $Log: not supported by cvs2svn $
C Revision 1.1.1.1  2004/12/13 11:16:10  rich
C New CRYSTALS repository
C
C Revision 1.4  2001/10/08 12:25:58  ckp2
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
C Revision 1.3  2001/02/26 10:25:32  richard
C Added changelog to top of file
C
C
CODE FOR FIDDLE
      SUBROUTINE FIDDLE
      CALL XSYSDC(-1,1)
      CALL XDISCA
      RETURN
      END

CODE FOR XDISCA
      SUBROUTINE XDISCA
C--CONTROL ROUTINE FOR DISC MODIFICATION ROUTINES

      INCLUDE 'XUNITS.INC'
      INCLUDE 'XERVAL.INC'

C -- READ THE NEXT INSTRUCTION CARD, AND CHECK IF IT IS FOR THIS SECTION

      NUM=KNXTOP(I,J,K)
      IF(NUM.LE.0) RETURN

C--BRANCH ON THE TYPE OF OPERATION

      GO TO ( 2100 , 2200 , 2300 , 2400 , 1300 , 2600 , 1300 ) , NUM
1300  CONTINUE
      CALL XERHND ( IERPRG )
      CALL GUEXIT(600)


C--'#END' CARD  -  END OF THE JOB
2100  CONTINUE
      CALL XMONTR(-1)
      CALL XEND

C--'#TITLE' CARD  -  READ A NEW TITLE
2200  CONTINUE
      CALL XRCN
      RETURN

C--'#DISC' INSTRUCTION  -  DISC MODIFICATION INSTRUCTIONS
2300  CONTINUE
      CALL XDISCF
      RETURN

C--'#PURGE' INSTRUCTION
2400  CONTINUE
      CALL XPURGE
      RETURN

2600  CONTINUE
      CALL XSIMUL
      RETURN
      END

