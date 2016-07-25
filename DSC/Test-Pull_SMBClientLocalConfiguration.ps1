$smbPullShare = "\\mark-vm\DSCConfig\SMBPull" # Standard SMB share. Same as in client resource
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "MARK-VM"

[DSCLocalConfigurationManager()]
Configuration PullSMBConfig {
    param (
        [Parameter(Mandatory=$true)]
        [String[]]$ComputerName,

        [Parameter(Mandatory=$true)]
        [String]$GUID
    )

    Node $ComputerName {
        Settings {
            AllowModuleOverwrite = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Pull'
            RebootNodeIfNeeded = $false # True for "true" clients
            ConfigurationID = $GUID
        } 

        ConfigurationRepositoryShare SMBPullShare {
            SourcePath = $smbPullShare
        }
    }
}

# GUID = New-Guid - Paired with config
PullSMBConfig -ComputerName $computerNames -GUID "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5" -OutputPath $configPath

Set-DscLocalConfigurationManager -ComputerName $computerNames -Path $configPath -Verbose

Get-DscLocalConfigurationManager -CimSession $computerNames