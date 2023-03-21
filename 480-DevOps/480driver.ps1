Import-Module '/home/nicolas/tech-journal/480-DevOps/modules/480-utils/480-utils.psm1' -Force

# Call the Banner function
480Banner

#$conf = Get-480Config -config_path = '/home/nicolas/tech-journal/480-DevOps/480.json'
#480Connect -server $conf.vcenter_server
#Write-Host("Selecting your VM...")
#Select-VM -folder "BASEVM"

#Get-IP -vmName blue1-fw -vcenter_server vcenter.nicolashall.local
#New-VirtualSwitch -Name TESTING -VMHost 192.168.7.30
#Get-VM
#CreateLinkedClone
#StartVM -vmName blue1-fw -esxi_host 192.168.7.30
#StopVM -vmName blue1-fw -esxi_host 192.168.7.30
#Set-Network -vmName blue1-fw -networkName BLUE1-LAN -esxiHost 192.168.7.30