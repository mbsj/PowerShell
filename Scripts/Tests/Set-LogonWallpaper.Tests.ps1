Describe "Set-LogonWallpaper" {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Set-LogonWallpaper.ps1"
    $imagePath = "TestDrive:\wallpaper.png"

    Mock Set-ItemProperty {}
    Mock Remove-Item {}
    Mock New-Item {}
    Mock Copy-Item {}

    Set-Content -Value "" -Path $imagePath

    It "Should run without error" {
        $scriptRun = { & $scriptFile -ImagePath $imagePath -Force }

        $scriptRun | Should Not Throw
    }

    It "Sets OEMBackground registry key" {
        Assert-MockCalled -CommandName Set-ItemProperty -Times 1
    }

    It "Removes OEMBackground folder due to -Force" {
        Assert-MockCalled -CommandName Remove-Item -Times 1
    }

    It "Creates new OEMBackground folder" {
        Assert-MockCalled -CommandName New-Item -Times 1
    }

    it "Copies image file to OEMBackground folder" {
        Assert-MockCalled -CommandName Copy-Item -Times 1 -ParameterFilter {
            $Path -eq $imagePath
        }
    }
}