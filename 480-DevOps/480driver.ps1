Import-Module '/home/nicolas/tech-journal/480-DevOps/modules/480-utils/480-utils.psm1' -Force

# Call the Banner function
480Banner
# $conf = Get-480Config -config_path = '/home/nicolas/tech-journal/480-DevOps/480.json'
# 480Connect -server $conf.vcenter_server
# Write-Host("Selecting your VM...")
# Select-VM -folder "BASEVM"
# Get-IP -vmName super20-xubuntu-wan -vcenter_server vcenter.nicolashall.local
# New-VirtualSwitch -Name TEST-LAN -VMHost 192.168.7.30
#StartVM -vmName awx -esxi_host 192.168.7.30
#StopVM -vmName awx -esxi_host 192.168.7.30