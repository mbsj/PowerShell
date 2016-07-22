$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config"
$computerNames = "MARK-VM"

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