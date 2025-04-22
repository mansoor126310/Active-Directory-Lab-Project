# Base OU for groups
$groupOU = "OU=Groups,OU=Resources,DC=homedc,DC=pvt"

# Mapping Global Groups to Domain Local Groups
$groupMappings = @{
    "FileServer-Read"        = @("IT-Staff", "HR-Staff")
    "FileServer-Modify"      = @("Finance-Staff")
    "FileServer-FullControl" = @("IT-Staff")
    "PrinterAccess"          = @("Marketing-Staff")
    "RemoteDesktopUsers"     = @("IT-Staff", "Finance-Staff")
}

foreach ($domainLocalGroup in $groupMappings.Keys) {
    foreach ($globalGroup in $groupMappings[$domainLocalGroup]) {
        try {
            Add-ADGroupMember -Identity $domainLocalGroup -Members $globalGroup
            Write-Host "Added $globalGroup to $domainLocalGroup"
        } catch {
            Write-Host "Failed to add $globalGroup to $domainLocalGroup. $_"
        }
    }
}
