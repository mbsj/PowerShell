[CmdletBinding(SupportsShouldProcess = $true)]
param (
)

Write-Verbose "Verifying that fonts are installed..."
$fontFilesPathRoot = Join-Path -Path $env:OneDriveConsumer -ChildPath "Technical\FiraCode_1.207\ttf"

$requiredFonts = @{
    "Fira Code Bold (TrueType)"    = "FiraCode-Bold.ttf";
    "Fira Code Medium (TrueType)"  = "FiraCode-Medium.ttf";
    "Fira Code Retina (TrueType)"  = "FiraCode-Retina.ttf";
    "Fira Code Light (TrueType)"   = "FiraCode-Light.ttf";
    "Fira Code Regular (TrueType)" = "FiraCode-Regular.ttf"
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