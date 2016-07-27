#Install-Module -Name xPSDesiredStateConfiguration
#Get-DscResource -Name xDSCWebService -Syntax

#Destination server must have all DscResource modules (xPSDesiredStateConfiguration)

$configData = & (Join-Path $PSScriptRoot "Test-ConfigurationData.ps1")

Configuration HTTPPullServer {
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.Where{$_.Role -eq "PullServer"}.NodeName {
        WindowsFeature DSCWebService {
            Name = "DSC-Service"
            Ensure = "Present"
        }

        xDSCWebService DSCPullServer {
            Ensure = "Present"
            EndpointName = "DSCPullServer"
            Port = 8080
            PhysicalPath = $Node.PhysicalPath
            CertificateThumbPrint = "AllowUnencryptedTraffic" # Certificate thumb print on IIS server
            ModulePath = $Node.ModulePath
            ConfigurationPath = $Node.ConfigurationPath
            State = "Started"
            DependsOn = "[WindowsFeature]DSCWebService"
        }
    }
}

# ConfigurationData can be a psd1 file with hash table
HTTPPullServer -ConfigurationData $configData -OutputPath $configData.NonNodeData.ConfigPath

Start-DscConfiguration -Credential $configData.NonNodeData.Credentials -Path $configData.NonNodeData.ConfigPath -ComputerName ($configData.AllNodes.Where{$_.Role -eq "PullServer"}.NodeName) -Verbose -Wait -Force