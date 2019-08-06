<#
.SYNOPSIS
    Gets the uptime for the current machine or a selected remote machine.
.DESCRIPTION
    Uses CIM to get the last boot time of the selected machine. Based on that, calculates the total uptime.
.EXAMPLE
    .\Get-ComputerUpTime.ps1
    Returns the up time for the local computer.
.EXAMPLE
    .\Get-ComputerUpTime.ps1 -ComputerName "Server01","Server02","Server03"
    Returns the up time for the three selected servers.
.INPUTS
    Optional strings with computer names.
.OUTPUTS
    Objects with the property ComputerName and Uptime
#>
[CmdletBinding(ConfirmImpact = 'Medium')]
[OutputType([psobject])]
Param (
    # The computer to get the uptime for.
    [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$ComputerName = "localhost"
)

process {
    Get-CimInstance -ComputerName $ComputerName -Query "SELECT CSName,LastBootUpTime FROM Win32_OperatingSystem" | ForEach-Object {
        $props = @{
            ComputerName = $_.CSName
            UpTime = ((Get-Date) - ($_.LastBootUpTime))
        }

        New-Object -TypeName psobject -Property $props
    }
}