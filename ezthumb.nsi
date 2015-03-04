; example2.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install example2.nsi into a directory that the user selects,

;--------------------------------

; The name of the installer
Name "Ezthumb Installer"

; The file to write
;OutFile "ezthumb-3.2.3-setup.exe"
!include "nsis_version.txt"

; The default installation directory
InstallDir $PROGRAMFILES\Ezthumb

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\ezthumb" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Ezthumb (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "ezthumb.exe"
  File "ezthumb_win.exe"
  File "ezthumb.1"
  File "ezthumb.pdf"
  File "ezthumb.ico"
  File "libmingw\ffmpeg\bin\*.dll"
  File "libmingw\lib\*.dll"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\ezthumb "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ezthumb" "DisplayName" "Ezthumb Uninstaller"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ezthumb" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ezthumb" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ezthumb" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\Ezthumb"
  CreateShortCut "$SMPROGRAMS\Ezthumb\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\Ezthumb\ezthumb.lnk" "$INSTDIR\ezthumb_win.exe" "" "$INSTDIR\ezthumb_win.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ezthumb"
  DeleteRegKey HKLM SOFTWARE\Ezthumb
  DeleteRegKey HKCU SOFTWARE\ezthumb

  ; Remove files and uninstaller
  Delete $INSTDIR\*.*

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\Ezthumb\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\Ezthumb"
  RMDir "$INSTDIR"

SectionEnd