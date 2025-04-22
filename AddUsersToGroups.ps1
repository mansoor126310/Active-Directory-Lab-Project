# Define domain
$domain = "homedc.pvt"

# Define users and groups
$usersToAdd = @(
    @{ Username = "alex.thompson"; Group = "IT-Staff" },
    @{ Username = "maya.patel"; Group = "IT-Staff" },
    @{ Username = "james.wilson"; Group = "HR-Staff" },
    @{ Username = "sophia.rodriguez"; Group = "HR-Staff" },
    @{ Username = "daniel.lee"; Group = "Finance-Staff" },
    @{ Username = "olivia.garcia"; Group = "Finance-Staff" },
    @{ Username = "ethan.williams"; Group = "Marketing-Staff" },
    @{ Username = "emma.chen"; Group = "Marketing-Staff" }
)

# Loop through users and add them to their group
foreach ($entry in $usersToAdd) {
    $user = Get-ADUser -Filter "SamAccountName -eq '$($entry.Username)'" -ErrorAction SilentlyContinue
    $group = Get-ADGroup -Identity $entry.Group -ErrorAction SilentlyContinue

    if ($user -and $group) {
        Add-ADGroupMember -Identity $group -Members $user
        Write-Host "Added $($entry.Username) to $($entry.Group)"
    } else {
        Write-Host "❌ Could not find user or group for $($entry.Username) → $($entry.Group)"
    }
}
