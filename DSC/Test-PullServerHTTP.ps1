$pullLocalPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\PullServer\PullWeb"
$dscModulePath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\PullServer\Modules"
$dscConfigurationPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\PullServer\Configs"
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
$computerNames = "MARK-VM"

#Install-Module -Name xPSDesiredStateConfiguration
#Get-DscResource -Name xDSCWebService -Syntax

# TODO: report (compliance) server

#Destination server must have all DscResource modules (xPSDesiredStateConfiguration)

Configuration HTTPPullServer {
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $computerNames {
        WindowsFeature DSCWebService {
            Name = "DSC-Service"
            Ensure = "Present"
        }

        WindowsFeature IISManager {
            Name = "web-mgmt-tools"
            Ensure = "Present"
            DependsOn = "[WindowsFeature]DSCWebService"
        }

        xDSCWebService DSCPullServer {
            Ensure = "Present"
            EndpointName = "DSCPullServer"
            Port = 8080
            PhysicalPath = $pullLocalPath
            CertificateThumbPrint = "AllowUnencryptedTraffic" # Certificate thumb print on IIS server
            ModulePath = $dscModulePath
            ConfigurationPath = $dscConfigurationPath
            State = "Started"
            DependsOn = "[WindowsFeature]DSCWebService"
        }
    }
}

HTTPPullServer -OutputPath $configPath

Start-DscConfiguration -Path $configPath -ComputerName $computerNames -Verbose -Wait