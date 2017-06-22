Describe "Get-DiskSize" {
    $scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Get-DiskSize.ps1"

    $diskSizeXml = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Selected.Microsoft.Management.Infrastructure.CimInstance</T>
      <T>System.Management.Automation.PSCustomObject</T>
      <T>System.Object</T>
    </TN>
    <MS>
      <S N="SystemName">SERVER01</S>
      <S N="DriveLetter">C:</S>
      <S N="Label">OSDisk</S>
      <Db N="Capacity">69.998043060302734</Db>
      <Db N="FreePercent">35.645473269205752</Db>
      <Db N="FreeSpace">24.951133728027344</Db>
    </MS>
  </Obj>
  <Obj RefId="1">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER01</S>
      <S N="DriveLetter">D:</S>
      <S N="Label">Data</S>
      <Db N="Capacity">149.99706649780273</Db>
      <Db N="FreePercent">36.453502216166285</Db>
      <Db N="FreeSpace">54.679183959960938</Db>
    </MS>
  </Obj>
  <Obj RefId="2">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER02</S>
      <S N="DriveLetter">C:</S>
      <S N="Label">OSDisk</S>
      <Db N="Capacity">129.99706649780273</Db>
      <Db N="FreePercent">84.521167367134254</Db>
      <Db N="FreeSpace">109.87503814697266</Db>
    </MS>
  </Obj>
  <Obj RefId="3">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER02</S>
      <S N="DriveLetter">D:</S>
      <S N="Label">Data</S>
      <Db N="Capacity">29.997066497802734</Db>
      <Db N="FreePercent">63.337339581062047</Db>
      <Db N="FreeSpace">18.999343872070312</Db>
    </MS>
  </Obj>
  <Obj RefId="4">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER02</S>
      <S N="DriveLetter">S:</S>
      <S N="Label">SOLR</S>
      <Db N="Capacity">199.87206649780273</Db>
      <Db N="FreePercent">68.210673930580327</Db>
      <Db N="FreeSpace">136.33408355712891</Db>
    </MS>
  </Obj>
  <Obj RefId="5">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER03</S>
      <S N="DriveLetter">C:</S>
      <S N="Label">OSDisk</S>
      <Db N="Capacity">69.998043060302734</Db>
      <Db N="FreePercent">0.6325053882742846</Db>
      <Db N="FreeSpace">0.44274139404296875</Db>
    </MS>
  </Obj>
  <Obj RefId="6">
    <TNRef RefId="0" />
    <MS>
      <S N="SystemName">SERVER03</S>
      <S N="DriveLetter">D:</S>
      <Nil N="Label" />
      <Db N="Capacity">99.997066497802734</Db>
      <Db N="FreePercent">41.22050089131109</Db>
      <Db N="FreeSpace">41.219291687011719</Db>
    </MS>
  </Obj>
</Objs>
"@

    $diskSizeXml | Out-File -FilePath TestDrive:\DiskSize.xml

    Mock Get-CimInstance {
        Import-Clixml -Path TestDrive:\DiskSize.xml | Where-Object {
            $ComputerName -contains $_.SystemName
        }
    }

    It "Should run without error" {
        { & $scriptFile -ComputerName "SERVER01" } | Should Not Throw
    }

    It "Calls Get-CimInstance once" {
        Assert-MockCalled Get-CimInstance -Exactly 1 
    }

    It "Should return one result set per computer name supplied" {
        $diskinfo = & $scriptFile -ComputerName "SERVER01"
        $diskinfo | Where-Object SystemName -ne "SERVER01" | Should BeNullOrEmpty

        $diskinfo = & $scriptFile -ComputerName "SERVER01", "SERVER02", "SERVER03"
        $diskinfo | Select-Object -ExpandProperty SystemName -Unique | Measure-Object | Select-Object -ExpandProperty Count | Should Be 3
    }

    $expectedProperties = @(
        "SystemName",
        "DriveLetter",
        "Label",
        "Capacity",
        "FreePercent",
        "FreeSpace"
    )

    $diskinfo = & $scriptFile -ComputerName "SERVER01"

    $expectedProperties | ForEach-Object {
        It "Result should contain property $_" {
            $diskinfo | Get-Member -Name $_ | Should Not BeNullOrEmpty
        }
    }
}