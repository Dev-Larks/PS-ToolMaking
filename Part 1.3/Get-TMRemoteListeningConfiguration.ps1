function Get-TMRemoteListeningConfiguration {
    [CmdletBinding()]
    param (
        [string[]] $ComputerName,
        [switch] $LogErrors,
        [string] $LogFilePath = C:\Temp\OfflineServers.txt
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
}# End Get-TMRemoteListeningConfiguration