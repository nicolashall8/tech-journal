function 480Banner(){
    Write-Host "SYS480 DevOps"
}

function 480Connect([string] $server){
    $conn = $global:DefaultVIServer
    # Are we connected?
    if($conn){
        $msg = "Already connected to: {0}" -f $conn
        Write-Host -ForegroundColor Green $msg
    } else{
        $conn = Connect-VIServer -Server $server
        # If fails, let Connect-VIServer handle exception
    }
}

function Get-480Config([string] $config_path)
{
    $conf=$null
    if(Test-Path $config_path){
        $conf = (Get-Content -Raw -Path $config_path | ConvertFrom-Json)
        $msg = "Using Configuration at {0}" -f $config_path
        Write-Host -ForegroundColor  "Green" $msg
    } else{
        Write-Host -ForegroundColor "Yello" "No configuration"
    }
    return $conf
}

function Select-VM([string] $folder){
    $selected_vm=$null
    try {
        $vms = Get-VM -Location $folder
        $index = 1
        foreach($vm in $vms){
            Write-Host [$index] $vm.Name
            $index+=1
        }
        
        $pick_index = Read-Host("Which index number [x] do you want to pick?")
        $selected_vm = $vms[$pick_index -1]
        if(-not($selected_vm -in $vms)){
            Write-Host "Invalid Index: $pick_index" -ForegroundColor "Red"
        }
        else{
            Write-Host "You picked" $selected_vm.Name
        }
        return $selected_vm
    }
    catch {
        Write-Host "Invalid Folder: $folder" -ForegroundColor "Red"
    }
}

function CreateLinkedClone(){
    Write-Host "Create a linked clone using an existing Base image of a VM within your ESXi"
    $vm = Read-Host -Prompt "Enter the name of the VM"
    $snapshot = Get-Snapshot -VM $vm -Name "Base"
    $select_vmhost = Read-Host -Prompt "Enter the IP or Hostname of the ESXi"
    $vmhost = Get-VMHost -Name $select_vmhost
    $select_ds = Read-Host -Prompt "Enter the name of the datastore"
    $ds = Get-DataStore -Name $select_ds
    $linkedClone = "{0}.linked" -f $vm.name
    $linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -DataStore $ds
    $newvmname = Read-Host "Enter the name of the new VM linked clone"
    $newvm = New-VM -Name $newvmname -VM $linkedvm -VMHost $vmhost -DataStore $ds

    # Clean up
    $linkedvm | Remove-VM
}