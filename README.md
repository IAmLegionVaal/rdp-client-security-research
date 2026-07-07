# Reverse RDP Attack Research

Defensive security research notes for **Reverse RDP** attacks, where a malicious or compromised RDP server abuses client-side RDP features or parsing bugs to attack the connecting client.

> This repository is for defensive learning, hardening, detection engineering, and blue-team documentation. It does not include exploit code.

## Focus Areas

- RDP client-side attack surface
- Clipboard redirection abuse
- Historical RDP client CVEs
- File copy and clipboard data flow
- Windows hardening guidance
- Detection logic for SOC/SIEM teams

## Core Concept

Normally, an RDP client connects to a server. In a reverse RDP attack, the server becomes the attacker and targets the client machine through redirected channels, malformed protocol data, or clipboard/file redirection behavior.

## High-Risk RDP Features

- Clipboard redirection
- Drive redirection
- Printer redirection
- Smart card redirection
- Device/audio redirection
- File copy over redirected channels

## Repository Layout

```text
docs/                 Research notes and defensive writeups
detections/           Sigma, KQL, and Sysmon detection logic
hardening/            Windows hardening scripts and guidance
diagrams/             Architecture and attack-flow diagrams
.github/workflows/    GitHub Actions checks
```

## Defensive Controls

- Patch Windows and RDP clients regularly.
- Disable clipboard redirection where not operationally required.
- Restrict outbound RDP to trusted destinations.
- Use hardened jump hosts.
- Monitor suspicious `mstsc.exe` and `rdpclip.exe` behavior.
- Alert on unexpected child processes spawned after RDP sessions.

## References

See [`docs/references.md`](docs/references.md).
