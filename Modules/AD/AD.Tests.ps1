Import-Module $PSScriptRoot -Force

InModuleScope AD {
    Describe "Test-ADAuthentication" {
        Context "test authentication" {
            It "Should run without error" {
                { Test-ADAuthentication -Username "InvalidUser" -PlainTextPassword ")%lU^H~P3]cmn&3!iRg2=},n~&wmFY" } | Should Not Throw
            }

            It "Result should be false" {
                Test-ADAuthentication -Username "InvalidUser" -PlainTextPassword ")%lU^H~P3]cmn&3!iRg2=},n~&wmFY"  | Should Be $false
            }
        }
    }

    Describe "Get-StaleDomainAdmin" {
        New-Module -Name ActiveDirectory -ScriptBlock {
            function Get-ADUser {}
            function Get-ADObject {}
        } | Import-Module

        Mock Import-Module {
        } -Verifiable

        Mock Get-ADUser {
            $props = @(
                @{
                    Name = "Administrator"
                    SamAccountName = "Administrator"
                    DistinguishedName = "Local administrator"
                    Enabled = $true
                    lastLogonTimeStamp = (Get-Date).AddDays(-600).ToFileTime()
                    whenCreated = (Get-Date).AddDays(-700)
                },
                @{
                    Name = "AdminEnabled1"
                    SamAccountName = "EnaAdmin1"
                    DistinguishedName = "Enabled Admin User 1"
                    Enabled = $true
                    lastLogonTimeStamp = (Get-Date).AddDays(-1).ToFileTime()
                    whenCreated = (Get-Date).AddDays(-100)
                },
                @{
                    Name = "AdminEnabled2"
                    SamAccountName = "EnaAdmin2"
                    DistinguishedName = "Enabled Admin User 2"
                    Enabled = $true
                    lastLogonTimeStamp = (Get-Date).AddDays(-60).ToFileTime()
                    whenCreated = (Get-Date).AddDays(-700)
                },
                @{
                    Name = "AdminEnabled3"
                    SamAccountName = "EnaAdmin3"
                    DistinguishedName = "Enabled Admin User 3"
                    Enabled = $true
                    lastLogonTimeStamp = (Get-Date).AddDays(-700).ToFileTime()
                    whenCreated = (Get-Date).AddDays(-800)
                },
                @{
                    Name = "AdminEnabled4"
                    SamAccountName = "EnaAdmin4"
                    DistinguishedName = "Enabled Admin User 4"
                    Enabled = $true
                    lastLogonTimeStamp = $null
                    whenCreated = (Get-Date).AddDays(-700)
                },
                @{
                    Name = "AdminDisabled"
                    SamAccountName = "DisAdmin"
                    DistinguishedName = "Disabled Admin User"
                    Enabled = $false
                    lastLogonTimeStamp = (Get-Date).AddDays(-1).ToFileTime()
                    whenCreated = (Get-Date).AddDays(-100)
                }
            )

            $props | ForEach-Object {
                New-Object -TypeName psobject -Property $_
            }
        }

        Mock Get-ADObject {
            $_ | Select-Object -Property lastLogonTimeStamp, whenCreated, DistinguishedName, Name, SamAccountName
        }

        Context "Default" {
            It "Should not throw" {
                { Get-StaleDomainAdmin } | Should Not Throw
            }

            $users = Get-StaleDomainAdmin

            It "Should not contain user `"Administrator`"" {
                $users | ForEach-Object {
                    $_.Name | Should Not Be "Administrator"
                }
            }

            It "Should return 2 users" {
                $users.Count | Should Be 2
            }

            It "Users with last logon time should be older than 1 year" {
                $users | Where-Object { $_.lastLogonTimeStamp } | ForEach-Object {
                    $fileTime = $_ | Select-Object -ExpandProperty lastLogonTimeStamp $lastLogonFileTime
                    [DateTime]::FromFileTime($fileTime) | Should BeLessThan (Get-Date).AddYears(-1)
                }
            }

            It "Users without last logon time should have create time be older than 1 year" {

                $users | Where-Object { -not $_.lastLogonTimeStamp } | ForEach-Object {
                    $_.whenCreatedTime | Should BeLessThan (Get-Date).AddYears(-1)
                }
            }
        }

        Context "-MaxAge" {
            $maxAge = (Get-Date).AddDays(-30)

            It "Should throw when age is after now" {
                { Get-StaleDomainAdmin -MaxAge (Get-Date).AddDays(1) } | Should Throw
            }

            It "Should not throw when age is before now" {
                { Get-StaleDomainAdmin -MaxAge (Get-Date).AddDays(-1) } | Should Not Throw
            }

            $users = Get-StaleDomainAdmin -MaxAge $maxAge

            It "Should return 3 users" {
                $users.Count | Should Be 3
            }

            It "Users with last logon time should be older than 30 days" {
                $users | Where-Object { $_.lastLogonTimeStamp } | ForEach-Object {
                    $fileTime = $_ | Select-Object -ExpandProperty lastLogonTimeStamp $lastLogonFileTime
                    [DateTime]::FromFileTime($fileTime) | Should BeLessThan $maxAge
                }
            }

            It "Users without last logon time should have create time be older than 30 days" {
                $users | Where-Object { -not $_.lastLogonTimeStamp } | ForEach-Object {
                    $_.whenCreatedTime | Should BeLessThan $maxAge
                }
            }
        }

        Context "-SpecialAccounts" {
            It "Should not throw" {
                { Get-StaleDomainAdmin -SpecialAccounts "AdminEnabled3" } | Should Not Throw
            }

            $users = Get-StaleDomainAdmin -SpecialAccounts "EnaAdmin3"

            It "Should not contain user `"AdminEnabled3`"" {
                $users | ForEach-Object {
                    $_.Name | Should Not Be "AdminEnabled3"
                }
            }

            It "Should contain user `"Administrator`"" {
                $users | Where-Object Name -eq "Administrator" | Select-Object -ExpandProperty Name | Should Be "Administrator"
            }
        }
    }
}