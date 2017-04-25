Set-StrictMode -Version Latest

function prompt
{
    $host.ui.rawui.WindowTitle = $Env:USERNAME + " - " + $Env:COMPUTERNAME + " - " + $Host.Name + " - " + $Host.Version
    "PS " + $(get-location) + ">"
}

$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive\PowerShell\Modules"
$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive - KMD\PowerShell_KMD\Modules"

$modules = @(
    "PSReadLine",
    "PowerShellCookbook",
    "PSScriptAnalyzer",
    "xPSDesiredStateConfiguration",
    "xDSCResourceDesigner",
    "ISEModuleBrowserAddon",
    "ScriptBrowser",
    "ISERemoteTab",
    "Pester"
)

$missingModules = @()
$modules | ForEach-Object {
    if (-not (Get-Module -ListAvailable $_)) {
        Write-Warning "Module $_ not installed."
        $missingModules += $_
    }
}

if (Get-Module -ListAvailable "PowerShellCookbook") {
    Import-Module PowerShellCookbook -Prefix "Cookbook"
}

if ($missingModules) {
    Write-Warning "To install missing modules, use function `"Install-MissingModules`""
}

<#
.Synopsis
   Installs missing modules.
.DESCRIPTION
   Installs any and all missing modules as listed in variable $missingModules
.EXAMPLE
  Install-MissingModule

  Installs all missing modules. 
.EXAMPLE
   Install-MissingModule -Verbose

   Installs all missing modules with verbose output.
#>
function Install-MissingModule
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    Param()

    Install-Module -Name $missingModules -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference
}