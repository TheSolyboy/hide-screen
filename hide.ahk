isBlack := false

blackWindows := []

^+b::
    ; Toggle the state
    isBlack := !isBlack

    if (isBlack) {
        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []

        SysGet, MonitorInfo, Monitor, 1  ; Get info for the primary monitor
        x := MonitorInfoRight - 1        ; Bottom-right X coordinate (subtract 1 to stay within bounds)
        y := MonitorInfoBottom - 1       ; Bottom-right Y coordinate (subtract 1 to stay within bounds)
        MouseMove, %x%, %y%

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
        MouseMove, A_ScreenWidth // 2, A_ScreenHeight // 2  ; Move the cursor to the center of the primary screen

        for index, guiName in blackWindows {
            Gui, %guiName%:Destroy
        }
        blackWindows := []
    }
return
