# List of usernames to delete
$usernames = @(
    "alex.thompson",
    "maya.patel",
    "james.wilson",
    "sophia.rodriguez",
    "daniel.lee",
    "olivia.garcia",
    "ethan.williams",
    "emma.chen"
)

foreach ($username in $usernames) {
    $user = Get-ADUser -Filter { SamAccountName -eq $username } -ErrorAction SilentlyContinue
    if ($user) {
        Remove-ADUser -Identity $user -Confirm:$false
        Write-Host "Deleted user: $username"
    } else {
        Write-Host "User not found: $username"
    }
}
