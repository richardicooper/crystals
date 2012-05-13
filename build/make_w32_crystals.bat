
@call make_w32_include.bat

@if "%1" == "clean" goto clean
@if "%1" == "tidy" goto tidy
@if "%1" == "link" goto link

@if exist ..\crystals.exe del ..\crystals.exe
@if exist ..\crystalsd.exe del ..\crystalsd.exe
@if exist link.lis del link.lis
@if exist dlink.lis del dlink.lis
@if not exist obj mkdir obj
@set FOPTIONS=%FDEF% %FWIN% %FOPTS%
@set COPTIONS=%CDEF% %COPTS%
@if "%CRDEBUG%" == "TRUE" if not exist dobj mkdir dobj
@if "%CRDEBUG%" == "TRUE" set FOPTIONS=%FDEF% %FWIN% %FDEBUG%
@if "%CRDEBUG%" == "TRUE" set COPTIONS=%CDEF% %CDEBUG%
@FOR %%I IN ( ..\crystals\*.fpp ) DO ( @call buildfile.bat %%I || (echo buildfile.bat returned an error & goto error ))
@FOR %%I IN ( ..\cameron\*.fpp ) DO ( @call buildfile.bat %%I || (echo buildfile.bat returned an error & goto error ))
@FOR %%I IN ( ..\gui\*.cc )      DO ( @call buildfile.bat %%I || (echo buildfile.bat returned an error & goto error ))
@call buildfile.bat lapack

@if "%COMPCODE%" == "GID" rc /d__CR_WIN__ /fo script1.res ..\gui\script1.rc
@if "%COMPCODE%" == "WXS" rc /fo rc.o ..\gui\wx.rc
@if "%COMPCODE%" == "INW" rc /fo rc.res %CDEF% ..\gui\wx.rc
@rem  --include-dir c:\wxWidgets-2.8.11\include

@if "%CRDEBUG%" == "TRUE"  goto debug
:link
@%LD% %OPT% %LDFLAGS% obj\*.obj %LIBS% %OUT%crystals.exe >link.lis
@goto fini

:debug
@%LD% %LDEBUG% %LDFLAGS% dobj\*.obj %LIBS% %OUT%crystalsd.exe >link.lis

:fini
@type link.lis
@goto next1

:error
echo Failed
rem perl ..\bin\errmail.pl FPP_RELEASE_COMPILE %%I obj\listing.lis
@if "%CRBUILDEXIT%" == "TRUE"  exit 1
exit /b 1

:clean
@del crystals.exe

:tidy
@del *.obj *.lis *.res *.ilk *.opt *.pdb

:next1
@time /t

