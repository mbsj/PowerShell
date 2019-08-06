Describe "Search-FileAndAct" {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Search-FileAndAct.ps1"

    $pattern = "(\d{3})"

    $testDriveRoot = "TestDrive:\SearchFileAndAct"

    $pathStateFile = Join-Path $testDriveRoot "state.index"
    $pathSourceFile = Join-Path $testDriveRoot "source.txt"

    $sourceContent = @"
qweasd
asdzxc
zcxqwe
qw123c
qwezxc
adsasd
"@

    New-Item -Path $pathSourceFile -ItemType File -Force
    Add-Content -Path $pathSourceFile -Value $sourceContent

    Context "Matching" {
        It "Should run without error" {
            if (Test-Path $pathStateFile) {
                Remove-Item $pathStateFile -Force
            }

            $script = { &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile }
            $script | Should Not Throw
        }

        It "Variable `$Line should contain the entire line where a match was found" {
            if (Test-Path $pathStateFile) {
                Remove-Item $pathStateFile -Force
            }
            $scriptBlock = { $Line }

            &  $scriptFile -Path $pathSourceFile -Pattern $pattern -StatePath $pathStateFile -ScriptBlock $scriptBlock | Should Be "qw123c"
        }

        It "Variable `$Matches should contain the match information for the line where a match was found" {
            if (Test-Path $pathStateFile) {
                Remove-Item $pathStateFile -Force
            }
            $scriptBlock = { $Matches }

            $matches = &  $scriptFile -Path $pathSourceFile -Pattern $pattern -StatePath $pathStateFile -ScriptBlock $scriptBlock
            $matches.Keys.Count | Should be 2
            $matches[1] | Should Be "123"
        }
    }

    Context "State" {
        It "State file should be created" {
            if (Test-Path $pathStateFile) { Remove-Item $pathStateFile -Force }
            &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile

            $pathStateFile | Should Exist
        }

        It "State file should contain total number of lines in source file" {
            if (Test-Path $pathStateFile) { Remove-Item $pathStateFile -Force }
            &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile

            Import-Clixml $pathStateFile | Should Be 6
        }

        It "Should reuse state file" {
            Mock Import-Clixml { 0 }
            &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile

            Assert-MockCalled Import-Clixml
        }

        It "Read count should not reset if DoNotReset is specified" {
            Mock Import-Clixml { 6 }
            Mock Write-Verbose { "Will not reset" } -ParameterFilter { $Message -and $Message -match ".*is equal to number of lines 6 but DoNotReset is specified. Read count not reset." }

            $result = &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile -DoNotReset

            $result | Should Be "Will not reset"
        }

        It "Read count should reset if DoNotReset is not specified" {
            Mock Import-Clixml { 6 }
            Mock Write-Warning { "Will reset A" } -ParameterFilter { $Message -and $Message -match ".*and number of lines is 6. Resetting read count to 0." }

            $result = &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile

            $result | Should Be "Will reset A"
        }

        It "Read count should reset if DoNotReset is specified and number of lines is less than last read lines" {
            Mock Import-Clixml { 7 }
            Mock Write-Warning { "Will reset B" } -ParameterFilter { $Message -and $Message -match ".*but number of lines is 6. Resetting read count to 0." }

            $result = &  $scriptFile -Path $pathSourceFile -Pattern $pattern -ScriptBlock {} -StatePath $pathStateFile

            $result | Should Be "Will reset B"
        }
    }
}