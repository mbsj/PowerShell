$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "MARK-VM"

#Add-WindowsFeature -Name "DSC-Service"

[DSCLocalConfigurationManager()]
Configuration TestConfig {
    Node $computerNames {
        Settings {
            AllowModuleOverwrite = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Push'
        } 
    }
}

TestConfig -OutputPath $configPath

Set-DscLocalConfigurationManager -ComputerName $computerNames -Path $configPath -Verbose

Get-DscLocalConfigurationManager -CimSession $computerNames