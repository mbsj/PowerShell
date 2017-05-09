Import-Module $PSScriptRoot -Force

<#
TODO: Create better tests for SQL
#>
InModuleScope SQL {
    Describe "Limited testing of Invoke-SQL" {
        Context "Trusted Connection" {
            It "Should throw a connection error" {
                { Invoke-SQL -Query "SELECT" -Server "NonServer" -Database "NonDB" -Timeout 2 } | 
                    Should Throw "A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible."
            }
        }

        Context "Standard Security" {
            It "Should throw a connection error" {
                { Invoke-SQL -Query "SELECT" -Server "NonServer" -Database "NonDB" -Username "NonUser" -PlainTextPassword "%I|``N?:RUl7`"!@RD@-U!u7_;0p=ING" -Timeout 2 } | 
                    Should Throw "A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible."
            }
        }
    }
}