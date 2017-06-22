Describe "Sync-Directories" {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Sync-Directories.ps1"

    $testDriveRoot = "TestDrive:\SyncTest"
    $testDriveSource = Join-Path -Path $testDriveRoot -ChildPath "Source"
    $testDriveDestination = Join-Path -Path $testDriveRoot -ChildPath "Destination"
    $testDriveLog = Join-Path -Path $testDriveRoot -ChildPath "sync.log"

    New-Item -Path $testDriveSource -ItemType Directory
    New-Item -Path $testDriveDestination -ItemType Directory

    Context "Copy" {
        $sourceFiles = @(
            "File1.txt",
            "File2.jpg",
            "File3"
        )

        $destinationFiles = @(
            "File3"
            "File4.png",
            "File5"
        )

        $sourceFiles | ForEach-Object {
            New-Item -Path $testDriveSource -Name $_ -ItemType File
        }

        Add-Content -Value "Source data" -Path (Join-Path -Path $testDriveSource -ChildPath "File3")

        $destinationFiles | ForEach-Object {
            New-Item -Path $testDriveDestination -Name $_ -ItemType File
        }

        $sourceFiles | ForEach-Object {
            It "Source should have files $_" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Exist
            }
        }

        $destinationFiles | ForEach-Object {
            It "Destination should have files $_" {
                Join-Path -Path $testDriveDestination -ChildPath $_ | Should Exist
            }
        }

        It "Destination file File3 should be empty" {
            Get-Item -Path (Join-Path -Path $testDriveDestination -ChildPath "File3") | Select-Object -ExpandProperty Length | Should Be 0
        }

        New-Item -Path $testDriveLog -ItemType File
        
        It "Script should run without error" {
            $physicalSource = Get-Item $testDriveSource
            $physicalDestination = Get-Item $testDriveDestination
            $physicalLog = Get-Item $testDriveLog

            Get-Item $testDriveLog | Remove-Item

            $syncScript = { & $scriptFile -LogPath $physicalLog -SourcePath $physicalSource -DestinationPath $physicalDestination } 
            
            $syncScript | Should Not Throw
        }

        $sourceFiles | ForEach-Object {
            It "Destination should have source file $_" {
                Join-Path -Path $testDriveDestination -ChildPath $_ | Should Exist
            }
        }

        $destinationFiles | ForEach-Object {
            It "Destination should still have destination file $_" {
                Join-Path -Path $testDriveDestination -ChildPath $_ | Should Exist
            }
        }

        It "Destination file File3 should contain data from source file File3" {
            $sourceContent = Get-Content -Path (Join-Path -Path $testDriveSource -ChildPath "File3")
            $destinationContent = Get-Content -Path (Join-Path -Path $testDriveDestination -ChildPath "File3")

            $destinationContent | Should Be $sourceContent
        }

        It "Log file should contain data" {
            Get-Item -Path $testDriveLog | Select-Object -ExpandProperty Length | Should BeGreaterThan 0
        }
    }

    Context "Mirror" {
        $sourceFiles = @(
            "File1.txt",
            "File2.jpg",
            "File3"
        )

        $destinationFiles = @(
            "File3",
            "File4.docx",
            "File5.png"
        )

        $sourceFiles | ForEach-Object {
            New-Item -Path $testDriveSource -Name $_ -ItemType File
        }

        Add-Content -Value "Source data" -Path (Join-Path -Path $testDriveSource -ChildPath "File3")

        $destinationFiles | ForEach-Object {
            New-Item -Path $testDriveDestination -Name $_ -ItemType File
        }
        
        New-Item -Path $testDriveLog -ItemType File

        $sourceFiles | ForEach-Object {
            It "Source should have files $_" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Exist
            }
        }

        $destinationFiles | ForEach-Object {
            It "Destination should have files $_" {
                Join-Path -Path $testDriveDestination -ChildPath $_ | Should Exist
            }
        }

        It "Destination file File3 should be empty" {
            Get-Item -Path (Join-Path -Path $testDriveDestination -ChildPath "File3") | Select-Object -ExpandProperty Length | Should Be 0
        }
        
        It "Script should run without error" {
            $physicalSource = Get-Item $testDriveSource
            $physicalDestination = Get-Item $testDriveDestination
            $physicalLog = Get-Item $testDriveLog

            Get-Item $testDriveLog | Remove-Item

            $syncScript = { & $scriptFile -LogPath $physicalLog -SourcePath $physicalSource -DestinationPath $physicalDestination -Mirror } 
            
            $syncScript | Should Not Throw
        }

        $sourceFiles | ForEach-Object {
            It "Source should contain source file $_" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Exist
            }
        }

        $sourceFiles | ForEach-Object {
            It "Destination should contain source file $_" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Exist
            }
        }

        $destinationFiles | Where-Object { $_ -notin $sourceFiles } | ForEach-Object {
            It "Destination should not contain file $_, not present in source" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Not Exist
            }
        }

        It "Destination file File3 should contain data from source file File3" {
            $sourceContent = Get-Content -Path (Join-Path -Path $testDriveSource -ChildPath "File3")
            $destinationContent = Get-Content -Path (Join-Path -Path $testDriveDestination -ChildPath "File3")

            $destinationContent | Should Be $sourceContent
        }

        It "Log file should contain data" {
            Get-Item -Path $testDriveLog | Select-Object -ExpandProperty Length | Should BeGreaterThan 0
        }
    }

    Context "Log rotation" {
        New-Item -Path $testDriveLog -ItemType File
        $physicalLog = Get-Item $testDriveLog

        $file = [System.IO.File]::Create($physicalLog)
        $file.SetLength(11MB)
        $file.Close()

        $logHash = Get-FileHash -Path $testDriveLog

        New-Item -Path ($testDriveLog + ".old") -ItemType File

        It "Script should run without error" {
            $physicalSource = Get-Item $testDriveSource
            $physicalDestination = Get-Item $testDriveDestination

            $syncScript = { & $scriptFile -LogPath $physicalLog -SourcePath $physicalSource -DestinationPath $physicalDestination -Mirror } 
            
            $syncScript | Should Not Throw
        }

        It "Log should be moved to old log" {
            $oldLogHash = Get-FileHash -Path ($testDriveLog + ".old")

            $oldLogHash.Hash | Should Be $logHash.Hash
        }

        It "New log should contain run information" {
            $logContent = Get-Content -Path $testDriveLog -Raw

            $logContent | Should MatchExactly "SYNC START"
            $logContent | Should MatchExactly "SyncTest"
            $logContent | Should MatchExactly "SYNC END"
        }
    }
}