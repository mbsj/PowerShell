enum Ensure {
    Present;
    Absent
}

enum Status {
    Running;
    Stopped
}

[DscResource()]
class TestServiceClass {
    [DscProperty(Key)]
    [string] $Name

    [DscProperty(Mandatory)]
    [Status] $Status

    [DscProperty(Mandatory)]
    [Ensure] $Ensure
    
    # Gets the resource's current state.
    [TestServiceClass] Get() {
        Write-Verbose "Getting service $($this.Name)"

        $service = Get-Service -Name $this.Name -ErrorAction SilentlyContinue

        $precense = "Absent"

        if ($service) {
            Write-Verbose "Service $($this.Name) present"
            $precense = "Present"
        } else {
            Write-Verbose "Service $($this.Name) absent"
        }

        $result = New-Object TestServiceClass
        $result.Name = $this.Name
        $result.Status = $service.Status
        $result.Ensure = $precense

        return $result
    }
    
    # Sets the desired state of the resource.
    [void] Set() {
        Write-Verbose "Setting service $($this.Name)"

        $service = Get-Service -Name $this.Name -ErrorAction SilentlyContinue

        if ($this.Ensure -eq "Present") {
            if ($service) {
                if ($service.Status -ne $this.Status) {
                    Write-Verbose "Current service status is $($service.Status)"
                    if ($this.Status -eq "Running") {
                        Write-Verbose "Starting service"
                        Start-Service $this.Name
                    } elseif ($this.Status -eq "Stopped") {
                        Write-Verbose "Stopping service"
                        Stop-Service $this.Name
                    }
                } else {
                    Write-Verbose "Service $($this.Name) exists and is in correct status $($this.Status). Do nothing"
                }
            } else {
                Write-Verbose "Creating service $($this.Name)"
                # NOT IMPLEMENTED
            }
        } elseif ($this.Ensure -eq "Absent") {
            Write-Verbose "Removing service $($this.Name)"
            # NOT IMPLEMENTED
        }
    }
    
    # Tests if the resource is in the desired state.
    [bool] Test() {
        Write-Verbose "Testing service $($this.Name)"

        $result = $false
        $service = Get-Service -Name $($this.Name) -ErrorAction SilentlyContinue

        if ($this.Ensure -eq "Present") {
            if ($service) {
                if ($service.Status -eq $this.Status) {
                    Write-Verbose "Service $($this.Name) exists and is in correct status $($this.Status)."
                    $result = $true
                } else {
                    Write-Verbose "Service status does not match $($this.Status). Current status: $($service.Status)"
                    $result = $false
                }
            } else {
                Write-Verbose "Service $($this.Name) does not exist"
                $result = $false
            }
        } elseif ($this.Ensure -eq "Absent") {
            if (-not $service) {
                Write-Verbose "Service $($this.Name) does not exist"
                $result = $true
            } else {
                Write-Verbose "Service $($this.Name) exists and is in state $($service.Status)"
                $result = $false 
            }
        }

        return $result
    }
}