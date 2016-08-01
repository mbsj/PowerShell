$moduleName = "TestClassResource"
$modulePath = Join-Path $PSScriptRoot $moduleName

if (Test-Path $modulePath -PathType Container) {
    Remove-Item $modulePath -Recurse -Force
}

New-Item -Path $modulePath -ItemType Directory | Out-Null

New-ModuleManifest -Path (Join-Path $modulePath "$moduleName.psd1") -Guid (New-Guid) -ModuleVersion 1.0 -Author "Mark Birkedal Stjerslev Jakobsen" -CompanyName "N/A" -Description "Service test resource to demonstrate custom resources" -RootModule "$moduleName.psm1" -DscResourcesToExport "TestServiceClass" -Verbose

#Copy module with class to module foldes with manifest
Copy-Item (Join-Path $PSScriptRoot "$moduleName.psm1") -Destination $modulePath