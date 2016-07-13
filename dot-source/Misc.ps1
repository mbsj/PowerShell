function Get-Password() {
    param(
        [Switch]$Numeric,
        [Switch]$Complex,
        [int]$Count = 1,
        [int]$Length = 16
    )

    $passwords = @()

    if ($Numeric) {
        $chars = @("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
    } else {
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

function Sign-Script {
    param (
        [Parameter(Mandatory = $true)]
        [String]$ScriptPath
    )

    $codeSigningCerts = @()
    $codeSigningCerts += Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
    $codeSigningCerts += Get-ChildItem Cert:\LocalMachine\TrustedPublisher\ -CodeSigningCert
    $cert = $null

    if ($codeSigningCerts.Count -lt 1) {
        Write-Host "No code signing certificates found. At least one is required." -ForegroundColor Red
        return
    } elseif ($codeSigningCerts.Count -gt 1) {
        Write-Host "More than one certificate found. Please select one:" -ForegroundColor Green

        for ($i = 0; $i -lt $codeSigningCerts.Count; $i++) {
            Write-Host ($i + 1) " - SUBJECT:" $codeSigningCerts[$i].Subject "`tSERIAL NUMBER:" $codeSigningCerts[$i].SerialNumber
        }

        $selected = -1 
        do {
            $selected = Read-Host "Please select one" 
        } until ($selected -match "^[0-9]*$" -and $selected -le $codeSigningCerts.Count -and $selected -gt 0)

        $cert = $codeSigningCerts[$selected -1]
    } else {
        $cert = $codeSigningCerts[0]
    }

    Set-AuthenticodeSignature -Certificate $cert -FilePath $ScriptPath
}



function tools {
    Set-Location -Path "$env:USERPROFILE\OneDrive\Tools"
}

function downloads {
    Set-Location -Path "$env:USERPROFILE\Downloads"
}

filter Get-Matches($Pattern) {
    $_ | Select-String -AllMatches $pattern | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Value 
}