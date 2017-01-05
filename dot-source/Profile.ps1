Set-StrictMode -Version Latest

if ($Host.Name -eq "ConsoleHost" -and $env:COMPUTERNAME -eq "H46330") {
    Select-Window -ActiveWindow | Set-WindowPosition -Left 10 -Top 10
}

function prompt
{
    $host.ui.rawui.WindowTitle = $Env:USERNAME + " - " + $Env:COMPUTERNAME + " - " + $Host.Name + " - " + $Host.Version
    "PS " + $(get-location) + ">"
}

if ([System.Environment]::OSVersion.Version.Major -ge 6 -and [System.Environment]::OSVersion.Version.Minor -ge 2) {
    New-AliAs -Name Get-DNS -Value Resolve-DnsName
} else {
    function Get-DNS {
        param (
            [String] $HostName,
            [String] $Type,
            [String] $Server
        )

        if ([String]::IsNullOrWhiteSpace($Type)) {
            $Type = "A"
        }

        $command = "C:\Windows\System32\nslookup.exe"
        $type = "-query=$Type"
        $hostName = "$HostName"
        $server = "$Server"

        $eap = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"
        &$command $type $hostName $server
        $ErrorActionPreference = $eap
    }
}