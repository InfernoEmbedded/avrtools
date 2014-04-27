Name "Inferno AVR Tools"

SetCompressor /SOLID lzma
SetCompressorDictSize 128

RequestExecutionLevel admin

# General Symbol Definitions
!define REGKEY "SOFTWARE\$(^Name)"
!define VERSION 20140501
!define COMPANY "Inferno Embedded"
!define URL http://infernoembedded.com

# MUI Symbol Definitions
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-blue-full.ico"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Inferno AVR Tools"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall-blue-full.ico"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

# Included files
!include Sections.nsh
!include MUI2.nsh
!include EnvVarUpdate.nsh

# Variables
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE LICENSE.txt
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE English


# Installer attributes
OutFile Inferno_AVR_Tools_${VERSION}.exe
InstallDir "$PROGRAMFILES\Inferno AVR Tools"
CRCCheck on
XPStyle on
ShowInstDetails show
VIProductVersion 2014.05.01.00
VIAddVersionKey ProductName "Inferno AVR Tools"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path
ShowUninstDetails show

VAR use_smatch

Section "Enable SMATCH" smatch
    StrCpy $use_smatch "1"
SectionEnd

Section "Add Inferno AVR Tools to the system path"
    ${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$INSTDIR\bin"
#    ${EnvVarUpdate} $0 "INCLUDE" "A" "HKLM" "$INSTDIR\include"
SectionEnd

Section "" SecUninstallPrevious
    Call UninstallPrevious
SectionEnd

Function UninstallPrevious
    ; Check for uninstaller.
    ReadRegStr $R0 HKLM "${REGKEY}" "Path"

    ${If} $R0 == ""        
        Goto Done
    ${EndIf}

    DetailPrint "Removing previous installation."    

    ; Run the uninstaller silently.
    ExecWait '"$INSTDIR\Uninstall.exe /S"'

    Done:
FunctionEnd


LangString DESC_smatch ${LANG_ENGLISH} "Smatch provides additional compile time error detection"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${smatch} $(DESC_smatch) 
!insertmacro MUI_FUNCTION_DESCRIPTION_END

# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    File /r C:\avrtools\avrtools\avrtools\*
    WriteRegStr HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" GCC $INSTDIR
    WriteRegStr HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" BINUTILS $INSTDIR
    WriteRegStr HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" G++ $INSTDIR
    WriteRegStr HKLM "${REGKEY}\Components" Main 1

    FileOpen $9 "avrvars.bat" W
    FileWrite $9 "@echo off$\r$\n"
    FileWrite $9 "echo Setting up environment for Inferno AVR Tools ${VERSION}$\r$\n"
    FileWrite $9 "title Inferno AVR Tools ${VERSION}$\r$\n"
    FileWrite $9 "set USE_SMATCH=$use_smatch$\r$\n$\r$\n"
    FileWrite $9 "set INFERNOAVRTOOLS=$INSTDIR$\r$\n$\r$\n"
    FileWrite $9 "$\r$\n"
    FileWrite $9 "set PATH=%INFERNOAVRTOOLS%\bin;%PATH%$\r$\n"
    FileWrite $9 "set INCLUDE=%INFERNOAVRTOOLS%\include;%INFERNOAVRTOOLS%\avr\include$\r$\n"
    FileWrite $9 "set CC=%INFERNOAVRTOOLS%\bin\avr-gcc$\r$\n"
    FileWrite $9 "$\r$\n"
    FileWrite $9 "if  not $\"1$\" == $\"%USE_SMATCH%$\" goto nosmatch$\r$\n"
    FileWrite $9 "set REAL_CC=%INFERNOAVRTOOLS%\bin\avr-gcc.exe$\r$\n"
    FileWrite $9 "set CHECK=%INFERNOAVRTOOLS%\bin\smatch.exe --full-path$\r$\n"
    FileWrite $9 "set CC=%INFERNOAVRTOOLS%\bin\cgcc$\r$\n"
    FileWrite $9 "$\r$\n"
    FileWrite $9 ":end$\r$\n"
    FileWrite $9 "set USE_SMATCH=$\r$\n"
    FileClose $9
SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\uninstall.exe
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk" $INSTDIR\uninstall.exe
    SetOutPath $PROFILE
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\Inferno AVR Shell.lnk" "cmd.exe" "/k $\"$INSTDIR\avrvars.bat$\""
    !insertmacro MUI_STARTMENU_WRITE_END
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1

SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o -un.Main UNSEC0000
    DeleteRegValue HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" GCC
    DeleteRegValue HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" BINUTILS
    DeleteRegValue HKLM "SOFTWARE\Free Software Foundation\Inferno-AVR-Tools" G++

    RmDir /r /REBOOTOK $INSTDIR
    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk"
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RmDir /REBOOTOK $INSTDIR

    ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR\bin"
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

