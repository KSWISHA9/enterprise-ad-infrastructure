# INFRA-001 - Promote Server to Domain Controller
# OmniVerse Enterprise
# Note: This requires a Directory Services Restore Mode password during execution.

Install-ADDSForest `
    -DomainName "corp.omniverse.com" `
    -DomainNetbiosName "OMNIVERSE" `
    -InstallDNS

# Server will reboot automatically after promotion.
