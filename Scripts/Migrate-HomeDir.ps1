$oneDriveRegPath = "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Internet"
$oneDriveName = "OneDrive for Business"
$oneDrivePath = "$env:ProgramFiles\Microsoft Office 15\root\office15\groove.exe"
$oneDrivePDF = "\\domain.local\Arden\Faelles\OneDrive\OneDrive for Business.pdf"

Add-Type -AssemblyName System.Windows.Forms

function Get-OneDrivePath {
    try {
        $paths = (Get-ItemProperty -Path $oneDriveRegPath -ErrorAction Stop).LocalSyncClientDiskLocation
        $paths -split '[\r\n]' | ForEach-Object {
            if ($_ -match $oneDriveName) {
                return $_
            }
        }
    } catch {
        return $null
    }
}

function Test-OneDriveRunning {
    try {
        Get-Process -Name GROOVE -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

if ($HOME -notmatch '^[(H:)(P:)]') {
    if (!(Get-OneDrivePath)) {
        $result = [System.Windows.Forms.MessageBox]::Show("You have no networked home directory hence nothing to migrate. Do you want to start and configure OneDrive for Business anyway?", "No Home Directory", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            Start-Process -FilePath $oneDrivePath
        }
    } else {
        $result = [System.Windows.Forms.MessageBox]::Show("You have no networked home directory hence nothing to migrate. OneDrive for Business is already configured on your PC and you are ready to go.", "No Home Directory", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }

    exit
} elseif (!(Test-Path $HOME\*)) {
    if (!(Get-OneDrivePath)) {
        $result = [System.Windows.Forms.MessageBox]::Show("Your home directory is empty so there is nothing to migrate. Do you want to start and configure OneDrive for Business anyway?", "Home Directory Empty", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            Start-Process -FilePath $oneDrivePath
        }
    } else {
        $result = [System.Windows.Forms.MessageBox]::Show("Your home directory is empty so there is nothing to migrate. OneDrive for Business is already configured on your PC and you are ready to go.", "Home Directory Empty", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }

    exit
}

if (!(Test-Path $oneDrivePath)) {
    $result = [System.Windows.Forms.MessageBox]::Show("OneDrive for Business could not be found on your computer. Please contact helpdesk@qubiqa.com for assistance.", "OneDrive Not Found", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    exit
} elseif (!(Get-OneDrivePath)) {
    $result = [System.Windows.Forms.MessageBox]::Show("OneDrive for Business has not been configured yet. A PDF guide for setting up OneDrive for Business will now open along with a web page where you start the configuration. Please complete the configuration to setup OneDrive for Business.", "OneDrive Not Configured", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        Start-Process -FilePath "$env:ProgramFiles\Internet Explorer\iexplore.exe" -ArgumentList ("https://qubiqa-my.sharepoint.com/personal/" + $env:USERNAME + "_qubiqa_com/Documents")
        Start-Process -FilePath $oneDrivePDF

        $count = 0
        while (!(Get-OneDrivePath)) {
            Start-Sleep 5
            $count++

            if ($count -ge 60) {
                $result = [System.Windows.Forms.MessageBox]::Show("Could not get the path for the new OneDrive for Business folder. If you have not completed the configuration, please do so and re-run this program. If you keep getting this error please contact helpdesk@qubiqa.com for assistance.", "Configuration Failed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                exit
            }
        }
    } else {
        $result = [System.Windows.Forms.MessageBox]::Show("Configuration of OneDrive has been canceled so your home directory can not be migrated. Please re-run this program to finish the process. If you have any questions of issues please contact helpdesk@qubiqa.com for assistance.", "Configuration Canceled", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        exit
    }
}

$result = [System.Windows.Forms.MessageBox]::Show("You are ready to migrate your home directory ($HOME) to OneDrive for Business (" + (Get-OneDrivePath) + "). Please refrain from adding, changing or deleting files in your home directory until this process is complete.", "Ready To Migrate", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Information)
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $sourceDir = $HOME
    $destDir = (Get-OneDrivePath) + "\"

    $count = 0
    $files = Get-ChildItem -Path $sourceDir -Force -Recurse
    foreach ($file in $files) {
        Write-Progress -Activity "Copying files from $sourceDir to $destDir" -Status ("Copying " + $file.Name) -PercentComplete ($count / $files.Count * 100)

        $dest = $file.FullName.Replace($sourceDir, $destDir)
        Copy-Item -Path $file.FullName -Destination $dest -Force -ErrorAction SilentlyContinue
        $count++
    }

    Set-Content -Path \\domain.local\arden\Faelles\OneDrive\$env:USERNAME -Value ($null)

    $result = [System.Windows.Forms.MessageBox]::Show("Your home directory is now migrated to One Drive. ", "Migration Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
} else {
    $result = [System.Windows.Forms.MessageBox]::Show("Migration has been canceled. Please re-run this program to start the migration.", "Migration Canceled", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}