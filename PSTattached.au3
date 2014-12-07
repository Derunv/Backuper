#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Array.au3>
Func PSTattached()
	FileDelete('PSTattached.txt')
	RunWait("PowerShell.exe -File C:\Users\Derunv\Documents\Developing\Backuper\PSTattached.ps1")
	FileDelete('C:\Temp\1.txt')
	$hFile = FileOpen('C:\Temp\PSTattached.txt', 0)
	$hResult = FileOpen('C:\Temp\1.txt', 1)
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
	Local $attachedPST = IniReadSection('C:\Temp\1.txt' , "PSTattached")
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
	IniWriteSection('C:\Temp\1.ini', 'PSTattached', $attachedPST)
	FileDelete('C:\Temp\1.txt')
	FileDelete('C:\Temp\PSTattached.txt')
EndFunc

PSTattached()