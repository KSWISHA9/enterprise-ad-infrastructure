# INFRA-001 - Network Configuration
# OmniVerse Enterprise

# Enterprise LAN static IP configuration
Remove-NetIPAddress -InterfaceAlias "Enterprise LAN" -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue

New-NetIPAddress `
    -InterfaceAlias "Enterprise LAN" `
    -IPAddress 10.10.10.10 `
    -PrefixLength 24

Set-DnsClientServerAddress `
    -InterfaceAlias "Enterprise LAN" `
    -ServerAddresses 10.10.10.10

# Internet/NAT adapter DNS configuration
Set-DnsClientServerAddress `
    -InterfaceAlias "Internet" `
    -ServerAddresses 10.10.10.10

Get-NetIPConfiguration
Test-NetConnection google.com
