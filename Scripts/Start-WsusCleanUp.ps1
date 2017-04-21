<#
.SYNOPSIS
    Starts a clenaup of the WSUS service on the default WSUS server
.DESCRIPTION
    Runs locally on the WSUS server or on a client with WSUS admin tools installed 
    and triggers a cleanup job based on the configuration provided. 

    Possible cleanups to run are one or more of the floowing: 
        CleanupObsoleteComputers
        CleanupObsoleteUpdates
        CleanupUnneededContentFiles
        CompressUpdates
        DeclineExpiredUpdates
        DeclineSupersededUpdates
.EXAMPLE
    .\Start-WsusCleanUp.ps1 

    Starts a cleanup with the default scope of DeclineSupersededUpdates, DeclineExpiredUpdates, CleanupUnneededContentFiles and CleanupObsoleteUpdates
.EXAMPLE
    .\Start-WsusCleanUp.ps1 -CleanupScope "DeclineSupersededUpdates", "DeclineExpiredUpdates"

    Starts a cleanup, only running the declining cleanup scopes
.EXAMPLE
    .\Start-WsusCleanUp.ps1 -CleanupScope "*"

    Starts a cleanup with all possible cleanup scopes
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
Param (
    # Type of cleanup to run
    [Parameter(Mandatory = $false, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("DeclineSupersededUpdates", "DeclineExpiredUpdates", "CleanupUnneededContentFiles", "CleanupObsoleteComputers", "CleanupObsoleteUpdates", "CompressUpdates", "*")]
    [String[]]$CleanupScope = @("DeclineSupersededUpdates", "DeclineExpiredUpdates", "CleanupUnneededContentFiles", "CleanupObsoleteUpdates")
)
    
begin {
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null 

    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer(); 

    if (-not $wsus) {
        throw "WSUS service was not found"
    }

    if ($CleanupScope -eq "*") {
        $CleanupScope = @("DeclineSupersededUpdates", "DeclineExpiredUpdates", "CleanupUnneededContentFiles", "CleanupObsoleteComputers", "CleanupObsoleteUpdates", "CompressUpdates")
    }
}
    
process {
    $cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope; 

    $CleanupScope | ForEach-Object {
        switch ($_) {
            "CleanupObsoleteComputers" { $cleanupScope.CleanupObsoleteComputers = $true } 
            "CleanupObsoleteUpdates" { $cleanupScope.CleanupObsoleteUpdates = $true }
            "CleanupUnneededContentFiles" { $cleanupScope.CleanupUnneededContentFiles = $true } 
            "CompressUpdates" { $cleanupScope.CompressUpdates = $true }
            "DeclineExpiredUpdates" { $cleanupScope.DeclineExpiredUpdates = $true } 
            "DeclineSupersededUpdates" { $cleanupScope.DeclineSupersededUpdates = $true } 
            default { throw "Invalid cleanup scope"}
        }
    }

    if ($pscmdlet.ShouldProcess("WSUS service", "Run cleanup")) {
        $cleanupManager = $wsus.GetCleanupManager(); 
        $cleanupManager.PerformCleanup($cleanupScope); 
    }
}
    
end {
}