#Requires -Version 4

<#
.SYNOPSIS
    Tests the connection to the RPC endpoint mapper as well as all registered endpoints. 
.DESCRIPTION
    Queries the RPC endpoint mapper on port 135. If connection is successful and registered endpoints are reported, each endpoint is also tested for connectivity. 
.EXAMPLE
    .\Test-RPC.ps1 -ComputerName "server1","server2","server3"
    Tests connection to RPC port ranges on the three servers
.EXAMPLE
    .\Test-RPC.ps1 -ComputerName "server1" | Select-Object -ExpandProperty DynamicPorts
    Tests connection to the RPC ports ranges and, assuming that the connection to the endpoint mapper is successful, lists which dynamic ports are available. 
.EXAMPLE
    $testResults = .\Test-RPC.ps1 -ComputerName "server1","server2","server3"
    foreach ($r in $testResults) {
        $r.DynamicPorts | Select-object -Property @{Name = "ComputerName"; Expression={$r.ComputerName}}, Port, Open | Export-Csv ".\RPCPortTest.csv" -Append
    }

    Tests RPC connection to the three selected servers and gathers the results in the $testResults variable. 
    Then, iterates over the results and creates a line for each tested port on each server with computername, port number and open value and exports it to a CSV file in the current folder.
.INPUTS
    String array with computer names.
.OUTPUTS
    PSObject with three properties: 
        ComputerName -> String with the name of the computer for which the port tests were made
        EndpointMapperOpen -> Boolean with value indicating wether the endpoint mapper war available
        DynamicPorts -> Array of PSObjects, one for each port tested. If the endpoint mapper is not available this array will be empty. Each object will have two properties: 
            Port -> Int with the port number
            Open -> Boolean with value indicating wether the port can be opened or not

.NOTES
    Expanded upon script created by Ryan Ries ( Thanks for doing the hard work! :D )
    https://www.myotherpcisacloud.com/post/verifying-rpc-network-connectivity-like-a-boss
.LINK
https://www.myotherpcisacloud.com/post/verifying-rpc-network-connectivity-like-a-boss
#>
[CmdletBinding(SupportsShouldProcess = $false)]
Param (
    # The name of the computers to check for RPC connection
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$ComputerName
)
    
begin {
    $rpcClass = @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public class Rpc
{
    // I found this crud in RpcDce.h

    [DllImport("Rpcrt4.dll", CharSet = CharSet.Auto)]
    public static extern int RpcBindingFromStringBinding(string StringBinding, out IntPtr Binding);

    [DllImport("Rpcrt4.dll")]
    public static extern int RpcBindingFree(ref IntPtr Binding);

    [DllImport("Rpcrt4.dll", CharSet = CharSet.Auto)]
    public static extern int RpcMgmtEpEltInqBegin(IntPtr EpBinding,
                                            int InquiryType, // 0x00000000 = RPC_C_EP_ALL_ELTS
                                            int IfId,
                                            int VersOption,
                                            string ObjectUuid,
                                            out IntPtr InquiryContext);

    [DllImport("Rpcrt4.dll", CharSet = CharSet.Auto)]
    public static extern int RpcMgmtEpEltInqNext(IntPtr InquiryContext,
                                            out RPC_IF_ID IfId,
                                            out IntPtr Binding,
                                            out Guid ObjectUuid,
                                            out IntPtr Annotation);

    [DllImport("Rpcrt4.dll", CharSet = CharSet.Auto)]
    public static extern int RpcBindingToStringBinding(IntPtr Binding, out IntPtr StringBinding);

    public struct RPC_IF_ID
    {
        public Guid Uuid;
        public ushort VersMajor;
        public ushort VersMinor;
    }

    public static List<int> QueryEPM(string host)
    {
        List<int> ports = new List<int>();
        int retCode = 0; // RPC_S_OK                
        IntPtr bindingHandle = IntPtr.Zero;
        IntPtr inquiryContext = IntPtr.Zero;                
        IntPtr elementBindingHandle = IntPtr.Zero;
        RPC_IF_ID elementIfId;
        Guid elementUuid;
        IntPtr elementAnnotation;

        try
        {                    
            retCode = RpcBindingFromStringBinding("ncacn_ip_tcp:" + host, out bindingHandle);
            if (retCode != 0)
                throw new Exception("RpcBindingFromStringBinding: " + retCode);

            retCode = RpcMgmtEpEltInqBegin(bindingHandle, 0, 0, 0, string.Empty, out inquiryContext);
            if (retCode != 0)
                throw new Exception("RpcMgmtEpEltInqBegin: " + retCode);
            
            do
            {
                IntPtr bindString = IntPtr.Zero;
                retCode = RpcMgmtEpEltInqNext (inquiryContext, out elementIfId, out elementBindingHandle, out elementUuid, out elementAnnotation);
                if (retCode != 0)
                    if (retCode == 1772)
                        break;

                retCode = RpcBindingToStringBinding(elementBindingHandle, out bindString);
                if (retCode != 0)
                    throw new Exception("RpcBindingToStringBinding: " + retCode);
                    
                string s = Marshal.PtrToStringAuto(bindString).Trim().ToLower();
                if(s.StartsWith("ncacn_ip_tcp:"))                        
                    ports.Add(int.Parse(s.Split('[')[1].Split(']')[0]));
                
                RpcBindingFree(ref elementBindingHandle);
                
            }
            while (retCode != 1772); // RPC_X_NO_MORE_ENTRIES

        }
        catch(Exception ex)
        {
            Console.WriteLine(ex);
            return ports;
        }
        finally
        {
            RpcBindingFree(ref bindingHandle);
        }
        
        return ports;
    }
}
'@

    Add-Type $rpcClass
}
    
