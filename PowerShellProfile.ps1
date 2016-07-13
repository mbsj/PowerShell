Set-StrictMode -Version Latest

function prompt
{
    $host.ui.rawui.WindowTitle = $Env:USERNAME + " - " + $Env:COMPUTERNAME + " - " + $Host.Name + " - " + $Host.Version
    "PS " + $(get-location) + ">"
}

Get-ChildItem "C:\Users\$env:USERNAME\OneDrive\PowerShell\dot-source\" -Include *.ps1 -Force -Recurse | ForEach-Object {
    . $_.FullName
}

try {
    Import-Module PSReadLine -ErrorAction Stop
} catch {
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | Invoke-Expression
    Install-Module PSReadLine
    Import-Module PSReadLine
}