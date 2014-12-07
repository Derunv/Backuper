; Script Start - Add your code below here
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>
#include <RecFileListToArray.au3>


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

CheckNAS()
MsgBox(4096, '', 'ok')