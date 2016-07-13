<#
.Synopsis
   Sync directories either based on a CSV file or explicitly defined source and destination folders.
.DESCRIPTION
   Synchronizes the content of the source folder into the destination folder.

   When a source and destination is defined, will synchronize directly from one to the other.

   When a CSV file is defined, parses the file (semicolon delimited) for source and destination pairs and synchronizes the source folder to the destination.
   Syntax is Source;Destination

   Sample: 
   C:\Folder\Data;D:\Sync\Save
.EXAMPLE
    .\Sync-Directories.ps1 -SourcePath "C:\Data" -DestinationPath "D:\Sync\Save"

    Synchronises the contents of C:\Data to D:\Sync\Save. 
    Log data is saved to the script folder in a log file named after the source folder: Data_log.txt
.EXAMPLE
    .\Sync-Directories.ps1 -SourcePath "C:\Data" -DestinationPath "D:\Sync\Save\Data"  -LogPath "C:\Sync\Log.txt" -Force

    Synchronises the contents of C:\Data to D:\Sync\Save. If the destination folder does not exist it will be created. 
    Saves the log data to C:\Sync\Log.txt.
.EXAMPLE
   .\Sync-Directories.ps1 -Path .\Sync.txt -Mirror

   Synchronises the folder pairs specified in the file Sync.txt, mirroring the directories so the destination is equal to the source.
#>
[CmdletBinding(DefaultParameterSetName='SourceDest',
                SupportsShouldProcess=$true, 
                PositionalBinding=$false,
                ConfirmImpact='Medium')]
Param
(
    # Path to CSV files
    [Parameter(Mandatory=$true, Position=0, ParameterSetName='CSV')]
    [ValidateScript({Test-Path $_ -PathType Leaf})]
    [String]$CSVPath,

    # Path to source folder
    [Parameter(Mandatory=$true, Position=0, ParameterSetName='SourceDest')]
    [ValidateScript({Test-Path $_ -PathType Container})]
    [String]$SourcePath,

    # Path to destination folder
    [Parameter(Mandatory=$true, Position=1, ParameterSetName='SourceDest')]
    [String]$DestinationPath,

    # Path to log file. If not defined will be $PSScriptRoot\$SourceFolder_log.txt
    [Parameter(ParameterSetName='CSV')]
    [Parameter(ParameterSetName='SourceDest')]
    [String]$LogPath,

    # If the destination folder does not exist, create it
    [Parameter(ParameterSetName='CSV')]
    [Parameter(ParameterSetName='SourceDest')]
    [Switch]$Force, 

    # Mirrors the destination with the source, making the two folders equal. If file are present in the destination but not in the source, these files will be deleted. 
    [Parameter(ParameterSetName='CSV')]
    [Parameter(ParameterSetName='SourceDest')]
    [Switch]$Mirror
)

Begin
{
    $Error.Clear()
    $syncPairs = @() 

    if ($PSCmdlet.ParameterSetName -eq "CSV") {
        Write-Verbose "Importing CSV file $CSVPath"
        $syncPairs = Import-Csv -Delimiter ";" -Path $CSVPath -Header "Source","Destination"
        Write-Verbose "Found a total of $(($syncPairs | Measure-Object).Count) lines"
    } elseif ($PSCmdlet.ParameterSetName -eq "SourceDest") {
        $syncPair = New-Object psobject
        $syncPair | Add-Member -MemberType NoteProperty -Name Source -Value $SourcePath
        $syncPair | Add-Member -MemberType NoteProperty -Name Destination -Value $DestinationPath

        $syncPairs += $syncPair
    }

    if (($syncPairs | Measure-Object).Count -eq 0) {
        throw "No synchronization pairs defined."
    } else {
        for ($i = 0; $i -lt ($syncPairs | Measure-Object).Count; $i++) {
            if (-not (Test-Path $syncPairs[$i].Source)) {
                throw "Source $($syncPairs[$i].Source) does not exist."
            } elseif (Test-Path $syncPairs[$i].Source -PathType Leaf) {
                throw "Source $($syncPairs[$i].Source) is a file. It must be a folder."
            }

            if(-not (Test-Path $syncPairs[$i].Destination) -and -not $Force) {
                throw "Destination $($syncPairs[$i].Destination) does not exist."
            } elseif (Test-Path $syncPairs[$i].Destination -PathType Leaf) {
                throw "Destination $($syncPairs[$i].Source) is a file. It must be a folder."
            } elseif(-not (Test-Path $syncPairs[$i].Destination) -and $Force) {
                Write-Verbose "Destination $($syncPairs[$i].Destination) does not exist. Creating it."
                New-Item -Path $syncPairs[$i].Destination -ItemType Directory -Force | Out-Null
            }
        }
    }

    if ($Error.Count -gt 0) {
        return
    }
}
Process
{
    $syncPairs | ForEach-Object {
        $operation = "Copy"
        if ($Mirror) {
            $operation = "Mirror"
        }

        if ($pscmdlet.ShouldProcess("$($_.Source) -> $($_.Destination)", $operation)) {
            $logFile = Join-Path $PSScriptRoot "$(Split-Path $_.Source -Leaf)_log.txt"
            
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
                "`"$($_.Source)`"", 
                "`"$($_.Destination)`"",
                "/r:5",
                "/w:1",
                "/sec",
                "/dcopy:T",
                "/log+:`"$logFile`""
            )

            if ($Mirror) {
                $arguments += "/mir"
            } else {
                $arguments += "/e"
            }

            "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"): SYNC START" | Out-File $logFile -Encoding utf8 -Append
            Write-Verbose "Sync start: $($_.Source) -> $($_.Destination)"
            Start-Process Robocopy.exe -ArgumentList $arguments -Wait -WindowStyle Hidden
            "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"): SYNC END" | Out-File $logFile -Encoding utf8 -Append
            Write-Verbose "Sync end"
            "-------------------------------------------------------------------------------" | Out-File $logFile -Append
        }
    }
}