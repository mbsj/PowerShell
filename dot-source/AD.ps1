function Add-ActiveDirectory {
    Import-Module ActiveDirectory
} 

Function Test-ADAuthentication {
    param(
        [String]$Username,
        [String]$Password
    )

    $dirEntry = new-object directoryservices.directoryentry "",$Username,$Password
    $dirEntry.psbase.name -ne $null
}

Function Get-ADServers {
    param(
        [ValidateSet("Arden", "Esbjerg", "Pila", "All")]
        [String]$Location = "All",
        [Switch]$NoDomainControllers,
        [Switch]$IncludeDisabled
    )

    $servers = @()
    $filter = '(Name -ne "nas") -and (Name -ne "qnap-storage")'

    if (!$IncludeDisabled) {
        $filter = '(Enabled -eq "True") -and ' + $filter
    }

    switch ($Location) {
        "All" { $searchBase = "OU=Servers,OU=Computers,OU=Qubiqa,DC=domain,DC=local" }
        "Arden" { $searchBase = "OU=Arden,OU=DK,OU=Servers,OU=Computers,OU=Qubiqa,DC=domain,DC=local" }
        "Esbjerg" { $searchBase = "OU=Esbjerg,OU=DK,OU=Servers,OU=Computers,OU=Qubiqa,DC=domain,DC=local" }
        "Pila" { $searchBase = "OU=Pila,OU=PL,OU=Servers,OU=Computers,OU=Qubiqa,DC=domain,DC=local" }
    }

    Get-ADComputer -Filter $filter -SearchBase $searchBase | 
        ForEach-Object { $servers += $_.SamAccountName.TrimEnd("$") }

    if (!$NoDomainControllers) {
        switch ($Location) {
            "All" { $searchBase = "OU=Domain Controllers,DC=domain,DC=local" }
            "Arden" { $searchBase = "OU=Arden,OU=Domain Controllers,DC=domain,DC=local" }
            "Esbjerg" { $searchBase = "OU=Esbjerg,OU=Domain Controllers,DC=domain,DC=local" }
            "Pila" { $searchBase = "OU=Pila,OU=Domain Controllers,DC=domain,DC=local" }
        }

        Get-ADComputer -Filter $filter -SearchBase $searchBase | 
            ForEach-Object { $servers += $_.SamAccountName.TrimEnd("$") }
    }

    $servers | Sort-Object
}