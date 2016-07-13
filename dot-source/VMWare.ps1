function Get-VICommand { 
    Get-Command -pssnapin VMware.VimAutomation.Core 
}

function Connect-VIVCenter { 
    Connect-VIServer -Credential (Get-Credential)
}

New-Alias -Name Disconnect-VI -Value Disconnect-VIServer

function Add-VMWare { 
    Add-PSSnapin Vmware.VimAutomation.Core 
    #. "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"

    New-VIProperty -Name ToolsVersion -ObjectType VirtualMachine -ValueFromExtensionProperty 'Config.tools.ToolsVersion' | Out-Null
    New-VIProperty -Name ToolsStatus -ObjectType VirtualMachine -ValueFromExtensionProperty 'Guest.ToolsVersionStatus' | Out-Null

    Write-Host "Connecting to VCenter Server..."
    Connect-VIVCenter
}

function Get-OrphanedDisks {
    param (
        [string]$ReportPath
    )

    if ([string]::IsNullOrWhiteSpace($ReportPath)) {
        $ReportPath = Join-Path $env:USERPROFILE "Desktop" | Join-Path -ChildPath "VMWareOrphanedDisks.csv"
    }

    Write-Host -ForegroundColor Green "Saving report to" $ReportPath

    if (Test-Path $ReportPath){
        throw "Report file already exists."
        return
    }

    New-Item -Path $ReportPath -ItemType File | Out-Null

    $vmhdds = @()
    $dshdds = @()
    $orphaned = @()
    
    $vms = Get-VM
    $i = 0
    $vms | ForEach-Object {
        $i++
        Write-Progress -Activity "Getting virtual machine disks" -Status ("Getting disks from " + $_.Name) -PercentComplete(($i / $vms.Count) * 100)
        $_ | Get-HardDisk | ForEach-Object {
            $vmhdds += $_.Filename
        }
    }

    $dss = Get-Datastore
    $i = 0
    $dss | ForEach-Object {
        $i++ 
        Write-Progress -Activity "Getting datastore disks" -Status ("Getting disks from " + $_.Name) -PercentComplete(($i / $dss.Count) * 100)
        $_ | Get-HardDisk | ForEach-Object {
            $dshdds += $_.Filename
        }
    }

    $i = 0
    $dshdds | ForEach-Object {
        $i++
        Write-Progress -Activity "Comparing datastore disks with virtual machine disks" -Status ("Comparing" + $_) -PercentComplete(($i / $dshdds.Count) * 100)
        if ($vmhdds -notcontains $_) {
            $orphaned += $_
        }
    }
 
    Write-Host -ForegroundColor Yellow "Writing report."
    $orphaned | ForEach-Object {
        $store = $_.Substring(1, $_.IndexOf(']') - 1).Trim()
        $file = $_.Substring($_.IndexOf(']') + 2).Trim()
 
        "$store,$file" | Out-File -FilePath $ReportPath -Append
    }
}