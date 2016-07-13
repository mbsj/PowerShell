function Add-Exchange2010 {
    Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

    $global:exbin = (get-itemproperty HKLM:\SOFTWARE\Microsoft\ExchangeServer\v14\Setup).MsiInstallPath + "bin\"
    $global:exinstall = (get-itemproperty HKLM:\SOFTWARE\Microsoft\ExchangeServer\v14\Setup).MsiInstallPath
    $global:exscripts = (get-itemproperty HKLM:\SOFTWARE\Microsoft\ExchangeServer\v14\Setup).MsiInstallPath + "scripts\"

    . $global:exbin"CommonConnectFunctions.ps1"
    . $global:exbin"ConnectFunctions.ps1"

    Connect-ExchangeServer -UserName "domain\administrator" -ServerFqdn "sesbex01.domain.local"
}