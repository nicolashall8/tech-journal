# Objective: User provides a network prefix and a DNS server to use
# Example: .\dns-resolver2.ps1 192.168.3 192.168.4.5

param ($netprefix, $dns_server)

for($i = 1; $i -lt 254; $i++) { 
    $ip = ($netprefix + "." + $i)
    Write-Host($ip)
    $dns_command = (Resolve-DnsName -DnsOnly $ip -Server $dns_server -ErrorAction Ignore | Select-Object -Property NameHost)
    if ($dns_command -like "*"){
        echo $ip $dns_command 
    }
}
