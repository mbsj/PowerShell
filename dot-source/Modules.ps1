$modules = @(
    "PowerShellCookbook",
    "xPSDesiredStateConfiguration",
    "xDSCResourceDesigner"
)

$modules | ForEach-Object {
    if (-not (Get-Module -ListAvailable $_)) {
        Write-Warning "Module $_ not installed."
    }
}   