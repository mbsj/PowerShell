<#
.Synopsis
   Test authentication in Active Directory
.DESCRIPTION
   Uses provided username and password to test authentication against default Active Directory. 
.EXAMPLE
   Test-ADAuthentication -Username "User" -Password "P@ssw0rd"

   Tests the provided username and password, return "TRUE" or "FALSE" based on success
#>
function Test-ADAuthentication {
    [CmdletBinding(SupportsShouldProcess = $false,
        ConfirmImpact = 'Low')]
    param(
        # Username to test
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$Username,

        # Password for the user
        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]$PlainTextPassword
    )

    $dirEntry = New-Object directoryservices.directoryentry "", $Username, $Password
    $dirEntry.psbase.name -ne $null
}

<#
.Synopsis
   Retrieves a list of domain user accounts based on age
.DESCRIPTION
   Gets a list of users on the domain, based on the filter string provided in -Filter. The filter uses the PowerShell Expression language syntax and defaults to all users (Name -like *).
   Accounts are then filtered based on the value provided in -MaxAge. The age defaults to one year.
   If the LastLogonTimestamp value of the AD user is older than the max age, the user is disabled. 
   If the user has never logged on (the property LastLogonTimestamp is blank), the property whenCreated is used instead. 
.EXAMPLE
   Get-StaleDomainAdmins -SpecialAccounts "Administrator","Guest","ovoinst","sa_sql","trioappsvc1","vltrader"

   Disable stale domain users, which have been inactive for more than a year, excluding the selected special accounts. 

.EXAMPLE
   Get-StaleDomainAdmins -MaxAge (Get-Date).AddDays(-30)

   Disable stale domain users, which have been inactive for more than 30 days.
#>
function Get-StaleDomainAdmins {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    [OutputType([String])]
    Param
    (
        # Filter to use when querying the domain for users. Uses PowerShell expression language syntax and is passed unfiltered to the Get-ADUser cmdlet.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$Filter = "Name -like '*'",

        # The maximum age of a users logon or creation time
        [Parameter(Position = 1)]
        [ValidateNotNull()]
        [ValidateScript( {$_ -lt (Get-Date)})]
        [DateTime]$MaxAge = ((Get-Date).AddYears(-1)),

        # A list of SamAccountName which should not be disabled
        [Parameter(Position = 1)]
        [String[]]$SpecialAccounts = @("Administrator", "Guest"),

        # Path to log file
        [Parameter(Position = 2)]
        [String]$LogPath = ".\Disable-StaleDomainAdmins.log"
    )

    Begin {
        Import-Module ActiveDirectory -ErrorAction Stop

        $staleUsers = @()
        Write-Verbose "Special accounts are: $($SpecialAccounts -join ", ")."
    }
    Process {
        Write-Verbose "Getting enabled AD users using filer $Filter."
        $adUsers = Get-ADUser -Filter $Filter | Where-Object Enabled -eq $true

        Write-Verbose "Found $(($adUsers | Measure-Object).Count) users."

        Write-Verbose "Comparing user logon or creation times against max age of $MaxAge."
        $staleUsers = $adUsers | ForEach-Object {
            $adObject = $_ | Get-ADObject -Properties lastLogonTimeStamp, whenCreated 

            $lastLogonFileTime = $adObject | Select-Object -ExpandProperty lastLogonTimeStamp
            $whenCreatedTime = $adObject | Select-Object -ExpandProperty whenCreated

            if ($lastLogonFileTime) {
                $lastLogonTime = [DateTime]::FromFileTime($lastLogonFileTime)

                if ($lastLogonTime -lt (Get-Date).AddYears(-1) -and $_.Enabled) {
                    $_ | Select-Object -Property DistinguishedName, Name, SamAccountName, @{Name = "LastLogonTime"; Expression = {$lastLogonTime}}, @{Name = "CreatedTime"; Expression = {$whenCreatedTime}}
                }
            }
            else {
                if ($whenCreatedTime -and $whenCreatedTime -gt [DateTime]::MinValue -and $whenCreatedTime -lt (Get-Date).AddYears(-1)) {
                    $_ | Select-Object -Property DistinguishedName, Name, SamAccountName, @{Name = "LastLogonTime"; Expression = {}}, @{Name = "CreatedTime"; Expression = {$whenCreatedTime}}
                }
            }
        }

        Write-Verbose "Found $(($staleUsers | Measure-Object).Count) stale users."

        $staleUsers = $staleUsers | Where-Object { 
            if ($SpecialAccounts -contains $_.SamAccountName) {
                Write-Verbose "List of stale users contains special account $($_.SamAccountName). It will be excluded."
                $false
            }
            else {
                $true
            }
        }

        Write-Verbose "Found $(($staleUsers | Measure-Object).Count) stale users after filtering for special accounts."

        if ($staleUsers) {
            $staleUsers | ForEach-Object {
                if ($pscmdlet.ShouldProcess($_.DistinguishedName, "Disable AD user")) {
                    Disable-ADAccount -Identity $_.DistinguishedName
                }
            }
        }
        else {
            Write-Verbose "No stale users to disable"
        }
    }
    End {
    }
}