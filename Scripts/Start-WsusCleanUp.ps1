[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null 

$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer(); 

$cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope; 
$cleanupScope.DeclineSupersededUpdates = $true
$cleanupScope.DeclineExpiredUpdates = $true
$cleanupScope.CleanupUnneededContentFiles = $true
$cleanupScope.CleanupObsoleteComputers = $true
$cleanupScope.CleanupObsoleteUpdates     = $true 
#$cleanupScope.CompressUpdates = $true 

$cleanupManager = $wsus.GetCleanupManager(); 
$cleanupManager.PerformCleanup($cleanupScope); 