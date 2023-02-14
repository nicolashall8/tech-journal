Write-Host "This script creates a linked clone using existing Base images of VMs within the ESXi"
$vm = Read-Host -Prompt "Enter the name of the VM"
$snapshot = Get-Snapshot -VM $vm -Name "Base"
$vmhost = Get-VMHost -Name "192.168.7.30"  
$ds = Get-DataStore -Name "datastore1-super20"
$linkedClone = "{0}.linked" -f $vm.name
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -DataStore $ds
$newvmname = Read-Host "Enter the name of the new VM linked clone"
$newvm = New-VM -Name $newvmname -VM $linkedvm -VMHost $vmhost -DataStore $ds

# Clean up
$linkedvm | Remove-VM
