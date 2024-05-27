<#                                       
                                         
    .Synopsis                            
        Script to triage a Windows system
                                         
    .Description                         
        Quickly gather important system info like:  
            - Running processes          
            - Registered services        
            - TCP Connections            
            - Local user accounts        
            - Network adapters           
            - Execution policies         
            - OS hotfixes                                                  
            - Recent Windows system event logs                             
                                                                           
        Results are organized and output is directed to a txt file         
                                                                           
    .Example                                                               
        .\IncidentResponseTriage.ps1                                       
                                                                           
        $OutPutFile = "C:\Users\bob\Desktop\triage-05-27-24-win-wks-01.txt"
#>                                                                         

# User input required for full path of new output file
#$OutPutFile = ""
$OutputFile = Read-Host "Enter the full path of the new output file"

# Get system info
$ProcessesHeader = "====================System Info====================" | Out-File -Append -FilePath $OutputFile
Get-ComputerInfo | Select-Object CsDNSHostName,CsDomain,WindowsProductName,WindowsCurrentVersion,OsLocalDateTime | Out-File -Append -FilePath $OutputFile

# List all running processes and path for each process
$ProcessesHeader = "====================Running Processes====================" | Out-File -Append -FilePath $OutputFile
Get-Process | Sort-Object -Descending path | Select-Object processname,path | Get-Unique -AsString | Out-File -Append -FilePath $OutputFile

# List all registered services and the path of the executable for each service
$ServicesHeader = "====================Registered Services====================" | Out-File -Append -FilePath $OutputFile
Get-WmiObject win32_service | Sort-Object state,pathname | Select-Object name,state,pathname | Out-File -Append -FilePath $OutputFile

# List all TCP network sockets
$TCPConnectionsHeader = "====================TCP Connections====================" | Out-File -Append -FilePath $OutputFile
Get-NetTCPConnection | Sort-Object -Descending localaddress,remoteaddress,state | Select-Object localaddress,localport,remoteaddress,remoteport,state | Format-Table -AutoSize | O
ut-File -Append -FilePath $OutputFile

# List all the user account information - Optional : Include if / else statements to check if workstation is domain joined and list domain users too
$LocalUserAccHeader = "====================Local User Accounts====================" | Out-File -Append -FilePath $OutputFile
Get-LocalUser | Select-Object Name,Enabled,Description,LastLogon | Out-File -Append -FilePath $OutputFile

# List all Network Adapter configuration information
$NetAdapterHeader = "====================Network Adapters====================" | Out-File -Append -FilePath $OutputFile
Get-NetAdapter | Select-Object Name,InterfaceDescription,MacAddress,Status,LinkSpeed | Format-Table -AutoSize | Out-File -Append -FilePath $OutputFile

# List execution policies
$WinEventLogsHeader = "====================Execution Policies====================" | Out-File -Append -FilePath $OutputFile
Get-ExecutionPolicy | Out-File -Append -FilePath $OutputFile

# List hotfixes
$HotFixHeader = "====================HotFixes====================" | Out-File -Append -FilePath $OutputFile
Get-HotFix | Sort-Object Description | Select-Object Source,Description,HotFixID,InstalledBy,InstalledOn | Format-Table -AutoSize | Out-File -Append -FilePath $OutputFile        

# List total Windows Event Logs and show 5 most recent System event logs
$WinEventLogHeader = "====================Windows Event Logs====================" | Out-File -Append -FilePath $OutputFile
Get-EventLog -List | Out-File -Append -FilePath $OutputFile
Get-EventLog -LogName System -Newest 5 | Out-File -Append -FilePath $OutputFile
