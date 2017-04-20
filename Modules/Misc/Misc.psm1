<#
.Synopsis
   Creates a random password
.DESCRIPTION
   Creates a password with 16 characters or random numbers and letters.
   Can be configured to create a complex password also containing special characters. 
.EXAMPLE
   Get-Password

   Creates a random password with 16 characters
.EXAMPLE
   Get-Password -Numeric -Length 10 -Count 4

   Creates 4 numeric passwords with a length of 10 characters
#>
function Get-Password() {
    [CmdletBinding(DefaultParameterSetName = "Simple", ConfirmImpact = 'Low')]
    param(
        # The number of characters in the password
        [Parameter(Position = 0, ParameterSetName = "Simple")]
        [Parameter(Position = 0, ParameterSetName = "Numeric")]
        [Parameter(Position = 0, ParameterSetName = "Complex")]
        [int]$Length = 16,

        # The number of passwords to generate
        [Parameter(Position = 0, ParameterSetName = "Simple")]
        [Parameter(Position = 1, ParameterSetName = "Numeric")]
        [Parameter(Position = 1, ParameterSetName = "Complex")]
        [int]$Count = 1,

        # Whether the password should be numeric
        [Parameter(ParameterSetName = "Numeric")]
        [Switch]$Numeric,

        # Whether the password should use special characters
        [Parameter(ParameterSetName = "Complex")]
        [Switch]$Complex
    )

    $passwords = @()

    if ($Numeric) {
        $chars = @("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
    }
    else {
        $chars = @("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")
    }

    if ($Complex) {
        $chars += @("!", "`"", "#", "$", "%", "&", "`'", "`(", "`)", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "\", "]", "^", "_", "``", "{", "|", "}", "~")
    }

    for ($c = 1; $c -le $Count; $c++) {
        $password = ""

        for ($l = 1; $l -le $Length; $l++) {
            $password += ($chars | Get-Random)
        }

        $passwords += $password
    }

    return $passwords
}

<#
.Synopsis
   Signes a PowerShell script
.DESCRIPTION
   Signs the script provied with a valid code signing certificate. 

   If only one certificate exsists, the script will be signed with that. 
   If more that one exists, the user will be prompted to select a certificate. 
.EXAMPLE
   Set-ScriptCertificate -ScriptPath C:\Temp\Get-Output.ps1

   Signs the script C:\Temp\Get-Output.ps1
#>
function Set-ScriptCertificate {
    [CmdletBinding(ConfirmImpact = 'Low')]
    param (
        # The path to the script which should be signed
        [Parameter(Mandatory = $true)]
        [String]$ScriptPath
    )

    $codeSigningCerts = @()
    $codeSigningCerts += Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
    $codeSigningCerts += Get-ChildItem Cert:\LocalMachine\TrustedPublisher\ -CodeSigningCert
    $cert = $null

    if ($codeSigningCerts.Count -lt 1) {
        Write-Error "No code signing certificates found. At least one is required." -ForegroundColor Red
        return
    }
    elseif ($codeSigningCerts.Count -gt 1) {
        Write-Warning "More than one certificate found. Please select one:" -ForegroundColor Green

        for ($i = 0; $i -lt $codeSigningCerts.Count; $i++) {
            Write-Output -InputObject (($i + 1) + " - SUBJECT:" + $codeSigningCerts[$i].Subject + "`tSERIAL NUMBER:" + $codeSigningCerts[$i].SerialNumber)
        }

        $selected = -1 
        do {
            $selected = Read-Host "Please select one" 
        } until ($selected -match "^[0-9]*$" -and $selected -le $codeSigningCerts.Count -and $selected -gt 0)

        $cert = $codeSigningCerts[$selected - 1]
    }
    else {
        $cert = $codeSigningCerts[0]
    }

    Set-AuthenticodeSignature -Certificate $cert -FilePath $ScriptPath
}


function Suspend-ScreenSaver {
    [CmdletBinding(ConfirmImpact = 'Low')]
    param(
        [Parameter(Position = 0)]
        [int]$Delay = 60
    )

    $wscriptShell = New-Object -COM "WScript.Shell"

    while ($true) {
        $wscriptShell.SendKeys("{F15}")

        Start-Sleep -Seconds $Delay
    }
}

function Get-PasswordSecureString {
    [CmdletBinding(ConfirmImpact = 'Low')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String]$PlainTextPassword
    )

    $Password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
}

$Test2016Credentials = New-Object System.Management.Automation.PSCredential (“Administrator”, (ConvertTo-SecureString "9VBatteryEel" -AsPlainText -Force))

$STSMySQL = New-Object psobject
$STSMySQL | Add-Member -MemberType NoteProperty -Name Host -Value "172.30.211.156"
$STSMySQL | Add-Member -MemberType NoteProperty -Name Username -Value "z8mvj"
$STSMySQL | Add-Member -MemberType NoteProperty -Name Password -Value "jCXNg4y5x6"

Export-ModuleMember -Function * -Variable *