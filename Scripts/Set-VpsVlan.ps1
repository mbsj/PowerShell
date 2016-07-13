$ErrorActionPreference = "Stop"

Add-PSSnapin -name Microsoft.SystemCenter.VirtualMachineManager -ErrorAction SilentlyContinue

$serviceID = 121
$serverID = 51
$virtualNetworkName = "Trunk"
$vmmServerName = "localhost"
$connectionString = "Server=10.0.0.143; Database=NetworkAssets; User Id=sa; Password=BJpqJxRv7YbMybFZ;"
$sqlQuery = "SELECT dbo.VLANs.VlanTag FROM dbo.IPv4Addresses INNER JOIN dbo.IPv4Subnets ON dbo.IPv4Addresses.IPv4SubnetId = dbo.IPv4Subnets.id INNER JOIN dbo.VLANs ON dbo.IPv4Subnets.VlanId = dbo.VLANs.id WHERE dbo.IPv4Addresses.Address = dbo.ipStringToBinary('{0}');"

$esVirtServer = New-WebServiceProxy -Uri http://195.178.14.1:9002/esVirtualizationServer.asmx -Namespace esVirtualizationServer
$esServers = New-WebServiceProxy -Uri http://195.178.14.1:9002/esServers.asmx -Namespace esServers

$credentails = New-Object System.Net.NetworkCredential("serveradmin","UdC7Siht8hrb6u")
$esVirtServer.Credentials = $credentails
$esServers.Credentials = $credentails

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection
$sqlConnection.ConnectionString = $connectionString

$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
$sqlCommand.Connection = $sqlConnection

$addresses = $esServers.GetIPAddresses("VpsExternalNetwork", $serverID) | Where-Object { $_.ItemName -ne $null }

if ($addresses -ne $null) {
    Get-VMMServer $vmmServerName
    
    $allMachines = $esVirtServer.GetVirtualMachinesByServiceId($serviceID)
    $machines = $allMachines | Where-Object { ($addresses | Select-Object -ExpandProperty ItemName).Contains($_.Name)  }

    $machines | ForEach-Object {
        $machineDetails = $esVirtServer.GetVirtualMachineExtendedInfo($serviceID, $_.VirtualMachineId)
        $macAddress = $machineDetails.Adapters |Where-Object { $_.Name -match "External" } | Select-Object -Unique -ExpandProperty MacAddress
        $machineAddresses = $addresses | Where-Object { $_.ItemName -match $machineDetails.Name }

        $sqlCommand.CommandText = $sqlQuery -f $machineAddresses[0].ExternalIP
        $sqlConnection.Open()
        $vlanTag = $sqlCommand.ExecuteScalar()
        $sqlConnection.Close()

        if ($vlanTag -gt 0) {
            $vm = Get-VM $machineDetails.Name
            $networkAdapters = $vm | Get-VirtualNetworkAdapter
            $adapter = $networkAdapters | Where-Object { $_.PhysicalAddress.Replace(":","") -match $macAddress }

            if (!$adapter.VLanEnabled -or $adapter.VLanId -ne $vlanTag) {
                $vn = $vm.VMHost | Get-VirtualNetwork -Name $virtualNetworkName

                if ($vn.VMHostNetworkAdapters.VlanTags -notcontains $vlanTag) {
                    $vnTags = $vn.VMHostNetworkAdapters.VlanTags + $vlanTag
                    $vn.VMHostNetworkAdapters | Set-VMHostNetworkAdapter -VLANMode Trunk -VLANTrunkID $vnTags
                }

                $adapter | Set-VirtualNetworkAdapter -VLanEnabled $true -VLanId $vlanTag
            }
        }
    }
}