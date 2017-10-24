#Requires -Version 4
<#
.SYNOPSIS
    Verifies the installed hotfixes on servers from a baseline.
.DESCRIPTION
    A baseline of hotfix IDs is either supplied manually or generated from all installed hotfixes on all the servers. 
    Then lists which servers are missing which hotfixes based on the baseline. 
    
    A dictionary is returned with the computer names as keys and the value as an array of missing hotfix IDs. 
    If -ByHotfix is used, the dictionary will contain hotfix IDs as the key and the value will be an array of computer names where the hotfix is missing.
.EXAMPLE
    .\Verify-MissingHotfix.ps1 -ComputerName "server1","server2","server3"
    Creates a baseline of installed hotfixes on the three servers, assuming that the patch levels are different. 
    Then lists which hotfixes are not installed on which servers.
.EXAMPLE
    .\Verify-MissingHotfix.ps1 -ComputerName "server1","server2","server3" -BaseLine "KB1234567","KB7654321","KB1726354"
    Takes the supplied baseline and checks each server. 
.EXAMPLE
    .\Verify-MissingHotfix.ps1 -ComputerName "server1","server2","server3" -ByHotfix
    Returns a list ordered by the hotfix IDs rather than the computer names.
.EXAMPLE
    .\Verify-MissingHotfix.ps1 -ComputerName "server1","server2","server3" | Format-Table -Property Key,@{Name="Count";Expression={$_.Value.Count}}
    Lists the number of missing hotfixes for each server rather than the IDs.
.EXAMPLE
    $missingHotfixes = .\Verify-MissingHotfix.ps1    
    $missingHotfixesFormatted = $missingHotfixes.GetEnumerator() | Select-Object -Property Key,@{Name="Count";Expression={$_.Value.Count}},@{Name="IDs";Expression={$_.Value -join ", "}} 
    $missingHotfixesFormatted | Export-Csv -Delimiter ";" -Path ([Environment]::GetFolderPath("Desktop") + "\Hotfixes.csv")
    
    Takes the list of missing hotfixes and formats it with three colums; one with computer names, one with total missing hotfix count and lastly a column with the missing hotfix IDs.
    Then exports as CSV which can be imported in i.e. excel.
.EXAMPLE
    $baseline = Get-HotFix -ComputerName "server1" | Select-Object -ExpandProperty HotFixID
    .\Verify-MissingHotfix.ps1 -ComputerName "server2","server3" -BaseLine $baseline
    Uses the Get-HotFix cmdlet to create a baseline 
.INPUTS
    String array with computer names
    Optional string array with hotfix IDs for baseline
.OUTPUTS
    Dictionary list with computer names in the key and any missing hotfix IDs in a string array in the value. If no missing hotfixes, the value array will be empty. 
    If the -ByHotfix parameter is used, the key will be hotfix IDs and the value will be the computernames where the hotfix is missing.
#>
[CmdletBinding(SupportsShouldProcess = $false, ConfirmImpact = 'Low')]
Param (
    # Name of the computers to check
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$ComputerName,
        
    # Hotfix IDs to compare is computers hotfix level against
    [Parameter(Mandatory = $false, Position = 1)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("KB\d{1,7}")]
    [String[]]$Baseline,

    # Creates a dictionary with hotfixes as the key and the computer where its missing in the value 
    [Parameter()]
    [Switch]$ByHotfix
)
    
begin {
}
    
process {
    workflow getHotfixes {
        param($computers)

        foreach -parallel -throttlelimit $computers.Count ($computer in $computers) {
            InlineScript {
                @{
                    ComputerName = $using:computer
                    HotfixIDs    = @(Get-HotFix -ComputerName $using:computer | Select-Object -ExpandProperty HotFixID)
                }
            }
        }
    }

    Write-Verbose "Getting hotfixes from $($ComputerName.Count) computers"
    $computerHotfixes = getHotfixes -computers $ComputerName

    if (-not $Baseline) {
        Write-Verbose "No baseline supplied. Creating baseline from computers"
        $Baseline = $computerHotfixes | ForEach-Object { $_["HotfixIDs"] } | Select-Object -Unique
    }

    Write-Verbose "Getting missing hotfixes from baseline: `r`n`t$($Baseline -join "`r`n`t")"
    $missingHotfixes = @{}
    foreach ($computerHotfix in $computerHotfixes) {
        $missing = $Baseline | Where-Object { $computerHotfix["HotfixIDs"] -notcontains $_ }
        $missingHotfixes.Add($computerHotfix["ComputerName"], $missing)
    }
}
    
end {
    if ($ByHotfix) {
        $uniqueMissingIDs = $missingHotfixes.GetEnumerator() | Select-Object -ExpandProperty Value | Select-Object -Unique
        
        $missingComputers = @{}
        foreach ($id in $uniqueMissingIDs) {
            $missingComputers.Add($id, @())

            $computers = $missingHotfixes.Keys | Where-Object {
                $missingHotfixes[$_] -contains $id
            }

            $missingComputers[$id] += $computers
        }
        
        $missingComputers
    }
    else {
        $missingHotfixes
    }
}