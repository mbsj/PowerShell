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
   Suspends execution of the screen server and time lock
.DESCRIPTION
   When executed, starts a loop which sends a a keystroke to the session to prevent the screensaver
   from starting as well as session locks and other triggers based on inactive time. 
   Default loop delay is 60 seconds.

   The loop continues until the execution is interrupted, i.e. using Ctrl+C or closing the PowerShell window.
.EXAMPLE
   Suspend-ScreenSaver

   Starts a suspension loop with the default 60 second delay.
.EXAMPLE
   Suspend-ScreenSaver -Delay 5

   Starts a suspension loop but triggers the keystroke every 5 seconds.
#>
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

<#
.Synopsis
   Gets a PSCredential object with the setup test credentials
.DESCRIPTION
   Gets a PSCredential object with the setup test credentials
.EXAMPLE
   $creds = Get-TestCredential

   Gets the default test credentials and saves in the $creds variable
#>
function Get-TestCredential {
    [CmdletBinding(ConfirmImpact = 'Low')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
    param()

    $passwordSecureString = "01000000d08c9ddf0115d1118c7a00c04fc297eb01000000bedb5723bcf0a548b619ca968df80ece0000000002000000000003660000c000000010000000985f7ff40ccae1b4385ecd7d11935fb40000000004800000a000000010000000fc3db66bc3d96f1e528a982f2ce5e0b520000000f71fa436fc15dae8bff1d5dc4d12c059591c394a19729b1cbd3cd1d4474a7683140000000f1a66d0504492b58a0b741e45e69ee5e4430942"

    New-Object System.Management.Automation.PSCredential ("Administrator", ($passwordSecureString | ConvertTo-SecureString))
}