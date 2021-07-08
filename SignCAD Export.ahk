#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2
CoordMode, Mouse, Relative
#MaxThreadsPerHotkey 2

SleepDur := 600
#IfWinActive, OpenRoads SignCAD

Esc::
    BreakLoop := 1
return

ExportSignCAD(FileTitle){
    global SleepDur
    FileTitle := StrReplace(FileTitle, ".sgn")
        MouseClick, Left, 46, 41, 1, 0 ;Click File Menu
        Sleep SleepDur
        MouseClick, Left, 102, 185, 1, 0 ;Click Export Menu Button
        Sleep (SleepDur * 2)
        MouseClick, Left, 400, 188, 1, 100 ;Click Export to DWG Button
        WinWait Save As
        Sleep SleepDur
        Send %FileTitle%
        Sleep SleepDur
        Send {Enter}
        WinWait ACAD DWG file saving
        Sleep SleepDur
        Send {Enter}
        Sleep SleepDur
        MouseClick, Left, 1920, 35 ;Exit File
        Sleep SleepDur
        Send {Enter}
        Sleep (SleepDur * 2)
}

^e::
    WinMaximize
    Sleep 3000
    WinGetTitle, WinTitle, OpenRoads SignCAD
    If(RegExMatch(WinTitle, "[^\\]+\.sgn", FileTitle))
    {
        ExportSignCAD(FileTitle)
    }
return

^!e::
    BreakLoop := 0
    WinMaximize
    Sleep 3000
    WinGetTitle, WinTitle, OpenRoads SignCAD
    While(RegExMatch(WinTitle, "[^\\]+\.sgn", FileTitle))
    {
        If(BreakLoop = 1)
        {
            break
        }
        ExportSignCAD(FileTitle)
        WinGetTitle, WinTitle, OpenRoads SignCAD
    }
return