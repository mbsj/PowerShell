$httpPullUri = "http://DSC-SERVER:8080/PSDSCPullServer.svc" # Web service created using xPSDesiredStateConfiguration
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"

$computerNames = "DSC-CLIENT"
$credentials = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))

[DSCLocalConfigurationManager()]
Configuration PullHTTPConfig {
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
            RebootNodeIfNeeded = $true
            ConfigurationID = $GUID
            RefreshFrequencyMins = 30
        } 

        ConfigurationRepositoryWeb HTTPPull {
            ServerURL = $httpPullUri
            AllowUnsecureConnection = $true # For non-secure (http)
        }
    }
}

# GUID = New-Guid - Paired with config
PullHTTPConfig -ComputerName $computerNames -GUID "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5" -OutputPath $configPath

$session = New-CimSession -ComputerName $computerNames -Credential $credentials

Set-DscLocalConfigurationManager -CimSession $session -Path $configPath -Verbose

Get-DscLocalConfigurationManager -CimSession $session