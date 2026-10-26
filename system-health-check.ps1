
# Windows System Health Check
# A simple read-only IT support tool

Write-Host "`n=== Windows System Health Check ===" -ForegroundColor Cyan

# Operating system information
$OS = Get-CimInstance Win32_OperatingSystem
Write-Host "`nComputer Name: $env:COMPUTERNAME"
Write-Host "Windows Version: $($OS.Caption)"
Write-Host "Last Boot: $($OS.LastBootUpTime)"

# Drive C space
$Drive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

if ($Drive) {
    $FreeGB = [math]::Round($Drive.FreeSpace / 1GB, 2)
    $TotalGB = [math]::Round($Drive.Size / 1GB, 2)

    Write-Host "`nDrive C Total: $TotalGB GB"
    Write-Host "Drive C Free: $FreeGB GB"
}

# Internet connectivity
Write-Host "`nChecking internet connectivity..."

if (Test-Connection -ComputerName "1.1.1.1" -Count 2 -Quiet) {
    Write-Host "Internet test: Successful" -ForegroundColor Green
} else {
    Write-Host "Internet test: Failed" -ForegroundColor Yellow
}

Write-Host "`nHealth check completed."
