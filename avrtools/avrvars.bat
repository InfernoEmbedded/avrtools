@echo off


:: Do some one time setup
if exist c:\inferno-avrtools\install.bat.done goto env
call c:\inferno-avrtools\install.bat
ren c:\inferno-avrtools\install.bat install.bat.done
goto env


:env
set PATH=c:\inferno-avrtools\bin;%PATH%
set INCLUDE=c:\inferno-avrtools\include
set CC=c:\inferno-avrtools\bin\avr-gcc.exe

:: Use smatch
set REAL_CC=avr-gcc
set CHECK=c:\inferno-avrtools\bin\smatch.exe --full-path
set CC=c:\inferno-avrtools\bin\cgcc


