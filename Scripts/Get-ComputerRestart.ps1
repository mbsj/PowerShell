<#
.SYNOPSIS
    Returns the date and times as well as type of restart for servers. 
.DESCRIPTION
    Checks the windows event logs on the server and looks for both soft and hard reboots. 
    By default checks locally but can check remote servers with the ComputerName parameter.
    Will check the entire event log. If MaxAge is specified, the query will be limited to that time. This can also limit the execution time when querying a big event log.
.EXAMPLE
    .\Get-ComputerRestart.ps1
    Returns all restart events for the local computer. 
.EXAMPLE
    .\Get-ComputerRestart.ps1 -ComputerName FileServer01 
    Returns all restart events for the remote computer named FileServer01.
.EXAMPLE
    .\Get-ComputerRestart.ps1 -MaxAge (Get-Date).AddDays(-7)
    Returns all restart events for the local computer within the last week.
#>
[OutputType([Object[]])]
[CmdletBinding()]
param(
    # Name of the computer to check.
    [Parameter(Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$ComputerName,

    # Maximum age of events.
    [Parameter(Position = 1)]
    [ValidateScript( {($_ -lt (Get-Date)) -and ($_ -gt (Get-Date -Year 1970 -Month 01 -Day 01 -Hour 1 -Minute 0 -Second 0 -Millisecond 0))})]
    [DateTime]$MaxAge,

    # Credential to use when connecting to remote sessions
    [Parameter(Position = 2)]
    [ValidateNotNullOrEmpty()]
    [pscredential]$Credential
)

begin {
    $restartEvents = @()
    $session = $null

    $query = @"
SELECT 
    * 
FROM 
    Win32_NTLogEvent 
WHERE 
    LogFile = 'System' AND 
    (EventCode = 6008 OR EventCode = 1074)
"@

    if ($MaxAge) {
        $dmtfTime = [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime($MaxAge)
        $query += " AND TimeGenerated > '$dmtfTime'"
    }

    $params = @{
        Query = $query
    }

    if ($ComputerName) {
        if ($Credential) {
            $session = (New-CimSession -ComputerName $ComputerName -Credential $Credential -ErrorAction Stop)
            $params.Add("CimSession", $session)
        }
        else {
            $params.Add("ComputerName", $ComputerName)
        }
    }
}
process {
    $events = Get-CimInstance @params

    foreach ($event in $events) {
        $restartEvent = New-Object -TypeName psobject
        $restartEvent | Add-Member -MemberType NoteProperty -Name "Type" -Value ""
        $restartEvent | Add-Member -MemberType NoteProperty -Name "DateTime" -Value $event.TimeGenerated
        $restartEvent | Add-Member -MemberType NoteProperty -Name "Message" -Value ""
        $restartEvent | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $event.ComputerName
        $restartEvent | Add-Member -MemberType NoteProperty -Name "EventId" -Value $event.EventCode

        switch ($event.EventCode) {
            1074 {
                $previous = $restartEvents | Where-Object { 
                    $_.DateTime -gt $event.TimeGenerated.AddMinutes(-1) -and $_.EventId -eq $event.EventCode -and $_.ComputerName -eq $event.ComputerName
                }
                    
                if ($previous) {
                    continue
                }

                $restartEvent.Type = ($event.Message | Select-String -Pattern "Shutdown Type: (.*)").Matches.Groups[1].Value.Trim()
                
                $process = "Restarted by process: " + ($event.Message | Select-String -Pattern "The process (.*)\shas initiated").Matches.Groups[1].Value.Trim()
                $message = "$process`r`nRestarted by user: " + ($event.Message | Select-String -Pattern "on behalf of user (\S*)").Matches.Groups[1].Value.Trim()
                $comment = ($event.Message | Select-String -Pattern "Comment: (.*)").Matches.Groups[1].Value.Trim()

                if ($comment) {
                    $message += "`r`nUser comment: $comment"
                }
                $restartEvent.Message = $message
                    
                $restartEvents += $restartEvent
            }
            6008 {
                $restartEvent.Type = "Unexpected"
                $restartEvent.Message = $event.Message
                    
                $restartEvents += $restartEvent
            }
            default {
                Write-Warning "Unknown ID: $($event.EventCode)"
            }
        }
    }
}
end {
    $restartEvents

    if ($session) {
        $session | Remove-CimSession
    }
}