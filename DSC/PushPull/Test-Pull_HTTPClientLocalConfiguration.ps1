$configData = & (Join-Path $PSScriptRoot "Test-ConfigurationData.ps1")

[DSCLocalConfigurationManager()]
Configuration PullHTTPConfig {
    Node $AllNodes.Where{$_.Role -eq "Client"}.NodeName {
        Settings {
            AllowModuleOverwrite = $true
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Pull'
            RebootNodeIfNeeded = $true
            ConfigurationID = $Node.GUID
            ConfigurationModeFrequencyMins = 15
            RefreshFrequencyMins = 30
        } 

        ConfigurationRepositoryWeb HTTPPull {
            ServerURL = $ConfigurationData.NonNodeData.HTTPPullUri
            AllowUnsecureConnection = $true # For non-secure (http)
        }
    }
}

# GUID = New-Guid - Paired with config
PullHTTPConfig -ConfigurationData $configData -OutputPath $configData.NonNodeData.ConfigPath

$session = New-CimSession -ComputerName ($configData.AllNodes.Where{$_.Role -eq "Client"}.NodeName) -Credential $configData.NonNodeData.Credentials

Set-DscLocalConfigurationManager -CimSession $session -Path $configData.NonNodeData.ConfigPath -Verbose

Get-DscLocalConfigurationManager -CimSession $session