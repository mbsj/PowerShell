Get-ChildItem "C:\Users\$env:USERNAME\OneDrive\PowerShell\dot-source\" -Include *.ps1 -Force -Recurse | ForEach-Object {
    . $_.FullName
}