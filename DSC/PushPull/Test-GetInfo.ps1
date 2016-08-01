Get-DscConfigurationStatus -CimSession "MARK-VM" -All

# Install-Module PowerShellCookbook
Show-Object -InputObject (Get-DscConfigurationStatus -CimSession "MARK-VM")

# Install-Module xDscDiagnostics
Get-xDscOperation -ComputerName "MARK-VM"