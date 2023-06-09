# Random password generator
function random-pass($length){
    $characters = "1234567890!@#$%^&*()qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHKLZXCVBNM"
    $random = 1..$length | ForEach-Object { get-random -Maximum $characters.length }
    $private:ofs=""
    return [string]$characters[$random]
}

# Create new users in AD based on provided text file of Firstname Lastname format
# This script works but it can be improved by converting it to a function and changing variables such as file path, OU path, and upn as passable parameters
$newUsers = Get-Content -Path "E:\Shares\IT\client-user-names.txt"
foreach($newUser in $newUsers){
    $path = "OU=Business,OU=Accounts,OU=Testnet Cloud,DC=testnet,DC=local"
    $password = ConvertTo-SecureString -String $(random-pass -length 14) -AsPlainText -Force
    $firstname = $newUser.Split("")[0]
    $lastname = $newUser.Split("")[1]
    $username = "$firstname.$lastname".ToLower()
    $upn = $username + "@hallcyber.onmicrosoft.com"

    # Create new AD user
    New-ADUser -Name "$newuser" -GivenName "$firstname" -Surname "$lastname" -SamAccountName $username -UserPrincipalName $upn -AccountPassword $password -Enabled $true -Path $path
}
