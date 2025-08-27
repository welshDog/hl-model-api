# remote_windows_enable_ssh.ps1
# Run this script as Administrator on the Windows machine to install and enable OpenSSH server.
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType Automatic
# Allow SSH in Windows Firewall
if (-not (Get-NetFirewallRule -DisplayName 'OpenSSH SSH Server' -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -Name 'SSHD-In' -DisplayName 'OpenSSH SSH Server' -Direction Inbound -LocalPort 22 -Protocol TCP -Action Allow
}
Write-Output 'OpenSSH server installed and started. Verify with: Get-Service -Name sshd'
