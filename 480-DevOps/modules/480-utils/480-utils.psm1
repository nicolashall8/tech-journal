function 480Banner(){
    Write-Host "Hello SYS480-DevOps"
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