@call make_w32_include.bat
@if "%1" == "clean" goto clean
@if "%1" == "tidy" goto tidy

@echo Copying datafiles
@FOR %%I IN ( ..\datafiles\*.ssr ) DO ..\editor\cryseditor %%I %%~nI.srt code=%COMPCODE% incl=+ excl=- comm=# strip

@echo Copying precompiled stuff
echo CVS > cvs.txt
xcopy ..\precomp\all . /S /D /F /EXCLUDE:cvs.txt
xcopy ..\precomp\%COMPCODE% . /S /D /F /EXCLUDE:cvs.txt
del cvs.txt

@echo Creating COMMANDS.DSC file.
SETLOCAL
if not exist ..\editor\cryseditor cd ..\editor&&call make_w32.bat&&cd ..
ENDLOCAL
rmdir /q /s dscbuild
mkdir dscbuild
copy ..\datafiles\commands.src dscbuild\commands.src
copy ..\datafiles\crysdef.srt dscbuild\crystals.srt
SETLOCAL
cd dscbuild
set USECRYSDIR=TRUE
set CRYSDIR=./
..\crystals.exe
cd ..
ENDLOCAL
copy dscbuild\commands.dsc .
@goto exit

:clean
del commands.dsc
del *.srt
rmdir /q /s demo
rmdir /q /s mce
del script\*.bmp script\*.cmn script\*.dat script\*.gif script\*.jpg
del *.dll 
del Tables.txt oshell.bat contour.exe guide92.txt

:tidy
rmdir /q /s dscbuild
rmdir /q /s nket\cvs
rmdir /q /s mce\cvs
rmdir /q /s example\cvs
rmdir /q /s demo\cvs
rmdir /q /s demo\cyclo\cvs
rmdir /q /s demo\zoltan\cvs
rmdir /q /s demo\mogul\cvs
rmdir /q /s demo\demo\cvs
rmdir /q /s demo\editor\cvs
rmdir /q /s demo\keen\cvs
rmdir /q /s demo\peach\cvs
rmdir /q /s demo\quick\cvs
rmdir /q /s demo\shape\cvs
rmdir /q /s demo\shape2\cvs
rmdir /q /s demo\twin\cvs
rmdir /q /s demo\twin2\cvs
rmdir /q /s demo\twin3\cvs
rmdir /q /s demo\ylid\cvs
rmdir /q /s demo\disorder\cvs
rmdir /q /s demo\kpenv\cvs
rmdir /q /s script\cvs

:exit

