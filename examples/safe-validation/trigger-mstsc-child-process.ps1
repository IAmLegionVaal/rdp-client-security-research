# Safe validation helper for SIEM/Sysmon rule testing.
# This does NOT exploit RDP. It only starts mstsc.exe and launches a harmless child process pattern manually for detector tuning notes.

[CmdletBinding()]
param()

Write-Host 'This file is documentation-only. Do not use it to bypass controls.'
Write-Host 'Recommended validation: create a controlled process event in a lab and confirm your SIEM rule logic.'
Write-Host 'Example suspicious relationship to hunt for: mstsc.exe -> powershell.exe or mstsc.exe -> cmd.exe.'
Write-Host 'Because mstsc.exe normally does not spawn script interpreters, this should be high signal in most environments.'
