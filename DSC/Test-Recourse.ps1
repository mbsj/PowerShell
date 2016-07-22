$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config"
$computerNames = "MARK-VM"

#Get-DscResource
#Get-DscResource -Name WindowsFeature
#Get-DscResource -Name WindowsFeature -Syntax

Configuration InstallWebServer {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    Node $computerNames {
        WindowsFeature IISWebServer {
            Name = "web-server"
            Ensure = "Present"
        }

        WindowsFeature IISManager {
            Name = "web-mgmt-tools"
            Ensure = "Present"
        }
    }
}

InstallWebServer -OutputPath $configPath

Start-DscConfiguration -ComputerName $computerNames -Path $configPath -Wait -Verbose

Test-DscConfiguration -ComputerName $computerNames

Get-DscConfiguration -CimSession $computerNames