$requiredFonts = @(
    "Fira Code Bold (TrueType)",
    "Fira Code Medium (TrueType)",
    "Fira Code Retina (TrueType)",
    "Fira Code Light (TrueType)",
    "Fira Code Regular (TrueType)"
)

$installedFonts = Get-Font

$requiredFonts | ForEach-Object {
    if ($installedFonts.Keys -notcontains $_) {
        Write-Warning "Font $_ missing. Download and install from https://github.com/tonsky/FiraCode"
    }
}