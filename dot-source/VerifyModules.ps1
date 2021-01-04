[CmdletBinding(SupportsShouldProcess = $true)]
param (
)

Write-Verbose "Verifying modules are installed..."

$modules = @(
    #"PSReadLine",
    "PSScriptAnalyzer",
    "xPSDesiredStateConfiguration",
    "xDSCResourceDesigner",
    "Pester",
    "posh-git",
    "oh-my-posh"
)

Write-Verbose "The following modules are expected:"
$modules | Sort-Object | ForEach-Object {
    Write-Verbose "`t$_"
}

Write-Verbose "Getting installed modules..."
$installedModules = Get-Module -Name $modules -ListAvailable -Verbose:$false | Select-Object -ExpandProperty Name -Unique

Write-Verbose "The following modules are installed:"
$installedModules | Sort-Object | ForEach-Object {
    Write-Verbose "`t$_"
}

$missingModules = $modules | Compare-Object -ReferenceObject $installedModules | Select-Object -ExpandProperty InputObject

if ($missingModules) {
    Write-Warning "Missing module(s):"
    $missingModules | Sort-Object | ForEach-Object {
        Write-Warning "`t$_"
    }

    Write-Warning "To install missing modules, use function `"Install-MissingModule`""
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