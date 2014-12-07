; Script Start
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>
#include <RecFileListToArray.au3>

;------------------------------------------
#Region
#AutoIt3Wrapper_Icon="C:\Users\Derunv\Documents\Developing\SNUC\Release 1.0.1\Files\merck_icon_teal.ico"
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_FileVersion=1.0.1.0
#AutoIt3Wrapper_Res_Description=Startup New Users Configuration
#AutoIt3Wrapper_Res_LegalCopyright=©2014 Derun Vitaliy
;#AutoIt3Wrapper_Res_Comment=Демонстрационная программа
#AutoIt3Wrapper_Res_Field=OriginalFilename|SNUC.exe
;#AutoIt3Wrapper_Res_Field=ProductName|Ресурсы в AutoIt
#AutoIt3Wrapper_Res_Field=Release|1.0.1.0
#EndRegion

;-------------Global variables-------------
Global Const $sTempDir = "C:\TEMP\Backuper"
Global $sReIcon = $sTempDir & "\ReIcon\Save.cmd"
Global $sReIconSave = $sTempDir & "\ReIcon\IconLayouts.ini"
Global $PSTattachedIni = $sTempDir & "\PSTattached.ini"
Global $sUserNASDir = 'U:\' & @UserName
Global $sUserFolderNASDir = 'U:\' & @UserName & '\' & @UserName
;-------------Third-party files------------
FileInstall( ".\ReIcon\ReIcon.exe" , $sTempDir & "\ReIcon\ReIcon.exe" , 1)
FileInstall( ".\ReIcon\ReIcon.ini" , $sTempDir & "\ReIcon\ReIcon.ini" , 1)
FileInstall( ".\ReIcon\Save.cmd" , $sReIcon , 1)
FileInstall( ".\PSTattached.ps1" , $sTempDir & "\PSTattached.ps1" , 1)

;---------------GUI------------------------
Opt("GUIOnEventMode", 1)
HotKeySet("{ESC}", "specialEvents") ; Выход из скрипта по нажатию ESC

Global $iGuiNumb,$hGUI, $fileWay

Const $iIndent = 15	; Отступ слева в пикселях
Const $iMargin = 20	; Отступ сверху в пикселях
Const $iSpasing = 30	; Шаг сетки
$iTmpHgt = $iMargin + $iSpasing ; Позиция n-го елемента по вертикали ( первое значени - позиция 2-го елемента)

;-----------Main Window--------------------
Func MW()
	GUIDelete($hGUI)
	$iGuiNumb = 0
	$hGUI = GUICreate("Backuper", 280, 115)
		GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
		GUISetState(@SW_SHOW)
	GUICtrlCreateLabel("What backup you want to do?", $iIndent, $iMargin, 240)
		GUICtrlSetFont(-1, 14)
	GUICtrlCreateButton("Cancel", $iIndent-10, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "PSTattached")
	GUICtrlCreateButton("Regular Backup", $iIndent+80, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, 'RegularBackup1')
	GUICtrlCreateButton("Manual Backup", $iIndent+170, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "FMB")
	GUICtrlCreateLabel( "Created by Derun Vitaliy", 170, 104)
		GUICtrlSetFont(-1, 7)
EndFunc
;-------------------------------------------
;-----First page of Manual Backup(FMB)------
Func FMB()
	GUIDelete($hGUI)
	$iGuiNumb = 1
	$hGUI = GUICreate("Backuper", 280, 115)
		GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
	GUISetState(@SW_SHOW)
	$btnNext = GUICtrlCreateButton("Next", $iIndent+170, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "SMB")
	GUICtrlCreateButton("Back", $iIndent+80, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "BackBt")
EndFunc
;-------------------------------------------
;-----Second page of Manual Backup(SMB)-----
Func SMB()
	GUIDelete($hGUI)
	$iGuiNumb = 2
	$hGUI = GUICreate("Backuper", 280, 115)
		GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
		GUISetState(@SW_SHOW)
	GUICtrlCreateButton("Next", $iIndent+170, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "TMB")
	GUICtrlCreateButton("Back", $iIndent+80, $iTmpHgt , 90,50)
		GUICtrlSetOnEvent(-1, "BackBt")
