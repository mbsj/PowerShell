$moduleName = "TestDSCModule"
$modulePath = Join-Path $PSScriptRoot $moduleName

if (Test-Path $modulePath -PathType Container) {
    Remove-Item $modulePath -Recurse -Force
}

New-Item -Path $modulePath -ItemType Directory | Out-Null

New-xDscResource -Name "TestService" -Path $modulePath -Property $(
    New-xDscResourceProperty -Name Name -Type String -Attribute Key
    New-xDscResourceProperty -Name Status -Type String -Attribute Write -ValidateSet "Running","Stopped"
    New-xDscResourceProperty -Name Ensure -Type String -Attribute Write -ValidateSet "Present","Absent"
) -Force -Verbose

New-ModuleManifest -Path (Join-Path $modulePath "$moduleName.psd1") -Guid (New-Guid) -ModuleVersion 1.0 -Author "Mark Birkedal Stjerslev Jakobsen" -CompanyName "N/A" -Description "Service test resource to demonstrate custom resources" -RootModule "$moduleName.psm1" -Verbose