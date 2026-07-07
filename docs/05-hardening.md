# Hardening Guidance

## Recommended Controls

- Disable clipboard redirection unless required.
- Disable drive redirection unless required.
- Use a hardened jump host for admin access.
- Block outbound RDP except to approved targets.
- Enforce Network Level Authentication where applicable.
- Keep RDP clients patched.
- Avoid connecting from privileged admin workstations to untrusted systems.

## Group Policy Paths

```text
Computer Configuration
└─ Administrative Templates
   └─ Windows Components
      └─ Remote Desktop Services
         └─ Remote Desktop Session Host
            └─ Device and Resource Redirection
```

Relevant policies:

- Do not allow Clipboard redirection
- Do not allow drive redirection
- Do not allow supported Plug and Play device redirection
- Do not allow printer redirection
