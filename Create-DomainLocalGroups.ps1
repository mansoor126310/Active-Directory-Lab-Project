# Correct base OU for groups
$groupOU = "OU=Groups,OU=Resources,DC=homedc,DC=pvt"

# List of domain local security groups to create
$groups = @(
    "FileServer-Read",
    "FileServer-Modify",
    "FileServer-FullControl",
    "PrinterAccess",
    "RemoteDesktopUsers"
)

foreach ($groupName in $groups) {
    # Check if the group already exists
    if (-not (Get-ADGroup -Filter "Name -eq '$groupName'" -SearchBase $groupOU -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $groupName `
            -GroupScope "DomainLocal" `
            -GroupCategory "Security" `
            -Path $groupOU `
            -Description "$groupName Group"
        
        Write-Host "Created group: $groupName"
    } else {
        Write-Host "Group already exists: $groupName"
    }
}
