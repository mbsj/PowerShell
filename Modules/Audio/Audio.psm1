#requires -Version 2

Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;

[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume {
  // f(), g(), ... are unused COM method slots. Define these if you care
  int f(); int g(); int h(); int i();
  int SetMasterVolumeLevelScalar(float fLevel, System.Guid pguidEventContext);
  int j();
  int GetMasterVolumeLevelScalar(out float pfLevel);
  int k(); int l(); int m(); int n();
  int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, System.Guid pguidEventContext);
  int GetMute(out bool pbMute);
}

[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice {
  int Activate(ref System.Guid id, int clsCtx, int activationParams, out IAudioEndpointVolume aev);
}

[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator {
  int f(); // Unused
  int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
}

[ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject { }
public class Audio {
  static IAudioEndpointVolume Vol() {
    var enumerator = new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;
    IMMDevice dev = null;
    Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(/*eRender*/ 0, /*eMultimedia*/ 1, out dev));
    IAudioEndpointVolume epv = null;
    var epvid = typeof(IAudioEndpointVolume).GUID;
    Marshal.ThrowExceptionForHR(dev.Activate(ref epvid, /*CLSCTX_ALL*/ 23, 0, out epv));
    return epv;
  }

  public static float Volume {
    get {float v = -1; Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v)); return v;}
    set {Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value, System.Guid.Empty));}
  }

  public static bool Mute {
    get { bool mute; Marshal.ThrowExceptionForHR(Vol().GetMute(out mute)); return mute; }
    set { Marshal.ThrowExceptionForHR(Vol().SetMute(value, System.Guid.Empty)); }
  }
}
'@

<#
.SYNOPSIS
    Gets the current volume level
.DESCRIPTION
    Gets the current system volume level.
    Returns values from 0 to 100, representing the percent level to set.
.EXAMPLE
    Get-AudioVolume
    Gets the current volume level
.INPUTS
    None
.OUTPUTS
    Integer with the volume level
.NOTES
    Uses C# and InteropServices to interact with the system audio.
    Code taken from Ole Morten Didriksen's GitHub gists: https://gist.github.com/oledid/89a85a283b4b59947865
#>
function Get-AudioVolume {
    [CmdletBinding(ConfirmImpact = 'Low')]
    [OutputType([Int])]
    Param ()

    process {
        [System.Math]::Round([Audio]::Volume * 100)
    }
}

<#
.SYNOPSIS
    Set volume level
.DESCRIPTION
    Sets the volume to the desired level.
    Takes values from 0 to 100, representing the percent level to set.
.EXAMPLE
    Set-AudioVolume -Level 50
    Sets the volume to 50%
.INPUTS
    Integer with volume level percent
.OUTPUTS
    None
.NOTES
    Uses C# and InteropServices to interact with the system audio.
    Code taken from Ole Morten Didriksen's GitHub gists: https://gist.github.com/oledid/89a85a283b4b59947865
#>
function Set-AudioVolume {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        # The desired volume level
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {$_ -ge 0 -and $_ -le 100})]
        [int]$Level
    )

    process {
        $power = $Level / 100

        if ($pscmdlet.ShouldProcess("Audio volume", "Set level to $Level")) {
            [Audio]::Volume = $power
        }
    }
}

<#
.SYNOPSIS
    Gets the current mute status
.DESCRIPTION
    Gets the current audio mute status.
    Returns true or false, representing if the system is muted or not, respectively.
.EXAMPLE
    Get-AudioMute
    Gets the current status for audio mute
.INPUTS
    None
.OUTPUTS
    Boolean value for status
.NOTES
    Uses C# and InteropServices to interact with the system audio.
    Code taken from Ole Morten Didriksen's GitHub gists: https://gist.github.com/oledid/89a85a283b4b59947865
#>
function Get-AudioMute {
    [CmdletBinding(ConfirmImpact = 'Low')]
    [OutputType([bool])]
    Param ()

    process {
        [Audio]::Mute
    }
}

<#
.SYNOPSIS
    Sets the desired mute status
.DESCRIPTION
    Enables or disables audio mute.
    If note status is defined, will toggle the status based on the current status. If the audio is muted it will be unmuted and vice versa.
.EXAMPLE
    Set-AudioMute -Status Mute
    Mutes the volume
.EXAMPLE
    Set-AudioMute -Status Unmute
    Unmutes the volume
.EXAMPLE
    Set-AudioMute
    Toggles the mute status. If the audio is muted, unmutes it. And if the audio is unmuted, mutes it.
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    Uses C# and InteropServices to interact with the system audio.
    Code taken from Ole Morten Didriksen's GitHub gists: https://gist.github.com/oledid/89a85a283b4b59947865
#>
function Set-AudioMute {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param (
        # The desired audio mute status
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("Mute", "Unmute")]
        [String]$Status
    )

    process {
        if ($Status) {
            $mute = switch ($Status) {
                "Mute" { $true }
                "Unmute" { $false }
                default { throw "Invalid value for Status: $Status"}
            }
        }
        else {
            $mute = switch (Get-AudioMute) {
                $true { $false }
                $false { $true }
            }
        }

        if ($pscmdlet.ShouldProcess("Audio", "Set mute to $mute")) {
            [Audio]::Mute = $mute
        }
    }
}