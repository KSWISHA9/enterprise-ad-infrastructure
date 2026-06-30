# INFRA-001 - Assign Users to Department Groups
# OmniVerse Enterprise

Import-Module ActiveDirectory

$DepartmentGroupMap = @{
    "IT"          = "GG-IT"
    "HR"          = "GG-HR"
    "Finance"    = "GG-Finance"
    "Security"   = "GG-Security"
    "Legal"      = "GG-Legal"
    "Operations" = "GG-Operations"
    "Engineering"= "GG-Engineering"
    "Sales"      = "GG-Sales"
    "Marketing"  = "GG-Marketing"
    "Executive"  = "GG-Executive"
}

foreach ($Department in $DepartmentGroupMap.Keys) {
    $Group = $DepartmentGroupMap[$Department]

    $Users = Get-ADUser `
        -Filter "Department -eq '$Department'" `
        -SearchBase "OU=OmniVerse,DC=corp,DC=omniverse,DC=com"

    if ($Users.Count -gt 0) {
        Add-ADGroupMember -Identity $Group -Members $Users -ErrorAction SilentlyContinue
    }

    [PSCustomObject]@{
        Department   = $Department
        Group        = $Group
        UsersFound   = $Users.Count
        GroupMembers = (Get-ADGroupMember $Group).Count
    }
}
