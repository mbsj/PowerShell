#requires -Version 2

$userFontRegPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
$fontFileTypes = @{ }
$fontFileTypes.Add(".fon", "")
$fontFileTypes.Add(".fnt", "")
$fontFileTypes.Add(".ttf", " (TrueType)")
$fontFileTypes.Add(".ttc", " (TrueType)")
$fontFileTypes.Add(".otf", " (OpenType)")

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
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to a font file or a folder containing multiple font files")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { Test-Path $_ })]
        [string[]]
        $Path,

        [Parameter(HelpMessage = "Force installation even if the font already exists")]
        [switch]
        $Force
    )

    begin {
        $userFontRoot = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Microsoft\Windows\Fonts"
    }

    process {
        Write-Verbose "Getting font files from $Path"

        $fontFiles = Get-ChildItem $Path | Where-Object { $_.Extension -in $fontFileTypes.Keys }

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
                Copy-Item -Path $fontFile -Destination $userFontRoot -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference

                New-ItemProperty -Path $userFontRegPath -Name $fontRegKeyName -Value $destinationFile -PropertyType "String" -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference | Out-Null

                Write-Verbose "$($fontFile.FullName) installed."
            }
        }
    }
}

<#
.SYNOPSIS
Returns a list of installed fonts.

.DESCRIPTION
Returns a hash table with the name of the font as the key, and the path to the font file as the value.

.EXAMPLE
Get-Font
Returns a list of fonts and font files.

.EXAMPLE
Get-Font | Foreach-Object { Test-Path $_.Value }
Returns a list of fonts and iterates over them to test that the font files actually exist.

.NOTES
Mark Birkedal Stjerslev - 2019-08-01
#>

function Get-Font {
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (
    )

    begin {
        $fonts = @{ }
    }

    process {
        $fontRegItem = Get-Item -Path $userFontRegPath

        $fontRegItem.Property | ForEach-Object {
            $fonts.Add($_, $fontRegItem.GetValue($_))
        }
    }

    end {
        $fonts
    }
}