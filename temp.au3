#include <Array.au3>
#include <RecFileListToArray.au3>

;$timer = TimerInit()
;  ������ �����
;$aArray = _RecFileListToArray("Z:\__derun\", "*", 1, 1, 0, 2)
;$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
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

_ArrayDisplay($avArray, "$avArray ����� _ArrayInsert()")
_ArrayInsert($avArray, 4, "= ����������� =")
_ArrayDisplay($avArray, "$avArray ����� _ArrayInsert()")


Func max($x, $y) ; ���������� ������� �� ���� �����
    If $x > $y Then
        Return $x
    Else
        Return $y
    EndIf
EndFunc
$t = max(5,8)
MsgBox(4096, "", max(5,8))
#ce
; ������ ���������� ����� ���� ������ � ������� ����������.
$hSearch = FileFindFirstFile("t*.*") ; ���������� ���������� ������

; ��������, �������� �� ����� ��������
If $hSearch = -1 Then
    MsgBox(4096, "������", "�� ���� �� ������ ��� ��������� �� ������������� ����� ������")
    Exit
EndIf

While 1
    $sFile = FileFindNextFile($hSearch) ; ���������� ��� ���������� �����, ������� �� ������� �� ����������
    If @error Then ExitLoop

    $iAnswer = MsgBox(1, "��������� ���� / �������:", $sFile)
    If $iAnswer = 2 Then ExitLoop
WEnd

; ��������� ���������� ������
FileClose($hSearch)
