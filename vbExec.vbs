Option Explicit

'Variables
Dim target, username, password, strCommand, objSWbemLocator, objSWbemServices, objProcess, intProcessID, errReturn

' Get options
If WScript.Arguments.Count = 4 Then
	target = WScript.Arguments.Item(0)
	username = WScript.Arguments.Item(1)
	password = WScript.Arguments.Item(2)
	strCommand = WScript.Arguments.Item(3)
Else
	Wscript.Echo "Usage: vbExec.vbs target username password command"
	Wscript.Quit
End If


set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")
set objSWbemServices = objSWbemLocator.ConnectServer(target, "root\cimv2", username, password)
objSWbemServices.Security_.ImpersonationLevel = 3
objSWbemServices.Security_.AuthenticationLevel = 6

set objProcess = objSWbemServices.Get("Win32_Process")

errReturn = objProcess.Create(strCommand, null, null, intProcessID)

If errReturn = 0 Then
	Wscript.Echo "Process was started with ID: " & intProcessID
Else
	Wscript.Echo "Process could not be started due to error: " & errReturn
End If


