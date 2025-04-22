Import-Module ActiveDirectory

$groupOU = "OU=Groups,OU=Resources,DC=homedc,DC=pvt"

$groups = @(
    "IT-Staff",
    "HR-Staff",
    "Finance-Staff",
    "Marketing-Staff"
)

foreach ($group in $groups) {
    Write-Host "Creating group: $group"
    New-ADGroup `
        -Name $group `
        -SamAccountName $group `
        -GroupCategory Security `
        -GroupScope Global `
        -Path $groupOU
}
