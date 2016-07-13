# Explorer options
Write-Host -ForegroundColor Green "Configuring Windows Explorer options..."
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty -Path $key -Name Hidden -Value 1
Set-ItemProperty -Path $key -Name HideFileExt -Value 0
Set-ItemProperty -Path $key -Name DontUsePowerShellOnWinX -Value 0

Stop-Process -processname explorer

# Enable Chokolatey package management
Write-Host -ForegroundColor Green "Enabling Chocolatey PackageManagement provider..."
if (!(Get-PackageProvider -Name Chocolatey)) { 
    Get-PackageProvider -Name Chocolatey -Force
}

# Install applications
Write-Host -ForegroundColor Green "Installing basic applications..."
Install-Package -Name 7zip -Force
Install-Package -Name sublimetext3 -Force

# Windows Update
if (!(Test-Path $env:windir\System32\WindowsPowerShell\v1.0\Modules\PSWindowsUpdate -PathType Container)) {
    Write-Host -ForegroundColor Green "Installing Windows Update PowerShell module..."
    Copy-Item "$env:USERPROFILE\OneDrive\PowerShell\PSWindowsUpdate" -Destination "$env:windir\System32\WindowsPowerShell\v1.0\Modules" -Recurse
}

Write-Host -ForegroundColor Green "Running Windows Update..."
Import-Module -Name PSWindowsUpdate
Get-WUInstall -MicrosoftUpdate -AcceptAll