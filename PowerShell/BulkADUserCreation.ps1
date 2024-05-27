<#

    .Synopsis
        Bulk creation of new AD users from CSV file

    .Description
        Prepare a CSV file with necessary headers and values for AD user creation.   
        Run the script while specifying the location of the CSV file.
        The script will iterate through each column and row of the CSV file and      
        new AD users will be created.

    .Example
        .\ADUserBulkCreate.ps1

        CSV File Example:
        FirstName,LastName,Description,Office,Email,Username,Department,Password     
        Alice,Hall,Sysadmin,Boston,alice.hall@cyberlab.local,alice.hall,IT,Password1234!

#>

Import-Module ActiveDirectory

# Hard coded values - modify before running script
$NewUsers = Import-Csv "C:\Users\bob\Desktop\newusers.csv"
$OU = "OU=IT,OU=Users,OU=Boston,DC=cyberlab,DC=local"

# Get domain name for UPN
$d = Get-ADDomain
$UPN = $d.DNSRoot

# Use hard coded UPN as an alternative
#$UPN = "cyberlab.local"

foreach ($User in $NewUsers){
    # Check if the user already exists and output a warning message if it does       
    if (Get-ADUser -Filter "SamAccountName -eq '$($User.username)'"){
        Write-Warning "A user account called $($User.username) already exists in AD" 
    }
    else {
        $NewUserSplat = @{
            GivenName = $user.FirstName
            Surname = $user.LastName
            DisplayName = "$($user.LastName), $($user.FirstName)"
            Description = $user.Description
            Office = $user.Office
            EmailAddress = $user.Email
            userPrincipalName = "$($user.Username)@$UPN"
            Name = "$($user.FirstName) $($user.LastName)"
            Enabled = $True
            Company = $user.Office
            Title = $user.JobTitle
            Department = $user.Department
            SamAccountName = $user.Username
            Path = $OU
            AccountPassword = (ConvertTo-SecureString $user.Password -AsPlainText -Force)
            ChangePasswordAtLogon = $True
            }
    }
    # Create new AD user and output success message
    New-ADUser @NewUserSplat
    Write-Host "The user $($user.Username) has been created." -ForegroundColor Green 
}
