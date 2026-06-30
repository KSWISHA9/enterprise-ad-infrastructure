# INFRA-001 - Configure DHCP
# OmniVerse Enterprise

Add-DhcpServerInDC `
    -DnsName "OV-DC01.corp.omniverse.com" `
    -IPAddress 10.10.10.10

Add-DhcpServerv4Scope `
    -Name "OmniVerse Corporate LAN" `
    -StartRange 10.10.10.100 `
    -EndRange 10.10.10.250 `
    -SubnetMask 255.255.255.0 `
    -State Active

Add-DhcpServerv4ExclusionRange `
    -ScopeId 10.10.10.0 `
    -StartRange 10.10.10.1 `
    -EndRange 10.10.10.99

Set-DhcpServerv4OptionValue `
    -ScopeId 10.10.10.0 `
    -DnsServer 10.10.10.10 `
    -DnsDomain "corp.omniverse.com" `
    -Router 10.10.10.1

Get-DhcpServerInDC
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue -ScopeId 10.10.10.0
Get-DhcpServerv4Lease -ScopeId 10.10.10.0