EndFunc
;-------------------------------------------
;-----Third page of Manual Backup(TMB)------
Func TMB()
	GUIDelete($hGUI)
	$iGuiNumb = 3
	$hGUI = GUICreate("Backuper", 450, 145)
		GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
		GUISetState(@SW_SHOW)
	GUICtrlCreateLabel("Choose the destination folder", $iIndent+90, $iMargin, 240)
		GUICtrlSetFont(-1, 14)
	$fileWay = GUICtrlCreateInput("", $iIndent, $iTmpHgt, 380, 20)
	GUICtrlCreateButton("...", $iIndent+390, $iTmpHgt , 40,20)
		GUICtrlSetOnEvent(-1, "FOD")
	$btnStart = GUICtrlCreateButton("Start", $iIndent+330, $iTmpHgt+40 , 90,50)
	$btnCancel = GUICtrlCreateButton("Cancel", $iIndent+240, $iTmpHgt+40 , 90,50)
		GUICtrlSetOnEvent(-1, "specialEvents")
	GUICtrlCreateButton("Back", $iIndent+150, $iTmpHgt+40 , 90,50)
		GUICtrlSetOnEvent(-1, "BackBt")
EndFunc
;-------------------------------------------
;---------File Open Dialog (FOD)-----------
Func FOD()
	$hFOD = FileSelectFolder("Choose file...",GUICtrlRead($fileWay))
	If @error Then
	Else
		GUICtrlSetData($fileWay, $hFOD)
	EndIf
EndFunc
;-------------------------------------------
;----------------Back button----------------
Func BackBt()
	Select
		Case $iGuiNumb=1
			MW()
		Case $iGuiNumb=2
			FMB()
		Case $iGuiNumb=3
			SMB()
	EndSelect
EndFunc
;-------------------------------------------
;------------=>End GUI------------------------

Func DiffInFolder()

	Local $asDifferent[1]= [0], $i, $aMatch[1]= [0]
	Local $asUserDir = _RecFileListToArray(@UserProfileDir, "*", 2, 0, 0, 2) ;--- Получение списка папок в UserDir
	Local $avUserDirDefault = IniReadSection(@WorkingDir & "\param.ini" , "File");--- Считываем маску стандартных значений для этой папки
	$i = 1 ;--- Счетчик для перебора стандартных значений
	$n = 1 ;--- Счетчик для выявление несовпадений

	While $i<= UBound($avUserDirDefault)-1
		$iDifferent = _ArraySearch( $asUserDir, $avUserDirDefault[$i][1])
		_ArrayAdd($aMatch,$iDifferent)
		While $n<=$iDifferent
		If $n=$iDifferent Then
			$n = $iDifferent + 1
		Else
			_ArrayAdd($asDifferent,$n)
			$n += 1
		EndIf
		If $i = UBound($avUserDirDefault)-1 Then
			$n = _ArrayMax($aMatch,1)
			While $n < UBound($asUserDir)-1
				$n += 1
				_ArrayAdd($asDifferent,$n)
			WEnd
		EndIf
		WEnd
		$i += 1
	WEnd

	$i = 0
	Global $avIniWrite = $asDifferent
	ReDim $avIniWrite[UBound($asDifferent)][2]
	While $i<= UBound($asDifferent)-1
			$avIniWrite[$i][0] = $asDifferent[$i];
			$avIniWrite[$i][1] = $asUserDir[$asDifferent[$i]];
		$i += 1
	WEnd
