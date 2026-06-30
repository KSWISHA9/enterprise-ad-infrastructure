# INFRA-001 - Create Privileged Administrator Accounts
# OmniVerse Enterprise

Import-Module ActiveDirectory

$AdminOU = "OU=Privileged Accounts,OU=OmniVerse,DC=corp,DC=omniverse,DC=com"
$Password = ConvertTo-SecureString "OmniVerse2026!" -AsPlainText -Force

$Admins = @(
    @{ Name="adm.klynch"; First="Keshawn"; Last="Lynch"; Role="Enterprise Administrator" },
    @{ Name="adm.bwayne"; First="Bruce"; Last="Wayne"; Role="CIO Privileged Account" },
    @{ Name="adm.tstark"; First="Tony"; Last="Stark"; Role="Infrastructure Admin" },
    @{ Name="adm.bgordon"; First="Barbara"; Last="Gordon"; Role="IAM Admin" },
    @{ Name="adm.nfury"; First="Nick"; Last="Fury"; Role="Security Admin" }
)

foreach ($Admin in $Admins) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($Admin.Name)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $Admin.Name `
            -GivenName $Admin.First `
            -Surname $Admin.Last `
            -DisplayName $Admin.Name `
            -SamAccountName $Admin.Name `
            -UserPrincipalName "$($Admin.Name)@corp.omniverse.com" `
            -Path $AdminOU `
            -Description $Admin.Role `
            -AccountPassword $Password `
            -Enabled $true
    }
}

Add-ADGroupMember -Identity "GG-IAM-Admins" -Members "adm.klynch","adm.bgordon" -ErrorAction SilentlyContinue
Add-ADGroupMember -Identity "GG-Server-Admins" -Members "adm.klynch","adm.tstark" -ErrorAction SilentlyContinue
Add-ADGroupMember -Identity "GG-Security-Admins" -Members "adm.nfury" -ErrorAction SilentlyContinue

Get-ADUser -SearchBase $AdminOU -Filter * -Properties Description |
    Select-Object Name, SamAccountName, Enabled, Description
