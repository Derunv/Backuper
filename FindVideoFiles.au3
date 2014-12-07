; Script Start
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>
#include <RecFileListToArray.au3>

Func VideoFile()
	$aVideoFile = _RecFileListToArray(@UserProfileDir , "*.avi*;*.mpg*;*.mp4*;*.mkv;*.m4v;*.mpeg;*.wmv", 1 + 4 + 8, 1, 1, 2) ;--- Получение списка папок в Backups на NAS
	Local $i=1, $aTotalSize
	Global $aVideoMore1GB
	While $i <= UBound($aVideoFile)-1
		$iSize = FileGetSize($aVideoFile[$i])
		If $iSize > 1073741824 Then
			$aVideoMore1GB += 1
		EndIf
		$aTotalSize += Round($iSize/1048576, 1)
		$i +=1
	WEnd
EndFunc

VideoFile()