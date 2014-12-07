#include <GUIConstantsEx.au3>
#include <Array.au3>
#cs
Example()

Func Example()
    ; Font type to be used for setting the font of the controls.
    Local Const $sFont = "Comic Sans Ms"

    ; Create a GUI with various controls.
    Local $hGUI = GUICreate("Example", 300, 200)

    ; Create label controls.
    GUICtrlCreateLabel("A string of text underlined", 10, 10, 185, 17)
    GUICtrlSetFont(-1, 9, 400, 4, $sFont) ; Set the font of the previous control.

    Local $idLabel2 = GUICtrlCreateLabel("A string of italic text", 10, 30, 185, 17)
    GUICtrlSetFont($idLabel2, 9, 400, 2, $sFont) ; Set the font of the controlID stored in $iLabel2.

    Local $idLabel3 = GUICtrlCreateLabel("A string of text with a strike through", 10, 50, 290, 17)
    GUICtrlSetFont($idLabel3, 9, 400, 8, $sFont) ; Set the font of the controlID stored in $iLabel3.

    Local $idClose = GUICtrlCreateButton("Close", 210, 170, 85, 25)

    ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idClose
                ExitLoop

        EndSwitch
    WEnd

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>Example
#ce
#cs
Dim $aTest[1][3] = ['0-0', '0-1', '0-2']]
_ArrayDisplay($aTest)
Global $Array[0][0]
_ArrayAdd($Array, "gjkgh", "dfg")
;_ArrayAdd($Array, "gjkdfggh")
_ArrayDisplay($Array)
#ce

;~ #include <Array.au3>

;~ Local $avArray[10]

;~ $avArray[0] = "JPM"
;~ $avArray[1] = "Holger"
;~ $avArray[2] = "Jon"
;~ $avArray[3] = "Larry"
;~ $avArray[4] = "Jeremy"
;~ $avArray[5] = "Valik"
;~ $avArray[6] = "Cyberslug"
;~ $avArray[7] = "Nutster"
;~ $avArray[8] = "JdeB"
;~ $avArray[9] = "Tylo"

;~ _ArrayDisplay($avArray, "$avArray ПЕРЕД _ArrayDelete()")
;~ _ArrayDelete($avArray, 8)
;~ _ArrayDisplay($avArray, "$avArray ПОСЛЕ _ArrayDelete()")

;~ $text = FileRead('C:\Temp\PSTattached.txt')
;~ $sText = StringReplace($text, ":", "=")
;~ MsgBox(4096, '', $text)

; Читает построчно текст, пока не будет достигнут конец файла EOF


Run("PowerShell.exe -File C:\Users\Derunv\Documents\Developing\Backuper\PSTattached.ps1")


