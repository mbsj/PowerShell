<#
.Synopsis
   Adds VMWare modules and functions to current PowerShell session an dconnects to VI Server
.DESCRIPTION
   Adds VMWAre core snapin to current PowerShell session and adds VI propertie for VMWare tools. 
   Then connects to the default VI server
#>
function Add-VMWare { 
    [CmdletBinding(DefaultParameterSetName="Normal", 
                  SupportsShouldProcess=$false, 
                  ConfirmImpact='Low')]
    param()

    Add-PSSnapin Vmware.VimAutomation.Core 

    New-VIProperty -Name ToolsVersion -ObjectType VirtualMachine -ValueFromExtensionProperty 'Config.tools.ToolsVersion' | Out-Null
    New-VIProperty -Name ToolsStatus -ObjectType VirtualMachine -ValueFromExtensionProperty 'Guest.ToolsVersionStatus' | Out-Null

    Write-Verbose "Connecting to VCenter Server..."
    Connect-VIServer
}

<#
.Synopsis
   Gets orphaned disks in VMWare
.DESCRIPTION
   Gets a reports of all harddisks in VMWare which are not connected to a virtual machine
.EXAMPLE
   Get-OrphanedDisks

   Creates a disk report file on the desktop named "VMWareOrphanedDisks.csv"
.EXAMPLE
   Get-OrphanedDisks -ReportPath C:\Temp\Report.csv

   Createsd a report at C:\Temp\Report.csv
#>
function Get-OrphanedDisk {
    param (
        #Path for the reports file.
        [Parmaeter(Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]$ReportPath = (Join-Path $env:USERPROFILE "Desktop" | Join-Path -ChildPath "VMWareOrphanedDisks.csv")
    )

    Write-Verbose "Saving report to" $ReportPath

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
 
    Write-Output "Writing report."
    $orphaned | ForEach-Object {
        $store = $_.Substring(1, $_.IndexOf(']') - 1).Trim()
        $file = $_.Substring($_.IndexOf(']') + 2).Trim()
 
        "$store,$file" | Out-File -FilePath $ReportPath -Append
    }
}