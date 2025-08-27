
# Ubuntu AI Agent Connection Script
# Save this as connect-ubuntu.ps1

param(
    [string]$Action = "ssh",
    [string]$User = $env:USERNAME
)

$UbuntuHost = "ubuntu.tail13f1ca.ts.net"
$UbuntuIP = "100.68.37.27"

switch ($Action) {
    "ssh" {
        Write-Host "Connecting to Ubuntu via SSH..." -ForegroundColor Green
        ssh $User@$UbuntuHost
    }
    "jupyter" {
        Write-Host "Setting up Jupyter Lab port forwarding..." -ForegroundColor Green
        Write-Host "Access Jupyter at: http://localhost:8888" -ForegroundColor Yellow
        ssh -L 8888:localhost:8888 $User@$UbuntuHost
    }
    "tensorboard" {
        Write-Host "Setting up TensorBoard port forwarding..." -ForegroundColor Green
        Write-Host "Access TensorBoard at: http://localhost:6006" -ForegroundColor Yellow
        ssh -L 6006:localhost:6006 $User@$UbuntuHost
    }
    "all-ports" {
        Write-Host "Setting up multiple port forwards..." -ForegroundColor Green
        Write-Host "Jupyter: http://localhost:8888" -ForegroundColor Yellow
        Write-Host "TensorBoard: http://localhost:6006" -ForegroundColor Yellow
        Write-Host "Custom: http://localhost:8080" -ForegroundColor Yellow
        ssh -L 8888:localhost:8888 -L 6006:localhost:6006 -L 8080:localhost:8080 $User@$UbuntuHost
    }
    "test" {
        Write-Host "Testing connection to Ubuntu..." -ForegroundColor Green
        Test-NetConnection -ComputerName $UbuntuIP -Port 22
    }
    default {
        Write-Host "Usage: .\connect-ubuntu.ps1 -Action [ssh|jupyter|tensorboard|all-ports|test] -User [username]" -ForegroundColor Red
    }
}
