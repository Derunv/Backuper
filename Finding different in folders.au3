; Script Start
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include <Array.au3>
#include <RecFileListToArray.au3>

;--------------Finding different in folders-------------------------------------------
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
$avIniWrite = $asDifferent
ReDim $avIniWrite[UBound($asDifferent)][2]
While $i<= UBound($asDifferent)-1
		$avIniWrite[$i][0] = $asDifferent[$i];
		$avIniWrite[$i][1] = $asUserDir[$asDifferent[$i]];
	$i += 1
WEnd


Opt("GUIOnEventMode", 1) ;
;------------------------------------------------
$hGUI = GUICreate("Backuper", 280, (UBound($avIniWrite)*35))
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetState(@SW_SHOW)
;------------------------------------------------

$iMargin = 20
$iTmpHgt = 0
$iSpasing = 20
Global $i = 1
Global $aGUI[0]
ReDim $aGUI[UBound($avIniWrite)]
While $i<= UBound($avIniWrite) - 1
	$iTmpHgt += $iSpasing
	$aGUI[$i] = GUICtrlCreateCheckbox($avIniWrite[$i][1], $iMargin, $iTmpHgt)
	$i += 1
WEnd

While 1
	Sleep(500) ; Цикл ожидания
WEnd

Func specialEvents()
	Exit
EndFunc