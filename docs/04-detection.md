# Detection Engineering

## Useful Telemetry

Collect:

- Process creation logs
- PowerShell Script Block logging
- Sysmon Event ID 1 process creation
- Sysmon Event ID 11 file creation
- Windows Security Event ID 4688
- RDP connection logs
- Defender for Endpoint device timeline
- Firewall outbound connection logs

## Suspicious Patterns

Alert on:

- `mstsc.exe` spawning script interpreters
- `mstsc.exe` or `rdpclip.exe` writing executable content
- Unexpected file drops after RDP sessions
- RDP connections to unknown public IPs
- Clipboard abuse followed by execution

## Processes of Interest

- `mstsc.exe`
- `rdpclip.exe`
- `cmd.exe`
- `powershell.exe`
- `pwsh.exe`
- `wscript.exe`
- `cscript.exe`
- `mshta.exe`
- `rundll32.exe`
