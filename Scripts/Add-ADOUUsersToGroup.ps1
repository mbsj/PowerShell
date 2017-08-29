#Requires -Modules ActiveDirectory

<#
.SYNOPSIS
    Takes all member users from the selected OU and adds them to one or more AD groups
.DESCRIPTION
    Searches for any and all OUs based on the OU name. Any users in these OUs are then added to the groups. 

    Groups are also matched on the group name. Use SearchBase to limit the search area. 

    If multiple instances of OUs with the same name are present, a warning will be displayed. 
    If one or more OUs or groups cannot be found, a warning will be displayed.

    If some users are already members, this will not change anything for those users. 

    The script has high confirm impact and will prompt for confirmation unless the local machine is configured to ignore high confirm impact. 
.EXAMPLE
    .\Add-ADOUUsersToGroup.ps1 -OUName "WestOffice" -GroupName "AllOffices"
    Adds the users from the OU WestOffice to the group "AllOffices"
.EXAMPLE
    $ouNames = @("West","East","North")
    PS C:\>.\Add-ADOUUsersToGroup.ps1 -OUName $ouNames -GroupName "DKOffices" -SearchBase "OU=DK,DC=domain,DC=local"

    Searches the DK root base for all users in the "west", "east" and "north" OUs. Then adds them to the common group "DKOffices" 
.EXAMPLE
    $ouNames = @("West","East","North")
    PS C:\>$groupNames = @("DKOffices","DK","All")

    PS C:\>.\Add-ADOUUsersToGroup.ps1 -OUName $ouNames -GroupName $groupNames -SearchBase "OU=DK,DC=domain,DC=local"

    Searches the DK root base for all users in the "west", "east" and "north" OUs. Then adds them to the common group "DKOffices", "DK" and "All"
.EXAMPLE
    $ouNames | .\Add-ADOUUsersToGroup.ps1 -GroupName "AllSupporters"
    Pipes a list of OU names to the script, adding them to the group called "AllSupporters"
.INPUTS
    Strings identifying OU names, group names and the search base. 
.OUTPUTS
    None
.NOTES
    Requires the PowerShell AD module as well as sufficient rights to manipulate the desired groups. 
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
Param (
    # The name of the OU to take users from. 
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$OUName,
        
    # The name of the group the users should be added to.
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateNotNullOrEmpty()]
    [String[]]$GroupName,
        
    # AD root base the search should be limited to.
    [Parameter(Position = 2)]
    [String]$SearchBase
)
    
begin {
    $ouParams = @{
        Filter = "ObjectClass -eq 'organizationalUnit'"
    }

    if ($SearchBase) {
        $ouParams.Add("SearchBase", $SearchBase)
    }

    $groupParams = @{
        Filter = "ObjectClass -eq 'group'"
    }

    if ($SearchBase) {
        $groupParams.Add("SearchBase", $SearchBase)
    }

    Write-Verbose "Getting groups from AD"
    $groups = Get-ADGroup @groupParams | Where-Object Name -In $GroupName
    if (-not $groups) {
        throw "No groups found"
    }
    else {
        $GroupName | ForEach-Object {
            if (($groups | Where-Object Name -eq $_ | Measure-Object).Count -eq 0) { 
                Write-Warning "No group with name $_ found"
            }
        }
    }
}
    
process {
    Write-Verbose "Getting OUs from AD"
    $ous = Get-ADOrganizationalUnit @ouParams | Where-Object Name -In $OUName
    if (-not $ous) {
        throw "No OUs found"
    }
    else {
        $OUName | ForEach-Object {
            if (($ous | Where-Object Name -eq $_ | Measure-Object).Count -eq 0) { 
                Write-Warning "No OU with name $_ found"
            }
            elseif (($ous | Where-Object Name -eq $_ | Group-Object -Property Name).Count -gt 1) {
                Write-Warning "Multiple instances of OUs with name '$_':`r`n`t$(($ous | Where-Object Name -eq $_ | Select-Object -ExpandProperty "DistinguishedName") -join "`r`n`t")" 
            }
        }
    } 

    Write-Verbose "Getting users from AD"
    $users = $ous | ForEach-Object {
        Write-Verbose "Getting users from $($_.DistinguishedName)"
        Get-ADUser -SearchBase $_.DistinguishedName -Filter "ObjectClass -eq 'user'"
    }
    
    if ($users) {
        $groups | ForEach-Object {
            if ($pscmdlet.ShouldProcess($_.Name, "Add $($users.Count) users as group members")) {
                Add-ADGroupMember -Identity $_.DistinguishedName -Members $users
            }
        }
    }
    else {
        throw "No users found"
    }
}
    
end {
}