Import-Module $PSScriptRoot -Force

InModuleScope Misc {
    Describe "Get-Password" {
        Context "Default" {
            $defaultPassword = Get-Password

            It "Generates 1 password" {
                $defaultPassword | Measure-Object | Select-Object -ExpandProperty Count | Should Be 1
            }

            It "Generates 16 character password" {
                $defaultPassword.Length | Should Be 16
            }

            It "Generates simple password" {
                $defaultPassword | Should Not Match "(!|`"|#|\$|%|&|'|\(|\)|\*|\+|,|-|\.|<\/|:|;|<|=|>|\?|@|\[|\\|\]|\^|_|``|\{|\||\}|~)"
            }
        }

        Context "-Complex" {
            $complexPassword = Get-Password -Complex

            It "Should generate a complex password" {
                $complexPassword | Should Match "(!|`"|#|\$|%|&|'|\(|\)|\*|\+|,|-|\.|<\/|:|;|<|=|>|\?|@|\[|\\|\]|\^|_|``|\{|\||\}|~)"
            }

            It "Should generate default length 16 character password" {
                $complexPassword.Length | Should Be 16
            }
        }

        Context "-Length 32" {
            $longPassword = Get-Password -Length 32 

            It "Should generate 32 character password" {
                $longPassword.Length | Should Be 32
            }

            It "Should generate simple password" {
                $longPassword | Should Not Match "(!|`"|#|\$|%|&|'|\(|\)|\*|\+|,|-|\.|<\/|:|;|<|=|>|\?|@|\[|\\|\]|\^|_|``|\{|\||\}|~)"
            }
        }

        Context "-Numeric" {
            $numericPassword = Get-Password -Numeric

            It "Should generate default length 16 character password" {
                $numericPassword.Length | Should Be 16
            }
            
            It "Should be only numbers" {
                $numericPassword | Should Match "\d{16}"
            }
        }

        Context "-Numeric -Complex" {
            $errorScript = { Get-Password -Numeric -Complex } 

            It ("Should create error when using both Numeric and Complex") {
                $errorScript | Should Throw "Parameter set cannot be resolved using the specified named parameters"
            }
        }

        Context "-Count 3" {
            $manyPasswords = Get-Password -Count 3

            It "Should create 3 passwords" {
                $manyPasswords | Measure-Object | Select-Object -ExpandProperty Count | Should Be 3
            }

            It "Passwords should be default length" {
                for ($i = 0; $i -lt $manyPasswords.Count; $i++) {
                    $manyPasswords[$i].Length | Should Be 16
                }
            }

            It "Passwords should be simple" {
                for ($i = 0; $i -lt $manyPasswords.Count; $i++) {
                    $manyPasswords[$i] | Should Not Match "(!|`"|#|\$|%|&|'|\(|\)|\*|\+|,|-|\.|<\/|:|;|<|=|>|\?|@|\[|\\|\]|\^|_|``|\{|\||\}|~)"
                }
            }
        }

        Context "-Count 5 -Length 20 -Complex" {
            $mixedPasswords = Get-Password -Count 5 -Length 20 -Complex

            It "Should create 5 passwords" {
                $mixedPasswords | Measure-Object | Select-Object -ExpandProperty Count | Should Be 5
            }

            It "Passwords should be 20 characters long" {
                for ($i = 0; $i -lt $manyPasswords.Count; $i++) {
                    $manyPasswords[$i].Length | Should Be 20
                }
            }

            It "Passwords should be complex" {
                for ($i = 0; $i -lt $manyPasswords.Count; $i++) {
                    $manyPasswords[$i] | Should Match "(!|`"|#|\$|%|&|'|\(|\)|\*|\+|,|-|\.|<\/|:|;|<|=|>|\?|@|\[|\\|\]|\^|_|``|\{|\||\}|~)"
                }
            }
        }
    }
}