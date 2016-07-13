Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

$site = "https://qubiqa.sharepoint.com/teams/IT/arden"
$user = "smtp@qubiqa.com"
$pass = ConvertTo-SecureString -String "YYkyD9LgYTiVYPdZ" -AsPlainText -Force
$listName = "Documents"
$folderPath = "DHCP Backup"
$files = @("C:\Windows\System32\dhcp\backup\DhcpCfg", 
           "C:\Windows\System32\dhcp\backup\new\dhcp.mdb", 
           "C:\Windows\System32\dhcp\backup\new\dhcp.pat")

$context = New-Object Microsoft.SharePoint.Client.ClientContext($site)
$context.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($user, $pass)

$list = $context.Web.Lists.GetByTitle($listName)
$context.Load($list)
$context.ExecuteQuery()

$files | ForEach-Object {
    $file = $_
    $fileStream = New-Object IO.FileStream($file,[System.IO.FileMode]::Open)

    $fileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation
    $fileCreationInfo.Overwrite = $true
    $fileCreationInfo.ContentStream = $fileStream
    $fileCreationInfo.URL = Join-Path $folderPath $file.Split("\")[$file.Split("\").Count - 1]

    $upload = $list.RootFolder.Files.Add($fileCreationInfo)
    
    $context.Load($upload)
    $context.ExecuteQuery()

    $fileStream.Close()
}