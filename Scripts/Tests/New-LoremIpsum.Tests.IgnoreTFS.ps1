Describe New-LoremIpsum {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\New-LoremIpsum.ps1"

    Context "Default" {
        $ipsum = & $scriptFile

        It "Text should contain 1 paragraph" {
            $ipsum.Text -split "`n" | Measure-Object | Select-Object -ExpandProperty Count | Should Be 1
        }

        It "Reported paragraphs should be 1" {
            $ipsum.Paragraphs | Should Be 1
        }
    }

    Context "-Type Paragraph -Count 3 -StandardStart" {
        $ipsum = & $scriptFile -Type Paragraph -Count 3 -StandardStart

        It "Text should contain number of paragraphs matching what is specified in -Count" {
            $ipsum.Text -split "`n" | Measure-Object | Select-Object -ExpandProperty Count | Should Be 3
        }

        It "Reported paragraphs should match what is specified in -Count" {
            $ipsum.Paragraphs | Should Be 3
        }

        It "Text should start with standard lorem ipsum phrase" {
            $ipsum.Text | Should Match "Lorem ipsum dolor sit amet, consectetur adipiscing elit.*"
        }
    }

    Context "-Type Word -Count 10" {
        $ipsum = & $scriptFile -Type Word -Count 10
        
        It "Text should contain number of words matching what is specified in -Count" {
            $ipsum.Text -split "\s" | Measure-Object | Select-Object -ExpandProperty Count | Should Be 10
        }
        
        It "Reported words should match what is specified in -Count" {
            $ipsum.Words | Should Be 10
        }
        
        It "Text should not start with standard lorem ipsum phrase" {
            $ipsum.Text | Should Not Match "Lorem ipsum dolor sit amet, consectetur adipiscing elit.*"
        }
    }

    Context "-Type Byte -Count 50" {
        $ipsum = & $scriptFile -Type Byte -Count 50 
        
        It "Text byte size should match what is specified in -Count" {
            [System.Text.Encoding]::UTF8.GetByteCount($ipsum.Text) | Should Be 50
        }
        
        It "Reported bytes should match what is specified in -Count" {
            $ipsum.Bytes | Should Be 50
        }
    }

    Context "Enforced minimum values" {
        It "Should warn about minimum word count when -Type is Byte and -Count is less than 2" {
            try {
                & $scriptFile -Type Word -Count 1 -WarningAction Stop
            }
            catch {
                $_ | Should Be "The running command stopped because the preference variable `"WarningPreference`" or common parameter is set to Stop: Minimum word count is 2"
            }
        }

        It "Should warn about minimum byte size when -Type is byte and -Count is less than 27" {
            try {
                & $scriptFile -Type Byte -Count 10 -WarningAction Stop
            }
            catch {
                $_ | Should Be "The running command stopped because the preference variable `"WarningPreference`" or common parameter is set to Stop: Minimum byte count is 27"
            }
        }

        It "Should throw a validation error when -Count is less than 1" {
            { & $scriptFile -Count -1 } | Should Throw "Cannot validate argument on parameter 'Count'. The `"`$_ -gt 0`" validation script for the argument with value `"-1`" did not return a result of True. Determine why the validation script failed, and then try the command again."
        }
    }
}