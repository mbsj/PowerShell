$resourceName = "TestService"
$modulePath = Join-Path $PSScriptRoot $resourceName

if (Test-Path $modulePath -PathType Container) {
    Remove-Item $modulePath -Recurse -Force
}

New-Item -Path $modulePath -ItemType Directory | Out-Null

New-xDscResource -Name $resourceName -Path $modulePath -Property $(
    New-xDscResourceProperty -Name Name -Type String -Attribute Key
    New-xDscResourceProperty -Name Status -Type String -Attribute Write -ValidateSet "Running","Stopped"
    New-xDscResourceProperty -Name Ensure -Type String -Attribute Write -ValidateSet "Present","Absent"
) -Force -Verbose

New-ModuleManifest -Path (Join-Path $modulePath "$resourceName.psd1") -Guid (New-Guid) -ModuleVersion 1.0 -Author "Mark Jakobsen" -Description "Service test resource to demonstrate custom resources" -RootModule "$resourceName.psm1" -Verbose


$moduleDestination = ($env:PSModulePath.Split(";") | Where-Object { $_ -match $env:USERNAME })

if (Test-Path $moduleDestination -PathType Container) {
    Remove-Item $moduleDestination -Recurse -Force
}

Copy-Item $modulePath -Destination $moduleDestination -Recurse -Force