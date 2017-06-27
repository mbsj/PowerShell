<#
.SYNOPSIS
    Gets any users and groups as well as their access rights on a given file or folder. 
.DESCRIPTION
    Checks the file or folder access control lists and returns an object for each user, describing their access. 
    This returns objects for both users and groups. 
    The switch -ResolveGroups will make the script resolve any groups, and get the users in them. If groups contains groups, they will be resolved recursively. 
    The -AccountType parameter can be used to limit the access check to either local or domain users or both. Default is Domain.
.EXAMPLE
    .\Get-AccessRights.ps1 -Path C:\Temp

    Gets the access rights for the path C:\Temp
.EXAMPLE
    .\Get-AccessRights.ps1 -Path C:\Temp -ResolveGroups | Select-Object -Property UserName,AccessControlType,FileSystemRights

    Gets the access right for the path C:\Temp, resolving any and all groups in the process. 
    Output is limited to only the user names, access control types and associated rights. 
    This could then be pipet to i.e. Out-File to save a text file. 
.EXAMPLE
    .\Get-AccessRights.ps1 -Path C:\Temp -ResolveGroups -AccountType Local
    
    Gets the access rights for the path C:\Temp, resolving any and all groups on the process. 
    Also limits the check to only handle local user accounts, ignoring domain accounts. 
.EXAMPLE
    $paths = @(".\File1","C:\Temp")
    PS C:\>$paths | .\Get-AccessRights.ps1

    Gets the access rights for the paths specified in $paths.
.NOTES
    Be aware that if a local group contains domain groups of users, this will not be resolved. 
    This will be fixed at a later date.
#>
[CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact='Medium', HelpUri = "mailto:mvj@kmd.dk")]
Param (
    # Path to file or folder for which to check access rights
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({Test-Path $_})]
    [String]$Path,

    # Resolves any group members recursively
    [Parameter()]
    [Switch]$ResolveGroups,

    # Determines if access should be checked for local users, domain users or both
    [Parameter(Position=1)]
    [ValidateSet("Local","Domain")]
    [String[]]$AccountType = "Domain"
)

begin {
    function Get-DomainGroupMember {
        param(
            [Parameter(Mandatory=$true)]
            [ValidateNotNull()]
            [adsi]$Group
        )
        
        if ($handledGroups -notcontains $Group.Path) {
            Write-Verbose "Getting members for group $($Group.Name)"
            foreach ($member in $Group.Properties["member"]) {
                $dirEntry = New-Object adsi "LDAP://$member"

                if ($dirEntry.SchemaClassName -eq "group") {
                    $dirEntry = Get-DomainGroupMember -Group $dirEntry
                }

                $dirEntry
            }

            $handledGroups += $Group.Path
        } else {
            Write-Verbose "Ignoring already processed group $($Group.Name) with path $($Group.Path)"
        }
    }

    function Get-LocalGroupMember {
        param(
            [Parameter(Mandatory=$true)]
            [ValidateNotNull()]
            [adsi]$Group
        )

        if ($handledGroups -notcontains $Group.Path) {
            Write-Verbose "Getting members for group $($Group.Name)"
            foreach ($member in $Group.Invoke("members", $null)) {
                $dirEntry = New-Object adsi $member

                if ($dirEntry.SchemaClassName -eq "Group") {
                    $dirEntry = Get-LocalGroupMember -Group $dirEntry
                }

                $dirEntry
            }

            $handledGroups += $Group.Path
        } else {
            Write-Verbose "Ignoring already processed $($Group.Name) group with path $($Group.Path)"
        }
    }

    $directoryEntries = @()
    $localEntries = @()

    $domainEntryProperties = @(@{Name="DistinguishedName"; Expression={$_.Properties["distinguishedName"]}},
                            @{Name="SAMAccountName"; Expression={$_.Properties["sAMAccountName"]}},
                            @{Name="DisplayName"; Expression={$_.Properties["displayName"]}},
                            @{Name="WinPath"; Expression={$pathItem.FullName}},
                            @{Name="Access"; Expression={$access}})

    $localEntryProperties = @(@{Name="Name"; Expression={$_.Properties["Name"]}},
                            @{Name="WinPath"; Expression={$pathItem.FullName}},
                            @{Name="Access"; Expression={$access}})
}

