function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Name
    )

    Write-Verbose "Getting service $Name"

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue

    $ensure = "Absent"

    if ($service) {
        Write-Verbose "Service $Name present"
        $ensure = "Present"
    } else {
        Write-Verbose "Service $Name absent"
    }

    $result = @{
        Name = $Name
        Status = $service.Status
        Ensure = $ensure
    }

    $result
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [ValidateSet("Running","Stopped")]
        [System.String]
        $Status,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    Write-Verbose "Setting service $Name"

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue

    if ($Ensure -eq "Present") {
        if ($service) {
            if ($services.Status -ne $Status) {
                Write-Verbose "Current service status is $($service.Status)"
                if ($Status -eq "Running") {
                    Write-Verbose "Starting service"
                    Start-Service $Name
                } elseif ($Status -eq "Stopped") {
                    Write-Verbose "Stopping service"
                    Stop-Service $Name
                }
            } else {
                Write-Verbose "Service $Name exists and is in correct status $Status. Do nothing"
            }
        } else {
            Write-Verbose "Creating service $Name"
            # NOT IMPLEMENTED
        }
    } elseif ($Ensure -eq "Absent") {
        Write-Verbose "Removing service $Name"
        # NOT IMPLEMENTED
    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [ValidateSet("Running","Stopped")]
        [System.String]
        $Status,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    Write-Verbose "Testing service $Name"

    $result = $false
    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue

    if ($Ensure -eq "Present") {
        if ($service) {
            if ($services.Status -eq $Status) {
                Write-Verbose "Service $Name exists and is in correct status $Status."
                $result = $true
            } else {
                Write-Verbose "Service status does not match $Status. Current status: $($service.Status)"
                $result = $false
            }
        } else {
            Write-Verbose "Service $Name does not exist"
            $result = $false
        }
    } elseif ($Ensure -eq "Absent") {
        if (-not $service) {
            Write-Verbose "Service $Name does not exist"
            $result = $true
        } else {
            Write-Verbose "Service $Name exists and is in state $($service.Status)"
            $result = $false 
        }
    }

    return $result
}


Export-ModuleMember -Function *-TargetResource