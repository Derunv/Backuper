; Melba23
; http://www.autoitscript.com/forum/topic/126198-recfilelisttoarray-new-version-18-oct-11/
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include <Array.au3>
#include <RecFileListToArray.au3>


;$aArray = _RecFileListToArray(@UserProfileDir, "*", 2, 0, 0, 2); список папок
;$aArray = _RecFileListToArray("\\10.193.2.1\backups", "*", 2, 0, 1, 0) ; список папок на NAS
;$aArray = _RecFileListToArray(@UserProfileDir, "*.xl*;*.doc*;*.ppt*;*.pdf;*.msg;*.pst;*.tiff;*.txt", 0, 0, 1, 2); маска файлов для копирования

;$timer = TimerInit()

;$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
;_ArrayDisplay($aArray)

;For $i = 1 To UBound($aArray) - 1
;	 $aArray[$i][1] &= "-" & $i
;Next
;$TT = $aArray[0][0]
;IniWriteSection( @UserProfileDir & "\param.ini" , "File", $aArray)
; только папки
;$aArray = _RecFileListToArray(@UserProfileDir, "*.xl*;*.doc*;*.ppt*;*.pdf;*.msg;*.pst;*.tiff", 0, 0, 0, 2)
;For $i = 0 To UBound($aArray); - 1
;	IniWrite(@UserProfileDir & "\param.ini", "File", $i, $aArray[$i])
;next

;$iSize = FileGetSize($aArray[2])

;MsgBox(4096, Round($iSize/1048576, 1), UBound($aArray))
Global $aArray, $aArraySize

$aArray = _RecFileListToArray(@UserProfileDir, "*", 2, 0, 0, 2)
$aArraySize = $aArray
For $i = 1 to UBound($aArray) - 1
	;MsgBox(4096, '', DirGetSize($aArray[1]))
	$aArraySize[$i] = Round( DirGetSize($aArray[$i])/1048576, 1)
Next
;$fin[0][1] = $aArray[1]
;_ArrayConcatenate($aArraySize, $aArray)


;MsgBox(4096, '', $aArray[0])
;_ArrayDisplay($aArray)
;MsgBox(4096, '', $aArraySize[0])
Local $avArray[$aArraySize[0]+1][2]
Local $i = 0, $iTotalSize=0
While $i<= UBound($avArray)- 1
	$avArray[$i][0] = $aArray[$i]
	$avArray[$i][1] = $aArraySize[$i]
	$iTotalSize = $aArraySize[$i]+$iTotalSize
	$i=$i + 1

WEnd
MsgBox(4096, '', $iTotalSize)
;_ArrayDisplay($avArray)

IniWriteSection( @UserProfileDir & "\param.ini" , "File", $avArray)
$var = IniReadSection(@UserProfileDir & "\param.ini" , "File")
;_ArrayDisplay($var)

; GUI
;MsgBox(4096, "", $iChbx&$i))
Opt("GUIOnEventMode", 1) ;
;------------------------------------------------
$hGUI = GUICreate("Backuper", 280, (UBound($aArray)*26))
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetState(@SW_SHOW)
;------------------------------------------------
$aGUI = $aArray
$iMargin = 20
$iTmpHgt = 0
$iPadding = 30
$iGrid = 25
 ;+ $iMargin
	$iTmpWdth = 0
;$iChbx1 = GUICtrlCreateCheckbox("My Documents", $iMargin, $iMargin)
;GUICtrlSetState(-1, $GUI_CHECKED)
;$iTmpHgt=$iMargin+$iGrid
$i = 1
While $i<= UBound($aArray)- 1
	$iTmpHgt=$iTmpHgt+$iGrid
	$aGUI[$i] = GUICtrlCreateCheckbox($aArray[$i], $iMargin, $iTmpHgt)
	$i=$i + 1
	;$iTmpHgt=$iMargin+$iGrid
	;_ArrayDisplay($aGUI)

	;MsgBox(4096, "", $iTmpHgt)
WEnd
;_ArrayDisplay($aGUI)

While 1
	Sleep(500) ; Цикл ожидания
WEnd

Func specialEvents()
	Exit
EndFunc