EndFunc
;--------Check what I must copy-------------
Func DiffInFoldCheck()
	$hGUI = GUICreate("Backuper", 280, (UBound($avIniWrite)*35))
		GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
		GUISetState(@SW_SHOW)
	$iTmpHgt = 0
	$i = 1
	Global $aGUI[0]
	ReDim $aGUI[UBound($avIniWrite)]
	While $i<= UBound($avIniWrite) - 1
		$iTmpHgt += $iSpasing
		$aGUI[$i] = GUICtrlCreateCheckbox($avIniWrite[$i][1], $iMargin, $iTmpHgt)
		GUICtrlSetState(-1, $GUI_CHECKED)
		$i += 1
	WEnd
	$i = 1
	While $i<= UBound($aGUI) - 1
		$avIniWrite[$i][0] = $aGUI[$i]
		$i += 1
	WEnd
	GUICtrlCreateButton("Copy", $iIndent+130, $iTmpHgt+20 , 90,50)
		GUICtrlSetOnEvent(-1, 'RegularBackup3')
	GUICtrlCreateButton("Do not copy", $iIndent+35, $iTmpHgt+20 , 90,50)
		GUICtrlSetOnEvent(-1, 'RegularBackup2')
EndFunc


;--------------Regular Backup Part1---------------
Func RegularBackup1()
	DirCreate($sTempDir)
	CheckNAS()
	NetDrivesSave()
	IcoPosSave()
	PSTattached()
;~ 	DiffInFolder()
;~ 	DiffInFoldCheck()
	StandartFolderCopy()
	;MsgBox(4096, '', 'End')
	;SpecialEvents()
EndFunc
;--------------Regular Backup Part2---------------
Func RegularBackup2()

EndFunc

Func RegularBackup3()
	RegularBackup2()
	GetCheckboxStatus()

EndFunc


