[CmdletBinding()]
param()

Set-StrictMode -Version Latest

$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive\PowerShell\Modules"
$env:PSModulePath += ";C:\Users\$env:USERNAME\OneDrive - KMD\PowerShell_KMD\Modules"

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "C:\Users\$env:USERNAME\AppData\Local\Programs\oh-my-posh\themes\kushal.omp.json" | Invoke-Expression
} else {
    Write-Warning "Oh My Posh is not installed. Use the following command to install it: `r`n`twinget install JanDeDobbeleer.OhMyPosh -s winget"
}