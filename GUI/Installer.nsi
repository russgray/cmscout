; Program name and version
!define MUI_PRODUCT "CM Scout"
!define MUI_VERSION "3.00"

; Use Modern UI
!include "MUI.nsh"
  
;--------------------------------
;Configuration

  ;General
  OutFile "..\CMScout-v${MUI_VERSION}.exe"
  SetCompressor bzip2
  !define MUI_ICON "${NSISDIR}\contrib\icons\yi-simple2_install.ico"
  !define MUI_UNICON "${NSISDIR}\contrib\icons\yi-simple2_uninstall.ico"

  ;Folder selection page
  InstallDir "$PROGRAMFILES\nygreen.net\CMScout"
  
  ;Remember install folder
  InstallDirRegKey HKCU "Software\nygreen.net\CMScout" "InstallDir"

  ;Default Start Menu Folder
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER "nygreen.net\CM Scout"

  ;Remember the Start Menu Folder
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\nygreen.net\CMScout" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenu"

  !define TEMP $R0

;--------------------------------
;Modern UI Configuration

  !define MUI_WELCOMEPAGE
  !define MUI_COMPONENTSPAGE
  !define MUI_DIRECTORYPAGE
  !define MUI_STARTMENUPAGE
  !define MUI_FINISHPAGE
    !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Readme.txt"
    !define MUI_FINISHPAGE_RUN "$INSTDIR\CMScout.exe"
      !define MUI_FINISHPAGE_RUN_NOTCHECKED
  
  !define MUI_ABORTWARNING
  
  !define MUI_UNINSTALLER
  !define MUI_UNCONFIRMPAGE
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"
  
;--------------------------------
;Language Strings

  ;Description
  LangString DESC_SecProgram ${LANG_ENGLISH} "This will install CM Scout."
  LangString DESC_SecXPLook ${LANG_ENGLISH} "This will enable the Windows XP look for the program, it will only work on Windows XP."
  LangString DESC_SecDesktop ${LANG_ENGLISH} "This will install a shortcut on your desktop."
  LangString DESC_SecQuickLaunch ${LANG_ENGLISH} "This will install a shortcut in your quick launch bar."

;--------------------------------
;Installer Sections

Section "CM Scout" SecProgram

  SectionIn RO
  ;Add your stuff here

  SetOutPath "$INSTDIR"
  File "CMScout.exe"
  File "Readme.txt"
  
  ;Store install folder
  WriteRegStr HKCU "Software\nygreen.net\CMScout" "InstallDir" $INSTDIR
    
  !insertmacro MUI_STARTMENU_WRITE_BEGIN
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\CM Scout.lnk" "$INSTDIR\CMScout.exe"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\Readme.lnk" "$INSTDIR\Readme.txt"
    CreateShortCut "$SMPROGRAMS\${MUI_STARTMENUPAGE_VARIABLE}\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "DisplayName" "CM Scout"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "DisplayIcon" "$INSTDIR\CMScout.exe,0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "Publisher" "nygreen.net"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "URLInfoAbout" "http://www.nygreen.net"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "URLUpdateInfo" "http://www.nygreen.net"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "DisplayVersion" "${MUI_VERSION}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout" "NoRepair" 1

SectionEnd

Section "Windows XP Look" SecXPLook
  SetOutPath "$INSTDIR"
  File "CMScout.exe.manifest"
SectionEnd

Section "Desktop Shortcut" SecDesktop
  CreateShortCut "$DESKTOP\CM Scout.lnk" "$INSTDIR\CMScout.exe"
SectionEnd

Section "Quick Launch Shortcut" SecQuickLaunch
  CreateShortCut "$QUICKLAUNCH\CM Scout.lnk" "$INSTDIR\CMScout.exe"
SectionEnd

;--------------------------------
;Descriptions

!insertmacro MUI_FUNCTIONS_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecProgram} $(DESC_SecProgram)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecXPLook} $(DESC_SecXPLook)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} $(DESC_SecDesktop)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecQuickLaunch} $(DESC_SecQuickLaunch)
!insertmacro MUI_FUNCTIONS_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ; Remove Files
  Delete "$INSTDIR\CMScout.exe"
  Delete "$INSTDIR\Readme.txt"
  Delete "$INSTDIR\CMScout.exe.manifest"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$DESKTOP\CM Scout.lnk"
  Delete "$QUICKLAUNCH\CM Scout.lnk"

  ; Remove Directories
  Push "$INSTDIR"
  Call un.DeleteDirs

  ; Remove shortcuts
  ReadRegStr ${TEMP} "${MUI_STARTMENUPAGE_REGISTRY_ROOT}" "${MUI_STARTMENUPAGE_REGISTRY_KEY}" "${MUI_STARTMENUPAGE_REGISTRY_VALUENAME}"
  
  StrCmp ${TEMP} "" noshortcuts
  
    Delete "$SMPROGRAMS\${TEMP}\CM Scout.lnk"
    Delete "$SMPROGRAMS\${TEMP}\Readme.lnk"
    Delete "$SMPROGRAMS\${TEMP}\Uninstall.lnk"

    Push "$SMPROGRAMS\${TEMP}"
    Call un.DeleteDirs
    
  noshortcuts:

  DeleteRegKey HKCU "Software\nygreen.net\CMScout"
  DeleteRegKey /ifempty HKCU "Software\nygreen.net"
  DeleteRegKey /ifempty HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\CMScout"

  !insertmacro MUI_UNFINISHHEADER

SectionEnd

; GetParent
 ; input, top of stack  (e.g. C:\Program Files\Poop)
 ; output, top of stack (replaces, with e.g. C:\Program Files)
 ; modifies no other variables.
 ;
 ; Usage:
 ;   Push "C:\Program Files\Directory\Whatever"
 ;   Call GetParent
 ;   Pop $R0
 ;   ; at this point $R0 will equal "C:\Program Files\Directory"

Function un.GetParent
  Exch $R0 ; old $R0 is on top of stack
  Push $R1
  Push $R2
  StrCpy $R1 -1
  loop:
    StrCpy $R2 $R0 1 $R1
    StrCmp $R2 "" exit
    StrCmp $R2 "\" exit
    IntOp $R1 $R1 - 1
  Goto loop
  exit:
    StrCpy $R0 $R0 $R1
    Pop $R2
    Pop $R1
    Exch $R0 ; put $R0 on top of stack, restore $R0 to original value
FunctionEnd
 
Function un.DeleteDirs
  Exch $R0

  ; Attempt to recursively remove all empty folders
  ClearErrors
  rmnextscfolder:
    RMDir $R0 ; Only remove if empty, so it won't delete other files
    IfErrors exit ; If Folder Couldn't be removed, stop removing folders
    Push $R0
    Call un.GetParent ; Find the folders parent
    Pop $R0
    Goto rmnextscfolder ; Try to remove the folders parent

  exit:
    Exch $R0
FunctionEnd

Function .onInit
  Push $R0

  SectionGetFlags ${SecXPLook} $R0
  IntOp $R0 $R0 & 0xFFFFFFFE
  SectionSetFlags ${SecXPLook} $R0

  SectionGetFlags ${SecDesktop} $R0
  IntOp $R0 $R0 & 0xFFFFFFFE
  SectionSetFlags ${SecDesktop} $R0

  SectionGetFlags ${SecQuickLaunch} $R0
  IntOp $R0 $R0 & 0xFFFFFFFE
  SectionSetFlags ${SecQuickLaunch} $R0

  Pop $R0
FunctionEnd