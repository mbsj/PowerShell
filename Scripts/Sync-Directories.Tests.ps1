$scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "Sync-Directories.ps1"

Describe "Sync-Directories" {
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

        $sourceFiles | ForEach-Object {
            New-Item -Path $testDriveSource -Name $_ -ItemType File
        }

        $sourceFiles | ForEach-Object {
            It "Source should have files $_" {
                Join-Path -Path $testDriveSource -ChildPath $_ | Should Exist
            }
        }

        New-Item -Path $testDriveLog -ItemType File

        It "Destination should be empty" {
            Get-ChildItem -Path $testDriveDestination -Recurse | Measure-Object | Select-Object -ExpandProperty Count | Should Be 0
        }
        
        It "Script should run without error" {
            $physicalSource = Get-Item $testDriveSource
            $physicalDestination = Get-Item $testDriveDestination
            $physicalLog = Get-Item $testDriveLog

            $syncScript = { & $scriptFile -LogPath $physicalLog -SourcePath $physicalSource -DestinationPath $physicalDestination } 
            
            $syncScript | Should Not Throw
        }

        $sourceFiles | ForEach-Object {
            It "Destination should have file $_" {
                Join-Path -Path $testDriveDestination -ChildPath $_ | Should Exist
            }
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
        
        It "Script should run without error" {
            $physicalSource = Get-Item $testDriveSource
            $physicalDestination = Get-Item $testDriveDestination
            $physicalLog = Get-Item $testDriveLog

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

        It "Log file should contain data" {
            Get-Item -Path $testDriveLog | Select-Object -ExpandProperty Length | Should BeGreaterThan 0
        }
    }
}