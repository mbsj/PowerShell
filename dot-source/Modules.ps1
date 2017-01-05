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
    "WASP"
)

$Global:missingModules = @()
$modules | ForEach-Object {
    if (-not (Get-Module -ListAvailable $_)) {
        Write-Warning "Module $_ not installed."
        $missingModules += $_
    }
}

if (Get-Module -ListAvailable "PowerShellCookbook") {
    Import-Module PowerShellCookbook -Prefix "Cookbook"
}

if ($Global:missingModules) {
    Write-Warning "To install missing modules, use function `"Install-MissingModules`""
}

<#
.Synopsis
   Installs missing modules.
.DESCRIPTION
   Installs any and all missing modules as listed in variable $Global:missingModules
.EXAMPLE
  Install-MissingModules

  Installs all missing modules. 
.EXAMPLE
   Install-MissingModules -Verbose

   Installs all missing modules with verbose output.
#>
function Install-MissingModules
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    Param()

    Install-Module -Name $Global:missingModules -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference
}