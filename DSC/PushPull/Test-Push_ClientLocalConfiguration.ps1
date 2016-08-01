$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "DSC-CLIENT"

#Add-WindowsFeature -Name "DSC-Service"

[DSCLocalConfigurationManager()]
Configuration PushConfig {
    Node $computerNames {
        Settings {
            AllowModuleOverwrite = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Push'
            RebootNodeIfNeeded = $true
        } 
    }
}

PushConfig -OutputPath $configPath

Set-DscLocalConfigurationManager -ComputerName $computerNames -Path $configPath -Verbose

Get-DscLocalConfigurationManager -CimSession $computerNames