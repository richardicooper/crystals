      program combine
      character *80 cline
      in1 = 10
      in2 = 11
      iout1 = 12
      open(in1,file='PLATON6',status='old')
      open(in2,file='platon.hkp',status='old')
      open(iout1,file='LIST6.ABC',status='unknown')
      do 1 i=1,10
      read(in1,'(a)') cline
1     continue 
c
1001  FORMAT('#LIST      6'/
     * 'READ NCOEFFICIENT = 11, TYPE = FIXED, UNIT = DATAFILE' ,
     1 ', CHECK=NO' /
     2 'INPUT H K L /FO/ SIGMA(/FO/) /FC/ PHASE'
     4 ,' SQRTW JCODE A-PART B-PART' /
     3 ,'FORMAT (3F4.0, F10.2, F8.2, F10.2, F8.4, G12.5, F10.5'
     * ,'/2F8.2)'/
     * ,'STORE NCOEF=10'/
     * ,'OUTPUT INDICES /FO/    SQRTW   /FC/    BATCH/PHASE'/  
     * ,'CONTINUE RATIO/JCODE  SIGMA(/FO/)   CORRECTIONS  '
     * ,'A-PART B-PART'
     5 / 'END')
      write(iout1,1001)

      n6 = 0
      np = 0

100   continue
        read(in2,'(3i4,68x,i8,2f8.2)',err=200,end=200)
     1    ih,ik,il,ic,a,b                             !read from hkp
        np = np + 1
110     continue
          read(in1,'(a)',end=200) cline               !read from our L6
          read(cline,'(3i4)') jh,jk,jl
          if ( jh.eq.-512) goto 200
          n6 = n6 + 1
          if((ih.ne.jh).or.(ik.ne.jk).or.(il.ne.jl)) then
             write(6,'(3I4,A)')jh,jk,jl,' not found in HKP file'
             goto 110
          end if
          write(iout1,'(a)') cline
          write(iout1,'(2f8.2)')a,b
      goto 100
200   continue
      write(iout1,'(I4/)')-512
      write(6,'(A,I6,A,I6,A)')
     1 'Finished. Of ',N6,' reflections passed to Platon, ',NP,
     1 ' were passed back. Press return to finish.'
      read(5,'(a)') cline
      stop
220   continue
      rewind(iout1)
      write(iout1,'(A)') 'Index mismatch - processing aborted'
      write(6,'(A)')
     1 'Index mismatch - processing aborted. Press return to finish.'
      read(5,'(a)') cline
      end

