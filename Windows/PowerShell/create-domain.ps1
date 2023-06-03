# AD DS Deployment

Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NIDS" `
-DomainMode "WinThreshold" `
-DomainName "testnet.local" `
-DomainNetbiosName "TESTNET" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NIDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
