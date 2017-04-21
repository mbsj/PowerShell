<#
.Synopsis
   Sync directories either based on a explicitly defined source and destination folders.
.DESCRIPTION
   Synchronizes the content of the source folder into the destination folder.

   When a source and destination is defined, will synchronize directly from one to the other.
.EXAMPLE
    .\Sync-Directories.ps1 -SourcePath "C:\Data" -DestinationPath "D:\Sync\Save"

    Synchronises the contents of C:\Data to D:\Sync\Save. 
    Log data is saved to the script folder in a log file named after the source folder: Data_log.txt
.EXAMPLE
    .\Sync-Directories.ps1 -SourcePath "C:\Data" -DestinationPath "D:\Sync\Save\Data"  -LogPath "C:\Sync\Log.txt" -Force

    Synchronises the contents of C:\Data to D:\Sync\Save. If the destination folder does not exist it will be created. 
    Saves the log data to C:\Sync\Log.txt.
#>
[CmdletBinding(SupportsShouldProcess = $true, PositionalBinding = $false, ConfirmImpact = 'Medium')]
Param
(
    # Path to source folder
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript( {Test-Path $_ -PathType Container})]
    [String]$SourcePath,

    # Path to destination folder
    [Parameter(Mandatory = $true, Position = 1)]
    [String]$DestinationPath,

    # Path to log file. If not defined will be $PSScriptRoot\$SourceFolder_log.txt
    [Parameter(Position = 2)]
    [String]$LogPath,

    # If the destination folder does not exist, create it
    [Parameter()]
    [Switch]$Force, 

    # Mirrors the destination with the source, making the two folders equal. If file are present in the destination but not in the source, these files will be deleted. 
    [Parameter()]
    [Switch]$Mirror
)

Begin {
    $operation = if ($Mirror) {
        "Mirror"
    }
    else {
        "Copy"
    }
}

Process {
    if ($pscmdlet.ShouldProcess("$DestinationPath", "$operation $SourcePath")) {
        $logFile = Join-Path $PSScriptRoot "$(Split-Path $SourcePath -Leaf)_log.txt"
            
        if ($LogPath) {
            $logFile = $LogPath
        }

        Write-Verbose "Log file is $logFile"

        if (-not (Test-Path $logFile -PathType Leaf)) {
            Write-Verbose "Log file does not exist. Creating empty log fil $logFile"
            New-Item -Path $logFile -ItemType File | Out-Null
        }

        if ((Get-Item $logFile).Length -gt 10MB) {
            if (Test-Path ("$logFile.old")) {
                Write-Verbose "Removing old log file $logFile.old"
                Remove-Item "$logFile.old"
            }

            Write-Verbose "Renaming log file $logFile to $(Split-Path $logFile -Leaf).old"
            Rename-Item -Path $logFile -NewName "$(Split-Path $logFile -Leaf).old"
        }

        $arguments = @(
            "`"$SourcePath`"", 
            "`"$DestinationPath`"",
            "/r:5",
            "/w:1",
            "/sec",
            "/dcopy:T",
            "/log+:`"$logFile`""
        )

        if ($Mirror) {
            $arguments += "/mir"
        }
        else {
            $arguments += "/e"
        }

        "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"): SYNC START" | Out-File $logFile -Encoding utf8 -Append
        Write-Verbose "Sync start: $SourcePath -> $DestinationPath"
        Start-Process -FilePath Robocopy.exe -ArgumentList $arguments -Wait -WindowStyle Hidden
        "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"): SYNC END" | Out-File $logFile -Encoding utf8 -Append
        Write-Verbose "Sync end"
        "-------------------------------------------------------------------------------" | Out-File $logFile -Append -Encoding utf8
    }
}