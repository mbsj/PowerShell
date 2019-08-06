<#
.SYNOPSIS
    Queries servers for disk sizes.
.DESCRIPTION
    Uses CIM to query the list of servers for drive volumes and returns the size and free space.
    If no list of servers are supplied, will check the local machine.
.EXAMPLE
    .\Get-DiskSize.ps1
    Returns disk information from the local machine.
.EXAMPLE
    .\Get-DiskSize.ps1 -ComputerName "server1","server2"
    Returns disk information from the specified servers.
.EXAMPLE
    Get-Content .\servers.txt | .\Get-DiskSize.ps1
    Gets the list of servers from servers.txt file and gets the disk size info from them.
.INPUTS
    Server name strings
.OUTPUTS
    Objects with system name, drive letter, drive label, total capacity, free space percent, free space
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$ComputerName = "localhost"
)

process {
    Get-CimInstance -ClassName Win32_Volume -ComputerName $ComputerName -Filter 'DriveType = 3 AND DriveLetter != NULL' |
        Select-Object SystemName,
                      DriveLetter,
                      Label,
                      @{Name = "Capacity"; Expression = {$_.Capacity / 1GB}},
                      @{Name = 'FreePercent'; Expression = {($_.FreeSpace / $_.Capacity) * 100} },
                      @{Name = 'FreeSpace'; Expression = {($_.FreeSpace / 1GB)} }
}