process {
    $pathItem = Get-Item -Path $Path
    $acl = $pathItem | Get-Acl

    $handledGroups = @()

    Write-Verbose "Checking access rights on $($pathItem.FullName)"
    foreach ($access in $acl.Access) {
        Write-Verbose "Processing access rights for $($access.IdentityReference)"
        $sid = $access.IdentityReference.Translate([System.Security.Principal.SecurityIdentifier]).Value
        $domainEntry = New-Object adsi "LDAP://<SID=$sid>"

        if ($domainEntry.Guid -and $AccountType -contains "Domain" -and $access.IdentityReference -notmatch "^BUILTIN") {
            if ($domainEntry.SchemaClassName -eq "user" -or -not $ResolveGroups) {
                Write-Verbose "Adding domain entry for $($domainEntry.Name)"
                $directoryEntries += $domainEntry | Select-Object -Property $domainEntryProperties
            } elseif ($domainEntry.SchemaClassName -eq "group" -and $ResolveGroups) {
                $groupMembers = Get-DomainGroupMember -Group $domainEntry
                Write-Verbose "Adding domain entries for $(($groupMembers | Measure-Object).Count) group members"
                $directoryEntries += $groupMembers | Select-Object -Property $domainEntryProperties
            }
        } elseif ((-not $domainEntry.Guid -or $access.IdentityReference -match "^BUILTIN") -and $AccountType -contains "Local") {
            $localEntry = New-Object adsi "WinNT://$($env:COMPUTERNAME)/$($access.Identityreference -split "\\" | Select-Object -Last 1)"

            if ($localEntry.SchemaClassName -eq "user" -or -not $ResolveGroups) {
                Write-Verbose "Adding local entry for $($localEntry.Name)"
                $localEntries += $localEntry | Select-Object -Property $localEntryProperties
            } elseif ($localEntry.SchemaClassName -eq "Group" -and $ResolveGroups) {
                $groupMembers = Get-LocalGroupMember -Group $localEntry
                Write-Verbose "Adding local entries for $(($groupMembers | Measure-Object).Count) group members"
                $localEntries += $groupMembers | Select-Object -Property $localEntryProperties
            } 
        }
    }
}

end {
    Write-Verbose "Returning results"
    $userACL = @()
    $userACL += $directoryEntries | Select-Object -Property @{Name="Path"; Expression={$_.WinPath}},
                                                @{Name="Domain"; Expression={($_.DistinguishedName -split "," | Where-Object { $_ -match "^DC=" }) -replace "DC=","" -join "."}},
                                                @{Name="UserName"; Expression={$_.SAMAccountName}},
                                                @{Name="DisplayName"; Expression={$_.DisplayName}},
                                                @{Name="AccessControlType"; Expression={$_.Access.AccessControlType}},
                                                @{Name="FileSystemRights"; Expression={$_.Access.FileSystemRights}}
                                                
    $userACL += $localEntries | Select-Object -Property @{Name="Path"; Expression={$_.WinPath}},
                                            @{Name="Domain"; Expression={$env:COMPUTERNAME}},
                                            @{Name="UserName"; Expression={$_.Name}},
                                            @{Name="DisplayName"; Expression={""}},
                                            @{Name="AccessControlType"; Expression={$_.Access.AccessControlType}},
                                            @{Name="FileSystemRights"; Expression={$_.Access.FileSystemRights}}
    
    $userACL | ForEach-Object {
        if (-not ($_.UserName)) {
            $_.UserName = "SYSTEM" 
        }
    }

    $userACL | Sort-Object -Property Path,Domain,UserName
}