Import-Module $PSScriptRoot -Force

<#
TODO: Create better tests for MySQL
#>
InModuleScope MySQL {
    Describe "Limited testing of Invoke-MySQL" {
        Context "Default" {
            if (-not [System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")) {
                It "Should throw an error about missing assembly" {
                    { Invoke-MySQL -Query "SELECT" -Server "NonServer" -Database "NonDB" -Username "User" -PlainTextPassword "GGWn>:ay:`$Y+>BV=Rp8EWw*v29Lm+^" -Timeout 2 } | Should Throw "Unable to load assembly MySql.Data."
                }
            }
            else {
                It "Should throw a connection error" {
                    { Invoke-MySQL -Query "SELECT" -Server "NonServer" -Database "NonDB" -Username "User" -PlainTextPassword "%`$l:({:qe,pw}jC0GLg5`"Ev3L_0\u}" -Timeout 2 } | Should Throw "Unable to connect to any of the specified MySQL hosts."
                }
            }
        }
    }
}