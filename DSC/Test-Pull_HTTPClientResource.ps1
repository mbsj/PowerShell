$httpConfigPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\PullServer\Configs" # DSC configuration path from PullServer setup
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "MARK-VM"

Configuration TelnetClientInstalled {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    Node $computerNames {
        WindowsFeature TelnetClient {
            Name = "Telnet-Client"
            Ensure = "Present"
        }
    }
}

TelnetClientInstalled -OutputPath $configPath

# Clients look for GUID as set in LCM setup.
# GUID - Get GUID dynamically from servers or set statically
# $guid = Get-DscLocalConfigurationManager -CimSession $computerNames | Select-Object -ExcludeProperty ConfigurationID
# Generate in config dir and move to share while renaming
Move-Item -Path "$(Join-Path $configPath $computerNames).mof" -Destination "$(Join-Path $httpConfigPath ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof)" -Force

# Checksum - Used by clients to compare current configuration with configuration available on the pull server (dumb share)
# Create checksom for mof file
New-DscChecksum "$(Join-Path $httpConfigPath ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof)" -Force # Force to update checksum

# Wait for refresh interval or manually trigger update
Update-DscConfiguration -ComputerName $computerNames -Wait -Verbose