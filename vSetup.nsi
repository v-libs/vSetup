; :Author: snxx
; :Copyright: GPLv3
;------------------

; The name of the installer
Name "V"

; To change from default installer icon:
Icon "setup.ico"
;---------------

; The file to write
OutFile "vSetup.exe"
;-------------------

; Request application privileges for Windows Vista
RequestExecutionLevel user
;-------------------------

; Build Unicode installer
Unicode True
;-----------

; The default installation directory
; Path: %LocalAppData%\Programs\V\v.30-32-bit\v.exe
InstallDir "$APPDATA\Local\Programs\V"
;-------------------------------------

; Check Example: https://github.com/v-libs/vSetup/blob/master/vlang.reg
; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\"
;--------------------------------

; Pages
Page directory
Page instfiles

UninstPage uninstConfirm
;-----------------------

; The stuff to install
Section ""
	SetOutPath "$APPDATA\Local\Programs\V\v.30-32-bit"
	File ""
	WriteRegStr HKLM ""
	
	WriteUninstaller "$\unins000.exe"
SectionEnd ; end the Staff section
;---------------------------------

; Uninstaller
Section "Uninstall"
	DeleteRegKey HKLM ""

	Delete "$APPDATA\Local\Programs\V\v.30-32-bit\v.exe"
	Delete "$APPDATA\Local\Programs\V\v.30-32-bit\unins000.exe"
	
	RMDir "$APPDATA\Local\Programs\V\v.30-32-bit"
	RMDir "$APPDATA\Local\Programs\V"
SectionEnd ; end the Uninstall section
;-------------------------------------
