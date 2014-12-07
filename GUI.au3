; Script Start
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>


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
		GUICtrlSetOnEvent(-1, "specialEvents")
	GUICtrlCreateButton("Regular Backup", $iIndent+80, $iTmpHgt , 90,50)
	;~ GUICtrlSetOnEvent(-1, "backupPressed")
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

MW() ; Вызов главного окна

While 1
	Sleep(500) ; Цикл ожидания
WEnd

Func specialEvents()
	Exit
EndFunc