process {
    foreach ($computer in $ComputerName) {
        Write-Verbose "Testing connection to RPC ports on $computer"

        $rpcTest = New-Object -TypeName psobject
        $rpcTest | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $computer
        $rpcTest | Add-Member -MemberType NoteProperty -Name "EndpointMapperOpen" -Value $false
        $rpcTest | Add-Member -MemberType NoteProperty -Name "DynamicPorts" -Value @()

        $socket = New-Object Net.Sockets.TcpClient

        try {
            Write-Verbose "Testing connection to endpoint mapper"
            $socket.Connect($computer, 135)
            if ($socket.Connected) {
                Write-Verbose "Endpoint mapper available"
                $rpcTest.EndpointMapperOpen = $true
            }
            else {
                Write-Warning "Endpoint mapper (135) not available"
            }
            
            $socket.Close()
        }
        catch {
            Write-Warning "Endpoint mapper (135) not available"
        }
        finally {
            $socket.Dispose()
        }

        if ($rpcTest.EndpointMapperOpen) {
            Write-Verbose "Getting registered endpoint ports"
            $endpointPorts = [Rpc]::QueryEPM($computer)
            $rpcPorts = $endpointPorts | Select-Object -Unique | Sort-Object

            Write-Verbose "Found $($endpointPorts.Count) endpoints on $($rpcPorts.Count) unique ports. Ports: `r`n`t$($rpcPorts -join "`r`n`t")"

            $jobs = @()
            foreach ($port in $rpcPorts) {
                Write-Verbose "Starting background job to test connection to port $port"
                $jobs += Start-Job -Name $port -ArgumentList $computer, $port -ScriptBlock {
                    param ($computer, $port)

                    $open = $false
                    $socket = New-Object Net.Sockets.TcpClient
                    
                    try {
                        $ErrorActionPreference = "Stop"
                        $socket.Connect($computer, $port) 
                        if ($socket.Connected) {
                            $open = $true
                        }
                        $socket.Close()
                    }
                    catch {
                        Write-Verbose "Failed connecting to $computer on port $port"
                    }
                    finally {
                        $socket.Dispose()
                        $open
                    }
                }
            }

            while ($jobs.State -contains "Running") {
                $runningJobs = $jobs | Where-Object State -eq "Running"
                Write-Verbose "Waiting for port test jobs to finish. Unfinished port tests: $($runningJobs.Name -join ", ")"
                Start-Sleep -Seconds 1
            }

            Write-Verbose "Parsing test results for endpoint ports"
            foreach ($job in $jobs) {
                $rpcPortTest = New-Object -TypeName psobject
                $rpcPortTest | Add-Member -MemberType NoteProperty -Name "Port" -Value ([int]$job.Name)
                $rpcPortTest | Add-Member -MemberType NoteProperty -Name "Open" -Value ($job | Receive-Job)
                
                $job | Remove-Job

                $rpcTest.DynamicPorts += $rpcPortTest
            }
        }
        else {
            Write-Verbose "Endpoint mapper not availabe. Cannot enumerate endpoints."
        }

        $rpcTest
    }
}
    
end {
}