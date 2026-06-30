# Enterprise Active Directory Infrastructure (INFRA-001)

> Designed and automated an enterprise Active Directory environment for OmniVerse Enterprise using Windows Server 2022, PowerShell, DNS, DHCP, and identity lifecycle automation for 2,000 simulated users.

---

# Overview

This project demonstrates the deployment of a simulated enterprise Active Directory environment from the ground up.

The environment was built to mirror how a real enterprise identity team provisions users, organizes Active Directory, automates onboarding, and manages core Windows infrastructure.

Rather than manually creating users and organizational units, the environment leverages PowerShell automation to provision an enterprise-ready Active Directory domain supporting thousands of users.

---

# Environment

| Component | Value |
|------------|-------------------------|
| Operating System | Windows Server 2022 |
| Domain Controller | OV-DC01 |
| Domain Name | corp.omniverse.com |
| Active Directory | ✅ |
| DNS | ✅ |
| DHCP | ✅ |
| Users Imported | 2,000 |
| Service Accounts | 5 |
| Privileged Accounts | 5 |
| Automation | PowerShell |

---

# Enterprise Architecture

Architecture diagram coming soon.

```
                   Internet
                       │
                 Windows Server 2022
                     OV-DC01
                       │
      ┌────────────────┼────────────────┐
      │                │                │
     DNS             DHCP      Active Directory
                                        │
                     Enterprise OU Structure
                                        │
                      Security Groups (RBAC)
                                        │
                          2,000 HR Users
                                        │
                   Automated Provisioning
```

---

# Features

## Active Directory

- Enterprise Domain Controller
- Organizational Unit hierarchy
- Department-based Active Directory design
- PowerShell automation
- Enterprise naming conventions

---

## Identity Management

- Automated HR CSV generation
- Automated provisioning of 2,000 users
- Department-based user placement
- Automated security group assignment
- Service account management
- Privileged administrator accounts

---

## Windows Infrastructure

- Active Directory Domain Services
- DNS
- DHCP
- Static IP Configuration
- Enterprise domain configuration

---

# Automation Workflow

```text
HR Export
      │
      ▼
PowerShell Automation
      │
      ▼
Active Directory
      │
      ▼
Organizational Units
      │
      ▼
Department Security Groups
      │
      ▼
Enterprise Identity
```

---

# PowerShell Scripts

| Script | Purpose |
|---------|---------|
| 01-Build-OU-Structure.ps1 | Creates the enterprise OU hierarchy |
| 02-Create-Security-Groups.ps1 | Creates enterprise security groups |
| 03-Generate-HR-CSV.ps1 | Generates the HR employee dataset |
| 04-Import-HR-Users.ps1 | Imports 2,000 users into Active Directory |
| 05-Assign-Department-Groups.ps1 | Assigns users to department security groups |
| 06-Create-Service-Accounts.ps1 | Creates enterprise service accounts |
| 07-Create-Privileged-Accounts.ps1 | Creates dedicated administrator accounts |
| 08-Configure-DHCP.ps1 | Configures DHCP scope and options |

---

# Screenshots

The repository includes screenshots demonstrating:

- Windows Server Installation
- Domain Controller Promotion
- Enterprise OU Structure
- Security Group Creation
- HR Dataset Generation
- Automated User Import
- Department Group Assignment
- Service Accounts
- Privileged Administrator Accounts
- DHCP Configuration
- DHCP Scope Verification
- DHCP Management Console

---

# Skills Demonstrated

- Active Directory Administration
- Windows Server 2022
- DNS Administration
- DHCP Administration
- Identity Lifecycle Management
- PowerShell Automation
- RBAC Design
- Enterprise OU Design
- User Provisioning
- Enterprise Identity Management
- Infrastructure Automation

---

# Results

✅ Deployed Windows Server 2022 Domain Controller

✅ Configured Active Directory Domain Services

✅ Configured DNS

✅ Configured DHCP

✅ Built Enterprise OU Structure

✅ Created Department Security Groups

✅ Generated HR Dataset

✅ Imported 2,000 Active Directory Users

✅ Automated Department Group Assignment

✅ Created Enterprise Service Accounts

✅ Created Privileged Administrator Accounts

---

# Future Enhancements

The following projects will build on this enterprise environment:

- Enterprise File Server
- AGDLP Implementation
- Group Policy Objects (GPOs)
- Microsoft Entra Connect
- Hybrid Identity
- Microsoft Sentinel
- Azure Infrastructure
- Identity Governance
- Zero Trust Architecture

---

# Related Projects

This repository is part of the OmniVerse Enterprise portfolio.

- OmniVerse Enterprise
- Enterprise Network Infrastructure
- Windows Infrastructure Services
- Hybrid Identity Engineering
- Identity Lifecycle Automation
- Zero Trust Identity Security
- Identity Governance
- Enterprise Azure Infrastructure
- Enterprise Vulnerability Management
- Security Operations & Threat Detection
- Governance, Risk & Compliance

---

# Author

**Keshawn Lynch**

Information Technology Graduate

Identity & Access Management (IAM)

Cybersecurity | Windows Infrastructure | Microsoft Entra ID | Active Directory | PowerShell