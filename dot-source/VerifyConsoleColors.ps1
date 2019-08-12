# Code taken from https://github.com/lukesampson/concfg
# Severely downsized to only achieve one desired color scheme.

$consoleReg = "HKCU:\Console"

$vsCodeDarkColors = [ordered]@{
    "ColorTable00" = 1973790;
    "ColorTable01" = 15111783;
    "ColorTable02" = 5147488;
    "ColorTable03" = 14064726;
    "ColorTable04" = 4671476;
    "ColorTable05" = 9791076;
    "ColorTable06" = 8239831;
    "ColorTable07" = 13948116;
    "ColorTable08" = 8421504;
    "ColorTable09" = 16702620;
    "ColorTable10" = 8106125;
    "ColorTable11" = 11585870;
    "ColorTable12" = 6908369
    "ColorTable13" = 12617413;
    "ColorTable14" = 11197660;
    "ColorTable15" = 15658734;
    "PopupColors"  = 243;
    "ScreenColors" = 7;
}

$missingColors = @{ }

$currentColors = Get-ItemProperty -Path $consoleReg -Name ([array]$vsCodeDarkColors.Keys)

$vsCodeDarkColors.GetEnumerator() | ForEach-Object {
    if ($currentColors.($_.Key) -ne $_.Value) {
        $missingColors += @{$_.Key = $_.Value }
    }
}

if ($missingColors.Count -gt 0) {
    Write-Warning "Console color scheme is not applied or only partially applied. Use function `"Set-ConsoleColor`" to apply the color scheme or `"Get-ConsoleColor`" to view the status or each color setting."
}

<#
.SYNOPSIS
Gets a list of registry key values, detailing the current console colors as well as if they differ from the desired settings of the Visual Studio Code theme "Dark+".

.DESCRIPTION
Returns a list of objects detailing each settings value as well as if it is set correctly.
Properties are:
    Name: The name of the registry key
    Value: The value the registry key
    Correct: Will be true if the value of the key matches the corresponding value in the "Dark+" theme.

.EXAMPLE
Get-ConsoleColor
Returns a list of registry values en wether they are set correctly.

.NOTES
Mark Birkedal Stjerslev - 2019-08-12
#>

function Get-ConsoleColor {
    [CmdletBinding()]
    param (
    )

    process {
        Write-Verbose "Reading console colors from $consoleReg"
        Write-Verbose "Properties read: `r`n`t$($vsCodeDarkColors.Keys -join "`r`n`t")"

        $currentColors = Get-ItemProperty -Path $consoleReg -Name ([array]$vsCodeDarkColors.Keys)

        $vsCodeDarkColors.GetEnumerator() | ForEach-Object {
            $colorSetting = New-Object -TypeName psobject -Property ([ordered]@{
                    Name    = $_.Key;
                    Value   = $_.Value;
                    Correct = $true
                })

            if ($currentColors.($_.Key) -ne $_.Value) {
                $colorSetting.Correct = $false
            }

            $colorSetting
        }
    }
}

<#
.SYNOPSIS
Set the color scheme for the console to VS Code Dark Plus

.DESCRIPTION
Sets the color scheme of the windows console to approximate the colors of the Visual Studio Code theme "Dark+".
Colors used are:
    ColorTable00 = #1e1e1e
    ColorTable01 = #6796e6
    ColorTable02 = #608b4e
    ColorTable03 = #569cd6
    ColorTable04 = #f44747
    ColorTable05 = #646695
    ColorTable06 = #d7ba7d
    ColorTable07 = #d4d4d4
    ColorTable08 = #808080
    ColorTable09 = #9cdcfe
    ColorTable10 = #8db07b
    ColorTable11 = #4ec9b0
    ColorTable12 = #d16969
    ColorTable13 = #c586c0
    ColorTable14 = #dcdcaa
    ColorTable15 = #eeeeee
    PopupColors  = gray,black
    ScreenColors = dark_cyan,white

When the console colors are applied, a new console must be opened in for the colors to take effect.

.EXAMPLE
Set-ConsoleColor
Will set the colors involved in the theme.

.NOTES
Mark Birkedal Stjerslev - 2019-08-12
#>

function Set-ConsoleColor {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
    )

    process {
        $missingColors.GetEnumerator() | ForEach-Object {
            if ($pscmdlet.ShouldProcess("$(Join-Path -Path $consoleReg -ChildPath $_.Key)", "Set value to $($_.Value)")) {
                Set-ItemProperty -Path $consoleReg -Name $_.Key -Value $_.Value
            }
        }
    }
}
