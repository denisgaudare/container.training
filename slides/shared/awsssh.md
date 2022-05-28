## SSH

- The virtual machines are also accessible via SSH

- This can be useful if:

  - you can't install an SSH client on your machine

  - SSH connections are blocked (by firewall or local policy)

- To use SSH, connect to the IP address of the remote VM on port 22

  (each machine runs a tiny server)

- Do not forget the private key you have been given (-i XXX.pem)

---

## Good to know

- WebSSH uses WebSocket

- If you're having connections issues, try to disable your HTTP proxy

  (many HTTP proxies can't handle WebSocket properly)

- Most keyboard shortcuts should work, except Ctrl-W

  (as it is hardwired by the browser to "close this tab")
