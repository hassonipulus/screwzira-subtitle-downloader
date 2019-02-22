; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Screwzira-Downloader"
!define PRODUCT_VERSION "1.5.1"
!define PRODUCT_PUBLISHER "yoavain"
!define PRODUCT_WEB_SITE "https://github.com/yoavain/screwzira-subtitle-downloader"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME}.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
Var MkvProgID
Var AviProgID
Var Mp4ProgID

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "../resources/icons/sz_install.ico"
!define MUI_UNICON "../resources/icons/sz_uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}_Setup.exe"
InstallDir "$PROGRAMFILES64\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "Main" SEC00
SetOutPath "$INSTDIR"
File "..\dist\screwzira-downloader.exe"
File "..\dist\screwzira-downloader-launcher.exe"
File "..\dist\SnoreToast.exe"
SectionEnd
Section "Directory" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  WriteRegStr HKCR "Folder\shell\${PRODUCT_NAME}" "Icon" '$INSTDIR\screwzira-downloader-launcher.exe,0'
  WriteRegStr HKCR "Folder\shell\${PRODUCT_NAME}\command" "" '"$INSTDIR\screwzira-downloader-launcher.exe" "$INSTDIR\screwzira-downloader.exe" input "%1"'
SectionEnd
Section "MKV" SEC02
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ReadRegStr $MkvProgID HKLM "SOFTWARE\Classes\.mkv" ""
  WriteRegStr HKLM "SOFTWARE\Classes\$MkvProgID\shell\${PRODUCT_NAME}" "Icon" '$INSTDIR\screwzira-downloader-launcher.exe,0'
  WriteRegStr HKLM "SOFTWARE\Classes\$MkvProgID\shell\${PRODUCT_NAME}\command" "" '"$INSTDIR\screwzira-downloader-launcher.exe" "$INSTDIR\screwzira-downloader.exe" input "%1"'
SectionEnd
Section "AVI" SEC03
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
    ReadRegStr $AviProgID HKLM "SOFTWARE\Classes\.avi" ""
    WriteRegStr HKLM "SOFTWARE\Classes\$AviProgID\shell\${PRODUCT_NAME}" "Icon" '$INSTDIR\screwzira-downloader-launcher.exe,0'
    WriteRegStr HKLM "SOFTWARE\Classes\$AviProgID\shell\${PRODUCT_NAME}\command" "" '"$INSTDIR\screwzira-downloader-launcher.exe" "$INSTDIR\screwzira-downloader.exe" input "%1"'
SectionEnd
Section "MP4" SEC04
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
    ReadRegStr $Mp4ProgID HKLM "SOFTWARE\Classes\.mp4" ""
    WriteRegStr HKLM "SOFTWARE\Classes\$Mp4ProgID\shell\${PRODUCT_NAME}" "Icon" '$INSTDIR\screwzira-downloader-launcher.exe,0'
    WriteRegStr HKLM "SOFTWARE\Classes\$Mp4ProgID\shell\${PRODUCT_NAME}\command" "" '"$INSTDIR\screwzira-downloader-launcher.exe" "$INSTDIR\screwzira-downloader.exe" input "%1"'
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${PRODUCT_NAME}.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PRODUCT_NAME}.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "Associate folders to $(^Name)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Associate .mkv files to $(^Name)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "Associate .avi files to $(^Name)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "Associate .mp4 files to $(^Name)"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function .onInit
  SectionSetFlags ${SEC00} 17
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}_Uninst.exe"
  Delete "$INSTDIR\screwzira-downloader.exe"
  Delete "$INSTDIR\screwzira-downloader-launcher.exe"
  Delete "$INSTDIR\SnoreToast.exe"
  RMDir "$INSTDIR"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey HKCR "Folder\shell\${PRODUCT_NAME}"
  ReadRegStr $MkvProgID HKLM "SOFTWARE\Classes\.mkv" ""
  DeleteRegKey HKLM "SOFTWARE\Classes\$MkvProgID\shell\${PRODUCT_NAME}"
  ReadRegStr $AviProgID HKLM "SOFTWARE\Classes\.mkv" ""
  DeleteRegKey HKLM "SOFTWARE\Classes\$AviProgID\shell\${PRODUCT_NAME}"
  ReadRegStr $Mp4ProgID HKLM "SOFTWARE\Classes\.mkv" ""
  DeleteRegKey HKLM "SOFTWARE\Classes\$Mp4ProgID\shell\${PRODUCT_NAME}"
  SetAutoClose true
SectionEnd