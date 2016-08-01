$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "MARK-VM"

#Get-DscResource
#Get-DscResource -Name WindowsFeature
#Get-DscResource -Name WindowsFeature -Syntax

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

Start-DscConfiguration -ComputerName $computerNames -Path $configPath -Wait -Verbose

Test-DscConfiguration -ComputerName $computerNames

Get-DscConfiguration -CimSession $computerNames