<#
.Synopsis
   Exports a CSV with a list of AD users and chosen properties.
.DESCRIPTION
   List Active Directory users recursively in a chose OU and get any chosen properties. Finally, export to a CSV file.
   Default properties are: 
      samaccountname
      givenname
      sn
      mail
      homephone
      mobile
.EXAMPLE
   .\Export-ADUserProperties.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local"

   List all users in the OU "Users" and get the default properties. 
   Exports to a CSV file in the same directory as the scrip called "ADUserProperties.csv"
.EXAMPLE
   .\Export-ADUserProperties.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local" -CSVPath "C:\Users\UserName\Desktop\UserProps.csv"

   List all users in the OU "Users" and get the default properties. 
   Exports to a CSV file at the chosen path.
.EXAMPLE
   .\Export-ADUserProperties.ps1 -LDAPPath "LDAP://OU=Users,DC=domain,DC=local" -Properties "samaccountname","displayname","accountexpires"

   List all users in the OU "Users" and get custom properties that list the user name, display name and when the account expires.
   Exports to a CSV file at the chosen path.
.INPUTS
   System.String
.OUTPUTS
   System.Management.Automation.PSCustomObject
.NOTES
   This function does not take pipeline input. 
#>

[CmdletBinding(SupportsShouldProcess=$false, 
                PositionalBinding=$false,
                ConfirmImpact='Low')]
[OutputType([System.Management.Automation.PSCustomObject])]
Param
(
    # LDAP path to the root container in AD where users are to be found.
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^LDAP://.*")]
    [String]$LDAPPath,

    # Path to exported CSV file. 
    [ValidateNotNullOrEmpty()]
    [String]$CSVPath = (Join-Path -Path $PSScriptRoot -ChildPath "ADUserProperties.csv"),

    # List of properties to load.
    [ValidateNotNullOrEmpty()]
    [String[]]$Properties = @("samaccountname", "givenname", "sn", "mail", "homephone", "mobile"),

    # Delimiter used to separate values in the CSV file.
    [ValidateNotNullOrEmpty()]
    [String]$CSVDelimiter = ",",

    # Force the export to overwrite any existing file
    [Switch]$Force
)

Begin
{
    if ((Test-Path $CSVPath) -and (-not $Force)) {
        throw "Export file already exists. Use -Force to overwrite."
    }

    $domain = New-Object System.DirectoryServices.DirectoryEntry($LDAPPath)
    $searcher = New-Object System.DirectoryServices.DirectorySearcher($domain)

    $searcher.CacheResults = $true
    $searcher.Filter = "(&(objectCategory=Person))"

    Write-Verbose "Adding properties $Properties to searcher"
    $Properties | ForEach-Object {
        $searcher.PropertiesToLoad.Add($_) | Out-Null
    }

    $searcher.SizeLimit = 0
    $searcher.PageSize = 1000
}
Process
{
    Write-Progress -Activity "Exporting user properties..." -Status "Running user search" -PercentComplete 0
    Write-Verbose "Running search"
    $persons = $searcher.FindAll()
    if ($persons.Count -eq 0) {
        throw "No users found in AD. Check LDAP path."
    } else {
        Write-Verbose "Found $($persons.Count) users."
    }

    $users = @()
    Write-Progress -Activity "Exporting user properties..." -Status "Parsing users" -PercentComplete 0
    Write-Verbose "Parsing users"

    for ($i = 0; $i -lt $persons.Count; $i++) {
        Write-Progress -Activity "Exporting user properties..." -Status "Parsing users" -CurrentOperation ("$i of $($persons.Count)") -PercentComplete ($i / $persons.Count * 100)
        $user = New-Object -TypeName psobject 

        $properties | ForEach-Object {
            if ($persons[$i].Properties.Contains($_)) {
                $user | Add-Member -MemberType NoteProperty -Name $_ -Value $persons[$i].Properties[$_][0] | Out-Null
            } else {
                $user | Add-Member -MemberType NoteProperty -Name $_ -Value "" | Out-Null
            }
        }

        $users += $user
    }
    
    Write-Progress -Activity "Exporting user properties..." -Status "Exporting to CSV file" -PercentComplete 100
    Write-Verbose "Exporting to $CSVPath"

    $users | Export-Csv -Path $CSVPath -Delimiter $CSVDelimiter -Encoding UTF8 -Force
}
End
{
    $searcher.Dispose()

    $domain.Close()
    $domain.Dispose()
}