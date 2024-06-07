<#

    .Synopsis
        Automatically detect expired AD users and disable them properly.

    .Description
        When a user is planning to leave the organization, their AD account will be set to expire
        on their last day. Instead of having to remember to manually disable the account when that
        day comes, this script will automatically do the following:
            1. Search AD for any expired users
            2. Move expired users to specified OU
            3. Disable expired users
            4. Remove all groups from expired users

    .Example
        .\DisableExpiredADUsers.ps1

    .Notes
        Modify $SearchOU and $OU according to your environment before running the script.
#>

Import-Module ActiveDirectory

# Specify search OU
$SearchOU = "OU=Users,OU=Boston,DC=cyberlab,DC=local"

# Specify OU for disabled AD users
$OU = "OU=DisabledUsers,OU=Boston,DC=cyberlab,DC=local"

# Search for expired AD users
$Users = Search-ADAccount -AccountExpired -SearchBase $SearchOU

# Move expired AD users to target OU and disable
foreach($User in $Users){
    Move-ADObject -Identity $User -TargetPath $OU
    Disable-ADAccount -Identity $User.SamAccountName
    Write-Host "Moved and disabled $($User.SamAccountName)" -ForegroundColor Green
}

# Filter all AD users in $OU
$StripUsers = Get-ADUser -Filter "*" -SearchBase $OU -SearchScope OneLevel

# Remove all groups except for Domain Users
foreach($StripUser in $StripUsers){
    Get-ADPrincipalGroupMembership -Identity $StripUser.SamAccountName | Where-Object -Property Name -NE -Value "Domain Users" | Remove-ADGroupMember -Members $StripUser.SamAccountName -Confirm:$false
    Write-Host "Removed all groups from $($StripUser.SamAccountName)" -ForegroundColor Green
}
