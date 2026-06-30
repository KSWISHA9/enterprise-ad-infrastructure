# INFRA-001 - Create Security Groups
# OmniVerse Enterprise

Import-Module ActiveDirectory

$BaseDN = "DC=corp,DC=omniverse,DC=com"
$RootOU = "OU=OmniVerse,$BaseDN"
$GroupsOU = "OU=Groups,$RootOU"

$Groups = @(
    @{ Name = "GG-IT"; Description = "Global group for IT department users" },
    @{ Name = "GG-HR"; Description = "Global group for HR department users" },
    @{ Name = "GG-Finance"; Description = "Global group for Finance department users" },
    @{ Name = "GG-Security"; Description = "Global group for Security department users" },
    @{ Name = "GG-Legal"; Description = "Global group for Legal department users" },
    @{ Name = "GG-Operations"; Description = "Global group for Operations department users" },
    @{ Name = "GG-Engineering"; Description = "Global group for Engineering department users" },
    @{ Name = "GG-Sales"; Description = "Global group for Sales department users" },
    @{ Name = "GG-Marketing"; Description = "Global group for Marketing department users" },
    @{ Name = "GG-Executive"; Description = "Global group for Executive department users" },

    @{ Name = "GG-HelpDesk"; Description = "Help Desk support group" },
    @{ Name = "GG-IAM-Admins"; Description = "Identity and Access Management administrators" },
    @{ Name = "GG-Server-Admins"; Description = "Server administration group" },
    @{ Name = "GG-Security-Admins"; Description = "Security administration group" },

    @{ Name = "DL-HR-Share-RW"; Description = "Domain local group for HR share read/write access" },
    @{ Name = "DL-Finance-Share-RW"; Description = "Domain local group for Finance share read/write access" },
    @{ Name = "DL-IT-Share-RW"; Description = "Domain local group for IT share read/write access" },
    @{ Name = "DL-Executive-Share-RW"; Description = "Domain local group for Executive share read/write access" }
)

foreach ($Group in $Groups) {
    $Scope = if ($Group.Name -like "DL-*") { "DomainLocal" } else { "Global" }

    if (-not (Get-ADGroup -Filter "Name -eq '$($Group.Name)'" -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $Group.Name `
            -SamAccountName $Group.Name `
            -GroupScope $Scope `
            -GroupCategory Security `
            -Path $GroupsOU `
            -Description $Group.Description

        Write-Host "Created group: $($Group.Name)" -ForegroundColor Green
    }
    else {
        Write-Host "Group already exists: $($Group.Name)" -ForegroundColor Yellow
    }
}

Get-ADGroup -SearchBase $GroupsOU -Filter * |
    Select-Object Name, GroupScope, Description |
    Sort-Object Name
