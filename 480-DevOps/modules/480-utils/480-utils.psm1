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