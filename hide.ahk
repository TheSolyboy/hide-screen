isBlack := false

blackWindows := []

^+b::
    ; Toggle the state
    isBlack := !isBlack

    if (isBlack) {
        ; Destroy any existing black windows
        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []

        SysGet, MonitorCount, MonitorCount

        Loop, %MonitorCount% {
            SysGet, MonitorInfo, Monitor, %A_Index%
            x := MonitorInfoLeft
            y := MonitorInfoTop
            w := MonitorInfoRight - MonitorInfoLeft
            h := MonitorInfoBottom - MonitorInfoTop

            guiName := "BlackScreen" . A_Index

            Gui, %guiName%: +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
            Gui, %guiName%:Color, 000000
            WinSet, Transparent, 255
            Gui, %guiName%:Show, NA x%x% y%y% w%w% h%h%, %guiName%

            blackWindows.Push(guiName)
        }
    } else {
        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []
    }
return
