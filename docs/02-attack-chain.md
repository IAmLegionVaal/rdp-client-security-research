# Attack Chain

## Simplified Flow

1. User connects to an RDP server using an RDP client such as `mstsc.exe`.
2. The server sends protocol data back to the client.
3. Client-side components parse server-controlled data.
4. Redirected channels such as clipboard or drive sharing expand the attack surface.
5. If vulnerable parsing or unsafe data handling exists, the server may influence client-side behavior.

## Clipboard Redirection Flow

In normal copy/paste over RDP:

1. Clipboard content is created on one side of the session.
2. RDP clipboard components serialize the data.
3. The data is sent across the RDP virtual channel.
4. The receiving side deserializes and exposes it to the local clipboard.
5. The focused local process can paste or read the content.

## Security Concern

The client often trusts data flowing from the remote session. Malformed metadata, unexpected file descriptors, path manipulation, or parser bugs can create risk.
