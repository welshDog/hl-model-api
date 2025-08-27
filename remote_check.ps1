<# remote_check.ps1
   Usage: .\remote_check.ps1 -Host ubuntu.tail13f1ca.ts.net -User ubuntu
#>
param(
    [string]$Host = 'ubuntu.tail13f1ca.ts.net',
    [string]$User = 'ubuntu'
)

Write-Output "Testing DNS and ping for $Host"
Resolve-DnsName $Host -ErrorAction SilentlyContinue | Select-Object Name,IPAddress
Test-NetConnection -ComputerName $Host -InformationLevel Quiet -CommonTCPPort Ping | Out-Null
Test-NetConnection -ComputerName $Host -Port 22
Test-NetConnection -ComputerName $Host -Port 8000

# Try SSH if available
if (Get-Command ssh -ErrorAction SilentlyContinue) {
    Write-Output "Attempting SSH test (will require auth)..."
    try {
        ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$User@$Host" "echo remote-ok"
    } catch {
        Write-Output "SSH test failed or requires credentials."
    }
} else {
    Write-Output "Local SSH client not found. Install OpenSSH client or use PowerShell's SSH." 
}
