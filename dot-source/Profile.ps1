[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
param()

Set-StrictMode -Version Latest

function prompt {
    $Host.UI.RawUI.WindowTitle = $Env:USERNAME + " - " + $Env:COMPUTERNAME + " - " + $Host.Name + " - " + $Host.Version
    "PS " + $(get-location) + ">"
}

$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive\PowerShell\Modules"
$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive - KMD\PowerShell_KMD\Modules"

$modules = @(
    "PSReadLine",
    "PSScriptAnalyzer",
    "xPSDesiredStateConfiguration",
    "xDSCResourceDesigner",
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
   Also sets the PSGallery as a trusted repository.
.EXAMPLE
  Install-MissingModule

  Installs all missing modules for the current user.
.EXAMPLE
   Install-MissingModule -Verbose

   Installs all missing modules with verbose output.
.EXAMPLE
    Install-MissingModule -AllUsers

    Installs all missing modules for all local users.
#>
function Install-MissingModule {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param(
        # Install the modules for all users rather than the current user only
        [Switch]$AllUsers
    )

    $scope = if ($AllUsers) {
        "AllUsers"
    }
    else {
        "CurrentUser"
    }

    if ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty InstallationPolicy) -ne "Trusted") {
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted -Verbose:$VerbosePreference
    }

    Install-Module -Name $missingModules -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference -Scope $scope
}

$requiredFonts = @(
    "Fira Code Bold (TrueType)",
    "Fira Code Medium (TrueType)",
    "Fira Code Retina (TrueType)",
    "Fira Code Light (TrueType)",
    "Fira Code Regular (TrueType)"
)

$installedFonts = Get-Font

$requiredFonts | ForEach-Object {
    if ($installedFonts.Keys -notcontains $_) {
        Write-Warning "Font $_ missing. Download and install from https://github.com/tonsky/FiraCode"
    }
}