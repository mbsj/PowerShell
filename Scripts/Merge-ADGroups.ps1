<#
.SYNOPSIS
    Merges all groups in a specified OU into a single destination group. 
.DESCRIPTION
    Takes a source LDAP path for an OU and gathers all groups in that OU. 
    Then takes the members of each group and adds it to a specified destination group as provided by LDAP distinguished named. 
    If a member appears in several source groups, they will only be added once to the destination group. 
.EXAMPLE
    $sourceOU = "LDAP://OU=Suppert,OU=Users,DC=domain,DC=local"
    $destinationGroup = "LDAP://CN=AllSupporters,OU=Suppert,OU=Users,DC=domain,DC=local"
    $filter = "*Level"
    
    .\Merge-ADGroups.ps1 -SourceOU $sourceOU -DestinationGroup $destinationGroup -SourceGroupFilter $filter

    Assume three groups exist in domain.local/Users/Suppoert: 
        1stLevel
        2ndLevel
        AllSupporters
    
    The filter will match the first two groups, and the destination group LDAP path will merge those groups in AllSupporters
.INPUTS
    LDAP distinguished paths
.OUTPUTS
    No regular output
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    # LDAP distinguished name for the source OU containing group. I.e.: LDAP://OU=Support,OU=Users,DC=domain,DC=local
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidatePattern("^LDAP://")]
    [String]$SourceOU,

    # LDAP distinguished name for the destination group. I.e.: LDAP://CN=AllSupport,OU=Support,OU=Users,DC=domain,DC=local
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidatePattern("^LDAP://")]
    [String]$DestinationGroup,

    # A LDAP filter to limit the source groups
    [Parameter(Position = 2)]
    [String]$SourceGroupFilter
)

begin {
    $OldGroupsOU_LDAP = "LDAP://OU=Test,OU=KMD,OU=Brugere,OU=Butik,DC=triostaging,DC=local"
    $NewGroupLDAP = "LDAP://CN=ASD,OU=Test,OU=KMD,OU=Brugere,OU=Butik,DC=triostaging,DC=local"
    $OldGroupsFilter = "Test*"

    $newGroup = New-Object System.DirectoryServices.DirectoryEntry($DestinationGroup)
    $oldGroupsOU = New-Object System.DirectoryServices.DirectoryEntry($SourceOU)
    $searcher = New-Object System.DirectoryServices.DirectorySearcher($oldGroupsOU)
}
process {
    $searcher.CacheResults = $true
    $searcher.Filter = "(&(objectCategory=Group)(name=$SourceGroupFilter))"
    $searcher.PropertiesToLoad.Add("member") | Out-Null
    $searcher.PropertiesToLoad.Add("name") | Out-Null
    $searcher.SizeLimit = 0
    $searcher.PageSize = 1000

    $groups = $searcher.FindAll()
    Write-Verbose "Found $($groups.Count) groups."

    foreach ($group in $groups) {
        $members = $group.Properties["member"]

        Write-Verbose "Parsing $($members.Count) members of $($group.Properties["name"])"
        $members | ForEach-Object {
            if (-not $newGroup.Properties["member"].Contains($_)) {
                if ($pscmdlet.ShouldProcess($newGroup.Properties["name"], "Add user $($_)")) {
                    $newGroup.Properties["member"].Add($_) | Out-Null
                }
            }
            else {
                Write-Verbose "User $_ already exists in group $($newGroup.Properties["name"])"
            }
        }
    }
}
end {
    if ($pscmdlet.ShouldProcess($newGroup.Properties["name"], "Commit changes")) {
        $newGroup.CommitChanges()
    }
}