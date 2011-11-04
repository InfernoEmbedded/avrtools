@echo off


:: Do some one time setup
if exist c:\mhvavrtools\install.bat.done goto env
call c:\mhvavrtools\install.bat
ren c:\mhvavrtools\install.bat install.bat.done
goto env


:env
set PATH=c:\mhvavrtools\bin;%PATH%
set INCLUDE=c:\mhvavrtools\include
set CC=c:\mhvavrtools\bin\avr-gcc.exe

:: Use smatch
set REAL_CC=avr-gcc
set CHECK=c:\mhvavrtools\bin\smatch.exe --full-path
set CC=c:\mhvavrtools\bin\cgcc


