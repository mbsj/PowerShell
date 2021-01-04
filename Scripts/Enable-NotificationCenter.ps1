<#
.SYNOPSIS
Enable the Windows 10 Action Center in the registry.

.DESCRIPTION
Meant to run silently and check if:
    1. The path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" exists.
    2. The item property "DisableNotificationCenter" exists.
    3. The value of the item property is anything other than 0.
If all are true, the item property is set to 0 in order to enable the Action Center.

.EXAMPLE
.\Enable-NotificationCenter.ps1
Sets the value of DisableNotificationCenter to 0 if it isn't already.

.EXAMPLE
.\Enable-NotificationCenter.ps1 -RestartExplorer
Sets the value of DisableNotificationCenter to 0 if it isn't already. If the value was changed, the explorer process is also restarted.

.NOTES
Requires permissions to edit the items under the registry path either directly or with general administrative access.
#>

[CmdletBinding()]
param (
    # Restart the Windows Explorer process to allow the changed registry value to take effect. Only happens if the value is actually changed.
    [Switch] $RestartExplorer,

    # Force an update of the registry value. If executed with -RestartExplorer, will force a restart.
    [Switch] $Force
)

begin {
    $regItem = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
    $regProperty = "DisableNotificationCenter"
}

process {
    if (Test-Path -Path $regItem) {
        Write-Verbose "Registry path `"$regItem`" found."

        try {
            $ncVal = Get-ItemPropertyValue -Path $regItem -Name $regProperty -ErrorAction Stop
            Write-Verbose "The value of registry property `"$regProperty`" is $ncVal."

            if ($ncVal -ne 0 -or $Force) {
                Set-ItemProperty -Path $regItem -Name $regProperty -Value 0 -Verbose:$VerbosePreference

                if ($RestartExplorer) {
                    Write-Verbose "Restarting Windows Explorer process."
                    Stop-Process -ProcessName "explorer" -Verbose:$VerbosePreference -Force
                }
            }
        }
        catch {
            Write-Verbose "Registry property `"$regProperty`" not found at path `"$regItem`"."
        }
    }
    else {
        Write-Verbose "Registry path `"$regItem`" not found."
    }
}