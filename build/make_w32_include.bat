@goto %COMPCODE%
@
:WXS
@if "%CRDEBUG%" == "TRUE"     set LIBS=/LIBPATH:c:\wxWidgets-2.8.11\lib\vc_lib  wxbase28d.lib wxmsw28d_core.lib wxzlibd.lib wxjpegd.lib wxtiffd.lib wxpngd.lib wxmsw28d_gl.lib user32.lib shell32.lib ole32.lib comctl32.lib rpcrt4.lib winmm.lib advapi32.lib wsock32.lib Comdlg32.lib Oleaut32.lib Winspool.lib
@if not "%CRDEBUG%" == "TRUE" set LIBS=/LIBPATH:c:\wxWidgets-2.8.11\lib\vc_lib  wxbase28.lib  wxmsw28_core.lib  wxzlib.lib  wxjpeg.lib  wxtiff.lib  wxpng.lib  wxmsw28_gl.lib  user32.lib shell32.lib ole32.lib comctl32.lib rpcrt4.lib winmm.lib advapi32.lib wsock32.lib Comdlg32.lib Oleaut32.lib Winspool.lib
@set LIBS=%LIBS% rc.o
@rem @set LIBS=/LIBPATH:c:\wxWidgets-2.8.11\lib\vc_lib msvcrtd.lib libcmtd.lib wxbase28d.lib wxmsw28d_core.lib comctl32.lib rpcrt4.lib winmm.lib advapi32.lib wsock32.lib  user32.lib ole32.lib /NODEFAULTLIB:MSVCRT.lib
@set CDEF=/D"__WXMSW__" /D"_DIGITALF77_"
@set FDEF=/define:_%COMPCODE%_ /define:_DIGITALF77_
goto ALLDVF
@
:GID
@set LIBS=script1.res
@set CDEF=/D"__CR_WIN__"  /D"_AFXDLL" /D"_DIGITALF77_"
@set FDEF=/define:_%COMPCODE%_ /define:_DIGITALF77_
@
:ALLDVF
@set LD=link
@set OUT=/OUT:
@set OPT=/OPT:REF
@set LDFLAGS=/SUBSYSTEM:WINDOWS
@set LDCFLAGS=/SUBSYSTEM:console
@set LIBS=%LIBS% opengl32.lib glu32.lib
@set LDEBUG=/DEBUG /debugtype:cv /pdb:none /incremental:no

@set CC=CL
@set CDEF=%CDEF% /D"WIN32" /D"_WINDOWS" /D"_MBCS"
@set COPTS=/EHs /W3 /nologo /c /TP /I..\gui /O2 /D"NDEBUG" /MD
@set CDEBUG=/EHs /W3 /nologo /c /Od /RTC1 /MDd /Z7 /TP /I..\gui
@set COUT=/Foobj\

@set F77=DF
@set FDEF=%FDEF%
@set FOPTS=/fpp /I..\crystals /MD /optimize:4  /nolink
@set FNOOPT=/fpp /I..\crystals /MD /optimize:0 /nolink
@set FWIN=/winapp
@set FOUT=/object:obj\
@set FDEBUG=/fpp /I..\crystals /MDd /debug /Zt /check:bounds /check:format /check:overflow /check:underflow /warn:argument_checking /warn:nofileopt /nolink
@if "%CRDEBUG%" == "TRUE" set FOUT=/object:dobj\
@if "%CRDEBUG%" == "TRUE" set COUT=/Fodobj\
@goto exit

:DVF
set LD=link
set OUT=/OUT:
set OPT=/OPT:REF
set LDFLAGS=/SUBSYSTEM:console
set LDCFLAGS=/SUBSYSTEM:console
set LIBS=
set LDEBUG=/DEBUG /debugtype:cv /pdb:none /incremental:no
set CC=rem
set CDEF=
set COPTS=
set CDEBUG=
set COUT=
set F77=DF
set FDEF=/define:_%COMPCODE%_ /define:_DIGITALF77_
set FOPTS=/fpp /I..\crystals /ML /optimize:4 /winapp /nolink
set FNOOPT=/fpp /I..\crystals /ML /optimize:0 /winapp /nolink
set FOUT=/object:obj\
set FDEBUG=/fpp /I..\crystals /MLd /debug /Zt /check:bounds /check:format /check:overflow /check:underflow /warn:argument_checking /warn:nofileopt /nolink
@if "%CRDEBUG%" == "TRUE" set FOUT=/object:dobj\
goto exit

:DOS
:F95
set LD=slink
set OUT=-OUT:
set OPT=
set LDFLAGS=
set LDCFLAGS=
set LIBS=
set LDEBUG=-DEBUG:FULL
set CC=rem
set CDEF=
set COPTS=
set CDEBUG=
set COUT=
set F77=ftn77
set FDEF=/define:_%COMPCODE%_
set FOPTS=/cfpp /I..\crystals  /no_warn73 /zero
set FNOOPT=/fpp /I..\crystals  /no_warn73 /zero 
set FOUT=/binary obj\
set FDEBUG=/debug
@if "%CRDEBUG%" == "TRUE" set FOUT=/binary obj\

:exit

