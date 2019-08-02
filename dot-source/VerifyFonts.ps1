$fontFilesPathRoot = Join-Path -Path $env:OneDriveConsumer -ChildPath "Technical\FiraCode_1.207\ttf"

$requiredFonts = @{
    "Fira Code Bold (TrueType)" = "FiraCode-Bold.ttf";
    "Fira Code Medium (TrueType)" = "FiraCode-Medium.ttf";
    "Fira Code Retina (TrueType)" = "FiraCode-Retina.ttf";
    "Fira Code Light (TrueType)" = "FiraCode-Light.ttf";
    "Fira Code Regular (TrueType)" = "FiraCode-Regular.ttf"
}

$installedFonts = Get-Font

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