<#
.SYNOPSIS
    Searches through a file for a string. Then performs an action specified in a script block. 
.DESCRIPTION
    Takes a file as input and searches through the file. If a line in the file matches, a specific action is performed as specified in the ScriptBlock parameter. 
    
    The processing of the file can be halted by pressing Ctrl+C. At that point, the line index will be saved to a state file.
    The next time script runs, it will check if a state file exists and resume from that line number. Otherwise it will start again from line index 0.
    If the script completes, the state file will contain the last line of the file, ready to resume if more information is added to the file. If the last read line is greater than or equal the number of lines in the file, the script will start from the beginning. 
    
    The content of the matched line can be acced in the script block using the variable $Line.
    The script uses -match to match the content of the file to the current line. As such, $Matches can also be referenced in the script block.
.EXAMPLE
    .\Seach-File.ps1 -Path .\server.log -Pattern "Error:" -ScriptBlock { Send-MailMessage -From "server@comp" -To "support@comp" -Subject "Error found!" -Body $Line }
    Searcher a server log file for the string "Error:". The script block is specified to send a mail message to the support team with the content of the matched line. 
.EXAMPLE
    .\Seach-File.ps1 -Path .\server.log -Pattern "Error:" -ScriptBlock { & .\alarm.exe } -StatePath C:\temp\state.index -DoNotReset
    Searcher a server log file for the string "Error:". The script block will call an external program which will generate an alarm in monitoring. 
    The explicit state path makes it easier to reuse the state index, i.e. if automated to run every few minutes. 
    Also uses the DoNotReset switch. If the number of lines in the file is equal to the number of lines read, the read count is not reset to 0.
.INPUTS
    Strings for file path, pattern match and state file path. 
    Script block for action when pattern maches. 
.OUTPUTS
    None, unless defined in the ScriptBlock parameter.
#>
[CmdletBinding(SupportsShouldProcess = $false)]
Param (
    # Specifies the file to be searched. 
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateScript( {Test-Path $_ -Type Leaf})]
    [String]$Path,
        
    # Specifies the text to search for in the file. 
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$Pattern,

    # Specifies the script to run when a line is matched in the file. 
    [Parameter(Mandatory = $true, Position = 2)]
    [ValidateNotNull()]
    [scriptblock]$ScriptBlock,
        
    # Specifies the path to the state file.
    [Parameter(Mandatory = $false, Position = 3)]
    [ValidateNotNullOrEmpty()]
    [String]$StatePath = ".\Search-File.index",

    # Specifies that if the number of lines in the file are equal to the number of lines read, the read count will not reset to 0. The read count will still reset to 0 i the number of lines are less than the number read. 
    [Parameter()]
    [Switch]$DoNotReset
)
    
begin {
    $readCount = 0
    if (Test-Path -Path $StatePath -PathType Leaf) {
        $readCount = Import-Clixml $StatePath -ErrorAction Stop
        Write-Verbose "Found state file. Set line index start to $readCount"
    }
    else {
        Write-Verbose "No state file found"
    }
}
    
process {
    $lines = Get-Content -Path $Path

    if ($lines.Count -eq $readCount) {
        if ($DoNotReset) {
            Write-Verbose "Last read line index $readCount is equal to number of lines $($lines.Count) but DoNotReset is specified. Read count not reset."
        }
        else {
            Write-Warning "Last read line index is $readCount and number of lines is $($lines.Count). Resetting read count to 0."
            $readCount = 0
        }
    }
    elseif ($lines.Count -lt $readCount) {
        Write-Warning "Last read line index is $readCount but number of lines is $($lines.Count). Resetting read count to 0."
        $readCount = 0
    }

    [System.Console]::TreatControlCAsInput = $true
    Write-Verbose "Starting from $readCount"
    foreach ($Line in ($lines | Select-Object -Skip $readCount)) {
        if ($Line -match $Pattern) {
            Write-Verbose "Match at line $readCount. Running script block"
            & $ScriptBlock
        }
    
        $readCount++
    
        if ([System.Console]::KeyAvailable) {
            $key = [System.Console]::ReadKey($true)
            
            if (($key.Modifiers -band [System.ConsoleModifiers]::Control) -and ($key.Key -eq "C")) {
                Write-Warning "Stopped processing at $readCount"
                break
            }
        }
    }
}
    
end {
    $readCount | Export-Clixml -Path $StatePath
    Write-Verbose "Stopped processing at $readCount"
}