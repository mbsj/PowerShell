[CmdletBinding()]
param()

Set-StrictMode -Version Latest

function prompt {
    $Host.UI.RawUI.WindowTitle = $Env:USERNAME + " - " + $Env:COMPUTERNAME + " - " + $Host.Name + " - " + $Host.Version
    "PS " + $(get-location) + ">"
}

$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive\PowerShell\Modules"
$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive - KMD\PowerShell_KMD\Modules"

$modulesToImport = @(
    "posh-git",
    "oh-my-posh"
)

$modulesToImport | ForEach-Object {
    Import-Module -Name $_
}

Set-Theme Agnoster

if (Get-Module -ListAvailable "PowerShellCookbook") {
    Import-Module PowerShellCookbook -Prefix "Cookbook"
}