Get-ChildItem "$($env:USERPROFILE)\OneDrive\PowerShell\dot-source\" -Include *.ps1 -Force -Recurse | ForEach-Object {
    . $_.FullName
}