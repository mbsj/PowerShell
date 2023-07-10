[CmdletBinding(SupportsShouldProcess = $true)]
param (
)

Write-Verbose "Verifying fonts are installed..."
$fontFilesPathRoot = Join-Path -Path $env:OneDriveConsumer -ChildPath "Technical\FiraCode_1.207\ttf"

$requiredFonts = @{
    "FiraMono Nerd Font Mono Bold (TrueType)"    = "FiraMonoNerdFontMono-Bold.otf";
    "FiraMono Nerd Font Mono Medium (TrueType)"  = "FiraMonoNerdFontMono-Medium.otf";
    "FiraMono Nerd Font Mono Regular (TrueType)"  = "FiraMonoNerdFontMono-Regular.otf"
}

Write-Verbose "The following fonts are expected to be installed:"
$requiredFonts.Keys | Sort-Object | ForEach-Object {
    Write-Verbose "`t$_"
}

Write-Verbose "Getting installed fonts..."
$installedFonts = Get-Font

Write-Verbose "The following fonts are installed:"
$installedFonts.Keys | Sort-Object | ForEach-Object {
    Write-Verbose "`t$_"
}

Write-Verbose "Checking for missing fonts..."
$missingFonts = @()
$requiredFonts.Keys | ForEach-Object {
    if ($installedFonts.Keys -notcontains $_) {
        Write-Warning "Font `"$_`" not installed."
        $missingFonts += $_
    }
}

if ($missingFonts) {
    Write-Warning "To install missing fonts, use the function `"Install-MissingFont`""
}
else {
    Write-Verbose "No missing fonts."
}

<#
.SYNOPSIS
Install missing fonts.

.DESCRIPTION
Install the fonts that are deemed as missing by using the "Install-Font" cmdlet from the custom "Fonts" module.

.EXAMPLE
Install-MissingFont

.NOTES
Mark Birkedal Stjerslev - 2019-08-02
#>
function Install-MissingFont {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    process {
        $missingFonts | ForEach-Object {
            Write-Verbose "Installing missing font `"$_`""
            $fontFilePath = Join-Path -Path $fontFilesPathRoot -ChildPath $requiredFonts[$_]
            Install-Font -Path $fontFilePath -Verbose:$VerbosePreference -WhatIf:$WhatIfPreference
        }
    }
}