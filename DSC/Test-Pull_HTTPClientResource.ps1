$httpConfigPath = "C:\DSC\Config\PullServer\Configs" # DSC configuration path from PullServer setup
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"

$computerNames = "DSC-SERVER"
$credentials = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))

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
$session = New-PSSession -ComputerName $computerNames -Credential $credentials

if (Test-Path (Join-Path $configPath "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof")) {
    Remove-Item (Join-Path $configPath "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof")
}

Rename-Item "$(Join-Path $configPath $computerNames).mof" -NewName "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof"
Copy-Item -Path "$(Join-Path $configPath ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof)" -Destination "$httpConfigPath" -ToSession $session -Force

# Checksum - Used by clients to compare current configuration with configuration available on the pull server (dumb share)
# Create checksom for mof file
New-DscChecksum "$(Join-Path $configPath ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof)" -Force # Force to update checksum
Copy-Item -Path "$(Join-Path $configPath ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5.mof.checksum)" -Destination $httpConfigPath -ToSession $session -Force

# Wait for refresh interval or manually trigger update
Update-DscConfiguration -ComputerName $computerNames -Wait -Verbose