warn = MsgBox("WARNING: This malware can destroy your computer (not really), are you sure you want to run the malware?", vbYesNo + vbQuestion, "winbye.vbs")

If warn = vbYes Then

warn2 = MsgBox("SECOND WARNING (for avoiding misclick): This malware can encrypt your files, doxx you, kill your pc (not really), disable task manager, force kill regedit on loop, are you actually sure to run the malware?", vbYesNo + vbQuestion, "winbye.vbs")
  
  If warn2 = vbYes Then
set shell = createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")
shell.run fso.getparentfoldername(wscript.scriptfullname) & "\run\runmalware.vbs"
elseif warn2 = vbNo Then
    WScript.Quit
end if
elseif warn1 = vbNo Then
    WScript.Quit
end if
