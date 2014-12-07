; Script Start
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>
#include <RecFileListToArray.au3>

Func PicturesFile()
	$aPicturesFile = _RecFileListToArray(@UserProfileDir , "*.bmp;*.jpg;*.png;*.jpeg;*.gif", 1 + 4 + 8, 1, 1, 2) ;--- Получение списка
	Local $i=1, $aTotalSize
	Global $aPicturesMore1MB
	While $i <= UBound($aPicturesFile)-1
		$iSize = FileGetSize($aPicturesFile[$i])
		If $iSize > 1048576 Then
			$aPicturesMore1MB += 1
		EndIf
		$aTotalSize += Round($iSize/1048576, 1)
		$i +=1
	WEnd
EndFunc

PicturesFile()