# Affected Client Areas

Historically researched areas include:

- Microsoft RDP client components
- FreeRDP
- rdesktop
- xrdp-related protocol handling

## Common Bug Classes

- Integer overflow
- Integer truncation
- Heap buffer overflow
- Out-of-bounds read/write
- Insufficient length validation
- Unsafe clipboard/file metadata handling

## Defensive Takeaway

Do not treat RDP as a one-way trust relationship. A server can influence the client through protocol responses and redirected channels.
