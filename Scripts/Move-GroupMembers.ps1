$OldGroupsOU_LDAP = "LDAP://OU=Test,OU=KMD,OU=Brugere,OU=Butik,DC=triostaging,DC=local"
$NewGroupLDAP = "LDAP://CN=ASD,OU=Test,OU=KMD,OU=Brugere,OU=Butik,DC=triostaging,DC=local"
$OldGroupsFilter = "Test*"

$newGroup = New-Object System.DirectoryServices.DirectoryEntry($NewGroupLDAP)
$oldGroupsOU = New-Object System.DirectoryServices.DirectoryEntry($OldGroupsOU_LDAP)
$searcher = New-Object System.DirectoryServices.DirectorySearcher($oldGroupsOU)

$searcher.CacheResults = $true
$searcher.Filter = "(&(objectCategory=Group)(name=$OldGroupsFilter))"
$searcher.PropertiesToLoad.Add("member") | Out-Null
$searcher.PropertiesToLoad.Add("name") | Out-Null
$searcher.SizeLimit = 0
$searcher.PageSize = 1000

$groups = $searcher.FindAll()
Write-Output "Found $($groups.Count) groups."

foreach ($group in $groups) {
    $members = $group.Properties["member"]

    Write-Output "Parsing $($members.Count) members of $($group.Properties["name"])"
    $members | ForEach-Object {
        $_.Properties["samaccount"]
        if (-not $newGroup.Properties["member"].Contains($_)) {
            $newGroup.Properties["member"].Add($_) | Out-Null
        }
    }

    $newGroup.CommitChanges()
}