<#
.SYNOPSIS
    Uninstalls installed PowerShell modules where newer versions exist.
.DESCRIPTION
    Parses the list of installed modules on the local computer. 
    If a module has several versions installed, the older versions are uninstalled, leaving only the newest version. 
    System modules, modules installed in C:\Windows\system32\WindowsPowerShell\v1.0\Modules, are ignored.
.EXAMPLE
    .\Uninstall-DeprecatedModule.ps1
    Uninstalls all old versions of all modules. Will ask for confirmation for each one.
.EXAMPLE
    .\Uninstall-DeprecatedModule.ps1 -Name "PSScriptAnalyzer","xPSDesiredStateConfiguration"
    Uninstalls old versions of the two modules "PSScriptAnalyzer" and "xPSDesiredStateConfiguration"
.EXAMPLE
    .\Uninstall-DeprecatedModule.ps1 -Confirm:$false
    Uninstalls all old versions of all modules. Will not ask for confirmation before uninstalling.
.INPUTS
    String array with one or more name filters
.OUTPUTS
    None
.NOTES
    Will only work for modules that can be uninstalled with the "Uninstall-Module" cmdlet.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
Param (
    # The name of of the modules to remove
    [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$Name = "*"
)

begin {
    Write-Verbose "Getting modules with old versions..."
    $duplicateModuleGroup = Get-Module -Name $Name -ListAvailable -ErrorAction Stop -Verbose:$false | Where-Object Path -NotLike "C:\Windows\system32\*" | Group-Object -Property Name | Where-Object -Property Count -GT 1
    if (($duplicateModuleGroup | Measure-Object).Count -gt 0) {
        Write-Verbose "Modules with old versions: $(($duplicateModuleGroup.Group | Select-Object -ExpandProperty Name -Unique) -join ", ")"
    } 
    else {
        Write-Verbose "No modules with duplicate versions found"
    }
}
    
process {
    foreach ($moduleGroup in $duplicateModuleGroup) {
        Write-Verbose "Processing module: $($moduleGroup.Name)"
        $duplicateVersions = $moduleGroup.Group | Group-Object -Property version | Where-Object Count -gt 1
        
        if ($duplicateVersions) {
            $moduleName = $duplicateVersions.Group | Select-Object -ExpandProperty Name -Unique
            $versions = $duplicateVersions.Group | Select-Object -Property Version, Path

            Write-Warning "Skipping module $moduleName. Duplicate versions exist: $($versions | Format-Table | Out-String)"
        }
        else {
            $newestVersion = $moduleGroup.Group | Sort-Object -Property Version -Descending | Select-Object -First 1
            Write-Verbose "Newest version is $($newestVersion.Version)"

            $oldVersions = $moduleGroup.group | Where-Object Version -ne $newestVersion.Version
            Write-Verbose "Old versions: $(($oldVersions.Version) -join ", ")"

            $oldVersions | ForEach-Object {
                if ($pscmdlet.ShouldProcess("$($_.Name) v. $($_.Version)", "Uninstall module")) {
                    Uninstall-Module -Name $_.Name -RequiredVersion $_.Version
                }
            }
        }
    }
}

end {
}