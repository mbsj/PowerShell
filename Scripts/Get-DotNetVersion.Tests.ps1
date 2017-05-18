$scriptFile = Join-Path -Path $PSScriptRoot -ChildPath "Get-DotNetVersion.ps1"

$dotNetXML = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Win32.RegistryKey</T>
      <T>System.MarshalByRefObject</T>
      <T>System.Object</T>
    </TN>
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</ToString>
    <Obj RefId="1">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="2">
          <TN RefId="1">
            <T>Microsoft.Win32.RegistryView</T>
            <T>System.Enum</T>
            <T>System.ValueType</T>
            <T>System.Object</T>
          </TN>
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="3">
          <TN RefId="2">
            <T>Microsoft.Win32.SafeHandles.SafeRegistryHandle</T>
            <T>Microsoft.Win32.SafeHandles.SafeHandleZeroOrMinusOneIsInvalid</T>
            <T>System.Runtime.InteropServices.SafeHandle</T>
            <T>System.Runtime.ConstrainedExecution.CriticalFinalizerObject</T>
            <T>System.Object</T>
          </TN>
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">0</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="4">
          <TN RefId="3">
            <T>System.String[]</T>
            <T>System.Array</T>
            <T>System.Object</T>
          </TN>
          <LST />
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">CDF</S>
        <Obj N="PSDrive" RefId="5">
          <TN RefId="4">
            <T>System.Management.Automation.PSDriveInfo</T>
            <T>System.Object</T>
          </TN>
          <ToString>HKLM</ToString>
          <Props>
            <S N="CurrentLocation"/>
            <S N="Name">HKLM</S>
            <Obj N="Provider" RefId="6">
              <TN RefId="5">
                <T>System.Management.Automation.ProviderInfo</T>
                <T>System.Object</T>
              </TN>
              <ToString>Microsoft.PowerShell.Core\Registry</ToString>
              <Props>
                <S N="ImplementingType">Microsoft.PowerShell.Commands.RegistryProvider</S>
                <S N="HelpFile">System.Management.Automation.dll-Help.xml</S>
                <S N="Name">Registry</S>
                <S N="PSSnapIn">Microsoft.PowerShell.Core</S>
                <S N="ModuleName">Microsoft.PowerShell.Core</S>
                <Nil N="Module" />
                <S N="Description"/>
                <S N="Capabilities">ShouldProcess, Transactions</S>
                <S N="Home"/>
                <Obj N="Drives" RefId="7">
                  <TN RefId="6">
                    <T>System.Collections.ObjectModel.Collection`1[[System.Management.Automation.PSDriveInfo, System.Management.Automation, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
                    <T>System.Object</T>
                  </TN>
                  <LST>
                    <Ref RefId="5" />
                    <S>HKCU</S>
                  </LST>
                </Obj>
              </Props>
            </Obj>
            <S N="Root">HKEY_LOCAL_MACHINE</S>
            <S N="Description">The configuration settings for the local computer</S>
            <Nil N="MaximumSize" />
            <Obj N="Credential" RefId="8">
              <TN RefId="7">
                <T>System.Management.Automation.PSCredential</T>
                <T>System.Object</T>
              </TN>
              <ToString>System.Management.Automation.PSCredential</ToString>
              <Props>
                <Nil N="UserName" />
                <Nil N="Password" />
              </Props>
            </Obj>
            <Nil N="DisplayRoot" />
          </Props>
          <MS>
            <Obj N="Used" RefId="9">
              <TN RefId="8">
                <T>System.Management.Automation.PSCustomObject</T>
                <T>System.Object</T>
              </TN>
            </Obj>
            <Ref N="Free" RefId="9" />
          </MS>
        </Obj>
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="4" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">CDF</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="10">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF\v4.0</ToString>
    <Obj RefId="11">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF\v4.0</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="12">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="13">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">5</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF\v4.0</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="14">
          <TNRef RefId="3" />
          <LST>
            <S>WMIInstalled</S>
            <S>NetTcpPortSharingInstalled</S>
            <S>HttpNamespaceReservationInstalled</S>
            <S>NonHttpActivationInstalled</S>
            <S>SMSvcHostPath</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF\v4.0</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</S>
        <S N="PSChildName">v4.0</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="14" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF\v4.0</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\CDF</S>
      <S N="PSChildName">v4.0</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="15">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</ToString>
    <Obj RefId="16">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</ToString>
      <Props>
        <I32 N="SubKeyCount">23</I32>
        <Obj N="View" RefId="17">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="18">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">6</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="19">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>Version</S>
            <S>Increment</S>
            <S>SP</S>
            <S>CBS</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">v2.0.50727</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="19" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">v2.0.50727</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="20">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1028</ToString>
    <Obj RefId="21">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1028</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="22">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="23">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1028</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="24">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1028</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1028</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="24" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1028</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1028</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="25">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1029</ToString>
    <Obj RefId="26">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1029</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="27">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="28">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1029</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="29">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>OCM</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1029</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1029</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="29" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1029</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1029</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="30">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1030</ToString>
    <Obj RefId="31">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1030</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="32">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="33">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">7</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1030</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="34">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
            <S>Version</S>
            <S>CBS</S>
            <S>Increment</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1030</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1030</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="34" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1030</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1030</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="35">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1031</ToString>
    <Obj RefId="36">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1031</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="37">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="38">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1031</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="39">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>MSI</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1031</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1031</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="39" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1031</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1031</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="40">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1032</ToString>
    <Obj RefId="41">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1032</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="42">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="43">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1032</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="44">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1032</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1032</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="44" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1032</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1032</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="45">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1033</ToString>
    <Obj RefId="46">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1033</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="47">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="48">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">4</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1033</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="49">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Increment</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1033</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1033</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="49" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1033</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1033</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="50">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1035</ToString>
    <Obj RefId="51">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1035</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="52">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="53">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1035</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="54">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>OCM</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1035</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1035</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="54" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1035</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1035</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="55">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1036</ToString>
    <Obj RefId="56">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1036</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="57">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="58">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1036</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="59">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1036</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1036</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="59" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1036</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1036</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="60">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1038</ToString>
    <Obj RefId="61">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1038</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="62">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="63">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1038</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="64">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>MSI</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1038</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1038</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="64" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1038</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1038</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="65">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1040</ToString>
    <Obj RefId="66">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1040</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="67">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="68">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1040</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="69">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1040</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1040</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="69" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1040</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1040</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="70">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1041</ToString>
    <Obj RefId="71">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1041</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="72">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="73">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1041</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="74">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1041</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1041</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="74" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1041</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1041</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="75">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1042</ToString>
    <Obj RefId="76">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1042</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="77">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="78">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1042</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="79">
          <TNRef RefId="3" />
          <LST>
            <S>MSI</S>
            <S>Install</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1042</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1042</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="79" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1042</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1042</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="80">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1043</ToString>
    <Obj RefId="81">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1043</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="82">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="83">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1043</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="84">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>MSI</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1043</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1043</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="84" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1043</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1043</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="85">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1044</ToString>
    <Obj RefId="86">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1044</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="87">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="88">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1044</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="89">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>MSI</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1044</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1044</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="89" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1044</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1044</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="90">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1045</ToString>
    <Obj RefId="91">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1045</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="92">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="93">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1045</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="94">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1045</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1045</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="94" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1045</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1045</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="95">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1046</ToString>
    <Obj RefId="96">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1046</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="97">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="98">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1046</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="99">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1046</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1046</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="99" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1046</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1046</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="100">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1049</ToString>
    <Obj RefId="101">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1049</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="102">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="103">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1049</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="104">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>MSI</S>
            <S>OCM</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1049</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1049</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="104" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1049</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1049</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="105">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1053</ToString>
    <Obj RefId="106">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1053</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="107">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="108">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1053</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="109">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1053</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1053</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="109" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1053</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1053</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="110">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1055</ToString>
    <Obj RefId="111">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1055</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="112">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="113">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1055</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="114">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>MSI</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1055</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">1055</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="114" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\1055</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">1055</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="115">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2052</ToString>
    <Obj RefId="116">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2052</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="117">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="118">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2052</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="119">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2052</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">2052</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="119" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2052</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">2052</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="120">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2070</ToString>
    <Obj RefId="121">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2070</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="122">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="123">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2070</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="124">
          <TNRef RefId="3" />
          <LST>
            <S>Install</S>
            <S>OCM</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2070</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">2070</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="124" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\2070</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">2070</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="125">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3076</ToString>
    <Obj RefId="126">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3076</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="127">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="128">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3076</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="129">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>MSI</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3076</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">3076</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="129" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3076</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">3076</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="130">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3082</ToString>
    <Obj RefId="131">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3082</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="132">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="133">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">3</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3082</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="134">
          <TNRef RefId="3" />
          <LST>
            <S>OCM</S>
            <S>Install</S>
            <S>MSI</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3082</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
        <S N="PSChildName">3082</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="134" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727\3082</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727</S>
      <S N="PSChildName">3082</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="135">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</ToString>
    <Obj RefId="136">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</ToString>
      <Props>
        <I32 N="SubKeyCount">2</I32>
        <Obj N="View" RefId="137">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="138">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">5</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="139">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Increment</S>
            <S>Install</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">v3.0</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="139" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">v3.0</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="140">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</ToString>
    <Obj RefId="141">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="142">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="143">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">0</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="144">
          <TNRef RefId="3" />
          <LST />
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
        <S N="PSChildName">Servicing</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="144" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
      <S N="PSChildName">Servicing</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="145">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing\Windows Workflow Foundation</ToString>
    <Obj RefId="146">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing\Windows Workflow Foundation</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="147">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="148">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">6</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing\Windows Workflow Foundation</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="149">
          <TNRef RefId="3" />
          <LST>
            <S>SPIndex</S>
            <S>CBS</S>
            <S>Install</S>
            <S>SP</S>
            <S>SPName</S>
            <S>Hotfix</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing\Windows Workflow Foundation</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</S>
        <S N="PSChildName">Windows Workflow Foundation</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="149" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing\Windows Workflow Foundation</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Servicing</S>
      <S N="PSChildName">Windows Workflow Foundation</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="150">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</ToString>
    <Obj RefId="151">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</ToString>
      <Props>
        <I32 N="SubKeyCount">5</I32>
        <Obj N="View" RefId="152">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="153">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">2</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="154">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>InstallSuccess</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
        <S N="PSChildName">Setup</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="154" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0</S>
      <S N="PSChildName">Setup</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="155">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1030</ToString>
    <Obj RefId="156">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1030</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="157">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="158">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">6</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1030</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="159">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Increment</S>
            <S>InstallSuccess</S>
            <S>Install</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1030</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSChildName">1030</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="159" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1030</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSChildName">1030</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="160">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1033</ToString>
    <Obj RefId="161">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1033</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="162">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="163">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">6</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1033</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="164">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Increment</S>
            <S>InstallSuccess</S>
            <S>Install</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1033</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSChildName">1033</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="164" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\1033</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSChildName">1033</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="165">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</ToString>
    <Obj RefId="166">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="167">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="168">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">4</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="169">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>RuntimeInstallPath</S>
            <S>InstallSuccess</S>
            <S>ReferenceInstallPath</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSChildName">Windows Communication Foundation</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="169" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSChildName">Windows Communication Foundation</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="170">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation\1030</ToString>
    <Obj RefId="171">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation\1030</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="172">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="173">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">1</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation\1030</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="174">
          <TNRef RefId="3" />
          <LST>
            <S>InstallSuccess</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation\1030</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</S>
        <S N="PSChildName">1030</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="174" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation\1030</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Communication Foundation</S>
      <S N="PSChildName">1030</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="175">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Presentation Foundation</ToString>
    <Obj RefId="176">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Presentation Foundation</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="177">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="178">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">8</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Presentation Foundation</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="179">
          <TNRef RefId="3" />
          <LST>
            <S>(default)</S>
            <S>Version</S>
            <S>WPFCommonAssembliesPathx64</S>
            <S>InstallRoot</S>
            <S>InstallSuccess</S>
            <S>WPFReferenceAssembliesPathx64</S>
            <S>ProductVersion</S>
            <S>WPFNonReferenceAssembliesPathx64</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Presentation Foundation</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSChildName">Windows Presentation Foundation</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="179" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Presentation Foundation</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSChildName">Windows Presentation Foundation</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="180">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</ToString>
    <Obj RefId="181">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="182">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="183">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">6</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="184">
          <TNRef RefId="3" />
          <LST>
            <S>(default)</S>
            <S>InstallDir</S>
            <S>MajorBuildNum</S>
            <S>FileVersion</S>
            <S>InstallSuccess</S>
            <S>ProductVersion</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
        <S N="PSChildName">Windows Workflow Foundation</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="184" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup</S>
      <S N="PSChildName">Windows Workflow Foundation</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="185">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation\Debugger</ToString>
    <Obj RefId="186">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation\Debugger</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="187">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="188">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">2</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation\Debugger</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="189">
          <TNRef RefId="3" />
          <LST>
            <S>ControllerConduitTypeName</S>
            <S>ExpressionEvaluationFrameTypeName</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation\Debugger</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</S>
        <S N="PSChildName">Debugger</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="189" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation\Debugger</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0\Setup\Windows Workflow Foundation</S>
      <S N="PSChildName">Debugger</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="190">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</ToString>
    <Obj RefId="191">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</ToString>
      <Props>
        <I32 N="SubKeyCount">2</I32>
        <Obj N="View" RefId="192">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="193">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">5</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="194">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Install</S>
            <S>InstallPath</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">v3.5</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="194" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">v3.5</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="195">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1030</ToString>
    <Obj RefId="196">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1030</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="197">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="198">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">4</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1030</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="199">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Install</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1030</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
        <S N="PSChildName">1030</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="199" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1030</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
      <S N="PSChildName">1030</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="200">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033</ToString>
    <Obj RefId="201">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="202">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="203">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">4</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="204">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>CBS</S>
            <S>Install</S>
            <S>SP</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
        <S N="PSChildName">1033</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="204" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5</S>
      <S N="PSChildName">1033</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="205">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</ToString>
    <Obj RefId="206">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</ToString>
      <Props>
        <I32 N="SubKeyCount">2</I32>
        <Obj N="View" RefId="207">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="208">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">0</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="209">
          <TNRef RefId="3" />
          <LST />
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">v4</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="209" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">v4</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="210">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</ToString>
    <Obj RefId="211">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="212">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="213">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">7</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="214">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>TargetVersion</S>
            <S>Install</S>
            <S>MSI</S>
            <S>Servicing</S>
            <S>Release</S>
            <S>InstallPath</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
        <S N="PSChildName">Client</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="214" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
      <S N="PSChildName">Client</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="215">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client\1033</ToString>
    <Obj RefId="216">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client\1033</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="217">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="218">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">5</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client\1033</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="219">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>TargetVersion</S>
            <S>Install</S>
            <S>Servicing</S>
            <S>Release</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client\1033</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</S>
        <S N="PSChildName">1033</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="219" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client\1033</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client</S>
      <S N="PSChildName">1033</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="220">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</ToString>
    <Obj RefId="221">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="222">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="223">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">7</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="224">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>TargetVersion</S>
            <S>Install</S>
            <S>MSI</S>
            <S>Servicing</S>
            <S>InstallPath</S>
            <S>Release</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
        <S N="PSChildName">Full</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="224" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4</S>
      <S N="PSChildName">Full</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="225">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\1033</ToString>
    <Obj RefId="226">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\1033</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="227">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="228">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">5</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\1033</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="229">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>TargetVersion</S>
            <S>Install</S>
            <S>Servicing</S>
            <S>Release</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\1033</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</S>
        <S N="PSChildName">1033</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="229" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\1033</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full</S>
      <S N="PSChildName">1033</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="230">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</ToString>
    <Obj RefId="231">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</ToString>
      <Props>
        <I32 N="SubKeyCount">1</I32>
        <Obj N="View" RefId="232">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="233">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">1</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="234">
          <TNRef RefId="3" />
          <LST>
            <S>(default)</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
        <S N="PSChildName">v4.0</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="234" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP</S>
      <S N="PSChildName">v4.0</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
  <Obj RefId="235">
    <TNRef RefId="0" />
    <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0\Client</ToString>
    <Obj RefId="236">
      <TNRef RefId="0" />
      <ToString>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0\Client</ToString>
      <Props>
        <I32 N="SubKeyCount">0</I32>
        <Obj N="View" RefId="237">
          <TNRef RefId="1" />
          <ToString>Default</ToString>
          <I32>0</I32>
        </Obj>
        <Obj N="Handle" RefId="238">
          <TNRef RefId="2" />
          <ToString>Microsoft.Win32.SafeHandles.SafeRegistryHandle</ToString>
          <Props>
            <B N="IsInvalid">false</B>
            <B N="IsClosed">false</B>
          </Props>
        </Obj>
        <I32 N="ValueCount">2</I32>
        <S N="Name">HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0\Client</S>
      </Props>
      <MS>
        <Obj N="Property" RefId="239">
          <TNRef RefId="3" />
          <LST>
            <S>Version</S>
            <S>Install</S>
          </LST>
        </Obj>
        <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0\Client</S>
        <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</S>
        <S N="PSChildName">Client</S>
        <Ref N="PSDrive" RefId="5" />
        <Ref N="PSProvider" RefId="6" />
        <B N="PSIsContainer">true</B>
      </MS>
    </Obj>
    <MS>
      <Ref N="Property" RefId="239" />
      <S N="PSPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0\Client</S>
      <S N="PSParentPath">Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0</S>
      <S N="PSChildName">Client</S>
      <Ref N="PSDrive" RefId="5" />
      <Ref N="PSProvider" RefId="6" />
      <B N="PSIsContainer">true</B>
    </MS>
  </Obj>
</Objs>
"@

Describe "Get-DotNetVersion" {
    $dotNetXml | Out-File -FilePath TestDrive:\DotNetInfo.xml

    Mock Get-ChildItem {
        Import-Clixml -Path TestDrive:\DotNetInfo.xml
    }

    Mock Test-Connection {
        $true
    }

    Context "Local" {
        It "Should run without error" {
            { & $scriptFile } | Should Not Throw
        }

        It "Calls Get-ChildItem on registry once" {
            Assert-MockCalled Get-ChildItem -Exactly 1 
        }

        $info = & $scriptFile

        $propertyNames = @(
            "Name",
            "Version",
            "Release"
        )
        $propertyNames | ForEach-Object {
            It "Should contain property $_" {
                foreach ($i in $info) {
                    $i | Get-Member -MemberType NoteProperty | Where-Object Name -eq "$_" | Select-Object -ExpandProperty Name | Should Be $_
                }
            }
        }

        It "Property `"Name`" should never be empty" {
            $info | ForEach-Object {
                $_.Name | Should Not BeNullOrEmpty
            }
        }

        It "Property `"Version`" should never be empty" {
            $info | ForEach-Object {
                $_.Version | Should Not BeNullOrEmpty
            }
        }
    }

    Context "Remote" {
        Mock Invoke-Command {
        }

        $credential = New-Object pscredential ("username", ("password" | ConvertTo-SecureString -AsPlainText -Force))

        It "Should run without error with implicit credentials" {
            { & $scriptFile -ComputerName "server1" } | Should Not Throw
        }

        It "Calls Invoke-Comand on remote server" {
            Assert-MockCalled Invoke-Command -Exactly 1 -ParameterFilter {
                $ComputerName -and $ComputerName -eq "server1"
            }
        }

        It "Should run without error with explicit credentials" {
            { & $scriptFile -ComputerName "server1" -Credential $credential } | Should Not Throw
        }

        It "Calls Invoke-Comand on remote server with credentials" {
            Assert-MockCalled Invoke-Command -Exactly 2 -ParameterFilter {
                $ComputerName -and $ComputerName -eq "server1" -and 
                $Credential -and $null -ne $Credential
            }
        }

        It "Should run without error with custom port" {
            { & $scriptFile -ComputerName "server1" -Port 80 } | Should Not Throw
        }

        It "Calls Invoke-Comand on remote server on custom port" {
            Assert-MockCalled Invoke-Command -Exactly 1 -ParameterFilter {
                $ComputerName -and $ComputerName -eq "server1" -and 
                $Port -and $Port -eq 80
            }
        }

        It "Should run without error with explicit credentials and custom port" {
            { & $scriptFile -ComputerName "server1" -Credential $credential -Port 80 } | Should Not Throw
        }

        It "Calls Invoke-Comand on remote server with credentials and custom port" {
            Assert-MockCalled Invoke-Command -Exactly 2 -ParameterFilter {
                $ComputerName -and $ComputerName -eq "server1" -and 
                $Credential -and $null -ne $Credential -and 
                $Port -and $Port -eq 80
            }
        }
    }
}