CRYSTALS CODE FOR BLOCK.FOR                                                     
CODE FOR ZBLOCK
      BLOCK DATA ZBLOCK
      
\CAMPAR
\CAMCOM
\CAMANA
\CAMDAT
\CAMCAL
\CAMMSE
\CAMMEN
\CAMCHR
\CAMGRP
\CAMCOL
\CAMFLG
\CAMSHR
\CAMVER
\CAMKEY
\CAMBTN
\CAMBLK
\XIOBUF

C DATA FOR THE MAXIMUM NUMBER OF KNOWN ELEMENT TYPES
      DATA NELM /100/
C DATA FOR THE PC KEYS
      DATA ICUP /328/
      DATA ICDOWN /336/
      DATA ICRGHT /333/
      DATA ICLEFT /331/
      DATA ICANTI /339/
      DATA ICCLCK /335/
C DATA FOR THE VAX KEYS
CVAX      DATA ICUP /274/
CVAX      DATA ICDOWN /275/
CVAX      DATA ICLEFT /276/
CVAX      DATA ICRGHT /277/
CVAX      DATA ICANTI /90/
CVAX      DATA ICCLCK /88/
      DATA ICBCK /127/
      DATA ICDEL /8/
      DATA ICRET /13/
      DATA ICESP /27/
      DATA ICLV /86/
      DATA ICUV /118/
      DATA ICHMIN /0/
      DATA ICHMAX /255/
C      DATA IVGACL /0,0,0,
C     c 0,0,63,
C     c 10,30,10,
C     c 63,25,0,
C     c 45,0,0,
C     c 0,63,63,
C     c 63,0,63,
C     c 40,40,40,
C     c 25,25,25,
C     c 30,63,30,
C     c 0,40,63,
C     c 63,10,10,
C     c 63,30,30,
C     c 35,0,50,
C     c 63,63,0,
C     c 63,63,63/
      DATA IGREYC /0,0,0,
     c 4,4,4,
     c 8,8,8,
     c 12,12,12,
     c 16,16,16,
     c 20,20,20,
     c 24,24,24,
     c 28,28,28,
     c 32,32,32,
     c 36,36,36,
     c 40,40,40,
     c 44,44,44,
     c 48,48,48,
     c 52,52,52,
     c 56,56,56,
     c 63,63,63/
C DATA FOR THE COLOURS
C      DATA IVGACL /0,0,0,
C     c 0,0,63,
C     c 0,63,0,
C     c 63,30,0,
C     c 63,0,0,
C     c 0,63,63,
C     c 63,0,63,
C     c 40,40,40,
C     c 25,25,25,
C     c 10,50,30,
C     c 0,40,63,
C     c 50,15,0,
C     c 60,30,30,
C     c 30,10,50,
C     c 63,63,0,
C     c 63,63,63/
C DATA FOR THE COLOUR NAME
C      DATA COLNAM /'BLACK ','BLUE  ','GREEN ','ORANGE','RED   ',
C     c 'CYAN  ','MAGENT','LGREY ','GREY  ','LGREEN', 'LBLUE ',
C     c 'LRED  ','PINK  ','PURPLE','YELLOW','WHITE '/
      DATA COLGRY /'BLACK ','GREY1 ','GREY2 ','GREY3 ','GREY4 ',
     c 'GREY5 ','GREY6 ','GREY7 ','GREY8 ','GREY9 ' ,'GREY10',
     c 'GREY11 ','GREY12 ', 'GREY13 ','GREY14 ','WHITE'/
      DATA IFIRST /0/
C DATA FOR SOME INITIALISATIONS
      DATA IELTYP /4/
      END
