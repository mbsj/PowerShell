param(
    [string]$SourceDir = $env:BUILD_SOURCESDIRECTORY,
    [string]$TempDir = $env:TEMP
)

$ErrorActionPreference = "Stop"
 
$modulePath = Join-Path $TempDir Pester-master\Pester.psm1
 
if (-not(Test-Path $modulePath)) {
    # Note: PSGet and chocolatey are not supported in hosted vsts build agent  
    $tempFile = Join-Path $TempDir pester.zip
    Invoke-WebRequest https://github.com/pester/Pester/archive/master.zip -OutFile $tempFile
 
    [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tempFile, $tempDir)
 
    Remove-Item $tempFile
}
 
Import-Module $modulePath -DisableNameChecking

Get-ChildItem $SourceDir -Include "*.Tests.ps1" -Recurse | ForEach-Object {
    $outputFile = Join-Path $SourceDir "TEST-pester_$($_.Name -replace "\.Tests",'').xml"
    $coverageFile = $_.FullName -replace ".Tests", ''

    $params = @{
        Script = $_.FullName
        PassThru = $true
        OutputFile = $outputFile
        OutputFormat = "NUnitXml"
        EnableExit = $true
    }

    if (Test-Path $coverageFile) {
        $params.Add("CodeCoverage", $coverageFile)
    } elseif (Test-Path ($coverageFile -replace "ps1", "psm1")) {
        $coverageFile = $coverageFile -replace "ps1", "psm1"
        $params.Add("CodeCoverage", $coverageFile)
    } 

    Invoke-Pester @params
}