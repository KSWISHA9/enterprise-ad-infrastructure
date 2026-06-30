# INFRA-001 - Create Service Accounts
# OmniVerse Enterprise

Import-Module ActiveDirectory

$ServiceAccountsOU = "OU=Service Accounts,OU=OmniVerse,DC=corp,DC=omniverse,DC=com"
$Password = ConvertTo-SecureString "OmniVerse2026!" -AsPlainText -Force

$ServiceAccounts = @(
    @{ Name="svc_backup"; Description="Backup platform service account" },
    @{ Name="svc_monitoring"; Description="Monitoring platform service account" },
    @{ Name="svc_sql"; Description="SQL service account" },
    @{ Name="svc_web"; Description="Internal web application service account" },
    @{ Name="svc_entra_sync"; Description="Future Microsoft Entra Connect synchronization account" }
)

foreach ($Svc in $ServiceAccounts) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($Svc.Name)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $Svc.Name `
            -SamAccountName $Svc.Name `
            -UserPrincipalName "$($Svc.Name)@corp.omniverse.com" `
            -Path $ServiceAccountsOU `
            -Description $Svc.Description `
            -AccountPassword $Password `
            -Enabled $true `
            -PasswordNeverExpires $true
    }
}

Get-ADUser -SearchBase $ServiceAccountsOU -Filter * -Properties Description |
    Select-Object Name, SamAccountName, Enabled, Description
