
#include <Array.au3>

#include "RecFileListToArray.au3"

#CS

Global $sAutoItDir = StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", Default, -1))
If StringRight($sAutoItDir, 5) = "beta\" Then
    $sAutoItDir = StringTrimRight($sAutoItDir, 5)
EndIf
ConsoleWrite($sAutoItDir & @CRLF)

#CE


#CS
; A sorted list of all files and folders in the AutoIt installation
$aArray = _RecFileListToArray($sAutoItDir, "*", 0, 1, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Sorted tree")

; And now ignoring the "Include" folder
$aArray = _RecFileListToArray($sAutoItDir, "*||include", 0, 1, 1)
_ArrayDisplay($aArray, "No 'Include' folder")

; A non-sorted list of all but the .exe files in the \AutoIt3 folder
$aArray = _RecFileListToArray($sAutoItDir, "*|*.exe", 1, 0, 1, 0)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Non .EXE files")

; And here are the .exe files we left out last time
$aArray = _RecFileListToArray($sAutoItDir, "*.exe", 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, ".EXE Files")

; A test for all folders and .exe files only throughout the folder tree, omitting folders beginning with I (Icons and Include)
$aArray = _RecFileListToArray($sAutoItDir, "*.exe||i*", 0, 1, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Recur with filter")

; Look for icon files - but exlude the "Icons" folder - I get just the one in "SciTE\cSnippet"
$aArray = _RecFileListToArray($sAutoItDir, "*.ico||ic*", 1, 1, 1)
If @error Then
	MsgBox(0, "Ooops!", "No ico files found")
Else
	_ArrayDisplay($aArray, "Icon files not in 'Icons' folder")
EndIf

; And to show that the filter applies to files AND folders when not recursive
$aArray = _RecFileListToArray($sAutoItDir, "*.exe", 0, 0, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Non-recur with filter")

; The filter also applies to folders when recursively searching for folders
$aArray = _RecFileListToArray($sAutoItDir, "Icons", 2, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Folder recur with filter")

; Note the exlude_folder parmeter is ignored when looking for folders - "Icons" will be excluded but "Include" will still be there
$aArray = _RecFileListToArray($sAutoItDir, "*|ic*|i*", 2, 1, 1)
_ArrayDisplay($aArray, "'Icons' out - 'Include' in")

; The root of C:\Windows showing hidden/system folders
$aArray = _RecFileListToArray("C:\Windows\", "*", 2)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Show hidden folders")
#CE


; The root of C:\Windows omitting hidden/system folders
$aArray = _RecFileListToArray(@UserProfileDir , "*.avi*;*.mpg*;*.mp4*;*.mkv;*.m4v;*.mpeg;*.wmv", 1 + 4 + 8, 1)
;ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Hide hidden folders")

