#cs ----------------------------------------------------------------------------
	Migration unit for windows 7

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#cs
	$aFolderArrayName - массив имен папок в месте назначения
	$aFolderArraySize - массив размеров папок в месте назначения
	$iTotalSize - общий размер папок в месте назначения
	$aFolderArray - массив имен и размеров папок в месте назначения
#ce



; Script Start - Add your code below here
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include <Array.au3>
#include <RecFileListToArray.au3>

Global $aFolderArray, $aFolderArraySize, $iTotalSize, $aFolderArrayName
Local $iTotalSize = 0, $aGUI[UBound($aFolderArray) - 1]

$aFolderArrayName = _RecFileListToArray(@UserProfileDir, "*", 2, 0, 0, 2)
$aFolderArraySize = $aFolderArray

Func getFolderArray()
	For $i = 1 to UBound($aFolderArray) - 1
		$aFolderArraySize[$i] = Round( DirGetSize($aFolderArray[$i])/1048576, 1)
	Next
	Local $avArray[$aFolderArraySize[0]+1][2]
	Local $i = 0
	While $i<= UBound($avArray)- 1
		$avArray[$i][0] = $aFolderArray[$i]
		$avArray[$i][1] = $aFolderArraySize[$i]
		$iTotalSize = $aFolderArraySize[$i]+$iTotalSize
		$i=$i + 1
	WEnd
EndFunc
getFolderArray()
; GUI
;MsgBox(4096, "", $iChbx&$i))
Opt("GUIOnEventMode", 1) ;
;------------------------------------------------
$hGUI = GUICreate("Backuper", 280, (UBound($aFolderArray)*25))
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetState(@SW_SHOW)
;------------------------------------------------


;$iChbx1 = GUICtrlCreateCheckbox("My Documents", $iMargin, $iMargin)
;GUICtrlSetState(-1, $GUI_CHECKED)
;$iTmpHgt=$iMargin+$iGrid
$i = 1
While $i<= UBound($aFolderArray)- 1
	$iMargin = 20
	$iPadding = 30
	$iGrid = 25
	$iTmpHgt = 0 + $iMargin
	$iTmpWdth = 0
	$aGUI[$i] = GUICtrlCreateCheckbox($aFolderArray[$i] & $avArray[$i][1], $iTmpHgt, $iMargin)
	$iTmpHgt=$iMargin+$iGrid
WEnd

Func getFileArray()

EndFunc

While 1
	Sleep(500) ; Цикл ожидания
WEnd

Func specialEvents()
	Exit
EndFunc










;DriveMapAdd("U:", "\\10.193.2.1\Backups", 1, "admin", "agemoi123")
;If
;DirCreate("\\10.193.2.1\Backups\")