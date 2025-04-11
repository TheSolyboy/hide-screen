; Define a toggle variable
isBlack := false

; Store GUI names for each monitor
blackWindows := []

; Define the hotkey Ctrl+Shift+B
^+b::
    ; Toggle the state
    isBlack := !isBlack

    if (isBlack) {
        ; Destroy any existing black windows
        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []

        ; Get the number of monitors
        SysGet, MonitorCount, MonitorCount

        ; Loop through all monitors
        Loop, %MonitorCount% {
            SysGet, MonitorInfo, Monitor, %A_Index%
            x := MonitorInfoLeft
            y := MonitorInfoTop
            w := MonitorInfoRight - MonitorInfoLeft
            h := MonitorInfoBottom - MonitorInfoTop

            ; Create a unique GUI name for the current monitor
            guiName := "BlackScreen" . A_Index

            ; Create a black window for the current monitor
            Gui, %guiName%: +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
            Gui, %guiName%:Color, 000000
            WinSet, Transparent, 255
            Gui, %guiName%:Show, NA x%x% y%y% w%w% h%h%, %guiName%

            ; Store the GUI name for later destruction
            blackWindows.Push(guiName)
        }
    } else {
        ; Destroy all black windows
        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []
    }
return