Import-Module ActiveDirectory

function Copy-ADUser {
    param (
        [Parameter(Mandatory = $true)]
        [string]$OldUsername,
        [Parameter(Mandatory = $true)]
        [string]$Username,
        [Parameter(Mandatory = $true)]
        [string]$FirstName,
        [Parameter(Mandatory = $true)]
        [string]$LastName, 
        [Parameter(Mandatory = $true)]
        [string]$Password,
        [Parameter(Mandatory = $true)]
        [string]$JobTitle,
        [Parameter(Mandatory = $true)]
        [string]$MobilePhone
    )

    $User = Get-AdUser -Identity $OldUsername -Properties HomePhone,Fax,Department,Company
    $DN = $User.distinguishedName
    $OldUser = [ADSI]"LDAP://$DN"
    $Parent = $OldUser.Parent
    $OU = [ADSI]$Parent
    $OUDN = $OU.distinguishedName
    $NewUser = $Username
    $FirstName = $FirstName
    $LastName = $LastName
    $FullName = "$firstname $lastname"
    $SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $HomePhone = $OldUser.HomePhone | Out-String
    $Fax = $OldUser.Fax | Out-String
    $Department = $OldUser.Department | Out-String
    $Company = $OldUser.Company | Out-String

    New-ADUser -SamAccountName $Username -Name $FullName -GivenName $FirstName -Surname $LastName `
        -Instance $DN -Path "$OUDN" -AccountPassword $SecurePassword -EmailAddress "$UserName@qubiqa.com" -HomePage "www.qubiqa.com" `
        -HomePhone $HomePhone -Fax $Fax -Department $Department -Company $Company -MobilePhone $MobilePhone
}

#Enable-Mailbox -Identity 'domain.local/Qubiqa/Users/DK/Arden/Økonomi/Dorthe Rothmann' -Alias 'dor'