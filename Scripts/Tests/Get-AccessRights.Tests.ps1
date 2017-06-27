Describe "Get-AccessRights" {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Get-AccessRights.ps1"
    $testFolder = "TestDrive:\TestFolder"

    New-Item $testFolder
    $acl = Get-Acl $testFolder
    $accessRule = New-Object  System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM", "FullControl", "Allow")
    $acl.SetAccessRule($accessRule)
    Set-Acl $testFolder -AclObject $acl

    Context "Not resolving groups" {
        It "Should run without error" {
            { & $scriptFile -Path $testFolder -AccountType "Local", "Domain" } | Should Not Throw
        }

        $result = (& $scriptFile -Path $testFolder -AccountType "Local", "Domain" )

        It "Should contain at least 1 result" {
            $result | Measure-Object | Select-Object -ExpandProperty Count | Should BeGreaterThan 0
        }

        $props = @("Path", "Domain", "UserName", "DisplayName", "AccessControlType", "FileSystemRights")

        foreach ($prop in $props) {
            It "Result should contain property $prop" {
                $result | Get-Member -Name $prop | Should Not BeNullOrEmpty
            }
        }

        It "Should contain access rights for current user" {
            $result | Where-Object UserName -eq $env:USERNAME | Should Not BeNullOrEmpty
        }
    }

    Context "Resolving groups" {
        It "Should run without error when resolving groups" {
            { & $scriptFile -Path $testFolder -ResolveGroups -AccountType "Local" } | Should Not Throw
        }

        $result = ( & $scriptFile -Path $testFolder -ResolveGroups -AccountType "Local" )

        It "Should contain at least 1 result" {
            $result | Measure-Object | Select-Object -ExpandProperty Count | Should BeGreaterThan 0
        }
    }
}