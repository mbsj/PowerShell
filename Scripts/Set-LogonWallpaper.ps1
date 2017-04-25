<#
.SYNOPSIS
    Sets the logon wallpaper on Windows 7
.DESCRIPTION
    Sets a logon wallpaper on Windows 7 be exploiting the "Out Of Box Experience".
    Sets the registry key for OEM background and places the specified image file in the OOBE backgrounds folder.
.EXAMPLE
    .\Set-LogonWallpaper.ps1 -ImagePath
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
Param (
    # Type of cleanup to run
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript( {Test-Path -Path $_ -PathType Leaf})]
    [String[]]$ImagePath
)

begin {
    $regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background"
    $oemPath = "C:\Windows\System32\oobe\info\backgrounds"
}

process {
    Set-ItemProperty -Path $regKey -Name "OEMBackground" -Value 1 -Type DWord -WhatIf:$WhatIfPreference

    if (-not (Test-Path $oemPath)) {
        New-Item $oemPath -ItemType Directory -Force -WhatIf:$WhatIfPreference
    }

    Copy-Item -Path $ImagePath -Destination (Join-Path -Path $oemPath -ChildPath "backgroundDefault.jpg") -Force -WhatIf:$WhatIfPreference
}

end {
}