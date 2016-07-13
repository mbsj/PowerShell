Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background -Name OEMBackground -Value 1 -Type DWord

if (-not (Test-Path "C:\Windows\System32\oobe\info\backgrounds")) {
    New-Item "C:\Windows\System32\oobe\info\backgrounds" -ItemType Directory -Force
}

if (Test-Path "$env:USERPROFILE\Pictures\LogonScreen.jpg") {
    Copy-Item -Path "$env:USERPROFILE\Pictures\LogonScreen.jpg" -Destination "C:\Windows\System32\oobe\info\backgrounds\backgroundDefault.jpg" -Force
}