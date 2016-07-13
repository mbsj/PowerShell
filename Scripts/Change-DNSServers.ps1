$creds = Get-Credential

$dnsMatch = "^10\.46\.113\.10(0|1)$"
$dnsServers = "10.46.113.200","10.46.113.201"

Get-ADServers -Location Esbjerg | `
Foreach-Object { Get-WMIObject -Credential $creds Win32_NetworkAdapterConfiguration -ComputerName $_ } | `
Where-Object { ( $_.IPEnabled -eq “TRUE”) -and ($_.DNSServerSearchOrder -match $dnsServers) } | `
ForEach-Object { $_.SetDNSServerSearchOrder($dnsServers) ; $_.SetDynamicDNSRegistration("TRUE") }