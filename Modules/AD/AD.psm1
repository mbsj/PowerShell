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
    [CmdletBinding(SupportsShouldProcess=$false,
                  ConfirmImpact='Low')]
    param(
        # Username to test
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [String]$Username,

        # Password for the user
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [String]$PlainTextPassword
    )

    $dirEntry = New-Object directoryservices.directoryentry "",$Username,$Password
    $dirEntry.psbase.name -ne $null
}