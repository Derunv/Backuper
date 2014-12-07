#include <Array.au3>
#include <RecFileListToArray.au3>

;$timer = TimerInit()
;  только файлы
;$aArray = _RecFileListToArray("Z:\__derun\", "*", 1, 1, 0, 2)
;$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
;_ArrayDisplay($aArray, $timer)
#cs
#include <Array.au3>

Local $avArray[10][2]

$avArray[0][0] = "JPM"
$avArray[1][0] = "Holger"
$avArray[2][0] = "Jon"
$avArray[3][0] = "Larry"
$avArray[4][0] = "Jeremy"
$avArray[5][0]= "Valik"
$avArray[6][0] = "Cyberslug"
$avArray[7][0] = "Nutster"
$avArray[8][0] = "JdeB"
$avArray[9][0] = "Tylo"

_ArrayDisplay($avArray, "$avArray ПЕРЕД _ArrayInsert()")
_ArrayInsert($avArray, 4, "= Вставленный =")
_ArrayDisplay($avArray, "$avArray ПОСЛЕ _ArrayInsert()")


Func max($x, $y) ; Возвращает большее из двух чисел
    If $x > $y Then
        Return $x
    Else
        Return $y
    EndIf
EndFunc
$t = max(5,8)
MsgBox(4096, "", max(5,8))
#ce
; Скрипт показывает имена всех файлов в текущей директории.
$hSearch = FileFindFirstFile("t*.*") ; возвращает дескриптор поиска

; Проверка, является ли поиск успешным
If $hSearch = -1 Then
    MsgBox(4096, "Ошибка", "Ни один из файлов или каталогов не соответствует маске поиска")
    Exit
EndIf

While 1
    $sFile = FileFindNextFile($hSearch) ; возвращает имя следующего файла, начиная от первого до последнего
    If @error Then ExitLoop

    $iAnswer = MsgBox(1, "Следующий файл / каталог:", $sFile)
    If $iAnswer = 2 Then ExitLoop
WEnd

; Закрывает дескриптор поиска
FileClose($hSearch)
