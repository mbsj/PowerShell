$credentials = Get-Credential -UserName DOMAIN\Administrator -Message "Provide credentials for user with access to RPC and WMI on target servers"
$servers = Get-ADServers

$servers | ForEach-Object {
    Get-CimInstance -Credential $credentials -Class Win32_Volume -ComputerName $_ -Filter 'DriveType = 3 AND DriveLetter != NULL ' | 
        Select-Object SystemName,DriveLetter, Label, @{LABEL='FreePercent';EXPRESSION={($_.FreeSpace/$_.Capacity) * 100} }, @{LABEL='FreeSpace';EXPRESSION={($_.FreeSpace/1GB)} }
} | Sort-Object -Property FreeSpace | Out-GridView
