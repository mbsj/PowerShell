$cred = Get-Credential -Message "WMI Credentials" -UserName "DOMAIN\Administrator"
$servers = Get-ADServers

$servers | ForEach-Object -Begin {$i = 0} -Process {
    $i++
    Write-Progress -Activity "Gathering services" -Status "Processing $_..." -PercentComplete ($i/$servers.Count*100)
        
    Get-WmiObject -Credential $cred -Class Win32_Service -ComputerName $_ | Where-Object { 
        $_.StartName -match "administrator"
    }
} | Sort-Object -Property PSComputerName | Select-object -Property PSComputerName,DisplayName,Name,StartMode,State,StartName | Out-GridView
