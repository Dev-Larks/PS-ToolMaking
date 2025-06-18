function Get-TMComputerStatus {
    [CmdletBinding()]
    param (
        [string[]] $ComputerName,
        [string] $ErrorLogFilePath,
        #[string] $Credential,
        [switch] $LogErrors
    )
    
    BEGIN {
        
    }
    
    PROCESS {
        foreach ($Computer in $ComputerName) {
            ## Run the commands here
            $os = Get-CimInstance win32_operatingsystem -computername $computer | 
            Select-Object -property CSName, TotalVisibleMemorySize, FreePhysicalMemory,
            NumberOfProcesses, #lastBootUpTime, 
            @{Name = "PctFreeMemory"; Expression = { ($_.freephysicalmemory / `
                        ($_.TotalVisibleMemorySize)) * 100 }
            },
            @{Name = "Uptime"; Expression = { (Get-Date) - $_.lastBootUpTime } }

            $cpu = Get-CimInstance win32_processor #-ComputerName $computer |
            Select-Object -Property LoadPercentage

            $vol = Get-Volume -DriveLetter C |
            Select-Object -property @{Name = "PctFreeC"; Expression = { ($_.SizeRemaining / $_.size) * 100 }
            }

            $os, $cpu, $vol

        } # End foreach $computer
    
    }
    
    END {
        
    }
} #Get-TMComputerStatus

function Get-TMRemoteListeningConfiguration {
    [CmdletBinding()]
    param (
        [string[]] $ComputerName,
        [switch] $LogErrors,
        [string] $LogFilePath = "C:\Temp\OfflineServers.txt"
    )
    
    begin {
        $ReportDate = Get-Date
    }
    
    process {

        $ports = "22", "5985", "5986"

        foreach ($computer in $ComputerName) {
            
            foreach ($port in $ports) {
                <# $port is tports item #>
            
            Test-NetConnection -Computername $computer -Port $port | Select-Object Computer,RemotePort, TcpTestSucceeded

            }# End ForEach port

        }# End ForEach computer
    
    }
    
    end {
        
    }
} # End Get-TMRemoteListeningConfiguration