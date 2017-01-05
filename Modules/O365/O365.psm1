<#
.Synopsis
   Connects to Exchange service in Office 365
.DESCRIPTION
   Connects to Exchange service in Office 365 using PowerShell remoting
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Connect-O365Exchange { 
    [CmdletBinding(SupportsShouldProcess=$false, 
                  ConfirmImpact='Medium')]
    
    param()
    $UserCredential = Get-Credential 
    
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
    
    Import-PSSession $Session
}