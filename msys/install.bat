set DOWNLOAD=%CD%\download
set CURRENT=%CD%

mkdir 1.0
cd 1.0

for /f %%a in ('dir /b %DOWNLOAD%\*msys*') do 7z x -so %DOWNLOAD%\%%a| tar xvf -


mkdir c:\mingw
cd \mingw

for /f %%a in ('dir /b %DOWNLOAD%\*mingw*') do 7z x -so %DOWNLOAD%\%%a| tar xvf -

cd %CURRENT%

cd 1.0\postinstall
call pi.bat
