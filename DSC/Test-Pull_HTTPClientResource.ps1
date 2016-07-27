$configData = & (Join-Path $PSScriptRoot "Test-ConfigurationData.ps1")

Configuration TelnetClientInstalled {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    Node $AllNodes.Where{$_.Role -eq "Client"}.NodeName {
        WindowsFeature TelnetClient {
            Name = "Telnet-Client"
            Ensure = "Present"
        }
    }
}

TelnetClientInstalled -ConfigurationData $configData -OutputPath $configData.NonNodeData.ConfigPath

# Clients look for GUID as set in LCM setup.
# GUID - Get GUID dynamically from servers or set statically
# $guid = Get-DscLocalConfigurationManager -CimSession $computerNames | Select-Object -ExcludeProperty ConfigurationID
# Generate in config dir and move to share while renaming
$serverSession = New-PSSession -ComputerName ($configData.AllNodes.Where{$_.Role -eq "PullServer"}.NodeName) -Credential $configData.NonNodeData.Credentials
$clientSession = New-CimSession -ComputerName ($configData.AllNodes.Where{$_.Role -eq "Client"}.NodeName) -Credential $configData.NonNodeData.Credentials

foreach ($client in ($configData.AllNodes.Where{$_.Role -eq "Client"})) {
    if (Test-Path (Join-Path $configData.NonNodeData.ConfigPath "$($client.Guid).mof")) {
        Remove-Item (Join-Path $configData.NonNodeData.ConfigPath "$($client.Guid).mof")
    }

    Rename-Item "$(Join-Path $configData.NonNodeData.ConfigPath $client.NodeName).mof" -NewName "$($client.Guid).mof"
    Copy-Item -Path "$(Join-Path $configData.NonNodeData.ConfigPath $client.Guid).mof" -Destination $configData.NonNodeData.HTTPConfigPath -ToSession $serverSession -Force

    # Checksum - Used by clients to compare current configuration with configuration available on the pull server (dumb share)
    # Create checksom for mof file
    New-DscChecksum "$(Join-Path $configData.NonNodeData.ConfigPath "$($client.Guid).mof")" -Force # Force to update checksum
    Copy-Item -Path "$(Join-Path $configData.NonNodeData.ConfigPath "$($client.Guid).mof.checksum")" -Destination $configData.NonNodeData.HTTPConfigPath -ToSession $serverSession -Force
}

# Wait for refresh interval or manually trigger update
#Update-DscConfiguration -CimSession $clientSession -Wait -Verbose