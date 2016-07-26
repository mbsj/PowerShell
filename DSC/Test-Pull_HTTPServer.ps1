$pullLocalPath = "C:\DSC\Config\PullServer\PullWeb" # On pull server
$dscModulePath = "C:\DSC\Config\PullServer\Modules" # On pull server
$dscConfigurationPath = "C:\DSC\Config\PullServer\Configs" # On pull server
$configPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"

$computerNames = "DSC-SERVER"
$credentials = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))

#Install-Module -Name xPSDesiredStateConfiguration
#Get-DscResource -Name xDSCWebService -Syntax

#Destination server must have all DscResource modules (xPSDesiredStateConfiguration)

Configuration HTTPPullServer {
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $computerNames {
        WindowsFeature DSCWebService {
            Name = "DSC-Service"
            Ensure = "Present"
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

Start-DscConfiguration -Credential $credentials -Path $configPath -ComputerName $computerNames -Verbose -Wait -Force #-Force to allow PUSH operation in PULL mode