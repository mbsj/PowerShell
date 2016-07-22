$configPath = "C:\Users\Mark\Downloads"
$computerNames = "MARK-VM"

#Get-DscResource
#Get-DscResource -Name WindowsFeature -Syntax

Configuration InstallWebServer {
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    Node $computerNames {
        WindowsFeature IISWebServer {
            Name = "web-server"
            Ensure = "Absent"
        }

        WindowsFeature IISManager {
            Name = "web-mgmt-tools"
            Ensure = "Absent"
        }
    }
}

InstallWebServer -OutputPath $configPath

Start-DscConfiguration -ComputerName $computerNames -Path $configPath -Wait -Verbose