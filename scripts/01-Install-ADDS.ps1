# INFRA-001 - Install AD DS, DNS, and DHCP Roles
# OmniVerse Enterprise

Install-WindowsFeature AD-Domain-Services,DNS,DHCP -IncludeManagementTools

Get-WindowsFeature AD-Domain-Services,DNS,DHCP