Func GetCheckboxStatus()
	$i = 1
	While $i<= UBound($aGUI) - 1
		If GUICtrlRead($aGUI[$i]) = 1 Then
		Else
			$iDell = _ArraySearch( $avIniWrite, $aGUI[$i])
			_ArrayDelete($avIniWrite, $iDell)
		EndIf
		$i += 1
	WEnd
	;_ArrayDisplay($avIniWrite)
	IniWriteSection( $sUserNASDir & '\' & 'backup.ini', 'DiffFolder', $avIniWrite)
EndFunc


Func CheckNAS()
	$sIfExist = DriveMapGet('U:')
	If $sIfExist = '\\10.193.2.1\Backups' Then
	Else
		DriveMapAdd('U:', '\\10.193.2.1\Backups', 1, 'admin', 'agemoi123')
	EndIf
	Local $aNASDir = _RecFileListToArray('U:', '*', 2, 0, 0, 0) 		;--- Получение списка папок в Backups на NAS
	Local $iUserDirExist = _ArraySearch( $aNASDir, @UserName)			 ;---  Поиск папки в масиве с именнем @UserName

	If $iUserDirExist > -1 Then 										;--- Проверка - существует ли папка @UserName
		$iUserDirExist = _ArraySearch( $aNASDir, '_' & @UserName)
		If $iUserDirExist > -1 Then										;--- Проверка - существует ли папка '_' & @UserName
			DirRemove('U:\' & '_' & @UserName, 1)
			DirMove('U:\' & @UserName, 'U:\' & '_' & @UserName)
			;DirCreate('U:\' & @UserName)								;--- Можно добавить проверку на ошибки - функция возвращает 1 если создана или 0 если нет
			Sleep(5000)
			DirCreate('U:\' & @UserName & '\' & @UserName)				;---
		Else
			DirMove('U:\' & @UserName, 'U:\' & '_' & @UserName)
			;DirCreate('U:\' & @UserName)
			Sleep(5000)
			DirCreate('U:\' & @UserName & '\' & @UserName)
		EndIf
	Else
		;DirCreate('U:\' & @UserName)
		Sleep(1500)
		DirCreate('U:\' & @UserName & '\' & @UserName)
	EndIf

EndFunc

Func NetDrivesSave()
	$aNetDrive = DriveGetDrive('NETWORK')
	Local $i = 0
	$avNetDriveIniWrite = $aNetDrive
	ReDim $avNetDriveIniWrite[UBound($aNetDrive)][2]
	While $i <= UBound($aNetDrive) - 1
		$avNetDriveIniWrite[$i][0] = $aNetDrive[$i];
		$avNetDriveIniWrite[$i][1] = DriveMapGet($aNetDrive[$i]);
		$i += 1
	WEnd
	IniWriteSection( $sUserNASDir & '\' & 'backup.ini', 'NetworkDrives', $avNetDriveIniWrite)
	IniDelete($sUserNASDir & '\' & 'backup.ini', 'NetworkDrives', 'u:')
EndFunc   ;==>NetDrivesSave

Func IcoPosSave()
	$temp = Run($sReIcon)
	ProcessWaitClose($temp)
	FileMove( $sReIconSave , $sUserNASDir  , 1)
EndFunc

Func StandartFolderCopy()
	;DirCopy( @UserProfileDir & '\My Documents', $sUserFolderNASDir & '\My Documents', 1)
	;DirCopy( @UserProfileDir & '\Contacts', $sUserFolderNASDir & '\Contacts', 1)
	;DirCopy( @UserProfileDir & '\Desktop', $sUserFolderNASDir & '\Desktop', 1)
	RunWait($sTempDir & '\Backup.cmd')
	DirCopy( @UserProfileDir & '\AppData\Roaming\Microsoft\Signatures', $sUserFolderNASDir & '\AppData\Roaming\Microsoft\Signatures', 1)
	Round( DirGetSize(@UserProfileDir & '\My Music')/1048576, 1)
	Round( DirGetSize(@UserProfileDir & '\My Pictures')/1048576, 1)
	Round( DirGetSize(@UserProfileDir & '\My Videos')/1048576, 1)

EndFunc



Func PSTattached()
	FileDelete($sTempDir & '\PSTattached.txt')
	RunWait("PowerShell.exe -File C:\Temp\Backuper\PSTattached.ps1")
	FileDelete($sTempDir & '\temp.txt')
	$hFile = FileOpen($sTempDir & '\PSTattached.txt', 0)
	$hResult = FileOpen($sTempDir & '\temp.txt', 1)
	FileWriteLine( $hResult, '[PSTattached]')

	While 1
		$sLine = FileReadLine($hFile)
		If @error = -1 Then ExitLoop
		$hNewString = StringReplace($sLine, ":", "=")
		FileWriteLine( $hResult, $hNewString)
	WEnd
	FileClose($hFile)
	FileClose($hResult)
	Local $attachedPSTtemp[0]
	Local $attachedPST = IniReadSection($sTempDir & '\temp.txt' , "PSTattached")
	$i = 1
	While $i <= UBound($attachedPST)-1
		$newstring = StringReplace($attachedPST[$i][1], "=", ":")
		_ArrayAdd($attachedPSTtemp, $newstring)
		$i +=1
	WEnd
	$i = 0
	$n = 0
	$m = 0
	Dim $attachedPST[(UBound($attachedPSTtemp)+2)/2][2]
	While $i <= UBound($attachedPSTtemp)-1
		;MsgBox(4096,'', $n)
		If Mod($i, 2) = 0 Then
			$m = $n + 1
			$attachedPST[$m][0] = $attachedPSTtemp[$i]
		Else

			$attachedPST[$n][1] = $attachedPSTtemp[$i]
		EndIf
		$i += 1
		$n += Mod($i, 2)
	WEnd
	IniWriteSection($sTempDir & '\PSTattached.ini', 'PSTattached', $attachedPST)
	FileDelete($sTempDir & '\temp.txt')
	FileDelete($sTempDir & '\PSTattached.txt')
	FileMove( $PSTattachedIni , $sUserNASDir  , 1)
EndFunc


MW() ; Вызов главного окна

While 1
	Sleep(500) ; Цикл ожидания
WEnd

Func specialEvents()
	Exit
EndFunc
