# INFRA-001 - Build OmniVerse Enterprise OU Structure
# OmniVerse Enterprise

Import-Module ActiveDirectory

$BaseDN = "DC=corp,DC=omniverse,DC=com"

# Root OU
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=OmniVerse)" -SearchBase $BaseDN -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit `
        -Name "OmniVerse" `
        -Path $BaseDN `
        -ProtectedFromAccidentalDeletion $true
}

$Root = "OU=OmniVerse,$BaseDN"

# Top-level OUs
$TopOUs = @(
    "Corporate",
    "Departments",
    "Infrastructure",
    "Groups",
    "Service Accounts",
    "Privileged Accounts",
    "Contractors",
    "Disabled Users",
    "Staging"
)

foreach ($OU in $TopOUs) {
    $DN = "OU=$OU,$Root"
    if (-not (Get-ADOrganizationalUnit -Identity $DN -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit `
            -Name $OU `
            -Path $Root `
            -ProtectedFromAccidentalDeletion $true
    }
}

# Department OUs
$Departments = @(
    "IT",
    "HR",
    "Finance",
    "Security",
    "Engineering",
    "Operations",
    "Marketing",
    "Sales",
    "Legal",
    "Executive"
)

$DeptPath = "OU=Departments,$Root"

foreach ($Dept in $Departments) {
    $DeptDN = "OU=$Dept,$DeptPath"

    if (-not (Get-ADOrganizationalUnit -Identity $DeptDN -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit `
            -Name $Dept `
            -Path $DeptPath `
            -ProtectedFromAccidentalDeletion $true
    }

    @("Users","Computers","Groups") | ForEach-Object {
        $ChildDN = "OU=$_,$DeptDN"
        if (-not (Get-ADOrganizationalUnit -Identity $ChildDN -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit `
                -Name $_ `
                -Path $DeptDN `
                -ProtectedFromAccidentalDeletion $true
        }
    }
}

# Infrastructure OUs
$InfraPath = "OU=Infrastructure,$Root"

@(
    "Domain Controllers",
    "Member Servers",
    "Application Servers",
    "Database Servers",
    "File Servers",
    "Workstations"
) | ForEach-Object {
    $InfraDN = "OU=$_,$InfraPath"
    if (-not (Get-ADOrganizationalUnit -Identity $InfraDN -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit `
            -Name $_ `
            -Path $InfraPath `
            -ProtectedFromAccidentalDeletion $true
    }
}

Get-ADOrganizationalUnit -Filter * -SearchBase $Root |
    Select-Object Name, DistinguishedName |
    Sort-Object DistinguishedName
