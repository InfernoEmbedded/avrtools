@echo off


:: Add the registry keys
goto %PROCESSOR_ARCHITECTURE%

:AMD64
:: In this case, the x86 section will actually populate the 64 bit registry keys,
:: so here we will populate the 32 bit keys
reg add "HKLM\Software\Wow6432Node\Free Software Foundation\MHV-AVR-Tools" /v BINUTILS /d c:\mhvavrtools
reg add "HKLM\Software\Wow6432Node\Free Software Foundation\MHV-AVR-Tools" /v G++ /d c:\mhvavrtools
reg add "HKLM\Software\Wow6432Node\Free Software Foundation\MHV-AVR-Tools" /v GCC /d c:\mhvavrtools
goto x86


:x86
reg add "HKLM\Software\Free Software Foundation\MHV-AVR-Tools" /v BINUTILS /d c:\mhvavrtools
reg add "HKLM\Software\Free Software Foundation\MHV-AVR-Tools" /v G++ /d c:\mhvavrtools
reg add "HKLM\Software\Free Software Foundation\MHV-AVR-Tools" /v GCC /d c:\mhvavrtools
goto end


:end

