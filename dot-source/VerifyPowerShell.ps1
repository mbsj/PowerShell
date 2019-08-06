$powerShellPaths = @{
    "HKLM:\SOFTWARE\Microsoft\PowerShell\*\PowerShellEngine"      = "PowerShellVersion";
    "HKLM:\SOFTWARE\Microsoft\PowerShellCore\InstalledVersions\*" = "SemanticVersion"
}

Write-Verbose "Getting installed powershell versions from: `r`n`t$($powerShellPaths.Keys -join "`r`n`t")"

$installedVersions = $powerShellPaths.GetEnumerator() | ForEach-Object {
    Get-ItemPropertyValue -Path $_.Key -Name $_.Value
}

Write-Verbose "Installed PowerShell versions: `r`n`t$($installedVersions -join "`r`n`t")"

$newVersionInstalled = $false
$installedVersions | ForEach-Object {
    if ([int]($_ -split "\.")[0] -ge 6) {
        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
        $newVersionInstalled = $true
    }
}

if (-not $newVersionInstalled) {
    Write-Warning "The newer version of PowerShell (core/6) is not installed. Use the Install-PowerShell cmdlet to install the latest version."
}

<#
.SYNOPSIS
Install the latest version of PowerShell.

.DESCRIPTION
Uses a PowerShell script provided by Microsoft to install the latest version of PowerShell.
The script it executed directly from the URL and that script wíll then perform the actual installation.
By default, PowerShell will be installed using an MSI package but it is possible to install a ZIP package as well.

.PARAMETER UseZIP
Use the ZIP installation package rather than that MSI package.

.PARAMETER AddToPath
When installing the ZIP package, add the destination path to the "User" scope environment variable.

.PARAMETER Loud
When installing the MSI package, perform a "loud" installation (i.e. not quiet) to see and manipulate the installation package.

.EXAMPLE
Install-PowerShell
Performs the default, quiet, MSI package installation.

.EXAMPLE
Install-PowerShell -Loud
Will start the MSI installation but allow regular manipulation of the installation process (i.e. license agreement).

.EXAMPLE
Install-PowerShell -UseZip -AddToPath
Installs the ZIP package and adds the destination path to the "User" environment variable to simplify usage.

.NOTES
Mark Birkedal Stjerslev - 2019-08-06
#>

function Install-PowerShell {
    [CmdletBinding(DefaultParameterSetName = "MSI", SupportsShouldProcess = $true)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '')]
    param (
        # Use the ZIP installation package rather than that MSI package.
        [Parameter(ParameterSetName = "ZIP")]
        [Switch]
        $UseZIP,

        # Add the destination path to the "User" scope environment variable
        [Parameter(ParameterSetName = "ZIP")]
        [Switch]
        $AddToPath,

        # Perform a "loud" installation (i.e. not quiet) to see and manipulate the installation package.
        [Parameter(ParameterSetName = "MSI")]
        [Switch]
        $Loud
    )

    begin {
        if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            throw "PowerShell must be installed with an administrative user."
        }

        $sourceURL = "https://aka.ms/install-powershell.ps1"
        Write-Verbose "Installing PowerShell using URL: $sourceURL"
    }

    process {
        $arguments = @()

        switch ($PSCmdlet.ParameterSetName) {
            "ZIP" {
                if ($AddToPath) {
                    $arguments += "-AddToPath"
                }
            }
            "MSI" {
                $arguments += "-UseMSI"

                if (-not $Loud) {
                    $arguments += "-Quiet"
                }
            }
            Default {
            }
        }

        Write-Verbose "Arguments: $($arguments -join " ")"

        if ($pscmdlet.ShouldProcess("$env:COMPUTERNAME", "Install PowerShell from $sourceURL with arguments $($arguments -join " ")")) {

            Invoke-Expression "& { $(Invoke-RestMethod $sourceURL) } $($arguments -join " ")"
        }
    }
}