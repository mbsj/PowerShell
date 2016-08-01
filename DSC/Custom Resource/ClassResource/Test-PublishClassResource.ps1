$moduleName = "TestClassResource"
$modulePath = Join-Path $PSScriptRoot $moduleName

#Copy to local modules foldes for development
$moduleDestination = Join-Path ($env:PSModulePath.Split(";") | Where-Object { $_ -like "*$($env:USERNAME)*" }) $moduleName

if (Test-Path $moduleDestination -PathType Container) {
    Remove-Item $moduleDestination -Recurse -Force
}

Copy-Item -Path $modulePath -Destination $moduleDestination -Recurse -Force

# Create ZIP for pull server
Compress-Archive -Path $modulePath -CompressionLevel Fastest -DestinationPath "$($modulePath)_1.0.zip" -Force
New-DscChecksum -Path "$($modulePath)_1.0.zip" -Force

$credentials = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))
$serverSession = New-PSSession -ComputerName "DSC-SERVER" -Credential $credentials -Verbose

Copy-Item -Path "$($modulePath)_1.0.zip","$($modulePath)_1.0.zip.checksum" -Destination "C:\DSC\Config\PullServer\Modules" -ToSession $serverSession -Verbose -Force