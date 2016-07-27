$configData = @{
    AllNodes = @(
        @{
            NodeName = "DSC-SERVER"
            Role = "PullServer"
            PhysicalPath = "C:\DSC\Config\PullServer\PullWeb"
            ModulePath = "C:\DSC\Config\PullServer\Modules"
            ConfigurationPath = "C:\DSC\Config\PullServer\Configs"
        },

        @{
            NodeName = "DSC-CLIENT"
            Role = "Client"
            GUID = "ef4e3f76-6da5-4c0e-8a6c-7978ac85acc5"
        }
    );

    NonNodeData = @{
        HTTPPullUri = "http://DSC-SERVER:8080/PSDSCPullServer.svc"
        HTTPConfigPath = "C:\DSC\Config\PullServer\Configs"
        ConfigPath = "C:\Users\Mark\OneDrive\PowerShell\DSC\Config\MOF"
        Credentials = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))
    }
}

$configData