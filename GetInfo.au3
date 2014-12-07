#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
; Script Start
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include <Array.au3>
#include <RecFileListToArray.au3>



Local $asUserDir = _RecFileListToArray(@WorkingDir, "*", 1, 0, 0, 2) ;--- Получение списка папок в UserDir
$avIniWrite = $asUserDir
ReDim $avIniWrite[UBound($asUserDir)][2]
$i =1
While $i<= UBound($avIniWrite)-1
	$avIniWrite[$i][0] = $i
	$avIniWrite[$i][1] = $asUserDir[$i]
	$i += 1
WEnd
_ArrayDisplay($avIniWrite)
IniWriteSection( '12.ini' , 'NetworkDrives', $avIniWrite)