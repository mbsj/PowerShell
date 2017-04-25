$scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "Start-WsusCleanUp.ps1"

Describe "Start-WsusCleanUp" {
    It "Should throw missing type" {
        $scriptRun = { & $scriptFile } 
            
        $scriptRun | Should Throw "Unable to find type [Microsoft.UpdateServices.Administration.AdminProxy]."
    }

    It "Should allow wildcard in -CleanupScope" {
        $scriptRun = { & $scriptFile -CleanupScope "*" } 
            
        $scriptRun | Should Throw "Unable to find type [Microsoft.UpdateServices.Administration.AdminProxy]."
    }

    $scopes = @(
        "DeclineSupersededUpdates", "DeclineExpiredUpdates", "CleanupUnneededContentFiles", "CleanupObsoleteComputers", "CleanupObsoleteUpdates", "CompressUpdates"
    )

    $scopes | ForEach-Object {
        It "Should allow scope $_" {
            $scriptRun = { & $scriptFile -CleanupScope $_ } 
            
            $scriptRun | Should Throw "Unable to find type [Microsoft.UpdateServices.Administration.AdminProxy]."
        }
    }

    It "Should all all scopes" {
        $scriptRun = { & $scriptFile -CleanupScope $scopes } 
            
        $scriptRun | Should Throw "Unable to find type [Microsoft.UpdateServices.Administration.AdminProxy]."
    }
}