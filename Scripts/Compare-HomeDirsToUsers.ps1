<#
.Synopsis
   Compare folders in homedir to actual users in AD.
.DESCRIPTION
   Traverses a homedir folder and checks Active Directory for any user with the same name.

   Can also check if a user has access to his home folder and if not, provide "Full Control" access.
.EXAMPLE
   .\Compare-HomeDirsToUser.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local" -HomeDirectory "C:\Users"

   Parse home folder and list all folders for which a user does not exist.
.EXAMPLE
   .\Compare-HomeDirsToUser.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local" -HomeDirectory "C:\Users" -CheckFullControl

   Parse home folder and list all folders for which a user does not exist as well as folders where the corresponding user does not have full access control.
.EXAMPLE
   .\Compare-HomeDirsToUser.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local" -HomeDirectory "C:\Users" -GiveFullControl

   Parse home folder, list all folders for which a user does not exist as well as folders where the corresponding user does not have full access control.
   If the user does not have full access control, grant it.
.INPUTS
   System.String
.OUTPUTS
   System.Management.Automation.PSCustomObject
.NOTES
   This function does not take pipeline input.
#>

[CmdletBinding(SupportsShouldProcess=$true,
                PositionalBinding=$false,
                ConfirmImpact='Medium')]
[OutputType([System.Management.Automation.PSCustomObject])]
Param
(
    # LDAP path to the root container in AD where users are to be found.
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^LDAP://.*")]
    [String]$LDAPPath,

    # Path to home directory root.
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $_})]
    [String]$HomeDirectory,

    # Relative domain label as appears to the user. I.e.: DOMAIN.
    [ValidateScript({-not ($_ -match "\.")})]
    [String]$DomainLabel,

    # If the user exists, check whether the user has full control to the folder. Implied when using "-GiveFullControl"
    [Switch]$CheckFullControl,

    # If the user exists, check whether the user has full control to the folder and if not, give the user "Full Control" access. Implies "-CheckFullControl"
    [Switch]$GiveFullControl
)

Begin
{
    $LDAPPath = $LDAPPath.Substring(0,4).ToUpper() + $LDAPPath.Substring(4)

    try {
        if (-not [ADSI]::Exists($LDAPPath)) {
            throw "LDAP path invalid. Active Directory container not found."
        }
    } catch {
        throw "LDAP path invalid. Active Directory container not found."
    }

    if (-not $DomainLabel) {
        if (-not ($LDAPPath -match "DC=(.*),DC=.*")) {
            throw "Unable to determine domain label from LDAP path $LDAPPath. Provide domain label using -DomainLabel parameter."
        }

        $DomainLabel = $Matches[1].ToUpper()
    }

    $domain = New-Object System.DirectoryServices.DirectoryEntry($LDAPPath)
    $searcher = New-Object System.DirectoryServices.DirectorySearcher($domain)

    $searcher.CacheResults = $true
    $searcher.Filter = "(&(objectCategory=Person))"
    $searcher.PropertiesToLoad.Add("samaccountname") | Out-Null
    $searcher.SizeLimit = 0
    $searcher.PageSize = 1000

    $homeFolderChecks = @()
}
Process
{
    Write-Progress -Activity "Finding users in Active Directory..." -PercentComplete 0

    $persons = $searcher.FindAll()
    if ($persons.Count -eq 0) {
        throw "No users found in AD. Check LDAP path."
    } else {
        Write-Verbose "Found $($persons.Count) users."
    }

    Write-Progress -Activity "Getting home folders..." -PercentComplete 0

    $homeFolders = Get-ChildItem $HomeDirectory | Where-Object { $_.PSIsContainer }

    for ($i = 0; $i -lt $homeFolders.Count; $i++) {
        $userName = $homeFolders[$i].Name

        $homeFolderCheck = New-Object -TypeName psobject
        $homeFolderCheck | Add-Member -MemberType NoteProperty -Name FolderName -Value $userName
        $homeFolderCheck | Add-Member -MemberType NoteProperty -Name UserExists -Value $false
        $homeFolderCheck | Add-Member -MemberType NoteProperty -Name UserHasFullAccess -Value $null
        $homeFolderCheck | Add-Member -MemberType NoteProperty -Name UserGivenFullAccess -Value $null

        Write-Progress -Activity "Iterating home folders..." -Status "Processing $userName" -CurrentOperation "Looking for user in AD" -PercentComplete ($i / $homeFolders.Count * 100)

        Write-Verbose "Looking for user $userName..."
        if (-not ($persons | Where-Object { $_.Properties["samaccountname"] -eq $userName })) {
            Write-Verbose "$userName not found in AD"
        } else {
            Write-Verbose "Found user $userName."
            $homeFolderCheck.UserExists = $true

            if ($CheckFullControl -or $GiveFullControl) {
                Write-Progress -Activity "Iterating home folders..." -Status "Processing $userName" -CurrentOperation "Checking user access to folder" -PercentComplete ($i / $homeFolders.Count * 100)
                Write-Verbose "Checking full access control for user $userName..."
                $acl = (Get-Item $homeFolders[$i].FullName).GetAccessControl("Access")

                $access = $acl.Access | Where-Object { $_.IdentityReference.Value -eq "$DomainLabel\$userName" }

                if ($access.FileSystemRights -ne [System.Security.AccessControl.FileSystemRights]::FullControl) {
                    Write-Verbose "$userName does not have full control of folder"
                    $homeFolderCheck.UserHasFullAccess = $false

                    if ($GiveFullControl) {
                        Write-Progress -Activity "Iterating home folders..." -Status "Processing $userName" -CurrentOperation "Giving user full access to folder" -PercentComplete ($i / $homeFolders.Count * 100)
                        Write-Verbose "Giving user $userName full access to folder..."

                        $inheritance = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
                        $propagation = [System.Security.AccessControl.PropagationFlags]::None
                        $rights = [System.Security.AccessControl.FileSystemRights]::FullControl
                        $type = [System.Security.AccessControl.AccessControlType]::Allow
                        $user = New-Object System.Security.Principal.NTAccount("$DomainLabel\$userName")

                        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, $rights, $inheritance, $propagation, $type)
                        $acl.SetAccessRule($rule)

                        if ($pscmdlet.ShouldProcess($homeFolders[$i].FullName, "Give $userName Full Control")) {
                            Set-Acl -Path $homeFolders[$i].FullName -AclObject $acl -ErrorVariable aclError

                            if (-not $aclError) {
                                Write-Verbose "User $userName was given full access to folder."
                                $homeFolderCheck.UserHasFullAccess = $true
                                $homeFolderCheck.UserGivenFullAccess = $true
                            }
                        }

                    }
                } else {
                    Write-Verbose "$userName has full access to the folder."
                    $homeFolderCheck.UserHasFullAccess = $true
                }
            }
        }

        $homeFolderChecks += $homeFolderCheck
    }

    Write-Progress -Activity "Finding users in Active Directory..." -PercentComplete 100 -Completed

    return $homeFolderChecks
}
End
{
    $searcher.Dispose()

    $domain.Close()
    $domain.Dispose()
}