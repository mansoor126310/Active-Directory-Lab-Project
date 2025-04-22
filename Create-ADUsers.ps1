Import-Module ActiveDirectory

# Define domain and base OU
$domain = "homedc.pvt"
$baseOU = "OU=Departments,DC=homedc,DC=pvt"

# User list
$users = @(
    @{ FirstName="Alex"; LastName="Thompson"; Username="alex.thompson"; Password="ITaccess@2025"; Department="IT" },
    @{ FirstName="Maya"; LastName="Patel"; Username="maya.patel"; Password="TechSupp0rt!25"; Department="IT" },
    @{ FirstName="James"; LastName="Wilson"; Username="james.wilson"; Password="HR$ecure2025"; Department="HR" },
    @{ FirstName="Sophia"; LastName="Rodriguez"; Username="sophia.rodriguez"; Password="P30ple@HR!25"; Department="HR" },
    @{ FirstName="Daniel"; LastName="Lee"; Username="daniel.lee"; Password="Finance$123!"; Department="Finance" },
    @{ FirstName="Olivia"; LastName="Garcia"; Username="olivia.garcia"; Password="Acc0unt$25#"; Department="Finance" },
    @{ FirstName="Ethan"; LastName="Williams"; Username="ethan.williams"; Password="Market!ng2025"; Department="Marketing" },
    @{ FirstName="Emma"; LastName="Chen"; Username="emma.chen"; Password="Cr3@tive!Mkt25"; Department="Marketing" }
)

foreach ($user in $users) {
    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force
    $fullName = "$($user.FirstName) $($user.LastName)"
    $ouPath = "OU=$($user.Department),$baseOU"

    Write-Host "Creating user: $fullName in OU: $ouPath"

    New-ADUser `
        -Name $fullName `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $user.Username `
        -UserPrincipalName "$($user.Username)@$domain" `
        -AccountPassword $securePassword `
        -Enabled $true `
        -Path $ouPath `
        -PasswordNeverExpires $true `
        -ChangePasswordAtLogon $false
}
