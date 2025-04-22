Import-Module ActiveDirectory

$domain = "homedc.pvt"
$adminOU = "OU=Admin Accounts,OU=Administration,DC=homedc,DC=pvt"
$serviceOU = "OU=Service Accounts,OU=Administration,DC=homedc,DC=pvt"

# Admin accounts (Department Admins)
$adminUsers = @(
    @{ Name="IT-Admin";     FirstName="IT";       LastName="Administrator";     Password="Str0ng!TAdm1n#2025" },
    @{ Name="HR-Admin";     FirstName="HR";       LastName="Administrator";     Password="Str0ngHR@Adm!n25" },
    @{ Name="Finance-Admin";FirstName="Finance";  LastName="Administrator";     Password="Fin@nc3Admin#2025" },
    @{ Name="Marketing-Admin";FirstName="Marketing";LastName="Administrator";   Password="M@rk3tAdmin2025!" }
)

# Service accounts
$serviceUsers = @(
    @{ Name="Domain-Admin";   FirstName="Domain";   LastName="Administrator";   Password="Dom@inAdm1n#2025" },
    @{ Name="Backup-Admin";   FirstName="Backup";   LastName="Administrator";   Password="B@ckupAdmin!2025" },
    @{ Name="Exchange-Admin"; FirstName="Exchange"; LastName="Administrator";   Password="Exch@ng3Adm!n2025" },
    @{ Name="SQL-Admin";      FirstName="SQL";      LastName="Administrator";   Password="SQL4dm!n$ecure2025" },
    @{ Name="Web-Admin";      FirstName="Web";      LastName="Administrator";   Password="W3bAdm1n2025#" },
    @{ Name="Helpdesk-Admin"; FirstName="Helpdesk"; LastName="Administrator";   Password="H3lpD3skAdm!n25" }
)

# Create Admin Accounts
foreach ($user in $adminUsers) {
    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force
    $fullName = "$($user.FirstName) $($user.LastName)"
    Write-Host "Creating Admin Account: $($user.Name) in $adminOU"

    New-ADUser `
        -Name $user.Name `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $user.Name `
        -UserPrincipalName "$($user.Name)@$domain" `
        -AccountPassword $securePassword `
        -Enabled $true `
        -Path $adminOU `
        -PasswordNeverExpires $true `
        -ChangePasswordAtLogon $false
}

# Create Service Accounts
foreach ($user in $serviceUsers) {
    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force
    $fullName = "$($user.FirstName) $($user.LastName)"
    Write-Host "Creating Service Account: $($user.Name) in $serviceOU"

    New-ADUser `
        -Name $user.Name `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $user.Name `
        -UserPrincipalName "$($user.Name)@$domain" `
        -AccountPassword $securePassword `
        -Enabled $true `
        -Path $serviceOU `
        -PasswordNeverExpires $true `
        -ChangePasswordAtLogon $false
}
