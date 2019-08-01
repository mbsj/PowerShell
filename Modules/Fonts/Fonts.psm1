#requires -Version 2

<#
.SYNOPSIS
Installs one or more fonts for the current user.

.DESCRIPTION
Installs font files specified in the FontFile parameter. Can reference a single file or a folder containing multiple files.
Accepts the following file types:
    .fon
    .fnt
    .ttf
    .ttc
    .otf

.EXAMPLE
Install-Font -Path "".\Fira Code-Bold.ttf"
Will install the Fira Code Bold font.

.NOTES
Mark Birkedal Stjerslev - 2019-08-01
#>

function Install-Font {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to a font file or a folder containing multiple font files")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path,

        [Parameter(HelpMessage = "Force installation even if the font already exists")]
        [switch]
        $Force
    )

    begin {
        $fontFileTypes = @{ }
        $fontFileTypes.Add(".fon", "")
        $fontFileTypes.Add(".fnt", "")
        $fontFileTypes.Add(".ttf", " (TrueType)")
        $fontFileTypes.Add(".ttc", " (TrueType)")
        $fontFileTypes.Add(".otf", " (OpenType)")

        $userFontRoot = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Microsoft\Windows\Fonts"
        $userFontRegPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    }

    process {
        $fontFiles = Get-ChildItem $FontPath

        Write-Verbose "Installing $($fontFiles | Measure-Object | Select-Object -ExpandProperty Count) font(s)"

        foreach ($fontFile in $fontFiles) {
            Write-Verbose "Installing $($fontFile.FullName)..."
            $destinationFile = Join-Path -Path $userFontRoot -ChildPath $fontFile.Name

            $shell = New-Object -ComObject Shell.Application
            $shellFontFolder = $shell.Namespace($fontFile.Directory.FullName)
            $shellFontFile = $shellFontFolder.Items().Item($fontFile.Name)
            $fontName = $shellFontFolder.GetDetailsOf($shellFontFile, 21)
            $fontRegKeyName = $fontName + $fontFileTypes[$fontFile.Extension]

            if ((Test-Path $destinationFile) -and (Get-ItemProperty -Path $userFontRegPath -Name $fontRegKeyName -ErrorAction SilentlyContinue) -and (-not $Force)) {
                Write-Error "The font `"$fontName`" is already installed."
            }
            else {
                Copy-Item -Path $fontFile -Destination $userFontRoot -Verbose:$VerbosePreference

                $regKey = New-ItemProperty -Path $userFontRegPath -Name $fontRegKeyName -Value $destinationFile -PropertyType "String" -Verbose:$VerbosePreference

                Write-Verbose "$($fontFile.FullName) installed."
            }
        }
    }
}