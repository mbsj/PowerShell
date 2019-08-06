<#
.SYNOPSIS
    Gets any and all installed .NET versions
.DESCRIPTION
    Looking in the registry, returns any and all installed .NET versions in a table.
    Also returns any additional software directly related to .NET.
    By providing a computer name, a remote machine can be checked, however this requires PowerShell remoting.
.EXAMPLE
    .\Get-DotNetVersion.ps1

    Returns information for the local machine
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    No input
.OUTPUTS
    Table containing name, version and release.
#>

[CmdletBinding(DefaultParameterSetName = "Local")]
param(
    # Whatever
    [Parameter(Mandatory = $false, ParameterSetName = "Local")]
    [Switch]$Local,

    # One or more computer names for which to get .NET information
    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "Remote")]
    [ValidateScript( {Test-Connection $_})]
    [String[]]$ComputerName,

    # Credentials allowing access to remote machines specified in ComputerName
    [Parameter(Mandatory = $false, Position = 1, ParameterSetName = "Remote")]
    [pscredential]$Credential,

    # Port to use for remote connections
    [Parameter(Mandatory = $false, Position = 2, ParameterSetName = "Remote")]
    [Int]$Port
)
begin {
    $netInfoScript = {
        Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse |
            Get-ItemProperty -Name Version, Release -ErrorAction SilentlyContinue |
            Where-Object { $_.PSChildName -match '^(?!S)\p{L}' } |
            Select-Object -Property @{Name = "Name"; Expression = {$_.PSChildName}}, Version, Release |
            Sort-Object -Property Version
    }

    $params = @{
        ScriptBlock = $netInfoScript
    }

    if ($ComputerName) {
        $params.Add("ComputerName", $ComputerName)

        if ($Credential) {
            $params.Add("Credential", $Credential)
        }

        if  ($Port) {
            $params.Add("Port", $Port)
        }
    }
}
process {
    Invoke-Command @params
}