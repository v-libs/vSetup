; :Author: snxx
; :Copyright: GPL v3.0
;---------------------

!addincludedir "${objdir}\V"
!addincludedir "${srcdir}\V"
!include "version.nsh"
!include "arch.nsh"

!define PRODUCT_NAME "Vlang"
!define PRODUCT_SHORT_NAME "V"
!define PACKAGE_NAME "${PRODUCT_NAME} ${VERSION}"
!define PACKAGE_SHORT_NAME "${PRODUCT_SHORT_NAME}-${VERSION}"

!if "${VLANG_PACKEDVERSION}" >= 0x3000000
	Unicode True
!endif

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "V"
!include "VMultiUser.nsh"

!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MULTIUSER_INSTALLMODEPAGE_INTERFACE



; The name of the installer
Name "${PACKAGE_NAME} Setup"
OutFile "vSetup.exe"

; Check Example: https://github.com/v-libs/vSetup/blob/master/vlang.reg
; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\"
;--------------------------------

; Request application privileges for Windows Vista
RequestExecutionLevel admin
;--------------------------

; Variables
Var StartMenuFolder
Var CmdFailed
;------------

; Interface Settings
Caption "${PACKAGE_SHORT_NAME}"
Icon "${srcdir}\nsis\setup.ico"
UninstallIcon "${srcdir}\nsis\unins000.ico"
;-------------------------------------------------

; The default installation directory
; Path: %LocalAppData%\Programs\V\v.30-32-bit\v.exe
InstallDir "$APPDATA\Local\Programs\V"
;-------------------------------------

; Pages
!insertmacro MUI_PAGE_DIRECTORY
Page directory
Page instfiles

UninstPage uninstConfirm
;-----------------------

!insertmacro MUI_LANGUAGE English

; The staff to install
Section "VLANG" SecVlang
	Sectionin
	SetOutPath "$APPDATA\Local\Programs\V\v.30-32-bit"
	File ""
	WriteRegStr HKLM ""
	
	WriteUninstaller "$\unins000.exe"
SectionEnd ; end the Staff section
;---------------------------------

Section "Manual" SecManual
	SetOutPath "$INSTDIR"
	File "${objdir}\docs\doc.chm"
	CreateShortCut "${}\$StartMenuFolder\man.lnk" "$INSTDIR\v${VLANG_PACKEDVERSION}.chm"
SectionEnd ; end the Manual section
;----------------------------------

; Uninstaller
Section "Uninstall"
	DeleteRegKey HKLM ""

	Delete "$APPDATA\Local\Programs\V\v.30-32-bit\v.exe"
	Delete "$APPDATA\Local\Programs\V\v.30-32-bit\unins000.exe"
	
	RMDir "$APPDATA\Local\Programs\V\v.30-32-bit"
	RMDir "$APPDATA\Local\Programs\V"
SectionEnd ; end the Uninstall section
;-------------------------------------
