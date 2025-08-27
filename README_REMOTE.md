Remote helpers and how to use them

Files added:
- `remote_check.sh` : Bash script to check DNS/ping/SSH and optionally start uvicorn remotely.
- `remote_start_uvicorn.sh` : Bash script to start uvicorn on a remote Ubuntu host (assumes venv at ~/ai-env).
- `remote_check.ps1` : PowerShell script to check connectivity and ports from Windows.
- `remote_windows_enable_ssh.ps1` : PowerShell script to install and enable OpenSSH Server on Windows (run as Administrator).

Usage examples:

Bash (from your workstation):

    # Check remote Ubuntu host
    ./remote_check.sh ubuntu.tail13f1ca.ts.net ubuntu

    # Check and start uvicorn remotely
    ./remote_check.sh ubuntu.tail13f1ca.ts.net ubuntu start-uvicorn

    # Explicit start
    ./remote_start_uvicorn.sh ubuntu.tail13f1ca.ts.net ubuntu /home/ubuntu/myproject

PowerShell (on Windows workstation):

    # Quick connectivity checks
    .\remote_check.ps1 -Host laptop-modcoukj.tail13f1ca.ts.net -User lyndz

On the Windows laptop (run as Admin) to enable OpenSSH:

    .\remote_windows_enable_ssh.ps1

Notes and preconditions:
- Scripts assume SSH key or password access is available. If SSH requires web authentication (Tailscale SSH with one-time auth), authenticate via the browser first.
- For Ubuntu remote scripts, ensure the project is present under the project dir and a Python venv is available at `~/ai-env` (or adjust the script to your path).
- These scripts intentionally avoid destructive actions; they echo progress and logs so you can inspect.

Next steps:
1. Run `ssh ubuntu@ubuntu.tail13f1ca.ts.net` (or the appropriate user) and authenticate.
2. If SSH fails because the user doesn't exist, create the user on the remote host or use the `ubuntu` account.
3. Run `./remote_start_uvicorn.sh` to start the API on the remote host.
