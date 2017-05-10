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

   The loop continues until the execution is interrupted, i.e. using Ctrl+C or closing the PowerShell window, 
   or until the timeout period expires, if specified.
.EXAMPLE
   Suspend-ScreenSaver

   Starts a suspension loop with the default 60 second delay.
.EXAMPLE
   Suspend-ScreenSaver -Delay 5

   Starts a suspension loop but triggers the keystroke every 5 seconds.
.EXAMPLE
   Suspend-ScreenSaver -TimeOut 60

   Starts a suspension loop with the default 60 second delay.
   After the timeout period of 60 minutes have passed, the function will exit.
#>
function Suspend-ScreenSaver {
    [CmdletBinding(ConfirmImpact = 'Low')]
    param(
        # Time to wait between each keystroke
        [Parameter(Position = 0)]
        [ValidateScript({$_ -gt 0})]
        [int]$Delay = 60,

        # Duration in minutes for the loop to run
        [Parameter(Position = 1)]
        [ValidateScript({$_ -gt 0})]
        [double]$TimeOut
    )

    $startTime = Get-Date
    $endTime = $null

    if ($TimeOut) {
        $endTime = $startTime.AddMinutes($TimeOut)
    }

    $wScriptShell = New-Object -COM "WScript.Shell"

    while ($true) {
        $wScriptShell.SendKeys("{F15}")

        Start-Sleep -Seconds $Delay

        if ($TimeOut -and $endTime -lt (Get-Date)) {
            return
        }
    }
}

<#
.Synopsis
   Gets a PSCredential object with the setup test credentials
.DESCRIPTION
   Gets a PSCredential object with the setup test credentials
.EXAMPLE
   $credentials = Get-TestCredential

   Gets the default test credentials and saves in the $credentials variable
#>
function Get-TestCredential {
    [CmdletBinding(ConfirmImpact = 'Low')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
    param()

    New-Object System.Management.Automation.PSCredential ("Administrator", ("9VBatteryEel" | ConvertTo-SecureString -AsPlainText -Force))
}