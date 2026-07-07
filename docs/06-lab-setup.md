# Safe Lab Setup

This lab is designed for defensive validation only. Do not connect production admin workstations to unknown RDP servers.

## Recommended Topology

```text
[Analyst Workstation]
        |
        | RDP
        v
[Isolated Windows Test VM]
        |
        v
[Telemetry Stack]
Sysmon + Windows Event Logs + Defender for Endpoint / Sentinel
```

## Minimum Lab Requirements

- Windows 10/11 test VM
- Sysmon installed with a known-good config
- PowerShell 5.1 or PowerShell 7
- Local admin rights on the test VM
- No shared clipboard with production systems
- NAT or host-only networking where possible

## Validation Goals

- Confirm hardening registry values are applied.
- Confirm RDP redirection controls block clipboard/drive/printer redirection.
- Confirm process creation detections fire when `mstsc.exe` launches suspicious child processes.
- Confirm KQL/Sigma rules can be mapped to your SIEM fields.

## Safety Notes

- Do not test against public systems.
- Do not use exploit payloads.
- Keep all testing inside an isolated lab.
- Snapshot the VM before making policy or registry changes.
