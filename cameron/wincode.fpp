
C----------------------------------------------------------------------C
C
      integer*4 function f_close()
C ---- this call-back function routine cleans up when the
C      Graphics Window is closed using the system menu

\CAMWIN
      call delete_tmp_files
C      call EraseWindow(DialogHandle)
      f_close=0
      end
C
C----------------------------------------------------------------------C
C
      subroutine CreateGraphicsWindow(ix,iy)
\CAMWIN
      COMMON /CAMBFF/ BUFFER
      CHARACTER*80 BUFFER(5)
      include <windows.ins>
      external f_close, mouseevent
      integer ix,iy,f_close
      GraphicsHandle=-1
      do 4 i = 1,4
        buffer(i) = ' '
4     continue

      i=winio@('%ca[CAMERON Graphics Window]%ww[no_border]&')
      i=winio@('%sp&',0,0)
      i=winio@('%cc&',f_close)
      i=winio@('%bg[grey]&')
      i=winio@('%pv%`3cu%^gr[black,full_mouse_input]%lw&',
     1 CURSOR_ARROW,CURSOR_CROSS,CURSOR_SIZE,Cursor$Number,ix,iy,
     1 mouseevent,GraphicsHandle)
      I=WINIO@('%ff%`80rs&',buffer(1))
      I=WINIO@('%ff%`80rs&',buffer(2))
      I=WINIO@('%ff%`80rs&',buffer(3))
C Removed status box, as there are now four lines of visible text
      I=WINIO@('%ff%`80rs',buffer(4))
C      I=WINIO@('%ff%`80rs&',buffer(4))
C      i=winio@('%ff%tc[blue]%fn[Times New Roman]%ts%ob[status,scored]%`6
C     10rs%cb',1.0d0,Status$Text)

      end
C
C----------------------------------------------------------------------C
C
      subroutine CreateIOWindow(caption,handle)
C ---- creates ClearWin Window for standard I/O
      include <windows.ins>
      integer*4 handle,xsize,ysize
      integer*2 xpos,ypos,xwin,ywin
      character*(*) caption
      call GetWindowSize(xsize,ysize)
      xwin=xsize
      ywin=nint(float(ysize)*0.75)
      xpos=0
      ypos=ysize-ywin+1
      handle=create_window(caption,xpos,ypos,xwin,ywin)
CDJW99 call  set_default_window@(handle)
      I = set_default_window@(handle)
      end
C
C----------------------------------------------------------------------C
C
      subroutine get_file_names(pat,nfiles,files,file_size)
      character*(*)pat
      character*(*)files(200)
      integer*2 n,nmax,attr(200),date(200),time(200)
      integer*4 file_size(200),nfiles
      n=0
      nmax=200
      call files@(pat,n,nmax,files,attr,date,time,file_size)
      nfiles=n
      end
C
C----------------------------------------------------------------------C
C
      subroutine delete_tmp_files
      character*80 files(200),pat
      integer*4 file_size(200),nfiles
      integer*2 ier
      pat='*.tmp'
      call get_file_names(pat,nfiles,files,file_size)
      if(nfiles .lt. 1) return
      do i=1,nfiles
        call erase@(files(i),ier)
      enddo
      end
C
C----------------------------------------------------------------------C
C
      subroutine GetWindowSize(xsize,ysize)
      include <windows.ins>
      integer xsize,ysize
      integer*2 x,y
      x=GetSystemMetrics(SM_CXSCREEN)
      y=GetSystemMetrics(SM_CYSCREEN)
c---- djw nov 98 - scale y to leave room for text
c      xsize=x
c      ysize=y
      xsize=  x
      ysize= 0.9 * y
      return
      end
C
C----------------------------------------------------------------------C
C
      subroutine SetGraphicsCursor(icursor)
C ---- updates the cursor for the graphics region
C     icursor = 1 -> normal arrow cursor
C     icursor = 2 -> cross-hair cursor
C     icursor = 3 -> size-cursor
\CAMWIN
      Cursor$Number=icursor
      call window_update@(Cursor$Number)
      end
C
C----------------------------------------------------------------------C
C
C
      subroutine temp_yield
      include <windows.ins>
      call temporary_yield@
      end
C
C----------------------------------------------------------------------C
C
      subroutine zsleep(time)
      real time
      call sleep@(time)
      end
C
C----------------------------------------------------------------------C
C
      subroutine EraseWindow(handle)
      include <windows.ins>
      integer handle
      call destroy_window(handle)
      end
C
C----------------------------------------------------------------------C
C
      subroutine get_mouse_position(ix,iy)
      integer*2 ixx,iyy,button_status
      call get_mouse_position@(ixx,iyy,button_status)
      ix=ixx
      iy=iyy
      end
C
C----------------------------------------------------------------------C
C
      subroutine get_mouse_button_press_count(ib,ic)
      integer*2 ibb,icc
      ibb=ib
      call get_mouse_button_press_count@(ibb,icc)
      ic=icc
      end
C
C----------------------------------------------------------------------C
C
      subroutine BoldFont(ifont)
      include <windows.ins>
      call bold_font@(ifont)
      end


      integer*4 function mouseevent()
      include <windows.ins>
\CAMWIN
      LOGICAL BOUNCE
      SAVE    BOUNCE

      DATA    BOUNCE /.FALSE./

      CALL GET_MOUSE_INFO@(IX,IY,IFLAG)

      IX = NINT(FLOAT(IX)/SCALE_X)
      IY = NINT(FLOAT(IY)/SCALE_Y)

      IF((IFLAG.EQ.1).OR.(IFLAG.EQ.2)) THEN
         IF ( BOUNCE ) THEN
            BOUNCE = .FALSE.
            CALL KMSADD(IX,IY,(IFLAG*(-2))+3) ! 2->-1, 1->+1
         END IF
      ELSE
         BOUNCE = .TRUE.
         CALL KMSADD(IX,IY,0)    
      ENDIF
      
      end


      subroutine winout(ctext)
      character*(*) ctext
      COMMON /CAMBFF/ BUFFER
      CHARACTER*80 BUFFER(5)
      include <windows.ins>

C Add new text
      NALEN = MIN(LEN(CTEXT),80)
      write(BUFFER(5),'(A)') ctext(1:NALEN)

C Shift buffer up.

      DO 10 I = 1,4
        BUFFER(I) = BUFFER(I+1)
      call window_update@(BUFFER(I))
10    CONTINUE

      end      
      
