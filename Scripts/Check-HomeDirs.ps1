$ldapPath = "LDAP://DC=triostaging,DC=local"
$homePath = "D:\KMD-PCO3"
$domainName = "TRIOSTAGING"

# Whether or not to give full access if needed
$giveAccess = $false

$domain = New-Object System.DirectoryServices.DirectoryEntry($ldapPath)

$searcher = New-Object System.DirectoryServices.DirectorySearcher
$searcher.SearchRoot = $domain

$filter = "(&(objectCategory=Person))"
$searcher.CacheResult
$searcher.Filter = $filter

$persons = $searcher.FindAll()

Get-ChildItem $homePath | Where-Object { $_.PSIsContainer } | ForEach-Object {
    $userName = $_.Name

    if (-not ($persons | Where-Object { $_.Properties["sAMAccountName"] -eq $userName })) {
        Write-Host -ForegroundColor Yellow "$userName not found in AD"
    } else {
        $acl = Get-Acl $_.FullName 

        $access = $acl | Where-Object { $_.Access.IdentityReference.Value -eq "$domainName\$userName" }

        if ($access.FileSystemRights -ne "FullControl") {
            Write-Host -ForegroundColor Yellow "$userName does not have full control of folder"

            if ($giveAccess) {
                $inheritance = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
                $propagation = [System.Security.AccessControl.PropagationFlags]::None 
                $rights = [System.Security.AccessControl.FileSystemRights]::FullControl
                $type = [System.Security.AccessControl.AccessControlType]::Allow 
                $user = New-Object System.Security.Principal.NTAccount("$domainName\$userName") 

                $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, $rights, $inheritance, $propagation, $type)
                $acl.SetAccessRule($rule)

                Set-Acl -Path $_.FullName -AclObject $acl
            }
        } 
    }
}