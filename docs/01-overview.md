# Reverse RDP Attack Overview

A reverse RDP attack flips the normal trust model. Instead of only worrying about the client attacking the server, the RDP server can attack the connecting client.

This matters because administrators, technicians, red-teamers, and support engineers often connect from trusted endpoints into less trusted remote systems.

## Attack Surface

RDP exposes several client-side features:

- Clipboard synchronization
- File copy through clipboard or drive redirection
- Drive mapping
- Printer redirection
- Smart card redirection
- Device redirection
- Graphics/bitmap processing

Any client-side parser that accepts server-controlled data becomes a potential attack surface.

## Defensive Framing

This repo focuses on:

- Understanding the risk
- Reducing exposed RDP features
- Building detections
- Improving workstation and jump-host posture
