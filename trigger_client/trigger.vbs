Set WshShell = WScript.CreateObject("WScript.Shell")
Set WshNetwork = WScript.CreateObject("WScript.Network")
dp0 = Replace(WScript.ScriptFullName, WScript.ScriptName, "")

action = ""
Set objArgs = WScript.Arguments
if WScript.Arguments.Count < 1 Then
	WScript.Echo "Need a command-line argument to indicate what action to take!"
End If
action = WScript.Arguments(0)

ssh = """" & dp0 & "ssh.exe"""
identity = """" & dp0 & action & "_key"""
user = "restartvrpn"
account = user & "@metal-devices.vrac.iastate.edu"

' Pass the local username as the "command" so we can log it.
WshShell.Run ssh & " -o 'StrictHostKeyChecking no' -i " & identity & " " & account & " " & WshNetwork.UserName, 0, true

WshShell.Popup "metal-devices command " & action & " completed!", 15, action & " Completed", 0
