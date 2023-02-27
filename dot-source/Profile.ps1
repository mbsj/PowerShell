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
    if (Get-Module -ListAvailable $_) {
        Import-Module -Name $_
    }
}

if (Get-Module -ListAvailable "oh-my-posh") {
    Set-PoshPrompt Agnoster
}

if (Get-Module -ListAvailable "PowerShellCookbook") {
    Import-Module PowerShellCookbook -Prefix "Cookbook"
}